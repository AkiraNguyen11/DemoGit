package poly.com.entity;

import javax.persistence.*;

@Entity
@Table(name = "Users")
public class Users {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="UserID")
    private Long id;

    @Column(name = "Username")  // Đảm bảo tên cột khớp với cơ sở dữ liệu
    private String username;

    @Column(name = "Password")  // Đảm bảo tên cột khớp với cơ sở dữ liệu
    private String password;

    @Column(name = "Email")  // Đảm bảo tên cột khớp với cơ sở dữ liệu
    private String email;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "Address")  // Đảm bảo tên cột khớp với cơ sở dữ liệu
    private String address;

    @Column(name = "phone_number")  // Đảm bảo tên cột khớp với cơ sở dữ liệu
    private String phoneNumber;

    @Column(name = "is_admin")  // Đảm bảo tên cột khớp với cơ sở dữ liệu
    private boolean isAdmin;

    // Getter và setter
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }
}
