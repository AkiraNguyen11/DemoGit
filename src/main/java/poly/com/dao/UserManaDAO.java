package poly.com.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import poly.com.entity.*;
public interface UserManaDAO extends JpaRepository<Users,Long> {

}
