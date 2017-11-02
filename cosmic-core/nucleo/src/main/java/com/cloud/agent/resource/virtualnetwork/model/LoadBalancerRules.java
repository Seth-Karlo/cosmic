package com.cloud.agent.resource.virtualnetwork.model;

import java.util.List;

public class LoadBalancerRules extends ConfigBaseTyped {
    List<LoadBalancerRule> rules;

    public LoadBalancerRules() {
        super(ConfigBaseTyped.LOAD_BALANCER);
    }

    public LoadBalancerRules(final List<LoadBalancerRule> rules) {
        super(ConfigBaseTyped.LOAD_BALANCER);
        this.rules = rules;
    }

    public List<LoadBalancerRule> getRules() {
        return rules;
    }

    public void setRules(final List<LoadBalancerRule> rules) {
        this.rules = rules;
    }
}
