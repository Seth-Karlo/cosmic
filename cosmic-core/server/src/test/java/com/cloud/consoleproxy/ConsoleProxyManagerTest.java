package com.cloud.consoleproxy;

import static org.mockito.AdditionalMatchers.not;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.anyLong;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import com.cloud.db.model.Zone;
import com.cloud.db.repository.ZoneRepository;
import com.cloud.model.enumeration.NetworkType;
import com.cloud.network.Networks.TrafficType;
import com.cloud.network.dao.NetworkDao;
import com.cloud.network.dao.NetworkVO;
import com.cloud.utils.db.GlobalLock;
import com.cloud.utils.exception.CloudRuntimeException;
import com.cloud.vm.ConsoleProxyVO;

import java.util.Collections;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.util.ReflectionTestUtils;

public class ConsoleProxyManagerTest {

    private static final Logger s_logger = LoggerFactory.getLogger(ConsoleProxyManagerTest.class);

    @Mock
    GlobalLock globalLock;
    @Mock
    ConsoleProxyVO proxyVO;
    @Mock
    NetworkDao _networkDao;
    @Mock
    ConsoleProxyManagerImpl cpvmManager;
    @Mock
    ZoneRepository zoneRepository;

    @Before
    public void setup() throws Exception {
        MockitoAnnotations.initMocks(this);
        ReflectionTestUtils.setField(cpvmManager, "_allocProxyLock", globalLock);
        ReflectionTestUtils.setField(cpvmManager, "_networkDao", _networkDao);
        ReflectionTestUtils.setField(cpvmManager, "zoneRepository", zoneRepository);
        Mockito.doCallRealMethod().when(cpvmManager).expandPool(Mockito.anyLong(), Mockito.anyObject());
        Mockito.doCallRealMethod().when(cpvmManager).getDefaultNetworkForCreation(Mockito.any(Zone.class));
        Mockito.doCallRealMethod().when(cpvmManager).getDefaultNetworkForAdvancedZone(Mockito.any(Zone.class));
        Mockito.doCallRealMethod().when(cpvmManager).getDefaultNetworkForBasicZone(Mockito.any(Zone.class));
    }

    @Test
    public void testNewCPVMCreation() throws Exception {
        s_logger.info("Running test for new CPVM creation");

        // No existing CPVM
        Mockito.when(cpvmManager.assignProxyFromStoppedPool(Mockito.anyLong())).thenReturn(null);
        // Allocate a new one
        Mockito.when(globalLock.lock(Mockito.anyInt())).thenReturn(true);
        Mockito.when(globalLock.unlock()).thenReturn(true);
        Mockito.when(cpvmManager.startNew(Mockito.anyLong())).thenReturn(proxyVO);
        // Start CPVM
        Mockito.when(cpvmManager.startProxy(Mockito.anyLong(), Mockito.anyBoolean())).thenReturn(proxyVO);

        cpvmManager.expandPool(new Long(1), new Object());
    }

    @Test
    public void testExistingCPVMStart() throws Exception {
        s_logger.info("Running test for existing CPVM start");

        // CPVM already exists
        Mockito.when(cpvmManager.assignProxyFromStoppedPool(Mockito.anyLong())).thenReturn(proxyVO);
        // Start CPVM
        Mockito.when(cpvmManager.startProxy(Mockito.anyLong(), Mockito.anyBoolean())).thenReturn(proxyVO);

        cpvmManager.expandPool(new Long(1), new Object());
    }

    @Test
    public void testExisingCPVMStartFailure() throws Exception {
        s_logger.info("Running test for existing CPVM start failure");

        // CPVM already exists
        Mockito.when(cpvmManager.assignProxyFromStoppedPool(Mockito.anyLong())).thenReturn(proxyVO);
        // Start CPVM
        Mockito.when(cpvmManager.startProxy(Mockito.anyLong(), Mockito.anyBoolean())).thenReturn(null);
        // Destroy existing CPVM, so that a new one is created subsequently
        Mockito.when(cpvmManager.destroyProxy(Mockito.anyLong())).thenReturn(true);

        cpvmManager.expandPool(new Long(1), new Object());
    }

    @Test
    public void getDefaultNetworkForAdvancedNonSG() {
        final Zone zone = mock(Zone.class);
        when(zone.getNetworkType()).thenReturn(NetworkType.Advanced);
        when(zone.isSecurityGroupEnabled()).thenReturn(false);

        when(zoneRepository.findOne(Mockito.anyLong())).thenReturn(zone);

        final NetworkVO network = Mockito.mock(NetworkVO.class);
        final NetworkVO badNetwork = Mockito.mock(NetworkVO.class);
        when(_networkDao.listByZoneAndTrafficType(anyLong(), eq(TrafficType.Public)))
                .thenReturn(Collections.singletonList(network));

        when(_networkDao.listByZoneAndTrafficType(anyLong(), not(eq(TrafficType.Public))))
                .thenReturn(Collections.singletonList(badNetwork));

        when(_networkDao.listByZoneSecurityGroup(anyLong()))
                .thenReturn(Collections.singletonList(badNetwork));

        final NetworkVO returnedNetwork = cpvmManager.getDefaultNetworkForAdvancedZone(zone);

        Assert.assertNotNull(returnedNetwork);
        Assert.assertEquals(network, returnedNetwork);
        Assert.assertNotEquals(badNetwork, returnedNetwork);
    }

    @Test
    public void getDefaultNetworkForAdvancedSG() {
        final Zone zone = mock(Zone.class);
        when(zone.getNetworkType()).thenReturn(NetworkType.Advanced);
        when(zone.isSecurityGroupEnabled()).thenReturn(true);

        when(zoneRepository.findOne(Mockito.anyLong())).thenReturn(zone);

        final NetworkVO network = Mockito.mock(NetworkVO.class);
        final NetworkVO badNetwork = Mockito.mock(NetworkVO.class);
        when(_networkDao.listByZoneAndTrafficType(anyLong(), any(TrafficType.class)))
                .thenReturn(Collections.singletonList(badNetwork));

        when(_networkDao.listByZoneSecurityGroup(anyLong()))
                .thenReturn(Collections.singletonList(network));

        final NetworkVO returnedNetwork = cpvmManager.getDefaultNetworkForAdvancedZone(zone);

        Assert.assertEquals(network, returnedNetwork);
        Assert.assertNotEquals(badNetwork, returnedNetwork);
    }

    @Test
    public void getDefaultNetworkForBasicNonSG() {
        final Zone zone = mock(Zone.class);
        when(zone.getNetworkType()).thenReturn(NetworkType.Basic);
        when(zone.isSecurityGroupEnabled()).thenReturn(false);

        when(zoneRepository.findOne(Mockito.anyLong())).thenReturn(zone);

        final NetworkVO network = Mockito.mock(NetworkVO.class);
        final NetworkVO badNetwork = Mockito.mock(NetworkVO.class);
        when(_networkDao.listByZoneAndTrafficType(anyLong(), eq(TrafficType.Guest)))
                .thenReturn(Collections.singletonList(network));

        when(_networkDao.listByZoneAndTrafficType(anyLong(), not(eq(TrafficType.Guest))))
                .thenReturn(Collections.singletonList(badNetwork));

        final NetworkVO returnedNetwork = cpvmManager.getDefaultNetworkForBasicZone(zone);
        Assert.assertNotNull(returnedNetwork);
        Assert.assertEquals(network, returnedNetwork);
        Assert.assertNotEquals(badNetwork, returnedNetwork);
    }

    @Test
    public void getDefaultNetworkForBasicSG() {
        final Zone zone = mock(Zone.class);
        when(zone.getNetworkType()).thenReturn(NetworkType.Basic);
        when(zone.isSecurityGroupEnabled()).thenReturn(true);

        when(zoneRepository.findOne(Mockito.anyLong())).thenReturn(zone);

        final NetworkVO network = Mockito.mock(NetworkVO.class);
        final NetworkVO badNetwork = Mockito.mock(NetworkVO.class);
        when(_networkDao.listByZoneAndTrafficType(anyLong(), eq(TrafficType.Guest)))
                .thenReturn(Collections.singletonList(network));

        when(_networkDao.listByZoneAndTrafficType(anyLong(), not(eq(TrafficType.Guest))))
                .thenReturn(Collections.singletonList(badNetwork));

        final NetworkVO returnedNetwork = cpvmManager.getDefaultNetworkForBasicZone(zone);

        Assert.assertNotNull(returnedNetwork);
        Assert.assertEquals(network, returnedNetwork);
        Assert.assertNotEquals(badNetwork, returnedNetwork);
    }

    //also test invalid input
    @Test(expected = CloudRuntimeException.class)
    public void getDefaultNetworkForBasicSGWrongZoneType() {
        final Zone zone = mock(Zone.class);
        when(zone.getNetworkType()).thenReturn(NetworkType.Advanced);
        when(zone.isSecurityGroupEnabled()).thenReturn(true);

        when(zoneRepository.findOne(Mockito.anyLong())).thenReturn(zone);

        final NetworkVO network = Mockito.mock(NetworkVO.class);
        final NetworkVO badNetwork = Mockito.mock(NetworkVO.class);
        when(_networkDao.listByZoneAndTrafficType(anyLong(), eq(TrafficType.Guest)))
                .thenReturn(Collections.singletonList(network));

        when(_networkDao.listByZoneAndTrafficType(anyLong(), not(eq(TrafficType.Guest))))
                .thenReturn(Collections.singletonList(badNetwork));

        cpvmManager.getDefaultNetworkForBasicZone(zone);
    }

    @Test(expected = CloudRuntimeException.class)
    public void getDefaultNetworkForAdvancedWrongZoneType() {
        final Zone zone = mock(Zone.class);
        when(zone.getNetworkType()).thenReturn(NetworkType.Basic);
        when(zone.isSecurityGroupEnabled()).thenReturn(true);

        when(zoneRepository.findOne(Mockito.anyLong())).thenReturn(zone);

        final NetworkVO network = Mockito.mock(NetworkVO.class);
        final NetworkVO badNetwork = Mockito.mock(NetworkVO.class);
        when(_networkDao.listByZoneAndTrafficType(anyLong(), any(TrafficType.class)))
                .thenReturn(Collections.singletonList(badNetwork));

        when(_networkDao.listByZoneSecurityGroup(anyLong()))
                .thenReturn(Collections.singletonList(network));

        cpvmManager.getDefaultNetworkForAdvancedZone(zone);
    }
}
