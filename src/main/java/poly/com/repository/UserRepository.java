package poly.com.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import poly.com.entity.Users;

public interface UserRepository extends JpaRepository<Users, Long> {
    Users findByEmail(String email);
}
