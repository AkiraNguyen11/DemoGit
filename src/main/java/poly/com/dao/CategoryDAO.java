package poly.com.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import poly.com.entity.Category;

@Repository
public interface CategoryDAO extends JpaRepository<Category, Long> {
}
