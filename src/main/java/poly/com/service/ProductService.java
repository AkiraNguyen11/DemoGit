package poly.com.service;

import poly.com.entity.Product;
import poly.com.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    
    @Autowired
    private ProductRepository productRepository;

    // Lấy danh sách tất cả sản phẩm
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // Tìm kiếm sản phẩm theo từ khóa
    public List<Product> searchProducts(String keyword) {
        if (keyword != null && !keyword.isEmpty()) {
            return productRepository.findByNameContainingIgnoreCase(keyword);
        }
        return getAllProducts();
    }

    // Lọc sản phẩm theo khoảng giá
    public List<Product> filterProductsByPrice(String priceRange) {
        if (priceRange != null && !priceRange.isEmpty()) {
            String[] prices = priceRange.split("-");
            if (prices.length == 2) {
                double minPrice = Double.parseDouble(prices[0]);
                double maxPrice = Double.parseDouble(prices[1]);
                return productRepository.findByPriceBetween(minPrice, maxPrice);
            } else if (prices.length == 1) {
                double minPrice = Double.parseDouble(prices[0]);
                return productRepository.findByPriceGreaterThanEqual(minPrice);
            }
        }
        return getAllProducts();
    }

    // Kết hợp tìm kiếm và lọc sản phẩm
    public List<Product> getProductBySearchAndFilter(String search, String priceRange) {
        List<Product> products = getAllProducts();
        if (search != null && !search.isEmpty()) {
            products = searchProducts(search);
        }
        if (priceRange != null && !priceRange.isEmpty()) {
            products = filterProductsByPrice(priceRange);
        }
        return products;
    }

    // Lấy thông tin của một sản phẩm theo id
    public Product getProductById(Long productId) {
        return productRepository.findById(productId).orElse(null);
    }

    // Lọc sản phẩm theo nhiều điều kiện: từ khóa tìm kiếm, khoảng giá và id của category
    public List<Product> getFilteredProducts(String search, String priceRange, Long categoryId) {
        List<Product> products = getAllProducts();
        if (search != null && !search.isEmpty()) {
            products = searchProducts(search);
        }
        if (priceRange != null && !priceRange.isEmpty()) {
            products = filterProductsByPrice(priceRange);
        }
        if (categoryId != null) {
            // Nếu categoryId được cung cấp, thêm điều kiện lọc theo categoryId vào danh sách sản phẩm
            products = productRepository.findByCategoryId(categoryId);
        }
        return products;
    }
    
    
}
