package poly.com.service;

import java.math.BigDecimal;
import java.util.Map;

public interface OrderService {

    Map<String, BigDecimal> getTotalRevenueByMonth();
}
