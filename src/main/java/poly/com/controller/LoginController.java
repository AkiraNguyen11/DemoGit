package poly.com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.com.dao.UserDAO;
import poly.com.entity.Users;

@Controller
public class LoginController {

    @Autowired
    private UserDAO userDAO;

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("user", new Users());
        return "account/account";
    }

    @PostMapping("/authenticate")
    @Transactional
    public String authenticateUser(@ModelAttribute("user") Users user, HttpSession session, Model model) {
        Users existingUser = userDAO.findByUsername(user.getUsername());
        if (existingUser != null) {
            if (existingUser.getPassword().equals(user.getPassword())) {
                session.setAttribute("loggedInUser", existingUser.getFullName());
                session.setAttribute("email", existingUser.getEmail());
                session.setAttribute("phoneNumber", existingUser.getPhoneNumber());
                session.setAttribute("address", existingUser.getAddress());
                session.setAttribute("userId", existingUser.getId()); // Lưu userId vào session
                session.setAttribute("isAdmin", existingUser.isAdmin()); // Lưu quyền admin vào session
                if (existingUser.isAdmin()) {
                    return "redirect:/index";
                } else {
                    return "redirect:/product/list";
                }
            } else {
                model.addAttribute("error", "Sai mật khẩu");
                return "account/account";
            }
        } else {
            model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu");
            return "account/account";
        }
    }

    @GetMapping("/edit-profile")
    public String showEditProfileForm(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId != null) {
            Users user = userDAO.findById(userId);
            model.addAttribute("user", user);
            return "account/edit_profile";
        } else {
            // Redirect to login if user not logged in
            return "redirect:/login";
        }
    }

    @PostMapping("/update-profile")
    @Transactional
    public String updateProfile(@ModelAttribute("user") Users updatedUser, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId != null) {
            Users existingUser = userDAO.findById(userId);
            existingUser.setFullName(updatedUser.getFullName());
            existingUser.setEmail(updatedUser.getEmail());
            existingUser.setPhoneNumber(updatedUser.getPhoneNumber());
            existingUser.setAddress(updatedUser.getAddress());
            String newPassword = updatedUser.getPassword();
            if (newPassword != null && !newPassword.isEmpty()) {
                existingUser.setPassword(newPassword);
            }
            userDAO.update(existingUser);
        }
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("loggedInUser");
        session.removeAttribute("email");
        session.removeAttribute("phoneNumber");
        session.removeAttribute("address");
        session.removeAttribute("userId"); // Xóa userId khỏi session
        session.removeAttribute("isAdmin"); // Xóa quyền admin khỏi session
        session.invalidate(); // Hủy session
        return "redirect:/login";
    }
}
