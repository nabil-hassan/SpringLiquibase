package net.example.config.web;

import net.example.config.context.AppContext;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

/**
 * Initialiser for the web application - uses Java Servlet 3 approach to web app configuration.
 */
public class AppWebIntializer implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {

        AnnotationConfigWebApplicationContext appContext = new AnnotationConfigWebApplicationContext();
        appContext.register(AppContext.class);
        appContext.setServletContext(servletContext);

        ServletRegistration.Dynamic servlet
                = servletContext.addServlet("dispatcher", new DispatcherServlet(appContext));
        servlet.setLoadOnStartup(1);
        servlet.addMapping("/");
    }
}
