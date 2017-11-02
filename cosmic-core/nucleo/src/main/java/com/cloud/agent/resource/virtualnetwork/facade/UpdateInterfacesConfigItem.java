package com.cloud.agent.resource.virtualnetwork.facade;

import com.cloud.agent.api.UpdateInterfacesCommand;
import com.cloud.agent.api.routing.NetworkElementCommand;
import com.cloud.agent.api.to.IpAddressTO;
import com.cloud.agent.resource.virtualnetwork.ConfigItem;
import com.cloud.agent.resource.virtualnetwork.VRScripts;
import com.cloud.agent.resource.virtualnetwork.model.ConfigBase;
import com.cloud.agent.resource.virtualnetwork.model.IPv4Address;
import com.cloud.agent.resource.virtualnetwork.model.Interface;
import com.cloud.agent.resource.virtualnetwork.model.Service;
import com.cloud.agent.resource.virtualnetwork.model.ServiceSourceNat;
import com.cloud.agent.resource.virtualnetwork.model.UpdateInterfaces;
import com.cloud.utils.net.NetUtils;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class UpdateInterfacesConfigItem extends AbstractConfigItemFacade {

    @Override
    public List<ConfigItem> generateConfig(final NetworkElementCommand cmd) {
        final UpdateInterfacesCommand command = (UpdateInterfacesCommand) cmd;

        final Map<String, Interface> interfaces = new HashMap<>();
        final Map<String, Service> services = new HashMap<>();

        Arrays.stream(command.getNicTOS()).forEach(nicTO -> {
            interfaces.put(nicTO.getMac(), new Interface(new HashMap<>(), null));
        });

        Arrays.stream(command.getIpAddressTOS()).forEach(ipAddressTO -> {
            interfaces.get(ipAddressTO.getMacAddress())
                      .getIpv4Address()
                      .put(ipAddressTO.getPublicIp() + "/" + NetUtils.getCidrSize(ipAddressTO.getVlanNetmask()), new IPv4Address());
        });

        Optional<IpAddressTO> sourceNat = Arrays.stream(command.getIpAddressTOS()).filter(IpAddressTO::isSourceNat).findFirst();
        sourceNat.ifPresent(ipAddressTO -> services.put("source_nat", new ServiceSourceNat(ipAddressTO.getPublicIp())));

        // Build JSON object in Java
        final UpdateInterfaces updateInterfaces = new UpdateInterfaces(interfaces, services);

        return generateConfigItems(updateInterfaces);
    }

    @Override
    protected List<ConfigItem> generateConfigItems(final ConfigBase configuration) {
        destinationFile = VRScripts.INTERFACES_CONFIG;

        return super.generateConfigItems(configuration);
    }
}
