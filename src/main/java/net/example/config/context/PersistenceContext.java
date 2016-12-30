package net.example.config.context;

import liquibase.Liquibase;
import liquibase.integration.spring.SpringLiquibase;
import org.h2.jdbcx.JdbcDataSource;
import org.h2.tools.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.SQLException;

@Configuration
public class PersistenceContext {

    public static final String DATA_SOURCE_NAME = "h2";
    public static final String DATA_SOURCE_URL =
            "jdbc:h2:mem:public;LOCK_MODE=0;DB_CLOSE_DELAY=-1;MODE=Oracle;INIT=CREATE SCHEMA IF NOT EXISTS public";

    @Bean
    public DataSource dataSource() throws NamingException {
        JdbcDataSource ds = new JdbcDataSource();
        ds.setURL(DATA_SOURCE_URL);
        ds.setUser("sa");
        ds.setPassword("sa");

        Context ctx = new InitialContext();
        ctx.bind(DATA_SOURCE_NAME, ds);

        return ds;
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
    public SpringLiquibase liquibase() throws NamingException {
        SpringLiquibase liquibase = new SpringLiquibase();
        liquibase.setBeanName("liquibase");
        liquibase.setDataSource(dataSource());
        liquibase.setChangeLog("classpath:liquibase/changelog.xml");
        return liquibase;
    }

}
