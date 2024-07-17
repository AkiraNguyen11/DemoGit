package poly.com.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import poly.com.entity.Cart;

public interface CartDAO extends JpaRepository<Cart, Long> {

    List<Cart> findByUserId(Long userId);

    Cart findByUserIdAndProductId(Long userId, Long productId);

    @Query("SELECT c FROM Cart c JOIN FETCH c.product p WHERE c.userId = :userId")
    List<Cart> findByUserIdWithProduct(Long userId);
    
    
}
