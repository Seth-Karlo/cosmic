package com.cloud.agent.resource.virtualnetwork.model;

import java.util.List;

public class IpAliases extends ConfigBaseTyped {
    List<IpAddressAlias> aliases;

    public IpAliases() {
        super(ConfigBaseTyped.IP_ALIAS_CONFIG);
    }

    public IpAliases(final List<IpAddressAlias> aliases) {
        super(ConfigBaseTyped.IP_ALIAS_CONFIG);
        this.aliases = aliases;
    }

    public List<IpAddressAlias> getAliases() {
        return aliases;
    }

    public void setAliases(final List<IpAddressAlias> aliases) {
        this.aliases = aliases;
    }
}
