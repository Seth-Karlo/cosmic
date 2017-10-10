INSERT INTO `domain` (`id`, `parent`, `name`, `uuid`, `owner`, `path`, `level`, `child_count`, `next_child_seq`, `removed`, `state`, `network_domain`, `type`, `email`)
VALUES
  (1, NULL, 'ROOT', '9cd7f24a-6d7b-11e7-8f09-5254001daa61', 2, '/', 0, 0, 1, NULL, 'Active', NULL, 'Normal', NULL);

INSERT INTO `account` (`id`, `account_name`, `uuid`, `type`, `domain_id`, `state`, `removed`, `cleanup_needed`, `network_domain`, `default_zone_id`, `default`)
VALUES
  (1, 'system', '9cd80650-6d7b-11e7-8f09-5254001daa61', 1, 1, 'enabled', NULL, 0, NULL, NULL, 1),
  (2, 'admin', '9cd811e2-6d7b-11e7-8f09-5254001daa61', 1, 1, 'enabled', NULL, 0, NULL, NULL, 1);

INSERT INTO `configuration` (`category`, `instance`, `component`, `name`, `value`, `description`, `default_value`, `updated`, `scope`, `is_dynamic`)
VALUES
  ('Advanced', 'DEFAULT', 'management-server', 'account.cleanup.interval', '60', NULL, '60', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'alert.purge.delay', '0', 'Alerts older than specified number days will be purged. Set this value to 0 to never delete alerts', '0', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'alert.purge.interval', '86400', 'The interval (in seconds) to wait before running the alert purge thread', '86400', NULL, NULL, 0),
  ('Alert', 'DEFAULT', 'management-server', 'alert.smtp.connectiontimeout', '30000', 'Socket connection timeout value in milliseconds. -1 for infinite timeout.', '30000', NULL, NULL, 0),
  ('Alert', 'DEFAULT', 'management-server', 'alert.smtp.timeout', '30000', 'Socket I/O timeout value in milliseconds. -1 for infinite timeout.', '30000', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'api.throttling.cachesize', '50000', 'Account based API count cache size', '50000', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'api.throttling.enabled', 'false', 'Enable/Disable Api rate limit', 'false', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'api.throttling.interval', '1', 'Time interval (in seconds) to reset API count', '1', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'api.throttling.max', '25', 'Max allowed number of APIs within fixed interval', '25', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'VpcManager', 'blacklisted.routes', NULL, 'Routes that are blacklisted, can not be used for Static Routes creation for the VPC Private Gateway', NULL, NULL, 'Zone', 0),
  ('Advanced', 'DEFAULT', 'management-server', 'cloud.dns.name', NULL, 'DNS name of the cloud for the GSLB service', NULL, NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'cluster.cpu.allocated.capacity.disablethreshold', '0.95', NULL, '0.95', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'cluster.memory.allocated.capacity.disablethreshold', '0.95', NULL, '0.95', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'CapacityManager', 'cluster.storage.operations.exclude', NULL, 'Exclude cluster from storage operations', 'false', '2017-07-20 20:46:06', 'Cluster', 1),
  ('Advanced', 'DEFAULT', 'management-server', 'concurrent.snapshots.threshold.perhost', NULL, 'Limit number of snapshots that can be handled concurrently; default is NULL - unlimited.', NULL, NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'detail.batch.query.size', '2000', 'Default entity detail batch query size for listing', '2000', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'developer', 'true', NULL, 'true', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'direct.agent.pool.size', '500', 'Default size for DirectAgentPool', '500', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'direct.agent.scan.interval', '90', 'Time interval (in seconds) to run the direct agent scan task.', '90', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'eip.use.multiple.netscalers', 'false', 'Should be set to true, if there will be multiple NetScaler devices providing EIP service in a zone', 'false', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'enable.dynamic.scale.vm', 'false', 'Enables/Diables dynamically scaling a vm', 'false', NULL, NULL, 0),
  ('Storage', 'DEFAULT', 'management-server', 'enable.ha.storage.migration', 'true', 'Enable/disable storage migration across primary storage during HA', 'true', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'execute.in.sequence.hypervisor.commands', 'false', 'If set to true, StartCommand, StopCommand, CopyCommand, MigrateCommand will be synchronized on the agent side. If set to false, these commands become asynchronous. Default value is true.', 'false', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'execute.in.sequence.network.element.commands', 'false', 'If set to true, DhcpEntryCommand, SavePasswordCommand, UserDataCommand, VmDataCommand will be synchronized on the agent side. If set to false, these commands become asynchronous. Default value is false.', 'false', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'expunge.delay', '60', NULL, '60', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'expunge.interval', '60', NULL, '60', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'healthcheck.update.interval', '600', 'Time Interval to fetch the LB health check states (in sec)', '600', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'host', '192.168.22.61', NULL, '192.168.22.61', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'host.reservation.release.period', '300000', 'The interval in milliseconds between host reservation release checks', '300000', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'implicit.host.tags', 'GPU', 'Tag hosts at the time of host disovery based on the host properties/capabilities ', 'GPU', NULL, NULL, 0),
  ('Hidden', 'DEFAULT', 'management-server', 'init', 'false', NULL, 'false', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'integration.api.port', '8096', NULL, '8096', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'NetworkManager', 'internallbvm.service.offering', NULL, 'Uuid of the service offering used by internal lb vm; if NULL - default system internal lb offering will be used', NULL, NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'kvm.guest.network.device', 'cloudbr0', NULL, 'cloudbr0', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'kvm.private.network.device', 'cloudbr0', NULL, 'cloudbr0', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'kvm.public.network.device', 'pub0', NULL, 'pub0', NULL, NULL, 0),
  ('Snapshots', 'DEFAULT', 'SnapshotManager', 'kvm.snapshot.enabled', 'true', 'whether snapshot is enabled for KVM hosts', 'true', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'kvm.ssh.to.agent', 'true', 'Specify whether or not the management server is allowed to SSH into KVM Agents', 'true', NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.basedn', NULL, 'Sets the basedn for LDAP', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.bind.password', NULL, 'Specifies the password to use for binding to LDAP', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.bind.principal', NULL, 'Specifies the bind principal to use for bind to LDAP', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.email.attribute', 'mail', 'Sets the email attribute used within LDAP', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.firstname.attribute', 'givenname', 'Sets the firstname attribute used within LDAP', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.group.object', 'groupOfUniqueNames', 'Sets the object type of groups within LDAP', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.group.user.uniquemember', 'uniquemember', 'Sets the attribute for uniquemembers within a group', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.lastname.attribute', 'sn', 'Sets the lastname attribute used within LDAP', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.search.group.principle', NULL, 'Sets the principle of the group that users must be a member of', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.truststore', NULL, 'Sets the path to the truststore to use for LDAP SSL', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.truststore.password', NULL, 'Sets the password for the truststore', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.user.object', 'inetOrgPerson', 'Sets the object type of users within LDAP', NULL, NULL, NULL, 0),
  ('Secure', 'DEFAULT', 'management-server', 'ldap.username.attribute', 'uid', 'Sets the username attribute used within LDAP', NULL, NULL, NULL, 0),
  ('Account Defaults', 'DEFAULT', 'management-server', 'max.account.cpus', '40', 'The default maximum number of cpu cores that can be used for an account', '40', NULL, NULL, 0),
  ('Account Defaults', 'DEFAULT', 'management-server', 'max.account.memory', '40960', 'The default maximum memory (in MiB) that can be used for an account', '40960', NULL, NULL, 0),
  ('Account Defaults', 'DEFAULT', 'management-server', 'max.account.primary.storage', '200', 'The default maximum primary storage space (in GiB) that can be used for an account', '200', NULL, NULL, 0),
  ('Account Defaults', 'DEFAULT', 'management-server', 'max.account.secondary.storage', '400', 'The default maximum secondary storage space (in GiB) that can be used for an account', '400', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.cpus', '-1', 'The default maximum number of cpu cores that can be used for a domain', '-1', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.memory', '-1', 'The default maximum memory (in MiB) that can be used for a domain', '-1', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.networks', '-1', 'The default maximum number of networks that can be created for a domain', '-1', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.primary.storage', '-1', 'The default maximum primary storage space (in GiB) that can be used for a domain', '-1', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.public.ips', '-1', 'The default maximum number of public IPs that can be consumed by a domain', '-1', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.secondary.storage', '-1', 'The default maximum secondary storage space (in GiB) that can be used for a domain', '-1', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.snapshots', '-1', 'The default maximum number of snapshots that can be created for a domain', '-1', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.templates', '-1', 'The default maximum number of templates that can be deployed for a domain', '-1', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.user.vms', '-1', 'The default maximum number of user VMs that can be deployed for a domain', '-1', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.volumes', '-1', 'The default maximum number of volumes that can be created for a domain', '-1', NULL, NULL, 0),
  ('Domain Defaults', 'DEFAULT', 'management-server', 'max.domain.vpcs', '-1', 'The default maximum number of vpcs that can be created for a domain', '-1', NULL, NULL, 0),
  ('Project Defaults', 'DEFAULT', 'management-server', 'max.project.cpus', '40', 'The default maximum number of cpu cores that can be used for a project', '40', NULL, NULL, 0),
  ('Project Defaults', 'DEFAULT', 'management-server', 'max.project.memory', '40960', 'The default maximum memory (in MiB) that can be used for a project', '40960', NULL, NULL, 0),
  ('Project Defaults', 'DEFAULT', 'management-server', 'max.project.primary.storage', '200', 'The default maximum primary storage space (in GiB) that can be used for a project', '200', NULL, NULL, 0),
  ('Project Defaults', 'DEFAULT', 'management-server', 'max.project.secondary.storage', '400', 'The default maximum secondary storage space (in GiB) that can be used for a project', '400', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'mgt.server.vendor', 'ACS', 'the vendor of management server', 'ACS', NULL, NULL, 0),
  ('Network', 'DEFAULT', 'management-server', 'midonet.apiserver.address', 'http://localhost:8081', 'Specify the address at which the Midonet API server can be contacted (if using Midonet)', 'http://localhost:8081', NULL, NULL, 0),
  ('Network', 'DEFAULT', 'management-server', 'midonet.providerrouter.id', 'd7c5e6a3-e2f4-426b-b728-b7ce6a0448e5', 'Specifies the UUID of the Midonet provider router (if using Midonet)', 'd7c5e6a3-e2f4-426b-b728-b7ce6a0448e5', NULL, NULL, 0),
  ('Network', 'DEFAULT', 'NetworkManager', 'network.dhcp.nondefaultnetwork.setgateway.guestos', 'Windows', 'The guest OS\'s name start with this fields would result in DHCP server response gateway information even when the network it\'s on is not default network. Names are separated by comma.', 'Windows', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'network.gc.interval', '10', NULL, '10', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'network.gc.wait', '10', NULL, '10', NULL, NULL, 0),
  ('Network', 'DEFAULT', 'management-server', 'network.ipv6.search.retry.max', '10000', 'The maximum number of retrying times to search for an available IPv6 address in the table', '10000', NULL, NULL, 0),
  ('Network', 'DEFAULT', 'management-server', 'network.loadbalancer.haproxy.default.timeout.client', '60000', 'Default HAProxy client timeout setting (in ms)', '60000', NULL, NULL, 0),
  ('Network', 'DEFAULT', 'management-server', 'network.loadbalancer.haproxy.default.timeout.server', '60000', 'Default HAProxy server timeout setting (in ms)', '60000', NULL, NULL, 0),
  ('Network', 'DEFAULT', 'management-server', 'network.loadbalancer.haproxy.max.conn', '4096', 'Load Balancer(haproxy) maximum number of concurrent connections(global max)', '4096', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'ManagementServer', 'ovm3.heartbeat.interval', '10', 'Interval value the checkheartbeat script uses before triggering the timeout for ovm3', '1', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'ManagementServer', 'ovm3.heartbeat.timeout', '180', 'Timeout value to send to the checkheartbeat script for guarding the self fencing functionality on ovm3', '120', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'pool.storage.allocated.capacity.disablethreshold', '0.95', NULL, '0.95', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'pool.storage.capacity.disablethreshold', '0.95', NULL, '0.95', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'NetworkOrchestrationService', 'router.aggregation.command.each.timeout', '3', 'timeout in seconds for each Virtual Router command being aggregated. The final aggregation command timeout would be determined by this timeout * commands counts ', '3', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'NetworkManager', 'router.check.poolsize', '10', 'Numbers of threads using to check redundant router status.', '10', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'NetworkOrchestrationService', 'router.redundant.vrrp.interval', '1', 'seconds between VRRP broadcast. It would 3 times broadcast fail to trigger fail-over mechanism of redundant router', '1', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'NetworkManager', 'router.template.kvm', 'SystemVM Template (KVM)', 'Name of the default router template on KVM.', 'SystemVM Template (KVM)', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'NetworkManager', 'router.template.ovm3', 'SystemVM Template (Ovm3)', 'Name of the default router template on Ovm3.', 'SystemVM Template (Ovm3)', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'NetworkManager', 'router.template.xenserver', 'SystemVM Template (XenServer)', 'Name of the default router template on Xenserver.', 'SystemVM Template (XenServer)', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 's3.rrs.enabled', 'false', 'enable s3 reduced redundancy storage', 'false', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 's3.singleupload.max.size', '5', 'The maximum size limit for S3 single part upload API(in GB). If it is set to 0, then it means always use multi-part upload to upload object to S3. If it is set to -1, then it means always use single-part upload to upload object to S3.', '5', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'scale.retry', '2', 'Number of times to retry scaling up the vm', '2', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'sdn.ovs.controller.default.label', 'cloudbr0', NULL, 'cloudbr0', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'secstorage.allowed.internal.sites', '0.0.0.0/0', NULL, '0.0.0.0/0', NULL, NULL, 0),
  ('Snapshots', 'DEFAULT', 'SnapshotManager', 'snapshot.backup.rightafter', 'true', 'backup snapshot right after snapshot is taken', 'true', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'stats.output.uri', '', 'URI to additionally send StatsCollector statistics to', '', NULL, NULL, 0),
  ('Storage', 'DEFAULT', 'management-server', 'storage.cache.replacement.enabled', 'true', 'enable or disable cache storage replacement algorithm.', 'true', NULL, NULL, 0),
  ('Storage', 'DEFAULT', 'management-server', 'storage.cache.replacement.interval', '86400', 'time interval between cache replacement threads (in seconds).', '86400', NULL, NULL, 0),
  ('Storage', 'DEFAULT', 'management-server', 'storage.cache.replacement.lru.interval', '30', 'time interval for unused data on cache storage (in days).', '30', NULL, NULL, 0),
  ('Usage', 'DEFAULT', 'management-server', 'traffic.sentinel.exclude.zones', '', 'Traffic going into specified list of zones is not metered', '', NULL, NULL, 0),
  ('Usage', 'DEFAULT', 'management-server', 'traffic.sentinel.include.zones', 'EXTERNAL', 'Traffic going into specified list of zones is metered. For metering all traffic leave this parameter empty', 'EXTERNAL', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'ucs.sync.blade.interval', '3600', 'the interval cloudstack sync with UCS manager for available blades in case user remove blades from chassis without notifying CloudStack', '3600', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'use.system.guest.vlans', 'true', 'If true, when account has dedicated guest vlan range(s), once the vlans dedicated to the account have been consumed vlans will be allocated from the system pool', 'true', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'use.system.public.ips', 'true', 'If true, when account has dedicated public ip range(s), once the ips dedicated to the account have been consumed ips will be acquired from the system pool', 'true', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vm.deployment.planner', 'FirstFitPlanner', '[\'FirstFitPlanner\', \'UserDispersingPlanner\', \'UserConcentratedPodPlanner\']: DeploymentPlanner heuristic that will be used for VM deployment.', 'FirstFitPlanner', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vm.destroy.forcestop', 'true', NULL, 'true', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vm.disk.stats.interval', '0', 'Interval (in seconds) to report vm disk statistics.', '0', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vm.disk.throttling.bytes_read_rate', '0', 'Default disk I/O read rate in bytes per second allowed in User vm\'s disk. ', '0', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vm.disk.throttling.bytes_write_rate', '0', 'Default disk I/O write rate in bytes per second allowed in User vm\'s disk. ', '0', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vm.disk.throttling.iops_read_rate', '0', 'Default disk I/O read rate in requests per second allowed in User vm\'s disk. ', '0', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vm.disk.throttling.iops_write_rate', '0', 'Default disk I/O write rate in requests per second allowed in User vm\'s disk. ', '0', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vm.instancename.flag', 'false', 'If set to true, will set guest VM\'s name as it appears on the hypervisor, to its hostname. The flag is supported for VMware hypervisor only', 'false', NULL, NULL, 0),
  ('NetworkManager', 'DEFAULT', 'management-server', 'vm.network.nic.max.secondary.ipaddresses', NULL, 'Specify the number of secondary ip addresses per nic per vm', '256', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vm.password.length', '6', 'Specifies the length of a randomly generated password', '6', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'VMSnapshotManager', 'vmsnapshot.create.wait', '1800', 'In second, timeout for create vm snapshot', NULL, NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'VMSnapshotManager', 'vmsnapshot.max', '10', 'Maximum vm snapshots for a vm', NULL, NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'UserVmManager', 'vmware.create.full.clone', 'true', 'If set to true, creates VMs as full clones on ESX hypervisor', 'true', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vmware.hung.wokervm.timeout', '7200', 'Worker VM timeout in seconds', '7200', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vmware.nested.virtualization', 'false', 'When set to true this will enable nested virtualization when this is supported by the hypervisor', 'false', NULL, NULL, 0),
  ('Network', 'DEFAULT', 'management-server', 'vmware.ports.per.dvportgroup', '256', 'Default number of ports per Vmware dvPortGroup in VMware environment', '256', NULL, NULL, 0),
  ('Network', 'DEFAULT', 'management-server', 'vmware.use.dvswitch', 'false', 'Enable/Disable Nexus/Vmware dvSwitch in VMware environment', 'false', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vmware.vcenter.session.timeout', '1200', 'VMware client timeout in seconds', '1200', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'management-server', 'vpc.max.networks', '4', NULL, '4', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'ManagementServer', 'xen.heartbeat.timeout', '180', 'Timeout value to send to the xenheartbeat script for guarding the self fencing functionality', '120', NULL, NULL, 0),
  ('Advanced', 'DEFAULT', 'AgentManager', 'xenserver.nics.max', '7', 'Maximum allowed nics for Vms created on XenServer', '7', NULL, NULL, 0);

INSERT INTO `counter` (`id`, `uuid`, `source`, `name`, `value`, `removed`, `created`)
VALUES
  (1, 'ad0d8f56-6d7b-11e7-8f09-5254001daa61', 'snmp', 'Linux User CPU - percentage', '1.3.6.1.4.1.2021.11.9.0', NULL, '2017-07-20 20:46:00'),
  (2, 'ad0d98b3-6d7b-11e7-8f09-5254001daa61', 'snmp', 'Linux System CPU - percentage', '1.3.6.1.4.1.2021.11.10.0', NULL, '2017-07-20 20:46:00'),
  (3, 'ad0da998-6d7b-11e7-8f09-5254001daa61', 'snmp', 'Linux CPU Idle - percentage', '1.3.6.1.4.1.2021.11.11.0', NULL, '2017-07-20 20:46:00'),
  (4, 'ad0dbb35-6d7b-11e7-8f09-5254001daa61', 'cpu', 'Linux User CPU - percentage - native', '1.3.6.1.4.1.2021.11.9.1', NULL, '2017-07-20 20:46:00'),
  (5, 'ad0dc2af-6d7b-11e7-8f09-5254001daa61', 'memory', 'Linux User RAM - percentage - native', '1.3.6.1.4.1.2021.11.10.1', NULL, '2017-07-20 20:46:00'),
  (100, 'ad0db25d-6d7b-11e7-8f09-5254001daa61', 'netscaler', 'Response Time - microseconds', 'RESPTIME', NULL, '2017-07-20 20:46:00');

INSERT INTO `guest_os_category` (`id`, `name`, `uuid`)
VALUES
  (1, 'CentOS', '9cc42fac-6d7b-11e7-8f09-5254001daa61'),
  (2, 'Debian', '9cc438cd-6d7b-11e7-8f09-5254001daa61'),
  (3, 'Oracle', '9cc441de-6d7b-11e7-8f09-5254001daa61'),
  (4, 'RedHat', '9cc44be5-6d7b-11e7-8f09-5254001daa61'),
  (5, 'SUSE', '9cc45476-6d7b-11e7-8f09-5254001daa61'),
  (6, 'Windows', '9cc45cf1-6d7b-11e7-8f09-5254001daa61'),
  (7, 'Other', '9cc464ff-6d7b-11e7-8f09-5254001daa61'),
  (8, 'Novel', '9cc46d5b-6d7b-11e7-8f09-5254001daa61'),
  (9, 'Unix', '9cc475aa-6d7b-11e7-8f09-5254001daa61'),
  (10, 'Ubuntu', '9cc47e53-6d7b-11e7-8f09-5254001daa61'),
  (11, 'None', '9cc488c9-6d7b-11e7-8f09-5254001daa61');

INSERT INTO `guest_os` (`id`, `category_id`, `name`, `uuid`, `display_name`, `created`, `removed`, `is_user_defined`, `manufacturer_string`)
VALUES
  (12, 1, NULL, '9cc500aa-6d7b-11e7-8f09-5254001daa61', 'CentOS 5.3 (64-bit)', '2017-07-20 20:46:02', NULL, 0, 'Mission Critical Cloud'),
  (15, 2, NULL, '9cc51a3b-6d7b-11e7-8f09-5254001daa61', 'Debian GNU/Linux 5.0 (64-bit)', '2017-07-20 20:46:02', NULL, 0, 'Mission Critical Cloud'),
  (140, 7, NULL, '9cc98be3-6d7b-11e7-8f09-5254001daa61', 'Other PV (64-bit)', '2017-07-20 20:46:02', NULL, 0, 'Mission Critical Cloud'),
  (142, 1, NULL, '9cc99fdb-6d7b-11e7-8f09-5254001daa61', 'CentOS 5.6 (64-bit)', '2017-07-20 20:46:02', NULL, 0, 'Mission Critical Cloud'),
  (182, 1, NULL, '9ccb2446-6d7b-11e7-8f09-5254001daa61', 'CentOS 6.4 (64-bit)', '2017-07-20 20:46:02', NULL, 0, 'Mission Critical Cloud'),
  (183, 2, NULL, '9ccb2d36-6d7b-11e7-8f09-5254001daa61', 'SystemVM Debian 7 (32 bit)', '2017-07-20 20:46:02', NULL, 0, 'Mission Critical Cloud'),
  (184, 2, NULL, '9ccb36b6-6d7b-11e7-8f09-5254001daa61', 'SystemVM Debian 7 (64 bit)', '2017-07-20 20:46:02', NULL, 0, 'Mission Critical Cloud'),
  (1000, 7, NULL, 'b08f5a46-6d7b-11e7-8f09-5254001daa61', 'Default - VirtIO capable OS (64-bit)', '2017-07-20 18:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1001, 7, NULL, 'b08ffaea-6d7b-11e7-8f09-5254001daa61', 'Non-VirtIO capable OS (64-bit)', '2017-07-20 18:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1002, 7, NULL, 'b0b64a22-6d7b-11e7-8f09-5254001daa61', 'VirtIO-SCSI capable OS (64-bit)', '2017-07-20 18:46:07', NULL, 0, 'Mission Critical Cloud'),
  (1010, 1, NULL, 'b08f6292-6d7b-11e7-8f09-5254001daa61', 'CentOS Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1011, 4, NULL, 'b08f6e2f-6d7b-11e7-8f09-5254001daa61', 'RHEL Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1012, 2, NULL, 'b08f793c-6d7b-11e7-8f09-5254001daa61', 'Debian Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1013, 10, NULL, 'b08f8519-6d7b-11e7-8f09-5254001daa61', 'Ubuntu Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1014, 7, NULL, 'b08f90ba-6d7b-11e7-8f09-5254001daa61', 'CoreOS Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1015, 7, NULL, 'b08f9b80-6d7b-11e7-8f09-5254001daa61', 'Linux Other', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1016, 6, NULL, 'b08fa712-6d7b-11e7-8f09-5254001daa61', 'Windows 7 Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1017, 6, NULL, 'b08fb414-6d7b-11e7-8f09-5254001daa61', 'Windows 8 Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1018, 6, NULL, 'b08fbf18-6d7b-11e7-8f09-5254001daa61', 'Windows 10 Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1019, 6, NULL, 'b08fca18-6d7b-11e7-8f09-5254001daa61', 'Windows 2008 Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1020, 6, NULL, 'b08fd62a-6d7b-11e7-8f09-5254001daa61', 'Windows 2012 Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1021, 6, NULL, 'b08fe0be-6d7b-11e7-8f09-5254001daa61', 'Windows 2016 Family', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1022, 6, NULL, 'b08feb53-6d7b-11e7-8f09-5254001daa61', 'Windows Other', '2017-07-20 20:46:06', NULL, 0, 'Mission Critical Cloud'),
  (1023, 6, NULL, 'b0b657cf-6d7b-11e7-8f09-5254001daa61', 'Windows VirtIO-SCSI', '2017-07-20 18:46:07', NULL, 0, 'Mission Critical Cloud');

INSERT INTO `guest_os_hypervisor` (`id`, `hypervisor_type`, `guest_os_name`, `guest_os_id`, `hypervisor_version`, `uuid`, `created`, `removed`, `is_user_defined`)
VALUES
  (12, 'XenServer', 'CentOS 5.3 (64-bit)', 12, 'default', 'add07eb2-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (18, 'XenServer', 'CentOS 5.6 (64-bit)', 142, 'default', 'add08314-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (34, 'XenServer', 'CentOS 6.4 (64-bit)', 182, 'default', 'add08fde-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (35, 'XenServer', 'Debian Lenny 5.0 (32-bit)', 15, 'default', 'add09067-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (94, 'XenServer', 'Other PV (64-bit)', 140, 'default', 'add0b455-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (220, 'KVM', 'CentOS 5.3', 12, 'default', 'add12a1f-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (263, 'KVM', 'Debian GNU/Linux 5', 15, 'default', 'add15396-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (326, 'XenServer', 'Debian GNU/Linux 7(32-bit)', 183, 'default', 'add1899e-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (327, 'XenServer', 'Debian GNU/Linux 7(64-bit)', 184, 'default', 'add18fc5-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (353, 'Xenserver', 'CentOS 5 (64-bit)', 12, 'XCP 1.0', 'addb11cd-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (358, 'Xenserver', 'Debian Lenny 5.0 (32-bit)', 15, 'XCP 1.0', 'addb2fa0-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (361, 'Xenserver', 'Debian Squeeze 6.0 (32-bit)', 183, 'XCP 1.0', 'addb4210-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (362, 'Xenserver', 'Debian Squeeze 6.0 (64-bit) (experimental)', 184, 'XCP 1.0', 'addb47a4-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (421, 'Xenserver', 'CentOS 5 (64-bit)', 140, 'XCP 1.0', 'addcb292-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (433, 'Xenserver', 'CentOS 5 (64-bit)', 12, '5.6 FP1', 'addcf81f-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (438, 'Xenserver', 'Debian Lenny 5.0 (32-bit)', 15, '5.6 FP1', 'addd1696-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (441, 'Xenserver', 'Debian Squeeze 6.0 (32-bit)', 183, '5.6 FP1', 'addd2856-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (442, 'Xenserver', 'Debian Squeeze 6.0 (64-bit) (experimental)', 184, '5.6 FP1', 'addd2ddd-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (498, 'Xenserver', 'CentOS 5 (64-bit)', 140, '5.6 FP1', 'addfbb00-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (510, 'Xenserver', 'CentOS 5 (64-bit)', 12, '5.6 SP2', 'ade0091a-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (515, 'Xenserver', 'Debian Lenny 5.0 (32-bit)', 15, '5.6 SP2', 'ade02884-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (518, 'Xenserver', 'Debian Squeeze 6.0 (32-bit)', 183, '5.6 SP2', 'ade03931-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (519, 'Xenserver', 'Debian Squeeze 6.0 (64-bit) (experimental)', 184, '5.6 SP2', 'ade03f01-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (570, 'Xenserver', 'CentOS 5 (64-bit)', 140, '5.6 SP2', 'ade16ee3-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (582, 'Xenserver', 'CentOS 5 (64-bit)', 12, '6.0', 'ade1b6a0-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (588, 'Xenserver', 'CentOS 5 (64-bit)', 142, '6.0', 'ade1d8a4-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (591, 'Xenserver', 'Debian Lenny 5.0 (32-bit)', 15, '6.0', 'ade1e8df-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (594, 'Xenserver', 'Debian Squeeze 6.0 (32-bit)', 183, '6.0', 'ade1fad7-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (595, 'Xenserver', 'Debian Squeeze 6.0 (64-bit)', 184, '6.0', 'ade2004c-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (673, 'Xenserver', 'CentOS 5 (64-bit)', 140, '6.0', 'ade3d4ee-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (685, 'Xenserver', 'CentOS 5 (64-bit)', 12, '6.0.2', 'ade41aad-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (691, 'Xenserver', 'CentOS 5 (64-bit)', 142, '6.0.2', 'ade43be3-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (696, 'Xenserver', 'Debian Lenny 5.0 (32-bit)', 15, '6.0.2', 'ade457c9-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (699, 'Xenserver', 'Debian Squeeze 6.0 (32-bit)', 183, '6.0.2', 'ade46a25-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (700, 'Xenserver', 'Debian Squeeze 6.0 (64-bit)', 184, '6.0.2', 'ade46f98-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (784, 'Xenserver', 'CentOS 5 (64-bit)', 140, '6.0.2', 'ade679bb-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (796, 'Xenserver', 'CentOS 5 (64-bit)', 12, '6.1.0', 'ade6c661-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (802, 'Xenserver', 'CentOS 5 (64-bit)', 142, '6.1.0', 'ade6e8bc-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (815, 'Xenserver', 'Debian Squeeze 6.0 (32-bit)', 183, '6.1.0', 'ade73297-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (816, 'Xenserver', 'Debian Squeeze 6.0 (64-bit)', 184, '6.1.0', 'ade7381d-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (913, 'Xenserver', 'CentOS 5 (64-bit)', 140, '6.1.0', 'ade9c1a3-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (925, 'Xenserver', 'CentOS 5 (64-bit)', 12, '6.2.0', 'adea1018-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (931, 'Xenserver', 'CentOS 5 (64-bit)', 142, '6.2.0', 'adea326f-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (947, 'Xenserver', 'CentOS 6 (64-bit)', 182, '6.2.0', 'adea8de0-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (950, 'Xenserver', 'Debian Wheezy 7.0 (32-bit)', 183, '6.2.0', 'adea9e1d-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (951, 'Xenserver', 'Debian Wheezy 7.0 (64-bit)', 184, '6.2.0', 'adeaa46d-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (1062, 'Xenserver', 'CentOS 5 (64-bit)', 140, '6.2.0', 'aded2538-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (1074, 'Xenserver', 'CentOS 5 (64-bit)', 12, '6.2.5', 'aded6efa-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (1080, 'Xenserver', 'CentOS 5 (64-bit)', 142, '6.2.5', 'aded92af-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (1096, 'Xenserver', 'CentOS 6 (64-bit)', 182, '6.2.5', 'adedf5b5-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (1099, 'Xenserver', 'Debian Wheezy 7.0 (32-bit)', 183, '6.2.5', 'adee076d-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (1100, 'Xenserver', 'Debian Wheezy 7.0 (64-bit)', 184, '6.2.5', 'adee0d10-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (1212, 'Xenserver', 'CentOS 5 (64-bit)', 140, '6.2.5', 'adf0985a-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (1214, 'KVM', 'CentOS 5.6', 142, 'default', 'adf283b8-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (1230, 'KVM', 'CentOS 6.4', 182, 'default', 'adf2e09b-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (1268, 'KVM', 'Other PV', 140, 'default', 'adf3c5f5-6d7b-11e7-8f09-5254001daa61', '2017-07-20 20:46:02', NULL, 0),
  (2138, 'Xenserver', 'CentOS 5 (64-bit)', 12, '6.5.0', 'ae29719d-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:02', NULL, 0),
  (2144, 'Xenserver', 'CentOS 5 (64-bit)', 142, '6.5.0', 'ae2991ad-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:02', NULL, 0),
  (2154, 'Xenserver', 'CentOS 5 (64-bit)', 140, '6.5.0', 'ae29d49f-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:02', NULL, 0),
  (2164, 'Xenserver', 'CentOS 6 (64-bit)', 182, '6.5.0', 'ae2a0a7b-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:02', NULL, 0),
  (2172, 'Xenserver', 'Debian Wheezy 7.0 (32-bit)', 183, '6.5.0', 'ae2a34e4-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:02', NULL, 0),
  (2173, 'Xenserver', 'Debian Wheezy 7.0 (64-bit)', 184, '6.5.0', 'ae2a39f1-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:02', NULL, 0),
  (2317, 'KVM', 'Debian GNU/Linux 7(32-bit)', 183, 'default', 'b04b5559-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2318, 'KVM', 'Debian GNU/Linux 7(64-bit)', 184, 'default', 'b04b5aa3-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2473, 'KVM', 'CentOS Family', 1010, 'default', 'b08f6845-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2474, 'KVM', 'RHEL Family', 1011, 'default', 'b08f73b8-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2475, 'KVM', 'Debian Family', 1012, 'default', 'b08f7f11-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2476, 'KVM', 'Ubuntu Family', 1013, 'default', 'b08f8b3f-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2477, 'KVM', 'CoreOS Family', 1014, 'default', 'b08f9613-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2478, 'KVM', 'Linux Other', 1015, 'default', 'b08fa0d6-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2479, 'KVM', 'Windows 7 Family', 1016, 'default', 'b08facfb-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2480, 'KVM', 'Windows 8 Family', 1017, 'default', 'b08fb9bb-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2481, 'KVM', 'Windows 10 Family', 1018, 'default', 'b08fc46b-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2482, 'KVM', 'Windows 2008 Family', 1019, 'default', 'b08fcf7d-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2483, 'KVM', 'Windows 2012 Family', 1020, 'default', 'b08fdb7c-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2484, 'KVM', 'Windows 2016 Family', 1021, 'default', 'b08fe607-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2485, 'KVM', 'Windows Other', 1022, 'default', 'b08ff47b-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2486, 'KVM', 'Non-VirtIO capable OS (64-bit)', 1001, 'default', 'b090011e-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:06', NULL, 0),
  (2487, 'KVM', 'VirtIO-SCSI capable OS', 1002, 'default', 'b0b651a9-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:07', NULL, 0),
  (2488, 'KVM', 'Windows VirtIO-SCSI', 1023, 'default', 'b0b65d81-6d7b-11e7-8f09-5254001daa61', '2017-07-20 18:46:07', NULL, 0);

INSERT INTO `hypervisor_capabilities` (`id`, `uuid`, `hypervisor_type`, `hypervisor_version`, `max_guests_limit`, `security_group_enabled`, `max_data_volumes_limit`, `max_hosts_per_cluster`, `storage_motion_supported`, `vm_snapshot_enabled`)
VALUES
  (1, '1', 'XenServer', 'default', 50, 1, 6, NULL, 0, 1),
  (2, '2', 'XenServer', 'XCP 1.0', 50, 1, 6, NULL, 0, 1),
  (3, '3', 'XenServer', '5.6', 50, 1, 6, NULL, 0, 1),
  (4, '4', 'XenServer', '5.6 FP1', 50, 1, 6, NULL, 0, 1),
  (5, '5', 'XenServer', '5.6 SP2', 50, 1, 6, NULL, 0, 1),
  (6, '6', 'XenServer', '6.0', 50, 1, 13, NULL, 0, 1),
  (7, '7', 'XenServer', '6.0.2', 50, 1, 13, NULL, 0, 1),
  (13, '13', 'KVM', 'default', 50, 1, 32, NULL, 0, 1),
  (14, '14', 'Ovm', 'default', 25, 1, 6, NULL, 0, 0),
  (15, '15', 'Ovm', '2.3', 25, 1, 6, NULL, 0, 0),
  (16, 'ad275d27-6d7b-11e7-8f09-5254001daa61', 'XenServer', '6.1.0', 150, 1, 13, NULL, 1, 1),
  (17, 'ad2765bf-6d7b-11e7-8f09-5254001daa61', 'XenServer', '6.2.0', 500, 1, 13, NULL, 1, 1),
  (22, 'ae2d1005-6d7b-11e7-8f09-5254001daa61', 'XenServer', '6.5.0', 500, 1, 13, NULL, 1, 0),
  (23, NULL, 'Ovm3', '3.2', 25, 0, 6, NULL, 0, 0),
  (24, NULL, 'Ovm3', '3.3', 50, 0, 6, NULL, 0, 0);

INSERT INTO `monitoring_services` (`id`, `uuid`, `service`, `process_name`, `service_name`, `service_path`, `pidfile`, `isDefault`)
VALUES
  (1, 'ada793ee-6d7b-11e7-8f09-5254001daa61', 'ssh', 'sshd', 'ssh', '/etc/init.d/ssh', '/var/run/sshd.pid', 1),
  (2, 'ada79a40-6d7b-11e7-8f09-5254001daa61', 'dhcp', 'dnsmasq', 'dnsmasq', '/etc/init.d/dnsmasq', '/var/run/dnsmasq/dnsmasq.pid', 0),
  (3, 'ada7a003-6d7b-11e7-8f09-5254001daa61', 'loadbalancing', 'haproxy', 'haproxy', '/etc/init.d/haproxy', '/var/run/haproxy.pid', 0),
  (4, 'ada7a6b8-6d7b-11e7-8f09-5254001daa61', 'webserver', 'apache2', 'apache2', '/etc/init.d/apache2', '/var/run/apache2.pid', 1);

INSERT INTO `network_acl` (`id`, `name`, `uuid`, `vpc_id`, `description`, `display`)
VALUES
  (1, 'default_deny', 'ad69103c-6d7b-11e7-8f09-5254001daa61', 0, 'Default Network ACL Deny All', 1),
  (2, 'default_allow', 'ad692983-6d7b-11e7-8f09-5254001daa61', 0, 'Default Network ACL Allow All', 1);

INSERT INTO `network_acl_item` (`id`, `uuid`, `acl_id`, `start_port`, `end_port`, `state`, `protocol`, `created`, `icmp_code`, `icmp_type`, `traffic_type`, `number`, `action`, `display`)
VALUES
  (1, 'ad691a30-6d7b-11e7-8f09-5254001daa61', 1, NULL, NULL, 'Active', 'all', '2017-07-20 20:46:01', NULL, NULL, 'Ingress', 1, 'Deny', 1),
  (2, 'ad692213-6d7b-11e7-8f09-5254001daa61', 1, NULL, NULL, 'Active', 'all', '2017-07-20 20:46:01', NULL, NULL, 'Egress', 2, 'Deny', 1),
  (3, 'ad692f9b-6d7b-11e7-8f09-5254001daa61', 2, NULL, NULL, 'Active', 'all', '2017-07-20 20:46:01', NULL, NULL, 'Ingress', 1, 'Allow', 1),
  (4, 'ad6935f8-6d7b-11e7-8f09-5254001daa61', 2, NULL, NULL, 'Active', 'all', '2017-07-20 20:46:01', NULL, NULL, 'Egress', 2, 'Allow', 1);

INSERT INTO `network_acl_item_cidrs` (`id`, `network_acl_item_id`, `cidr`)
VALUES
  (1, 1, '0.0.0.0/0'),
  (2, 2, '0.0.0.0/0'),
  (3, 3, '0.0.0.0/0'),
  (4, 4, '0.0.0.0/0');

INSERT INTO `ovs_tunnel_interface` (`id`, `ip`, `netmask`, `mac`, `host_id`, `label`)
VALUES
  (1, '0', '0', '0', 0, 'lock');

INSERT INTO `ovs_tunnel_network` (`id`, `from`, `to`, `network_id`, `key`, `port_name`, `state`)
VALUES
  (1, 0, 0, 0, 0, 'lock', 'SUCCESS');

INSERT INTO `region` (`id`, `name`, `end_point`, `portableip_service_enabled`, `gslb_service_enabled`)
VALUES
  (1, 'Local', 'http://localhost:8080/client/', 0, 1);


INSERT INTO `resource_count` (`id`, `account_id`, `domain_id`, `type`, `count`)
VALUES
  (1, 1, NULL, 'cpu', 0),
  (2, 1, NULL, 'memory', 0),
  (3, 1, NULL, 'primary_storage', 0),
  (4, 1, NULL, 'secondary_storage', 0),
  (5, 2, NULL, 'cpu', 0),
  (6, 2, NULL, 'memory', 0),
  (7, 2, NULL, 'primary_storage', 0),
  (8, 2, NULL, 'secondary_storage', 0),
  (9, NULL, 1, 'cpu', 0),
  (10, NULL, 1, 'memory', 0),
  (11, NULL, 1, 'primary_storage', 0),
  (12, NULL, 1, 'secondary_storage', 0);

INSERT INTO `sequence` (`name`, `value`)
VALUES
  ('checkpoint_seq', 1),
  ('networks_seq', 200),
  ('physical_networks_seq', 200),
  ('private_mac_address_seq', 1),
  ('public_mac_address_seq', 1),
  ('storage_pool_seq', 200),
  ('vm_instance_seq', 1),
  ('vm_template_seq', 200),
  ('volume_seq', 1);

INSERT INTO `user` (`id`, `uuid`, `username`, `password`, `account_id`, `firstname`, `lastname`, `email`, `state`, `api_key`, `secret_key`, `created`, `removed`, `timezone`, `registration_token`, `is_registered`, `incorrect_login_attempts`, `default`, `source`, `external_entity`)
VALUES
  (1, '9cd8238d-6d7b-11e7-8f09-5254001daa61', 'system', '0.23265509235919926', 1, 'system', 'cloud', NULL, 'enabled', NULL, NULL, '2017-07-20 20:45:33', NULL, NULL, NULL, 0, 0, 1, 'UNKNOWN', NULL),
  (2, '9cd83247-6d7b-11e7-8f09-5254001daa61', 'admin', '5f4dcc3b5aa765d61d8327deb882cf99', 2, 'Admin', 'User', 'admin@mailprovider.com', 'disabled', NULL, NULL, '2017-07-20 20:45:33', NULL, NULL, NULL, 0, 0, 1, 'UNKNOWN', NULL);

INSERT INTO `version` (`id`, `version`, `updated`, `step`)
VALUES
  (1, '4.0.0', '2017-07-20 20:45:33', 'Complete'),
  (2, '4.1.0', '2017-07-20 18:46:01', 'Complete'),
  (3, '4.2.0', '2017-07-20 18:46:01', 'Complete'),
  (4, '4.2.1', '2017-07-20 18:46:01', 'Complete'),
  (5, '4.3.0', '2017-07-20 18:46:02', 'Complete'),
  (6, '4.4.0', '2017-07-20 18:46:02', 'Complete'),
  (7, '4.4.1', '2017-07-20 18:46:02', 'Complete'),
  (8, '4.4.2', '2017-07-20 18:46:02', 'Complete'),
  (9, '4.5.0', '2017-07-20 18:46:06', 'Complete'),
  (10, '4.5.1', '2017-07-20 18:46:06', 'Complete'),
  (11, '4.5.2', '2017-07-20 18:46:06', 'Complete'),
  (12, '4.6.0', '2017-07-20 18:46:06', 'Complete'),
  (13, '4.6.1', '2017-07-20 18:46:06', 'Complete'),
  (14, '4.7.0', '2017-07-20 18:46:06', 'Complete'),
  (15, '4.7.1', '2017-07-20 18:46:06', 'Complete'),
  (16, '4.8.0', '2017-07-20 18:46:06', 'Complete'),
  (17, '5.0.0', '2017-07-20 18:46:06', 'Complete'),
  (18, '5.0.1', '2017-07-20 18:46:06', 'Complete'),
  (19, '5.1.0', '2017-07-20 18:46:06', 'Complete'),
  (20, '5.1.1', '2017-07-20 18:46:06', 'Complete'),
  (21, '5.2.0', '2017-07-20 18:46:07', 'Complete'),
  (22, '5.3.0', '2017-07-20 18:46:07', 'Complete'),
  (23, '5.3.1', '2017-07-20 18:46:07', 'Complete'),
  (24, '5.3.2', '2017-07-20 18:46:07', 'Complete'),
  (25, '5.3.3', '2017-07-20 18:46:07', 'Complete'),
  (26, '5.3.4', '2017-07-20 18:46:07', 'Complete'),
  (27, '5.3.5', '2017-07-20 18:46:07', 'Complete'),
  (28, '5.3.6', '2017-07-20 18:46:07', 'Complete'),
  (29, '5.3.7', '2017-07-20 18:46:07', 'Complete');

INSERT INTO `vm_template` (`id`, `unique_name`, `name`, `uuid`, `public`, `featured`, `type`, `hvm`, `bits`, `url`, `format`, `created`, `removed`, `account_id`, `checksum`, `display_text`, `enable_password`, `enable_sshkey`, `guest_os_id`, `bootable`, `prepopulate`, `cross_zones`, `extractable`, `hypervisor_type`, `source_template_id`, `template_tag`, `sort_key`, `size`, `state`, `update_count`, `updated`, `dynamically_scalable`)
VALUES
  (1, 'routing-1', 'SystemVM Template (XenServer)', '9cc3c107-6d7b-11e7-8f09-5254001daa61', 0, 0, 'SYSTEM', 0, 64, 'http://download.cloud.com/templates/4.3/systemvm64template-2014-01-14-master-xen.vhd.bz2', 'VHD', '2017-07-20 20:45:33', NULL, 1, '74b92f031cc5c2089ee89efb81344dcf', 'SystemVM Template (XenServer)', 0, 0, 184, 1, 0, 1, 0, 'XenServer', NULL, NULL, 0, NULL, 'Active', 0, NULL, 0),
  (3, 'routing-3', 'SystemVM Template (KVM)', 'f327eecc-be53-4d80-9d43-adaf45467abd', 0, 0, 'SYSTEM', 0, 64, '', 'QCOW2', '2017-07-20 20:45:33', NULL, 1, '85a1bed07bf43cbf022451cb2ecae4ff', 'SystemVM Template (KVM)', 0, 0, 1000, 1, 0, 1, 0, 'KVM', NULL, NULL, 0, NULL, 'Active', 0, NULL, 0),
  (4, 'tiny linux kvm', 'tiny linux kvm', '9cc3eac7-6d7b-11e7-8f09-5254001daa61', 1, 1, 'BUILTIN', 1, 64, 'http://dl.openvm.eu/cloudstack/macchinina/x86_64/macchinina-kvm.qcow2.bz2', 'QCOW2', '2017-07-20 20:45:33', NULL, 1, 'ed0e788280ff2912ea40f7f91ca7a249', 'tiny linux kvm', 0, 0, 140, 1, 0, 1, 1, 'KVM', NULL, NULL, 0, NULL, 'Active', 0, NULL, 0),
  (5, 'tiny linux xen', 'tiny linux xen', '9cc3f888-6d7b-11e7-8f09-5254001daa61', 1, 1, 'BUILTIN', 0, 64, 'http://dl.openvm.eu/cloudstack/macchinina/x86_64/macchinina-xen.vhd.bz2', 'VHD', '2017-07-20 20:45:33', NULL, 1, '905cec879afd9c9d22ecc8036131a180', 'tiny linux xen', 0, 0, 142, 1, 0, 1, 1, 'XenServer', NULL, NULL, 0, NULL, 'Active', 0, NULL, 0),
  (12, 'routing-12', 'SystemVM Template (Ovm3)', 'b05dd2c9-6d7b-11e7-8f09-5254001daa61', 0, 0, 'SYSTEM', 0, 64, 'http://cloudstack.apt-get.eu/systemvm/4.6/systemvm64template-4.6.0-ovm.raw.bz2', 'RAW', '2017-07-20 20:46:06', NULL, 1, 'c8577d27b2daafb2d9a4ed307ce2f00f', 'SystemVM Template (Ovm3)', 0, 0, 183, 1, 0, 1, 0, 'Ovm3', NULL, NULL, 0, NULL, 'Active', NULL, NULL, 0);

INSERT INTO `network_offerings` (`id`, `name`, `uuid`, `unique_name`, `display_text`, `nw_rate`, `mc_rate`, `traffic_type`, `tags`, `system_only`, `specify_vlan`, `service_offering_id`, `conserve_mode`, `created`, `removed`, `default`, `availability`, `dedicated_lb_service`, `shared_source_nat_service`, `sort_key`, `redundant_router_service`, `state`, `guest_type`, `elastic_ip_service`, `eip_associate_public_ip`, `elastic_lb_service`, `specify_ip_ranges`, `inline`, `is_persistent`, `internal_lb`, `public_lb`, `egress_default_policy`, `concurrent_connections`, `keep_alive_enabled`, `supports_streched_l2`, `secondary_service_offering_id`)
VALUES
  (1, 'System-Public-Network', '779fb2ef-ea81-4ec9-b8f2-aaed2046cb6e', 'System-Public-Network', 'System Offering for System-Public-Network', 0, 0, 'Public', NULL, 1, 0, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Required', 1, 0, 0, 0, 'Enabled', NULL, 0, 1, 0, 1, 0, 0, 0, 0, 0, NULL, 0, 0, NULL),
  (2, 'System-Management-Network', 'ff65e1ae-066c-408a-a302-0245966a410d', 'System-Management-Network', 'System Offering for System-Management-Network', 0, 0, 'Management', NULL, 1, 0, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Required', 1, 0, 0, 0, 'Enabled', NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, NULL),
  (3, 'System-Control-Network', 'bcc27350-998d-4540-bbef-f8d4963a68dc', 'System-Control-Network', 'System Offering for System-Control-Network', 0, 0, 'Control', NULL, 1, 0, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Required', 1, 0, 0, 0, 'Enabled', NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, NULL),
  (4, 'System-Storage-Network', '2f7dfe9e-c0f0-49dd-855e-05b314b2b3db', 'System-Storage-Network', 'System Offering for System-Storage-Network', 0, 0, 'Storage', NULL, 1, 0, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Required', 1, 0, 0, 0, 'Enabled', NULL, 0, 1, 0, 1, 0, 0, 0, 0, 0, NULL, 0, 0, NULL),
  (5, 'DefaultPrivateGatewayNetworkOffering', 'abd43eaa-7d60-46e3-a4af-6f084b48d0b8', 'DefaultPrivateGatewayNetworkOffering', 'System Offering for DefaultPrivateGatewayNetworkOffering', 0, 0, 'Guest', NULL, 0, 0, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Optional', 1, 0, 0, 0, 'Enabled', 'Private', 0, 1, 0, 0, 0, 1, 0, 0, 0, NULL, 0, 0, NULL),
  (6, 'DefaultPrivateGatewayNetworkOfferingSpecifyVlan', 'b1888e78-65a5-4cbf-aabc-3ddab700d3b0', 'DefaultPrivateGatewayNetworkOfferingSpecifyVlan', 'System Offering for DefaultPrivateGatewayNetworkOfferingSpecifyVlan', 0, 0, 'Guest', NULL, 0, 1, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Optional', 1, 0, 0, 0, 'Enabled', 'Private', 0, 1, 0, 0, 0, 1, 0, 0, 0, NULL, 0, 0, NULL),
  (7, 'DefaultSharedNetworkOfferingWithSGService', '60422962-a5ec-4103-8c72-dbd6aeb149e1', 'DefaultSharedNetworkOfferingWithSGService', 'Offering for Shared Security group enabled networks', NULL, NULL, 'Guest', NULL, 0, 1, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Optional', 1, 0, 0, 0, 'Enabled', 'Shared', 0, 1, 0, 1, 0, 1, 0, 0, 0, NULL, 0, 0, NULL),
  (8, 'DefaultSharedNetworkOffering', 'f05f7c40-ed90-465c-8697-9453635903ac', 'DefaultSharedNetworkOffering', 'Offering for Shared networks', NULL, NULL, 'Guest', NULL, 0, 1, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Optional', 1, 0, 0, 0, 'Enabled', 'Shared', 0, 1, 0, 1, 0, 1, 0, 0, 0, NULL, 0, 0, NULL),
  (9, 'DefaultIsolatedNetworkOfferingWithSourceNatService', 'feead2ad-e42e-44f8-8f4b-5ee32d598d8a', 'DefaultIsolatedNetworkOfferingWithSourceNatService', 'Offering for Isolated networks with Source Nat service enabled', NULL, NULL, 'Guest', NULL, 0, 0, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Required', 1, 0, 0, 0, 'Enabled', 'Isolated', 0, 1, 0, 0, 0, 1, 0, 1, 0, NULL, 0, 0, NULL),
  (10, 'DefaultIsolatedNetworkOffering', 'cde4b232-4c08-4b41-851a-57e8bd635bac', 'DefaultIsolatedNetworkOffering', 'Offering for Isolated networks with Source Nat service', NULL, 10, 'Guest', NULL, 0, 0, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Optional', 0, 0, 0, 0, 'Enabled', 'Isolated', 0, 0, 0, 0, 0, 1, 0, 1, 0, NULL, 1, 0, NULL),
  (11, 'DefaultIsolatedNetworkOfferingWithEgress', 'f70f9a9d-2547-4ddc-9893-62be2133609d', 'DefaultIsolatedNetworkOfferingWithEgress', 'Offering for Isolated networks with egress and Source Nat service', NULL, 10, 'Guest', NULL, 0, 0, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Optional', 0, 0, 0, 0, 'Enabled', 'Isolated', 0, 0, 0, 0, 0, 1, 0, 1, 1, NULL, 1, 0, NULL),
  (12, 'DefaultRedundantIsolatedNetworkOffering', '6f0a672c-0c55-4347-a4ac-489a2ad94a95', 'DefaultRedundantIsolatedNetworkOffering', 'Offering for Isolated networks with Source Nat service (redundant)', NULL, 10, 'Guest', NULL, 0, 0, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Optional', 1, 0, 0, 1, 'Enabled', 'Isolated', 0, 0, 0, 0, 0, 1, 0, 1, 0, NULL, 1, 0, NULL),
  (13, 'DefaultRedundantIsolatedNetworkOfferingWithEgress', '6e792426-aca6-4fdc-aa63-11d30dbb054e', 'DefaultRedundantIsolatedNetworkOfferingWithEgress', 'Offering for Isolated networks with egress and Source Nat service (redundant)', NULL, 10, 'Guest', NULL, 0, 0, NULL, 1, '2017-10-10 09:24:51', NULL, 1, 'Optional', 1, 0, 0, 1, 'Enabled', 'Isolated', 0, 0, 0, 0, 0, 1, 0, 1, 1, NULL, 1, 0, NULL),
  (14, 'DefaultIsolatedNetworkOfferingForVpcNetworks', 'ad855af2-3743-43b1-b2c0-fa632ebb6b29', 'DefaultIsolatedNetworkOfferingForVpcNetworks', 'Offering for Isolated Vpc networks with Source Nat service enabled', NULL, NULL, 'Guest', NULL, 0, 0, NULL, 0, '2017-10-10 09:24:51', NULL, 1, 'Optional', 1, 0, 0, 0, 'Enabled', 'Isolated', 0, 1, 0, 0, 0, 1, 0, 1, 0, NULL, 0, 0, NULL),
  (15, 'DefaultIsolatedNetworkOfferingForVpcNetworksNoLB', '76f3ac17-1a47-4e26-bccd-d86a0bfc0a05', 'DefaultIsolatedNetworkOfferingForVpcNetworksNoLB', 'Offering for Isolated Vpc networks with Source Nat service enabled and LB service Disabled', NULL, NULL, 'Guest', NULL, 0, 0, NULL, 0, '2017-10-10 09:24:51', NULL, 1, 'Optional', 1, 0, 0, 0, 'Enabled', 'Isolated', 0, 1, 0, 0, 0, 1, 0, 0, 0, NULL, 0, 0, NULL),
  (16, 'DefaultIsolatedNetworkOfferingForVpcNetworksWithInternalLB', 'b40523b6-0b6f-4022-9388-ddf76eab6d66', 'DefaultIsolatedNetworkOfferingForVpcNetworksWithInternalLB', 'Offering for Isolated Vpc networks with Internal LB support', NULL, NULL, 'Guest', NULL, 0, 0, NULL, 0, '2017-10-10 09:24:51', NULL, 1, 'Optional', 1, 0, 0, 0, 'Enabled', 'Isolated', 0, 1, 0, 0, 0, 1, 1, 0, 0, NULL, 0, 0, NULL),
  (17, 'DefaultIsolatedNetworkOfferingForVpcNetworksWithoutSourceNat', '7ef6790f-f334-4cdf-8562-67232de113ad', 'DefaultIsolatedNetworkOfferingForVpcNetworksWithoutSourceNat', 'Offering for Isolated VPC networks without Source Nat service enabled and LB service disabled', NULL, 10, 'Guest', NULL, 0, 0, NULL, 0, '2017-10-10 09:24:54', NULL, 1, 'Optional', 0, 0, 0, 0, 'Enabled', 'Isolated', 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 1, 0, NULL),
  (18, 'DefaultIsolatedNetworkOfferingForVpcNetworksInternalVPC', '28a928d2-84ab-435a-837a-b6da744ad49b', 'DefaultIsolatedNetworkOfferingForVpcNetworksInternalVPC', 'Offering for Isolated VPC networks for Internal VPC networks', NULL, 10, 'Guest', NULL, 0, 0, NULL, 0, '2017-10-10 09:24:54', NULL, 1, 'Optional', 0, 0, 0, 0, 'Enabled', 'Isolated', 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 1, 0, NULL);
