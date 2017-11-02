package com.cloud.agent.resource.virtualnetwork.model;

public class VRConfig extends ConfigBaseTyped {
    private String sourceNatList;
    private String syslogServerList;
    private String vpcName;

    public VRConfig() {
        // Empty constructor for (de)serialization
        super(ConfigBaseTyped.VR);
    }

    public VRConfig(final String vpcName, final String sourceNatList, final String syslogServerList) {
        super(ConfigBaseTyped.VR);
        this.sourceNatList = sourceNatList;
        this.syslogServerList = syslogServerList;
        this.vpcName = vpcName;
    }

    public String getSourceNatList() {
        return sourceNatList;
    }

    public void setSourceNatList(final String sourceNatList) {
        this.sourceNatList = sourceNatList;
    }

    public String getSyslogServerList() {
        return syslogServerList;
    }

    public void setSyslogServerList(final String syslogServerList) {
        this.syslogServerList = syslogServerList;
    }
}
