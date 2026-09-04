package vn.iotstar.services;

import java.util.List;
import vn.iotstar.entity.User;

public interface IUserService {
    void insert(User user);
    void update(User user);
    void delete(int id) throws Exception;
    User findById(int id);
    User findByUsername(String username);
    User findByEmail(String email);
    List<User> findAll();
    
    boolean updateOtp(String email, String otp);
    boolean verifyOtp(String email, String otp);
    boolean activateUser(String email);
    boolean resetPassword(String email, String newPassword);
    User checkLogin(String username, String password);
    
    boolean register(User user);
    boolean sendOtp(String email, String subject, String messageContent);
}
