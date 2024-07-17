package poly.com.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import poly.com.entity.*;
public interface ProductManaDAO extends JpaRepository<Product,Long> {

}
