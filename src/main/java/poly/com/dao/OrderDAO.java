package poly.com.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import poly.com.entity.Order;

@Repository
public interface OrderDAO extends JpaRepository<Order, Long> {
	 void deleteById(Long id);
	
	
}
