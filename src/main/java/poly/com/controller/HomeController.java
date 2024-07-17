package poly.com.controller;

import poly.com.service.CategoryService;
import poly.com.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/index")
    public String index(Model model) {
        return "index";
    }
    

    
    @GetMapping("/account")
    public String index3() {
        return "account/account";
    }
    
    @GetMapping("/regis")
    public String index4() {
        return "account/register";
    }
    
    @GetMapping("/forgot")
    public String index5() {
        return "account/forget";
    }
}


