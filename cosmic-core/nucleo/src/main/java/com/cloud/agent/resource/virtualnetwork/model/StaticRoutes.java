package com.cloud.agent.resource.virtualnetwork.model;

import java.util.List;

public class StaticRoutes extends ConfigBaseTyped {
    private List<StaticRoute> routes;

    public StaticRoutes() {
        super(ConfigBaseTyped.STATIC_ROUTES);
    }

    public StaticRoutes(final List<StaticRoute> routes) {
        super(ConfigBaseTyped.STATIC_ROUTES);
        this.routes = routes;
    }

    public List<StaticRoute> getRoutes() {
        return routes;
    }

    public void setRoutes(final List<StaticRoute> routes) {
        this.routes = routes;
    }
}
