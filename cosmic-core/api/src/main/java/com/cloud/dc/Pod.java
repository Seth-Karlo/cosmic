package com.cloud.dc;

import com.cloud.acl.InfrastructureEntity;
import com.cloud.api.Identity;
import com.cloud.api.InternalIdentity;
import com.cloud.model.enumeration.AllocationState;

/**
 * Represents one pod in the cloud stack.
 */
public interface Pod extends InfrastructureEntity, Identity, InternalIdentity {

    String getCidrAddress();

    int getCidrSize();

    String getGateway();

    long getDataCenterId();

    String getDescription();

    String getName();

    AllocationState getAllocationState();

    boolean getExternalDhcp();

    boolean belongsToDataCenter(final long dataCenterId);
}
