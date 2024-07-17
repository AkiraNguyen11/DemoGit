package poly.com.controller;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.com.entity.Cart;
import poly.com.entity.Category;
import poly.com.entity.Order;
import poly.com.service.CartService;
import poly.com.dao.OrderDAO;

@Controller
@RequestMapping("/cart")
public class CartController {

	@Autowired
	private CartService cartService;

	@Autowired
	private OrderDAO dao;

	@PostMapping("/add-to-cart")
	public String addToCart(@RequestParam("productId") Long productId, @RequestParam("quantity") int quantity,
			@RequestParam("price") BigDecimal price, HttpSession session) {

		Long userId = (Long) session.getAttribute("userId");
		if (userId != null) {
			cartService.addToCart(userId, productId, quantity, price);
			return "redirect:/cart/cartshow"; // Redirect to cart page after adding the item
		} else {
			return "redirect:/login"; // Redirect to login page if userId is not found
		}
	}

	@PostMapping("/remove-from-cart")
	public String removeFromCart(@RequestParam("productId") Long productId, HttpSession session) {

		Long userId = (Long) session.getAttribute("userId");
		if (userId != null) {
			cartService.removeFromCart(userId, productId);
			return "redirect:/cart/cartshow"; // Redirect to cart page after removing the item
		} else {
			return "redirect:/login"; // Redirect to login page if userId is not found
		}
	}

	@PostMapping("/update-quantity")
	@ResponseBody
	public String updateQuantity(@RequestParam("productId") Long productId, @RequestParam("quantity") int quantity,
			HttpSession session) {

		Long userId = (Long) session.getAttribute("userId");
		if (userId != null) {
			cartService.updateQuantity(userId, productId, quantity);
			return "Quantity updated successfully";
		} else {
			return "redirect:/login"; // Redirect to login page if userId is not found
		}
	}

	@GetMapping("/cartshow")
	public String viewCart(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId != null) {
			List<Cart> cartItems = cartService.getCartItems(userId);
			model.addAttribute("cartItems", cartItems);
			return "order/cart";
		} else {
			return "redirect:/login";
		}
	}

	@PostMapping("/orders")
	public String create(@ModelAttribute("item") Order item, HttpSession session, HttpServletRequest request,
			Model model) {
		Long userId = (Long) session.getAttribute("userId");

		// Lấy giá trị totalPrice từ request
		String totalPriceParam = request.getParameter("totalPrice");
		BigDecimal totalPrice = null;

		// Kiểm tra xem totalPrice có giá trị không null và không rỗng không
		if (totalPriceParam != null && !totalPriceParam.isEmpty()) {
			totalPrice = new BigDecimal(totalPriceParam);
		} else {
			// Xử lý khi totalPrice không có giá trị
			// Ví dụ: đặt giá trị mặc định là 0
			totalPrice = BigDecimal.ZERO;
		}

		// Thiết lập giá trị totalPrice cho đối tượng đơn hàng
		item.setTotalPrice(totalPrice);

		// Lấy thời gian hiện tại
		Timestamp orderDate = new Timestamp(System.currentTimeMillis());

		item.setOrderDate(orderDate);
		item.setOrderStatus("Pending");

		// Thiết lập userId cho đối tượng đơn hàng
		item.setUserId(userId);

		// Lưu đối tượng đơn hàng vào cơ sở dữ liệu
		dao.save(item);
		cartService.clearCart(userId);

		return "redirect:/cartshow";
	}

}
