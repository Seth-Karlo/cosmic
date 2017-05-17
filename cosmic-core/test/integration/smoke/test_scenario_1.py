import sys
import traceback

from nose.plugins.attrib import attr

from marvin.cloudstackTestCase import cloudstackTestCase
from marvin.lib.base import (
    Domain,
    Account,
    VPC,
    VirtualMachine,
    Network,
    NetworkACL,
    PublicIPAddress,
    NetworkACLList,
    NATRule
)

from marvin.lib.utils import (
    cleanup_resources,
    random_gen
)
from marvin.utils.MarvinLog import MarvinLog
from marvin.lib.common import (
    get_zone,
    get_network,
    get_virtual_machine,
    get_vpc,
    get_network_acl
)


class TestScenario1(cloudstackTestCase):

    @classmethod
    def setUpClass(cls):
        cls.logger = MarvinLog(MarvinLog.LOGGER_TEST).get_logger()

        cls.test_client = super(TestScenario1, cls).getClsTestClient()
        cls.api_client = cls.test_client.getApiClient()
        cls.test_data = cls.test_client.getParsedTestDataConfig()
        cls.zone = get_zone(cls.api_client, cls.test_client.getZoneForTests())

        cls.class_cleanup = []

    @classmethod
    def tearDownClass(cls):
        try:
            cleanup_resources(cls.api_client, cls.class_cleanup, cls.logger)
        except:
            sys.exit(1)

    def setUp(self):
        self.method_cleanup = []

    def tearDown(self):
        try:
            cleanup_resources(self.api_client, self.method_cleanup, self.logger)
        except:
            sys.exit(1)

    @attr(tags=['advanced'])
    def test_01(self):
        try:
            self.setup_infra(self.test_data['scenario_1']['data'])
        except:
            self.logger.debug('STACKTRACE >>>>> ' + traceback.format_exc())
            sys.exit(1)

    def setup_infra(self, scenario_data):
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
            domain = Domain.create(
                api_client=self.api_client,
                name=domain_data['name'] + '-' + random_gen()
            )
            domain_data['name'] = domain.name

        self.logger.debug(">>>>> DOMAIN > %s", domain.name)

        self.deploy_accounts(domain_data['accounts'], domain)

    def deploy_accounts(self, accounts_data, domain):
        for account in accounts_data:
            self.deploy_account(account['data'], domain)

    def deploy_account(self, account_data, domain):
        account = Account.create(
            api_client=self.api_client,
            services=account_data,
            domainid=domain.uuid
        )
        # self.class_cleanup.append(account)
        account_data['username'] = account.name

        self.logger.debug(">>>>> ACCOUNT > %s", account.name)

        self.deploy_vpcs(account_data['vpcs'], account)
        self.deploy_vms(account_data['virtualmachines'], account)

        for vpc in account_data['vpcs']:
            self.deploy_vpc_public_ips(vpc['data'], account_data['virtualmachines'])

        for privatenetwork in account_data['privatenetworks']:
            self.deploy_privatenetwork(privatenetwork['data'])

    def deploy_vpcs(self, vpcs_data, account):
        for vpc in vpcs_data:
            self.deploy_vpc(vpc['data'], account)

    def deploy_vpc(self, vpc_data, account):
        vpc = VPC.create(
            api_client=self.api_client,
            data=vpc_data,
            zone=self.zone,
            account=account
        )
        vpc_data['name'] = vpc.name

        self.logger.debug(">>>>> VPC > %s", vpc.name)

        self.deploy_acls(vpc_data['acls'], vpc)
        self.deploy_networks(vpc_data['networks'], vpc)

    def deploy_acls(self, acls_data, vpc):
        for acl in acls_data:
            self.deploy_acl(acl['data'], vpc)

    def deploy_acl(self, acl_data, vpc):
        acl = NetworkACLList.create(
            api_client=self.api_client,
            data=acl_data,
            vpc=vpc
        )

        self.deploy_rules(acl_data['rules'], acl)

    def deploy_rules(self, rules_data, acl):
        for rule in rules_data:
            self.deploy_rule(rule['data'], acl)

    def deploy_rule(self, rule_data, acl):
            NetworkACL.create(
                api_client=self.api_client,
                data=rule_data,
                acl=acl
            )

    def deploy_networks(self, networks_data, vpc):
        for network in networks_data:
            self.deploy_network(network, vpc)

    def deploy_network(self, network_data, vpc):
        acl = get_network_acl(api_client=self.api_client, name=network_data['data']['aclname'])

        network = Network.create(
            self.api_client,
            data=network_data['data'],
            vpc=vpc,
            zone=self.zone,
            acl=acl
        )
        network_data['data']['name'] = network.name

    def deploy_vms(self, vms_data, account):
        for vm in vms_data:
            self.deploy_vm(vm['data'], account)

    def deploy_vm(self, vm_data, account):
        network_list = []
        for nic in vm_data['nics']:
            network = get_network(api_client=self.api_client, name=nic['data']['networkname'])
            network_list.append(network)

        VirtualMachine.create(
            self.api_client,
            data=vm_data,
            zone=self.zone,
            account=account,
            networks=network_list
        )

    def deploy_vpc_public_ips(self, vpc_data, virtualmachines_data):
        vpc = get_vpc(api_client=self.api_client, name=vpc_data['name'])
        self.deploy_publicipaddresses(vpc_data['publicipaddresses'], virtualmachines_data, vpc)

    def deploy_publicipaddresses(self, publicipaddresses_data, virtualmachines_data, vpc):
        for publicipaddress in publicipaddresses_data:
            self.deploy_publicipaddress(publicipaddress['data'], virtualmachines_data, vpc)

    def deploy_publicipaddress(self, publicipaddress_data, virtualmachines_data, vpc):
        publicipaddress = PublicIPAddress.create(
            api_client=self.api_client,
            data=publicipaddress_data,
            vpc=vpc
        )

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
                                name=virtualmachine_data['data']['name'],
                                vpc=vpc
                            )
                            NATRule.create(
                                api_client=self.api_client,
                                data=portforward_data['data'],
                                vpc=vpc,
                                network=network,
                                virtual_machine=virtualmachine,
                                ipaddress=publicipaddress
                            )
