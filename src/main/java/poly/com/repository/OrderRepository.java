package poly.com.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import poly.com.entity.Order;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {

	@Query("SELECT MONTH(o.orderDate), SUM(o.totalPrice) FROM Order o WHERE MONTH(o.orderDate) = MONTH(CURRENT_DATE()) GROUP BY MONTH(o.orderDate)")
	List<Object[]> findTotalRevenueByMonth();

}
