package poly.com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import poly.com.dao.ProductManaDAO;
import poly.com.entity.Product;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/product-manager")
public class ProductManaController {

    @Autowired
    private ProductManaDAO productDAO;

    @GetMapping
    public String listProducts(Model model) {
        List<Product> products = productDAO.findAll();
        model.addAttribute("products", products);
        return "admin/product-manager";
    }

    @GetMapping("/edit/{id}")
    public String edit(Model model, @PathVariable("id") Long id) {
        Optional<Product> optionalProduct = productDAO.findById(id);
        if (optionalProduct.isPresent()) {
            Product product = optionalProduct.get();
            model.addAttribute("product", product);
            return "admin/product-edit";
        }
        return "redirect:/product-manager";
    }

    @PostMapping("/update")
    public String update(Product product) {
        productDAO.save(product);
        return "redirect:/product-manager";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        productDAO.deleteById(id);
        return "redirect:/product-manager";
    }

    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("product", new Product());
        return "admin/product-add";
    }

    @PostMapping("/save")
    public String save(Product product) {
        productDAO.save(product);
        return "redirect:/product-manager";
    }
}

