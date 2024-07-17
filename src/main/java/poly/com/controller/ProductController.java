package poly.com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import poly.com.service.SessionService;
import poly.com.dao.ProductDAO;
import poly.com.entity.Category;
import poly.com.entity.Product;
import poly.com.service.CategoryService;
import poly.com.service.ProductService;

import java.util.List;
import java.util.Optional;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;
    
    @Autowired
    ProductDAO dao;

    @Autowired
    private CategoryService categoryService;
    
    @Autowired
    SessionService session;

    @RequestMapping("/product/list")
    public String searchAndPage(Model model, @RequestParam("keywords") Optional<String> kw,
                                @RequestParam("p") Optional<Integer> p,
                                @RequestParam("min") Optional<Double> min,
                                @RequestParam("max") Optional<Double> max,
                                @RequestParam("category") Optional<Long> categoryId) {
        String kwords = kw.orElse(session.get("keywords"));
        session.set("keywords", kwords);
        double minPrice = min.orElse(Double.MIN_VALUE);
        double maxPrice = max.orElse(Double.MAX_VALUE);
        Long catId = categoryId.orElse(null);

        Pageable pageable = PageRequest.of(p.orElse(0), 12);
        Page<Product> page;

        if (catId != null) {
            page = dao.findByNameLikeAndPriceBetweenAndCategoryId("%" + kwords + "%", minPrice, maxPrice, catId, pageable);
            model.addAttribute("selectedCategory", catId);
        } else {
            page = dao.findByNameLikeAndPriceBetween("%" + kwords + "%", minPrice, maxPrice, pageable);
        }

        model.addAttribute("page", page);
        model.addAttribute("keywords", kwords);
        model.addAttribute("min", minPrice);
        model.addAttribute("max", maxPrice);

        // Get list of categories
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);

        return "product/list";
    }

    @GetMapping("/product_detail/{id}")
    public String getProductDetail(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "product/detail";
    }
}
