package com.cloud.agent.resource.virtualnetwork.model;

public class ForwardingRules extends ConfigBaseTyped {
    ForwardingRule[] rules;

    public ForwardingRules() {
        super(ConfigBaseTyped.FORWARDING_RULES);
    }

    public ForwardingRules(final ForwardingRule[] rules) {
        super(ConfigBaseTyped.FORWARDING_RULES);
        this.rules = rules;
    }

    public ForwardingRule[] getRules() {
        return rules;
    }

    public void setRules(final ForwardingRule[] rules) {
        this.rules = rules;
    }
}
