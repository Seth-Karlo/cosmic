package com.cloud.agent.resource.virtualnetwork.model;

public class ServiceSourceNat extends Service{
    private String Ipv4Address;

    public ServiceSourceNat(final String ipv4Address) {
        Ipv4Address = ipv4Address;
    }

    public String getIpv4Address() {
        return Ipv4Address;
    }
}
