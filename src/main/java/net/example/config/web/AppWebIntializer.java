package net.example.config.web;

import net.example.config.context.AppContext;
import net.example.config.context.PersistenceContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

/**
 * Initialiser for the web application - uses Java Servlet 3 approach to web app configuration.
 */
public class AppWebIntializer implements WebApplicationInitializer {

    private static final Logger LOG = LoggerFactory.getLogger(AppWebIntializer.class);

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        LOG.info("Starting up application context");
        AnnotationConfigWebApplicationContext appContext = new AnnotationConfigWebApplicationContext();
        appContext.register(AppContext.class);
        appContext.register(PersistenceContext.class);
        appContext.setServletContext(servletContext);
        servletContext.addListener(new ContextLoaderListener(appContext));

        LOG.info("Registering dispatcher servlet");
        ServletRegistration.Dynamic servlet
                = servletContext.addServlet("dispatcher", new DispatcherServlet(appContext));
        servlet.setLoadOnStartup(1);
        servlet.addMapping("/");
    }

}