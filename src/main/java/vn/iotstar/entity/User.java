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
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
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

    @NotBlank(message = "Tên đăng nhập không được để trống")
    @Size(min = 4, max = 50, message = "Tên đăng nhập phải từ 4 đến 50 ký tự")
    @Column(name = "username", length = 50, nullable = false, unique = true)
    private String username;

    @NotBlank(message = "Mật khẩu không được để trống")
    @Size(min = 6, message = "Mật khẩu phải có tối thiểu 6 ký tự")
    @Column(name = "password", length = 255, nullable = false)
    private String password;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không đúng định dạng (Ví dụ: name@domain.com)")
    @Column(name = "email", length = 100, nullable = false, unique = true)
    private String email;

    @Size(max = 100, message = "Họ tên không được vượt quá 100 ký tự")
    @Column(name = "fullname", columnDefinition = "NVARCHAR(100) NULL")
    private String fullname;

    @Pattern(regexp = "(^$|^0[0-9]{9}$)", message = "Số điện thoại phải gồm 10 chữ số bắt đầu bằng số 0")
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
