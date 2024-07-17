package poly.com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import poly.com.dao.UserManaDAO;
import poly.com.entity.Users;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/user-manager")
public class UserController {

    @Autowired
    private UserManaDAO dao;

    @GetMapping
    public String listUsers(Model model) {
        List<Users> users = dao.findAll();
        model.addAttribute("users", users);
        return "admin/user-manager"; // Name of the JSP page
    }

    @PostMapping("/create")
    public String create(Users item) {
        dao.save(item);
        return "redirect:/user-manager";
    }

    @PostMapping("/update")
    public String update(Users item) {
        dao.save(item);
        return "redirect:/user-manager";
    }

    @GetMapping("/edit/{id}")
    public String edit(Model model, @PathVariable("id") Long id) {
        Optional<Users> optionalItem = dao.findById(id);
        if (optionalItem.isPresent()) {
            Users item = optionalItem.get();
            model.addAttribute("item", item); // Chuyển đối tượng Users vào model
            List<Users> users = dao.findAll();
            model.addAttribute("users", users);
            return "admin/user-manager";
        }
        return "redirect:/user-manager";
    }



    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        dao.deleteById(id);
        return "redirect:/user-manager";
    }
}
