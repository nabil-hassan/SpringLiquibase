package net.example.config.context;

import liquibase.Liquibase;
import liquibase.integration.spring.SpringLiquibase;
import org.h2.tools.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.sql.SQLException;

@Configuration
public class PersistenceContext {

    private static final String DATA_SOURCE_DRIVER_CLASS = "org.h2.Driver";
    private static final String DATA_SOURCE_URL =
            "jdbc:h2:mem:public;LOCK_MODE=0;DB_CLOSE_DELAY=-1;MODE=Oracle;INIT=CREATE SCHEMA IF NOT EXISTS public";

    @Bean
    public DriverManagerDataSource dataSource() {
        DriverManagerDataSource dataSource
                = new DriverManagerDataSource(DATA_SOURCE_URL, "sa", "sa");
        dataSource.setDriverClassName(DATA_SOURCE_DRIVER_CLASS);
        return dataSource;
    }

    @Bean(initMethod = "start", destroyMethod = "stop")
    public Server h2Server() throws SQLException {
        return Server.createTcpServer("-tcpAllowOthers", "-tcpPort", "8043");
    }

    @Bean(initMethod = "start", destroyMethod = "stop")
    public Server webServer() throws SQLException {
        return Server.createWebServer("-web", "-webAllowOthers", "-webPort", "8091");
    }

    @Bean
    public SpringLiquibase liquibase() {
        SpringLiquibase liquibase = new SpringLiquibase();
        liquibase.setBeanName("liquibase");
        liquibase.setDataSource(dataSource());
        liquibase.setChangeLog("classpath:liquibase/changelog.xml");
        return liquibase;
    }


}
