package vn.iotstar.dao;

import java.time.LocalDateTime;
import java.util.List;
import vn.iotstar.entity.User;

public interface IUserDao {
    void insert(User user);
    void update(User user);
    void delete(int id) throws Exception;
    User findById(int id);
    User findByUsername(String username);
    User findByEmail(String email);
    List<User> findAll();
    boolean updateOtp(String email, String otp, LocalDateTime expiry);
    boolean verifyOtp(String email, String otp);
    boolean activateUser(String email);
    boolean updatePassword(String email, String newPassword);
    User checkLogin(String username, String password);
}
