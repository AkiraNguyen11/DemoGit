package poly.com.repository;

import poly.com.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByNameContainingIgnoreCase(String name);
    List<Product> findByPriceBetween(double minPrice, double maxPrice);
    List<Product> findByPriceGreaterThanEqual(double minPrice);
        List<Product> findByCategoryId(Long categoryId);
        
    
}
