package com.cloud.agent.resource.virtualnetwork.model;

public class VmPassword extends ConfigBaseTyped {
    private String ipAddress;
    private String password;

    public VmPassword() {
        super(ConfigBaseTyped.VM_PASSWORD);
    }

    public VmPassword(final String ipAddress, final String password) {
        super(ConfigBaseTyped.VM_PASSWORD);
        this.ipAddress = ipAddress;
        this.password = password;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(final String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(final String password) {
        this.password = password;
    }
}
