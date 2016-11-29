package net.example.service;

import net.example.dao.CustomerDAO;
import net.example.domain.Customer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CustomerService {

    private static final Logger LOG = LoggerFactory.getLogger(CustomerService.class);
    private CustomerDAO customerDAO;

    public CustomerService(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    public Customer saveCustomer(Customer customer) {
        LOG.debug("Saving customer: {}", customer);

        customerDAO.save(customer);

        return customer;
    }

}
