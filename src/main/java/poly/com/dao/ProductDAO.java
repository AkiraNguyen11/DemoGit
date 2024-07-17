package poly.com.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import poly.com.entity.Product;

@Repository
public interface ProductDAO extends JpaRepository<Product, Integer> {

	Page<Product> findByNameLikeAndPriceBetween(String name, double minPrice, double maxPrice, Pageable pageable);
    Page<Product> findByNameLikeAndPriceBetweenAndCategoryId(String name, double minPrice, double maxPrice, Long categoryId, Pageable pageable);

	Page<Product> findAllByNameLike(String keywords, Pageable pageable);
	
	
}