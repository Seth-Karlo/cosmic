package com.cloud.internallbelement;

import com.cloud.configuration.ConfigurationManager;
import com.cloud.dao.EntityManager;
import com.cloud.db.repository.ZoneRepository;
import com.cloud.engine.orchestration.service.NetworkOrchestrationService;
import com.cloud.lb.dao.ApplicationLoadBalancerRuleDao;
import com.cloud.network.IpAddressManager;
import com.cloud.network.NetworkModel;
import com.cloud.network.dao.NetworkServiceMapDao;
import com.cloud.network.dao.PhysicalNetworkServiceProviderDao;
import com.cloud.network.dao.VirtualRouterProviderDao;
import com.cloud.network.lb.InternalLoadBalancerVMManager;
import com.cloud.test.utils.SpringUtils;
import com.cloud.user.AccountManager;
import com.cloud.utils.net.NetUtils;
import com.cloud.vm.dao.DomainRouterDao;

import java.io.IOException;

import org.mockito.Mockito;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.core.type.classreading.MetadataReader;
import org.springframework.core.type.classreading.MetadataReaderFactory;
import org.springframework.core.type.filter.TypeFilter;

@Configuration
@ComponentScan(basePackageClasses = {NetUtils.class},
        includeFilters = {@Filter(value = ElementChildTestConfiguration.Library.class, type = FilterType.CUSTOM)},
        useDefaultFilters = false)
public class ElementChildTestConfiguration {
    public static class Library implements TypeFilter {
        @Bean
        public AccountManager accountManager() {
            return Mockito.mock(AccountManager.class);
        }

        @Bean
        public DomainRouterDao domainRouterDao() {
            return Mockito.mock(DomainRouterDao.class);
        }

        @Bean
        public VirtualRouterProviderDao virtualRouterProviderDao() {
            return Mockito.mock(VirtualRouterProviderDao.class);
        }

        @Bean
        public NetworkModel networkModel() {
            return Mockito.mock(NetworkModel.class);
        }

        @Bean
        public NetworkOrchestrationService networkManager() {
            return Mockito.mock(NetworkOrchestrationService.class);
        }

        @Bean
        public IpAddressManager ipAddressManager() {
            return Mockito.mock(IpAddressManager.class);
        }

        @Bean
        public PhysicalNetworkServiceProviderDao physicalNetworkServiceProviderDao() {
            return Mockito.mock(PhysicalNetworkServiceProviderDao.class);
        }

        @Bean
        public NetworkServiceMapDao networkServiceMapDao() {
            return Mockito.mock(NetworkServiceMapDao.class);
        }

        @Bean
        public InternalLoadBalancerVMManager internalLoadBalancerVMManager() {
            return Mockito.mock(InternalLoadBalancerVMManager.class);
        }

        @Bean
        public ConfigurationManager confugurationManager() {
            return Mockito.mock(ConfigurationManager.class);
        }

        @Bean
        public EntityManager entityManager() {
            return Mockito.mock(EntityManager.class);
        }

        @Bean
        public ApplicationLoadBalancerRuleDao applicationLoadBalancerRuleDao() {
            return Mockito.mock(ApplicationLoadBalancerRuleDao.class);
        }

        @Bean
        public ZoneRepository zoneRepository() {
            return Mockito.mock(ZoneRepository.class);
        }

        @Override
        public boolean match(final MetadataReader mdr, final MetadataReaderFactory arg1) throws IOException {
            mdr.getClassMetadata().getClassName();
            final ComponentScan cs = ElementChildTestConfiguration.class.getAnnotation(ComponentScan.class);
            return SpringUtils.includedInBasePackageClasses(mdr.getClassMetadata().getClassName(), cs);
        }
    }
}
