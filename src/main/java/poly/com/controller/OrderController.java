package poly.com.controller;

import java.util.List;

import java.math.BigDecimal;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.com.dao.OrderDAO;
import poly.com.entity.Order;
import poly.com.service.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderDAO orderDAO;

    @GetMapping("/list")
    public String listOrders(Model model) {
        List<Order> orders = orderDAO.findAll();
        model.addAttribute("orders", orders);
        return "order/list";
    }

    @PostMapping("/cancel")
    public String cancelOrder(Long orderId) {
        // Xóa đơn hàng có orderId khỏi cơ sở dữ liệu
        orderDAO.deleteById(orderId);
        // Sau khi xóa, chuyển hướng trở lại trang danh sách đơn hàng
        return "redirect:/order/list";
    }
    
    @Autowired
    private OrderService orderService;

    @GetMapping("/revenue-by-month")
    public String getTotalRevenueByMonth(Model model) {
        Map<String, BigDecimal> revenueByMonth = orderService.getTotalRevenueByMonth();
        model.addAttribute("revenueByMonth", revenueByMonth);
        return "admin/revenou";
    }
}

