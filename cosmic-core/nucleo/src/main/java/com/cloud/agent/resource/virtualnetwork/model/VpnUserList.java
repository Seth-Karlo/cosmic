package com.cloud.agent.resource.virtualnetwork.model;

import java.util.List;

public class VpnUserList extends ConfigBaseTyped {
    private List<VpnUser> vpnUsers;

    public VpnUserList() {
        super(ConfigBaseTyped.VPN_USER_LIST);
    }

    public VpnUserList(final List<VpnUser> vpnUsers) {
        super(ConfigBaseTyped.VPN_USER_LIST);
        this.vpnUsers = vpnUsers;
    }

    public List<VpnUser> getVpnUsers() {
        return vpnUsers;
    }

    public void setVpnUsers(final List<VpnUser> vpnUsers) {
        this.vpnUsers = vpnUsers;
    }
}
