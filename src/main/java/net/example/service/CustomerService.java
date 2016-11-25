package net.example.service;

import net.example.domain.Customer;
import net.example.validation.CustomerValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CustomerService {

    private static final Logger LOG = LoggerFactory.getLogger(CustomerService.class);
    private CustomerValidator customerValidator;

    public CustomerService(CustomerValidator customerValidator) {
        this.customerValidator = customerValidator;
    }

    public Customer saveCustomer(Customer customer) {
        return customer;
    }

}
