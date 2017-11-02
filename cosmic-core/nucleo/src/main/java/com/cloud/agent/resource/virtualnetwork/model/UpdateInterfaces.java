package com.cloud.agent.resource.virtualnetwork.model;

import java.util.Map;

public class UpdateInterfaces extends ConfigBase{

    Map<String, Interface> interfaces;
    Map<String, Service> services;

    public UpdateInterfaces(final Map<String, Interface> interfaces, final Map<String, Service> services) {
        this.interfaces = interfaces;
        this.services = services;
    }

    public Map<String, Interface> getInterfaces() {
        return interfaces;
    }

    public Map<String, Service> getServices() {
        return services;
    }
}
