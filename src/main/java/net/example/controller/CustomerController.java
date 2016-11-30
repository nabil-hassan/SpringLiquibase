package net.example.controller;

import net.example.constants.JSPView;
import net.example.dao.CustomerDAO;
import net.example.domain.Customer;
import net.example.service.CustomerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class CustomerController {

    private static final Logger LOG = LoggerFactory.getLogger(CustomerController.class);

    @Autowired
    private CustomerService customerService;

    @Autowired
    private CustomerDAO customerDAO;

    @RequestMapping(value = "/customerForm", method = RequestMethod.GET)
    public String handleGetCustomerForm(@RequestParam(required = false) String customerId, ModelMap modelMap) {
        // TODO: load from data source when customer id provided, rather than return null.
        Customer customer = customerId == null
                ? new Customer() : customerDAO.loadById(Long.valueOf(customerId));

        modelMap.addAttribute("customer", customer);

        return JSPView.CUSTOMER_DETAILS;
    }

    @RequestMapping(value = "/customerForm/submit", method = RequestMethod.POST)
    public String handleCustomerFormSubmit(@ModelAttribute Customer customer,
                                           BindingResult bindingResult,
                                           RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            LOG.error("Error binding customer form to entity object.");
            return JSPView.CUSTOMER_DETAILS;
        }

        Customer persistedCustomer = customerService.saveCustomer(customer);
        redirectAttributes.addFlashAttribute("customer", persistedCustomer);

        return "redirect:/customerForm/edit";
    }

    @RequestMapping(value = "/customerForm/edit", method = RequestMethod.GET)
    public String handleCustomerFormEdit() {
        return JSPView.CUSTOMER_DETAILS;
    }

    @RequestMapping(value = "/customerList")
    public ModelAndView handleGetCustomerList(ModelMap model) {
        List<Customer> customers = customerDAO.findAll();

        ModelAndView mv = new ModelAndView(JSPView.CUSTOMER_LIST);
        mv.addObject("customers", customers);

        return mv;
    }

}
