from marvin.lib.base import (Vpn,
                             VpnCustomerGateway,
                             StaticRoute,
                             PrivateGateway,
                             Network,
                             NATRule,
                             PublicIPAddress,
                             VirtualMachine,
                             NetworkACL,
                             NetworkACLList,
                             VPC,
                             Account,
                             Domain,
                             EgressFireWallRule,
                             FireWallRule)

from marvin.lib.common import (get_vpngateway,
                               get_vpc,
                               get_virtual_machine,
                               get_network,
                               get_network_acl)

from marvin.lib.utils import (random_gen,
                              cleanup_resources)

from marvin.utils.MarvinLog import MarvinLog


class TestScenarioManager:

    def __init__(self, api_client, scenario_data, zone):
        self.api_client = api_client
        self.scenario_data = scenario_data
        self.zone = zone
        self.logger = MarvinLog(MarvinLog.LOGGER_TEST).get_logger()
        self.dynamic_names = {
            'accounts': {},
            'vpcs': {},
            'vms': {},
        }
        self.resources_to_cleanup = []

    def setup_infra(self):
        scenario_data = self.scenario_data['data']
        self.deploy_domains(scenario_data['domains'])

    def deploy_domains(self, domains_data):
        for domain in domains_data:
            self.deploy_domain(domain['data'])

    def deploy_domain(self, domain_data):
        if domain_data['name'] == 'ROOT':
            domain_list = Domain.list(
                api_client=self.api_client,
                name=domain_data['name']
            )
            domain = domain_list[0]
        else:
            self.logger.debug('>>>  DOMAIN  =>  Creating...')
            domain = Domain.create(
                api_client=self.api_client,
                name=domain_data['name'] + '-' + random_gen()
            )

        self.logger.debug('>>>  DOMAIN  =>  ID: %s  =>  Name: %s  =>  Path: %s  =>  State: %s', domain.id, domain.name,
                          domain.path, domain.state)

        self.deploy_accounts(domain_data['accounts'], domain)

    def deploy_accounts(self, accounts_data, domain):
        for account in accounts_data:
            self.deploy_account(account['data'], domain)

    def deploy_account(self, account_data, domain):
        self.logger.debug('>>>  ACCOUNT  =>  Creating...')
        account = Account.create(
            api_client=self.api_client,
            services=account_data,
            domainid=domain.uuid
        )
        self.resources_to_cleanup.append(account)
        self.dynamic_names['accounts'][account_data['username']] = account.name

        self.logger.debug('>>>  ACCOUNT  =>  ID: %s  =>  Name: %s  =>  State: %s  =>  Domain: %s', account.id,
                          account.name, account.state, account.domainid)

        self.deploy_vpcs(account_data['vpcs'], account)
        self.deploy_isolatednetworks(account_data['isolatednetworks'], account)
        self.deploy_vms(account_data['virtualmachines'], account)
        self.deploy_vpcs_publicipaddresses(account_data['vpcs'], account_data['virtualmachines'])
        self.deploy_isolatednetworks_publicipaddresses(account_data['isolatednetworks'], account_data['virtualmachines'])
        self.deploy_privatenetworks(account_data['privatenetworks'], account, domain)
        self.deploy_vpcs_privategateways(account_data['vpcs'])
        self.enable_vpcs_localvpngateway(account_data['vpcs'])
        self.deploy_vpcs_remotevpngateways(account_data['vpcs'], account)

    def deploy_vpcs(self, vpcs_data, account):
        for vpc in vpcs_data:
            self.deploy_vpc(vpc['data'], account)

    def deploy_vpc(self, vpc_data, account):
        self.logger.debug('>>>  VPC  =>  Creating...')
        vpc = VPC.create(
            api_client=self.api_client,
            data=vpc_data,
            zone=self.zone,
            account=account
        )
        self.dynamic_names['vpcs'][vpc_data['name']] = vpc.name

        self.logger.debug('>>>  VPC  =>  ID: %s  =>  Name: %s  =>  CIDR: %s  =>  State: %s  =>  Offering: %s  '
                          '=>  Account: %s  =>  Domain: %s', vpc.id, vpc.name, vpc.cidr, vpc.state, vpc.vpcofferingid,
                          vpc.account, vpc.domainid)

        self.deploy_acls(vpc_data['acls'], vpc)
        self.deploy_networks(vpc_data['networks'], vpc)

    def deploy_acls(self, acls_data, vpc):
        for acl in acls_data:
            self.deploy_acl(acl['data'], vpc)

    def deploy_acl(self, acl_data, vpc):
        self.logger.debug('>>>  ACL  =>  Creating...')
        acl = NetworkACLList.create(
            api_client=self.api_client,
            data=acl_data,
            vpc=vpc
        )

        self.logger.debug('>>>  ACL  =>  ID: %s  =>  Name: %s  =>  VPC: %s', acl.id, acl.name, acl.vpcid)

        self.deploy_rules(acl_data['rules'], acl)

    def deploy_rules(self, rules_data, acl):
        for rule in rules_data:
            self.deploy_rule(rule['data'], acl)

    def deploy_rule(self, rule_data, acl):
        self.logger.debug('>>>  ACL RULE  =>  Creating...')
        rule = NetworkACL.create(
            api_client=self.api_client,
            data=rule_data,
            acl=acl
        )

        self.logger.debug('>>>  ACL RULE  =>  ID: %s  =>  Number: %s  =>  Action: %s  =>  Traffic Type: %s  '
                          '=>  CIDR List: %s  =>  Protocol: %s  =>  Start Port: %s  =>  End Port: %s  =>  ACL: %s',
                          rule.id, rule.number, rule.action, rule.traffictype, rule.cidrlist, rule.protocol.upper(),
                          rule.startport, rule.endport, rule.aclid)

    def deploy_networks(self, networks_data, vpc):
        for network in networks_data:
            self.deploy_network(network['data'], vpc)

    def deploy_network(self, network_data, vpc):
        acl = get_network_acl(api_client=self.api_client, name=network_data['aclname'], vpc=vpc)

        self.logger.debug('>>>  NETWORK  =>  Creating...')
        network = Network.create(
            self.api_client,
            data=network_data,
            vpc=vpc,
            zone=self.zone,
            acl=acl
        )

        self.logger.debug('>>>  NETWORK  =>  ID: %s  =>  Name: %s  =>  CIDR: %s  =>  Gateway: %s  =>  Type: %s  '
                          '=>  Traffic Type: %s  =>  State: %s  =>  Offering: %s  =>  ACL: %s  '
                          '=>  Physical Network: %s  =>  VPC: %s  =>  Domain: %s', network.id, network.name,
                          network.cidr, network.gateway, network.type, network.traffictype, network.state,
                          network.networkofferingid, network.aclid, network.physicalnetworkid, network.vpcid,
                          network.domainid)

    def deploy_vms(self, vms_data, account):
        for vm in vms_data:
            self.deploy_vm(vm['data'], account)

    def deploy_vm(self, vm_data, account):
        network_and_ip_list = []
        for nic in vm_data['nics']:
            network = get_network(api_client=self.api_client, name=nic['data']['networkname'])
            network_and_ip = {
                'networkid': network.id
            }
            if 'guestip' in nic['data']:
                network_and_ip['ip'] = nic['data']['guestip']
            network_and_ip_list.append(network_and_ip)

        self.logger.debug('>>>  VM  =>  Creating...')
        vm = VirtualMachine.create(
            self.api_client,
            data=vm_data,
            zone=self.zone,
            account=account,
            network_and_ip_list=network_and_ip_list
        )
        self.dynamic_names['vms'][vm_data['name']] = vm.name

        self.logger.debug('>>>  VM  =>  ID: %s  =>  Name: %s  =>  IP: %s  =>  SSH IP: %s  =>  State: %s  '
                          '=>  Offering: %s  =>  Template: %s  =>  Hypervisor: %s  =>  Domain: %s', vm.id, vm.name,
                          vm.ipaddress, vm.ssh_ip, vm.state, vm.serviceofferingid, vm.templateid, vm.hypervisor,
                          vm.domainid)

    def deploy_vpcs_publicipaddresses(self, vpcs_data, virtualmachines_data):
        for vpc in vpcs_data:
            self.deploy_vpc_publicipaddresses(vpc['data'], virtualmachines_data)

    def deploy_vpc_publicipaddresses(self, vpc_data, virtualmachines_data):
        vpc = get_vpc(api_client=self.api_client, name=self.dynamic_names['vpcs'][vpc_data['name']])
        for publicipaddress in vpc_data['publicipaddresses']:
            self.deploy_publicipaddress(publicipaddress['data'], virtualmachines_data, vpc)

    def deploy_publicipaddress(self, publicipaddress_data, virtualmachines_data, vpc):
        self.logger.debug('>>>  PUBLIC IP ADDRESS  =>  Creating...')
        publicipaddress = PublicIPAddress.create(
            api_client=self.api_client,
            data=publicipaddress_data,
            vpc=vpc
        )

        ipaddress = publicipaddress.ipaddress
        self.logger.debug('>>>  PUBLIC IP ADDRESS  =>  ID: %s  =>  IP: %s  =>  State: %s  =>  Source NAT: %s  '
                          '=>  Static NAT: %s  =>  ACL: %s  =>  VLAN: %s  =>  Physical Network: %s  =>  Network: %s  '
                          '=>  VPC: %s  =>  Domain: %s', ipaddress.id, ipaddress.ipaddress, ipaddress.state,
                          ipaddress.issourcenat, ipaddress.isstaticnat, ipaddress.aclid, ipaddress.vlanid,
                          ipaddress.physicalnetworkid, ipaddress.networkid, ipaddress.vpcid, ipaddress.domainid)

        self.deploy_portforwards(publicipaddress_data['portforwards'], virtualmachines_data, vpc, publicipaddress)

    def deploy_portforwards(self, portforwards_data, virtualmachines_data, vpc, publicipaddress):
        for portforward_data in portforwards_data:
            for virtualmachine_data in virtualmachines_data:
                if virtualmachine_data['data']['name'] == portforward_data['data']['virtualmachinename']:
                    for nic_data in virtualmachine_data['data']['nics']:
                        if nic_data['data']['guestip'] == portforward_data['data']['nic']:
                            network = get_network(
                                api_client=self.api_client,
                                name=nic_data['data']['networkname'],
                                vpc=vpc
                            )
                            virtualmachine = get_virtual_machine(
                                api_client=self.api_client,
                                name=self.dynamic_names['vms'][virtualmachine_data['data']['name']],
                                network=network
                            )

                            self.logger.debug('>>>  PORT FORWARD  =>  Creating...')
                            portforward = NATRule.create(
                                api_client=self.api_client,
                                data=portforward_data['data'],
                                network=network,
                                virtual_machine=virtualmachine,
                                ipaddress=publicipaddress
                            )

                            self.logger.debug('>>>  PORT FORWARD  =>  ID: %s  =>  Public Start Port: %s  '
                                              '=>  Public End Port: %s  =>  Private Start Port: %s  '
                                              '=>  Private End Port: %s  =>  CIDR List: %s  =>  Protocol: %s  '
                                              '=>  State: %s  =>  IP: %s  =>  VM: %s', portforward.id,
                                              portforward.publicport, portforward.publicendport,
                                              portforward.privateport, portforward.privateendport, portforward.cidrlist,
                                              portforward.protocol, portforward.state, portforward.ipaddressid,
                                              portforward.virtualmachineid)

    def deploy_privatenetworks(self, privatenetworks_data, account, domain):
        for privatenetwork in privatenetworks_data:
            self.deploy_privatenetwork(privatenetwork['data'], account, domain)

    def deploy_privatenetwork(self, privatenetwork_data, account, domain):
        self.logger.debug('>>>  PRIVATE GATEWAY NETWORK  =>  Creating...')
        private_gateways_network = Network.create(
            api_client=self.api_client,
            data=privatenetwork_data,
            zone=self.zone,
            domain=domain,
            account=account
        )

        self.logger.debug('>>>  PRIVATE GATEWAY NETWORK  =>  ID: %s  =>  Name: %s  =>  CIDR: %s  =>  Type: %s  '
                          '=>  Traffic Type: %s  =>  State: %s  =>  Offering: %s  =>  Broadcast Domain Type: %s  '
                          '=>  Broadcast URI: %s  =>  Physical Network: %s  =>  Domain: %s',
                          private_gateways_network.id, private_gateways_network.name, private_gateways_network.cidr,
                          private_gateways_network.type, private_gateways_network.traffictype,
                          private_gateways_network.state, private_gateways_network.networkofferingid,
                          private_gateways_network.broadcastdomaintype, private_gateways_network.broadcasturi,
                          private_gateways_network.physicalnetworkid, private_gateways_network.domainid)

    def deploy_vpcs_privategateways(self, vpcs_data):
        for vpc in vpcs_data:
            self.deploy_vpc_privategateways(vpc['data'])

    def deploy_vpc_privategateways(self, vpc_data):
        vpc = get_vpc(api_client=self.api_client, name=self.dynamic_names['vpcs'][vpc_data['name']])
        for privategateway in vpc_data['privategateways']:
            self.deploy_privategateway(privategateway['data'], vpc)

    def deploy_privategateway(self, privategateway_data, vpc):
        self.logger.debug('>>>  PRIVATE GATEWAY  =>  Creating...')
        private_gateway = PrivateGateway.create(
            api_client=self.api_client,
            data=privategateway_data,
            vpc=vpc
        )

        self.logger.debug('>>>  PRIVATE GATEWAY  =>  ID: %s  =>  IP: %s  =>  CIDR: %s  =>  State: %s  '
                          '=>  Source NAT: %s  =>  ACL: %s  =>  Network: %s  =>  VPC: %s  =>  Domain: %s',
                          private_gateway.id, private_gateway.ipaddress, private_gateway.cidr, private_gateway.state,
                          private_gateway.sourcenatsupported, private_gateway.aclid, private_gateway.networkid,
                          private_gateway.vpcid, private_gateway.domainid)

        self.deploy_staticroutes(privategateway_data['staticroutes'], vpc)

    def deploy_staticroutes(self, staticroutes_data, vpc):
        for staticroute_data in staticroutes_data:
            self.logger.debug('>>>  STATIC ROUTE  =>  Creating...')
            staticroute = StaticRoute.create(
                api_client=self.api_client,
                data=staticroute_data['data'],
                vpc=vpc
            )

            self.logger.debug('>>>  STATIC ROUTE  =>  ID: %s  =>  CIDR: %s  =>  Next Hop: %s  =>  State: %s  '
                              '=>  VPC: %s  =>  Domain: %s', staticroute.id, staticroute.cidr, staticroute.nexthop,
                              staticroute.state, staticroute.vpcid, staticroute.domainid)

    def enable_vpcs_localvpngateway(self, vpcs_data):
        for vpc_data in vpcs_data:
            vpc = get_vpc(api_client=self.api_client, name=self.dynamic_names['vpcs'][vpc_data['data']['name']])
            if vpc_data['data']['vpnconnections']:
                self.logger.debug('>>>  VPN LOCAL GATEWAY  =>  Creating...')
                localvpngateway = Vpn.createVpnGateway(api_client=self.api_client, vpc=vpc)

                self.logger.debug('>>>  VPN LOCAL GATEWAY  =>  ID: %s  =>  IP: %s  =>  VPC: %s  =>  Domain: %s',
                                  localvpngateway['id'], localvpngateway['publicip'], localvpngateway['vpcid'],
                                  localvpngateway['domainid'])

    def deploy_vpcs_remotevpngateways(self, vpcs_data, account):
        for vpc_data in vpcs_data:
            for vpnconnection_data in vpc_data['data']['vpnconnections']:
                vpc = get_vpc(api_client=self.api_client, name=self.dynamic_names['vpcs'][vpc_data['data']['name']])
                vpc_vpngateway = get_vpngateway(api_client=self.api_client, vpc=vpc)

                remotevpc = get_vpc(api_client=self.api_client, name=self.dynamic_names['vpcs'][vpnconnection_data])
                remotevpc_vpngateway = get_vpngateway(api_client=self.api_client, vpc=remotevpc)

                self.logger.debug('>>>  VPN CUSTOMER GATEWAY  =>  Creating...')
                vpncustomergateway = VpnCustomerGateway.create(
                    api_client=self.api_client,
                    name="remotegateway_to_" + remotevpc.name,
                    gateway=remotevpc_vpngateway.publicip,
                    cidrlist=remotevpc.cidr,
                    presharedkey='notasecret',
                    ikepolicy='aes128-sha256;modp2048',
                    esppolicy='aes128-sha256;modp2048',
                    account=account.name,
                    domainid=account.domainid
                )

                self.logger.debug('>>>  VPN CUSTOMER GATEWAY  =>  ID: %s  =>  Name: %s  =>  CIDR List: %s  '
                                  '=>  Gateway: %s  =>  Domain: %s', vpncustomergateway.id, vpncustomergateway.name,
                                  vpncustomergateway.cidrlist, vpncustomergateway.gateway, vpncustomergateway.domainid)

                self.logger.debug('>>>  VPN CONNECTION  =>  Creating...')
                vpnconnection = Vpn.createVpnConnection(
                    api_client=self.api_client,
                    s2svpngatewayid=vpc_vpngateway.id,
                    s2scustomergatewayid=vpncustomergateway.id
                )

                self.logger.debug('>>>  VPN CONNECTION  =>  ID: %s  =>  VPN Local Gateway: %s  '
                                  '=>  VPN Customer Gateway: %s  =>  State: %s', vpnconnection['id'],
                                  vpnconnection['s2svpngatewayid'], vpnconnection['s2scustomergatewayid'],
                                  vpnconnection['state'])

    def deploy_isolatednetworks(self, isolatednetworks_data, account):
        for isolatednetwork in isolatednetworks_data:
            self.deploy_isolatednetwork(isolatednetwork['data'], account)

    def deploy_isolatednetwork(self, isolatednetwork_data, account):
        self.logger.debug('>>>  ISOLATED NETWORKS  =>  Creating...')
        isolatednetwork = Network.create(
            self.api_client,
            data=isolatednetwork_data,
            account=account,
            zone=self.zone
        )
        self.logger.debug('>>>  ISOLATED NETWORKS   =>  ID: %s  =>  Name: %s  =>  CIDR: %s  '
                          '=>  Gateway: %s  =>  Type: %s  =>  Traffic Type: %s  =>  State: %s  '
                          '=>  Offering: %s  =>  Physical Network: %s  =>  Domain: %s',
                          isolatednetwork.id, isolatednetwork.name, isolatednetwork.cidr,
                          isolatednetwork.gateway, isolatednetwork.type, isolatednetwork.traffictype,
                          isolatednetwork.state, isolatednetwork.networkofferingid,
                          isolatednetwork.physicalnetworkid, isolatednetwork.domainid)

    def deploy_isolatednetworks_publicipaddresses(self, isolatednetworks_data, virtualmachines_data):
        for isolatednetwork in isolatednetworks_data:
            network = get_network(self.api_client, isolatednetwork['data']['name'])
            self.deploy_isolatednetwork_egresses(isolatednetwork['data'], network)
            self.deploy_isolatednetwork_publicipaddresses(isolatednetwork['data'], virtualmachines_data, network)

    def deploy_isolatednetwork_egresses(self, isolatednetwork_data, network):
        self.logger.debug('>>>  ISOLATED NETWORKS EGRESS RULES  =>  Creating...')
        for egress_data in isolatednetwork_data['egressrules']:
            egress = EgressFireWallRule.create(
                self.api_client,
                network=network,
                data=egress_data['data']
            )

            self.logger.debug('>>>  ISOLATED NETWORKS EGRESS RULES  =>  ID: %s  =>  Startport: %s  '
                              '=>  Endport: %s  =>  CIDR: %s  =>  Protocol: %s  =>  State: %s  '
                              'Network ID: %s',
                              egress.id, egress.startport, egress.endport, egress.cidrlist,
                              egress.protocol, egress.state, egress.networkid)

    def deploy_isolatednetwork_publicipaddresses(self, isolatednetwork_data, virtual_machines, network):
        for ipaddress in isolatednetwork_data['publicipaddresses']:
            self.deploy_isolatednetwork_publicipaddress(ipaddress['data'], virtual_machines, network)

    def deploy_isolatednetwork_publicipaddress(self, ipaddress_data, virtualmachines_data, network):
        self.logger.debug('>>>  ISOLATED NETWORK PUBLIC IP ADDRESS  =>  Creating...')
        publicipaddress = PublicIPAddress.create(
            api_client=self.api_client,
            data=ipaddress_data,
            network=network
        )
        self.deploy_firewallrules(ipaddress_data, publicipaddress)
        self.deploy_portforwards(ipaddress_data['portforwards'], virtualmachines_data, None, publicipaddress)

    def deploy_firewallrules(self, ipaddress_data, publicipaddress):
        self.logger.debug('>>>  ISOLATED NETWORK FIREWALL RULES  =>  Creating...')
        for firewallrule in ipaddress_data['firewallrules']:
            self.deploy_firewallrule(firewallrule, publicipaddress)

    def deploy_firewallrule(self, firewallrule, publicipaddress):
        firewall = FireWallRule.create(
            self.api_client,
            data=firewallrule['data'],
            ipaddress=publicipaddress
        )
        self.logger.debug('>>>  ISOLATED NETWORKS FIREWALL RULES  =>  ID: %s  =>  Startport: %s  '
                          '=>  Endport: %s  =>  CIDR: %s  =>  Protocol: %s  =>  State: %s  '
                          'Network ID: %s  =>  IP Address: %s',
                          firewall.id, firewall.startport, firewall.endport, firewall.cidrlist,
                          firewall.protocol, firewall.state, firewall.networkid, firewall.ipaddress)

    def finalize(self):
        try:
            self.logger.info('=== Scenario Manager, Cleaning Up of "%s" Started ===',
                             self.scenario_data['metadata']['name'])

            cleanup_resources(self.api_client, self.resources_to_cleanup, self.logger)

            self.logger.info('=== Scenario Manager, Cleaning Up of "%s" Finished ===',
                             self.scenario_data['metadata']['name'])
        except:
            self.logger.exception('Oops! Unable to clean up resources of "%s"!', self.scenario_data['metadata']['name'])
