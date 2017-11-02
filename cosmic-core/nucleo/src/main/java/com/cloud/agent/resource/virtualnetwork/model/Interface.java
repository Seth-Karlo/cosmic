package com.cloud.agent.resource.virtualnetwork.model;

import java.util.Map;

public class Interface {
    Map<String, IPv4Address> ipv4Address;
    InterfaceMetadata metadata;

    public Interface(final Map<String, IPv4Address> ipv4Address, final InterfaceMetadata metadata) {
        this.ipv4Address = ipv4Address;
        this.metadata = metadata;
    }

    public Map<String, IPv4Address> getIpv4Address() {
        return ipv4Address;
    }

    public InterfaceMetadata getMetadata() {
        return metadata;
    }
}
