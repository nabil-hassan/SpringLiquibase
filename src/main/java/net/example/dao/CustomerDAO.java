package net.example.dao;

import net.example.domain.Customer;

import java.util.*;

public class CustomerDAO {

    private Map<Long, Customer> dataSource = new LinkedHashMap<>();
    private Long idSequence = 1L;

    public CustomerDAO(Map<Long, Customer> dataSource) {
        this.dataSource = dataSource;
    }

    public Customer loadById(Long id) {
        Customer customer = dataSource.get(id);

        if (customer == null) {
            throw new RuntimeException("Customer with id: " + id + " does not exist");
        }

        return customer;
    }

    public Customer save(Customer customer) {
        if (customer.getId() == null) {
            customer.setId(idSequence++);
        }

        dataSource.put(customer.getId(), customer);

        return customer;
    }

    public List<Customer> findAll() {
        return new ArrayList<>(dataSource.values());
    }

}
