package net.example.controller;

import net.example.constants.JSPView;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CustomerController {

    @RequestMapping(value = "/customerList", method = RequestMethod.GET)
    public String customerList() {
        return JSPView.CUSTOMER_LIST;
    }
}
