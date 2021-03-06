package com.cloud.dc;

import com.cloud.acl.InfrastructureEntity;
import com.cloud.api.Identity;
import com.cloud.api.InternalIdentity;

import java.util.Date;

public interface Vlan extends InfrastructureEntity, InternalIdentity, Identity {
    public final static String UNTAGGED = "untagged";

    public String getVlanTag();

    public String getVlanGateway();

    public String getVlanNetmask();

    public long getDataCenterId();

    public String getIpRange();

    public VlanType getVlanType();

    public Long getNetworkId();

    public Date getRemoved();

    public Date getCreated();

    public Long getPhysicalNetworkId();

    public String getIp6Gateway();

    public String getIp6Cidr();

    public String getIp6Range();

    public enum VlanType {
        DirectAttached, VirtualNetwork
    }
}
