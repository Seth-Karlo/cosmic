package com.cloud.agent.api;

import com.cloud.agent.api.routing.NetworkElementCommand;
import com.cloud.agent.api.to.IpAddressTO;
import com.cloud.agent.api.to.NicTO;

public class UpdateInterfacesCommand extends NetworkElementCommand {
    private NicTO[] nicTOS;
    private IpAddressTO[] ipAddressTOS;

    protected UpdateInterfacesCommand() {}

    public UpdateInterfacesCommand(final NicTO[] nicTOS, final IpAddressTO[] ipAddressTOS) {
        this.nicTOS = nicTOS;
        this.ipAddressTOS = ipAddressTOS;
    }

    public NicTO[] getNicTOS() {
        return nicTOS;
    }

    public IpAddressTO[] getIpAddressTOS() {
        return ipAddressTOS;
    }

    @Override
    public boolean executeInSequence() {
        return true;
    }
}
