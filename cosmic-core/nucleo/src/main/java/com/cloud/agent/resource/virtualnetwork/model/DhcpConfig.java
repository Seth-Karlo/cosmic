package com.cloud.agent.resource.virtualnetwork.model;

import java.util.LinkedList;
import java.util.List;

public class DhcpConfig extends ConfigBaseTyped {
    List<DhcpConfigEntry> entries = new LinkedList<>();

    public DhcpConfig() {
        super(ConfigBaseTyped.DHCP_CONFIG);
    }

    public DhcpConfig(final List<DhcpConfigEntry> entries) {
        super(ConfigBaseTyped.DHCP_CONFIG);
        this.entries = entries;
    }

    public List<DhcpConfigEntry> getEntries() {
        return entries;
    }

    public void setEntries(final List<DhcpConfigEntry> entries) {
        this.entries = entries;
    }
}
