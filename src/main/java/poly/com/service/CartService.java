package poly.com.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import poly.com.dao.CartDAO;
import poly.com.entity.Cart;

@Service
public class CartService {
    @Autowired
    private CartDAO cartDAO;

    public List<Cart> getCartItems(Long userId) {
        return cartDAO.findByUserIdWithProduct(userId);
    }

    @Transactional
    public void addToCart(Long userId, Long productId, int quantity, BigDecimal price) {
        Cart existingCartItem = cartDAO.findByUserIdAndProductId(userId, productId);
        BigDecimal priceNotNull = price != null ? price : BigDecimal.ZERO;

        if (existingCartItem != null) {
            existingCartItem.setQuantity(existingCartItem.getQuantity() + quantity);
            existingCartItem.setPrice(
                existingCartItem.getPrice() != null ? 
                existingCartItem.getPrice().add(priceNotNull.multiply(BigDecimal.valueOf(quantity))) : 
                priceNotNull.multiply(BigDecimal.valueOf(quantity))
            );
            cartDAO.save(existingCartItem);
        } else {
            Cart newCartItem = new Cart();
            newCartItem.setUserId(userId);
            newCartItem.setProductId(productId);
            newCartItem.setQuantity(quantity);
            newCartItem.setPrice(priceNotNull.multiply(BigDecimal.valueOf(quantity)));
            cartDAO.save(newCartItem);
        }
    }

    @Transactional
    public void removeFromCart(Long userId, Long productId) {
        Cart cartItem = cartDAO.findByUserIdAndProductId(userId, productId);
        if (cartItem != null) {
            cartDAO.delete(cartItem);
        }
    }

    @Transactional
    public void updateQuantity(Long userId, Long productId, int quantity) {
        Cart cartItem = cartDAO.findByUserIdAndProductId(userId, productId);
        if (cartItem != null) {
            cartItem.setQuantity(quantity);
            cartDAO.save(cartItem);
        }
    }

    @Transactional
    public void checkout(Long userId) {
        List<Cart> cartItems = cartDAO.findByUserId(userId);
        if (cartItems != null && !cartItems.isEmpty()) {
            // Logic for checkout process
            // This could include creating an order, reducing stock, etc.
            
            // Clear the cart after checkout
            cartDAO.deleteAll(cartItems);
        }
    }
    
    @Transactional
    public BigDecimal calculateTotalPrice(List<Cart> cartItems) {
        BigDecimal totalPrice = BigDecimal.ZERO;
        for (Cart cartItem : cartItems) {
            totalPrice = totalPrice.add(cartItem.getPrice());
        }
        return totalPrice;
    }

    @Transactional
    public void clearCart(Long userId) {
        List<Cart> cartItems = cartDAO.findByUserId(userId);
        if (cartItems != null && !cartItems.isEmpty()) {
            cartDAO.deleteAll(cartItems);
        }
    }
}
