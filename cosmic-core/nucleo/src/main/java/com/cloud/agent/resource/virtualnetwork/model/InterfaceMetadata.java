package com.cloud.agent.resource.virtualnetwork.model;

public class InterfaceMetadata {
    private String type;
    private String domainname;
    private String dns1;
    private String dns2;

    public InterfaceMetadata(final String type, final String domainname, final String dns1, final String dns2) {
        this.type = type;
        this.domainname = domainname;
        this.dns1 = dns1;
        this.dns2 = dns2;
    }

    public String getType() {
        return type;
    }

    public String getDomainname() {
        return domainname;
    }

    public String getDns1() {
        return dns1;
    }

    public String getDns2() {
        return dns2;
    }
}
