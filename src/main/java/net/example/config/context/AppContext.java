package net.example.config.context;

import net.example.dao.CustomerDAO;
import net.example.domain.Customer;
import net.example.service.CustomerService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * <p>
 * The Spring context for the application. The top level is the controller-layer, and all beans in this package
 * are managed via component scan. This allows the dependencies defined in this JavaConfig context to be wired together,
 * and into the controller layer, via standard autowiring.
 * </p>
 *
 *
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "net.example.controller")
public class AppContext extends WebMvcConfigurerAdapter {

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }

    @Bean
    public Map<Long, Customer> customerDataSource() {
        return new LinkedHashMap<>();
    }

    @Bean
    public CustomerDAO customerDAO() {
        return new CustomerDAO(customerDataSource());
    }

    @Bean
    public CustomerService customerService() {
        return new CustomerService(customerDAO());
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry
                .addViewController("/")
                .setViewName("index");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }

}
