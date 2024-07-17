package poly.com.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import poly.com.entity.Cart;

public interface CartRepository extends JpaRepository<Cart, Long> {
}

