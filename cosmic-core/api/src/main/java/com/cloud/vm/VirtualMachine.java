package com.cloud.vm;

import com.cloud.acl.ControlledEntity;
import com.cloud.api.Displayable;
import com.cloud.api.Identity;
import com.cloud.api.InternalIdentity;
import com.cloud.hypervisor.Hypervisor.HypervisorType;
import com.cloud.utils.fsm.StateMachine2;
import com.cloud.utils.fsm.StateMachine2.Transition;
import com.cloud.utils.fsm.StateMachine2.Transition.Impact;
import com.cloud.utils.fsm.StateObject;

import java.util.Arrays;
import java.util.Date;
import java.util.Map;

/**
 * VirtualMachine describes the properties held by a virtual machine
 */
public interface VirtualMachine extends RunningOn, ControlledEntity, Identity, InternalIdentity, Displayable, StateObject<VirtualMachine.State> {

    static final String IsDynamicScalingEnabled = "enable.dynamic.scaling";

    /**
     * @return The name of the vm instance used by the cloud stack to uniquely
     * reference this VM. You can build names that starts with this name and it
     * guarantees uniqueness for things related to the VM.
     */
    String getInstanceName();

    /**
     * @return the host name of the virtual machine. If the user did not
     * specify the host name when creating the virtual machine then it is
     * defaults to the instance name.
     */
    String getHostName();

    /**
     * @return the ip address of the virtual machine.
     */
    String getPrivateIpAddress();

    /**
     * @return mac address.
     */
    String getPrivateMacAddress();

    /**
     * @return password of the host for vnc purposes.
     */
    String getVncPassword();

    /**
     * @return template id.
     */
    long getTemplateId();

    /**
     * returns the guest OS ID
     *
     * @return guestOSId
     */
    long getGuestOSId();

    /**
     * @return pod id.
     */
    Long getPodIdToDeployIn();

    /**
     * @return data center id.
     */
    long getDataCenterId();

    /**
     * @return the state of the virtual machine
     */
    // State getState();

    /**
     * @return id of the host it was assigned last time.
     */
    Long getLastHostId();

    @Override
    Long getHostId();

    /**
     * @return should HA be enabled for this machine?
     */
    boolean isHaEnabled();

    /**
     * @return should limit CPU usage to the service offering?
     */
    boolean limitCpuUse();

    /**
     * @return date when machine was created
     */
    Date getCreated();

    long getServiceOfferingId();

    Long getDiskOfferingId();

    Type getType();

    HypervisorType getHypervisorType();

    Map<String, String> getDetails();

    long getUpdated();

    @Override
    boolean isDisplay();

    public enum PowerState {
        PowerUnknown,
        PowerOn,
        PowerOff,
        PowerPaused,
        PowerReportMissing
    }

    public enum State {
        Starting(true, "VM is being started.  At this state, you should find host id filled which means it's being started on that host."),
        Running(false, "VM is running.  host id has the host that it is running on."),
        Stopping(true, "VM is being stopped.  host id has the host that it is being stopped on."),
        Stopped(false, "VM is stopped.  host id should be null."),
        Destroyed(false, "VM is marked for destroy."),
        Expunging(true, "VM is being   expunged."),
        Migrating(true, "VM is being migrated.  host id holds to from host"),
        Error(false, "VM is in error"),
        Paused(true, "VM is paused. host id has the host that it is running on."),
        Unknown(false, "VM state is unknown."),
        Shutdowned(false, "VM is shutdowned from inside");

        protected static final StateMachine2<State, VirtualMachine.Event, VirtualMachine> s_fsm = new StateMachine2<>();

        static {
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.StartRequested, State.Starting, null));
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.DestroyRequested, State.Destroyed, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.StopRequested, State.Stopped, null));
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.AgentReportStopped, State.Stopped, null));

            // please pay attention about state transition to Error state, there should be only one case (failed in VM
            // creation process)
            // that can have such transition
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.OperationFailedToError, State.Error, Arrays.asList(new Impact[]{Impact.USAGE})));

            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.OperationFailed, State.Stopped, null));
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.ExpungeOperation, State.Expunging, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.AgentReportShutdowned, State.Stopped, null));
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.StorageMigrationRequested, State.Migrating, null));
            s_fsm.addTransition(new Transition<>(State.Starting, VirtualMachine.Event.OperationRetry, State.Starting, null));
            s_fsm.addTransition(new Transition<>(State.Starting, VirtualMachine.Event.OperationSucceeded, State.Running, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Starting, VirtualMachine.Event.OperationFailed, State.Stopped, null));
            s_fsm.addTransition(new Transition<>(State.Starting, VirtualMachine.Event.AgentReportRunning, State.Running, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Starting, VirtualMachine.Event.AgentReportStopped, State.Stopped, null));
            s_fsm.addTransition(new Transition<>(State.Starting, VirtualMachine.Event.AgentReportShutdowned, State.Stopped, null));
            s_fsm.addTransition(new Transition<>(State.Destroyed, VirtualMachine.Event.RecoveryRequested, State.Stopped, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Destroyed, VirtualMachine.Event.ExpungeOperation, State.Expunging, null));
            s_fsm.addTransition(new Transition<>(State.Running, VirtualMachine.Event.MigrationRequested, State.Migrating, null));
            s_fsm.addTransition(new Transition<>(State.Running, VirtualMachine.Event.AgentReportRunning, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Running, VirtualMachine.Event.AgentReportStopped, State.Stopped, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Running, VirtualMachine.Event.StopRequested, State.Stopping, null));
            s_fsm.addTransition(new Transition<>(State.Running, VirtualMachine.Event.AgentReportShutdowned, State.Stopped, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Running, VirtualMachine.Event.AgentReportMigrated, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Running, VirtualMachine.Event.OperationSucceeded, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Migrating, VirtualMachine.Event.MigrationRequested, State.Migrating, null));
            s_fsm.addTransition(new Transition<>(State.Migrating, VirtualMachine.Event.OperationSucceeded, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Migrating, VirtualMachine.Event.OperationFailed, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Migrating, VirtualMachine.Event.AgentReportRunning, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Migrating, VirtualMachine.Event.AgentReportStopped, State.Stopped, null));
            s_fsm.addTransition(new Transition<>(State.Migrating, VirtualMachine.Event.AgentReportShutdowned, State.Stopped, null));
            s_fsm.addTransition(new Transition<>(State.Stopping, VirtualMachine.Event.OperationSucceeded, State.Stopped, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Stopping, VirtualMachine.Event.OperationFailed, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Stopping, VirtualMachine.Event.AgentReportRunning, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Stopping, VirtualMachine.Event.AgentReportStopped, State.Stopped, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Stopping, VirtualMachine.Event.StopRequested, State.Stopping, null));
            s_fsm.addTransition(new Transition<>(State.Stopping, VirtualMachine.Event.AgentReportShutdowned, State.Stopped, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Expunging, VirtualMachine.Event.OperationFailed, State.Expunging, null));
            s_fsm.addTransition(new Transition<>(State.Expunging, VirtualMachine.Event.ExpungeOperation, State.Expunging, null));
            s_fsm.addTransition(new Transition<>(State.Error, VirtualMachine.Event.DestroyRequested, State.Expunging, null));
            s_fsm.addTransition(new Transition<>(State.Error, VirtualMachine.Event.ExpungeOperation, State.Expunging, null));
            s_fsm.addTransition(new Transition<>(State.Paused, VirtualMachine.Event.AgentReportRunning, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Paused, VirtualMachine.Event.StopRequested, State.Stopping, null));
            s_fsm.addTransition(new Transition<>(State.Paused, VirtualMachine.Event.AgentReportStopped, State.Stopped, Arrays.asList(new Impact[]{Impact.USAGE})));

            s_fsm.addTransition(new Transition<>(State.Starting, VirtualMachine.Event.FollowAgentPowerPausedReport, State.Paused, null));
            s_fsm.addTransition(new Transition<>(State.Stopping, VirtualMachine.Event.FollowAgentPowerPausedReport, State.Paused, null));
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.FollowAgentPowerPausedReport, State.Paused, null));
            s_fsm.addTransition(new Transition<>(State.Running, VirtualMachine.Event.FollowAgentPowerPausedReport, State.Paused, null));
            s_fsm.addTransition(new Transition<>(State.Migrating, VirtualMachine.Event.FollowAgentPowerPausedReport, State.Paused, null));

            s_fsm.addTransition(new Transition<>(State.Starting, VirtualMachine.Event.FollowAgentPowerOnReport, State.Running, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Stopping, VirtualMachine.Event.FollowAgentPowerOnReport, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.FollowAgentPowerOnReport, State.Running, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Running, VirtualMachine.Event.FollowAgentPowerOnReport, State.Running, null));
            s_fsm.addTransition(new Transition<>(State.Migrating, VirtualMachine.Event.FollowAgentPowerOnReport, State.Running, null));

            s_fsm.addTransition(new Transition<>(State.Starting, VirtualMachine.Event.FollowAgentPowerOffReport, State.Stopped, null));
            s_fsm.addTransition(new Transition<>(State.Stopping, VirtualMachine.Event.FollowAgentPowerOffReport, State.Stopped, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Running, VirtualMachine.Event.FollowAgentPowerOffReport, State.Stopped, Arrays.asList(new Impact[]{Impact.USAGE})));
            s_fsm.addTransition(new Transition<>(State.Migrating, VirtualMachine.Event.FollowAgentPowerOffReport, State.Stopped, null));
            s_fsm.addTransition(new Transition<>(State.Stopped, VirtualMachine.Event.FollowAgentPowerOffReport, State.Stopped, null));
        }

        private final boolean _transitional;
        String _description;

        private State(final boolean transitional, final String description) {
            _transitional = transitional;
            _description = description;
        }

        public static StateMachine2<State, VirtualMachine.Event, VirtualMachine> getStateMachine() {
            return s_fsm;
        }

        public static boolean isVmStarted(final State oldState, final Event e, final State newState) {
            if (oldState == State.Starting && newState == State.Running) {
                return true;
            }
            return false;
        }

        public static boolean isVmStopped(final State oldState, final Event e, final State newState) {
            if ((oldState == State.Stopping && newState == State.Stopped) ||
                    (oldState == State.Running &&
                            newState == State.Stopped &&
                            e == Event.FollowAgentPowerOffReport)) {
                return true;
            }
            return false;
        }

        public static boolean isVmMigrated(final State oldState, final Event e, final State newState) {
            if (oldState == State.Migrating && newState == State.Running && (e == Event.OperationSucceeded || e == Event.AgentReportRunning)) {
                return true;
            }
            return false;
        }

        public static boolean isVmCreated(final State oldState, final Event e, final State newState) {
            if (oldState == State.Destroyed && newState == State.Stopped) {
                // VM recover
                return true;
            }
            return false;
        }

        public static boolean isVmDestroyed(final State oldState, final Event e, final State newState) {
            if (oldState == State.Stopped && newState == State.Destroyed) {
                return true;
            }
            if (oldState == State.Stopped && newState == State.Error) {
                return true;
            }

            if (oldState == State.Stopped && newState == State.Expunging) {
                return true;
            }

            return false;
        }

        public String getDescription() {
            return _description;
        }

        public boolean isTransitional() {
            return _transitional;
        }
    }

    public enum Event {
        CreateRequested,
        StartRequested,
        StopRequested,
        DestroyRequested,
        RecoveryRequested,
        AgentReportStopped,
        AgentReportRunning,
        MigrationRequested,
        StorageMigrationRequested,
        ExpungeOperation,
        OperationSucceeded,
        OperationFailed,
        OperationFailedToError,
        OperationRetry,
        AgentReportShutdowned,
        AgentReportMigrated,
        RevertRequested,
        SnapshotRequested,

        // added for new VMSync logic
        FollowAgentPowerOnReport,
        FollowAgentPowerOffReport,
        FollowAgentPowerPausedReport,
    }

    public enum Type {
        User(false), DomainRouter(true), ConsoleProxy(true), SecondaryStorageVm(true), ElasticIpVm(true), ElasticLoadBalancerVm(true), InternalLoadBalancerVm(true),

        /*
         * General VM type for queuing VM orchestration work
         */
        Instance(false);

        boolean _isUsedBySystem;

        private Type(final boolean isUsedBySystem) {
            _isUsedBySystem = isUsedBySystem;
        }

        public boolean isUsedBySystem() {
            return _isUsedBySystem;
        }
    }
}
