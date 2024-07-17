package poly.com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import poly.com.dao.OrderDAO;
import poly.com.entity.Order;
import poly.com.entity.Product;

@Controller
@RequestMapping("/order")
public class OrderDetailController {

    @Autowired
    private OrderDAO orderDAO;

    @GetMapping("/details/{orderId}")
    public String getOrderDetails(@PathVariable Long orderId, Model model) {
        Order order = orderDAO.findById(orderId).orElse(null);
        if (order != null) {
            model.addAttribute("order", order);
            return "order/order_detail";
        } else {
            // Xử lý trường hợp không tìm thấy đơn hàng
            return "error";
        }
    }
}
