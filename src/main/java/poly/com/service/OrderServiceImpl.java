package poly.com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import poly.com.entity.Order;
import poly.com.repository.OrderRepository;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Override
    public Map<String, BigDecimal> getTotalRevenueByMonth() {
        List<Object[]> results = orderRepository.findTotalRevenueByMonth();

        Map<String, BigDecimal> revenueByMonth = new HashMap<>();
        for (Object[] result : results) {
            Integer month = (Integer) result[0];
            BigDecimal totalRevenue = (BigDecimal) result[1];
            String monthYear = String.format("%02d", month) + "-" + LocalDate.now().getYear();
            revenueByMonth.put(monthYear, totalRevenue);
        }

        return revenueByMonth;
    }

}
