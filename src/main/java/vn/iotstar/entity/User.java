package vn.iotstar.entity;

import java.io.Serializable;
import java.time.LocalDateTime;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "username", length = 50, nullable = false, unique = true)
    private String username;

    @Column(name = "password", length = 255, nullable = false)
    private String password;

    @Column(name = "email", length = 100, nullable = false, unique = true)
    private String email;

    @Column(name = "fullname", columnDefinition = "NVARCHAR(100) NULL")
    private String fullname;

    @Column(name = "phone", length = 20, nullable = true)
    private String phone;

    @Column(name = "images", columnDefinition = "NVARCHAR(500) NULL")
    private String images;

    @Column(name = "roleid")
    private Integer roleid = 2; // 1: Admin, 2: User

    @Column(name = "status")
    private Integer status = 0; // 0: Chưa kích hoạt, 1: Đã kích hoạt

    @Column(name = "code", length = 10, nullable = true)
    private String code; // Mã OTP

    @Column(name = "otpExpiry", nullable = true)
    private LocalDateTime otpExpiry; // Thời gian hết hạn OTP

    @Column(name = "createdDate", nullable = true)
    private LocalDateTime createdDate = LocalDateTime.now();

    public Integer getStatus() {
        return status != null ? status : 0;
    }

    public Integer getRoleid() {
        return roleid != null ? roleid : 2;
    }
}
