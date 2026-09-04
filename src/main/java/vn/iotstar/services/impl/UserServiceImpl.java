package vn.iotstar.services.impl;

import java.time.LocalDateTime;
import java.util.List;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.utils.EmailUtil;

public class UserServiceImpl implements IUserService {

    private IUserDao userDao = new UserDaoImpl();

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void delete(int id) throws Exception {
        userDao.delete(id);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public boolean updateOtp(String email, String otp) {
        LocalDateTime expiry = LocalDateTime.now().plusMinutes(5); // OTP có hạn 5 phút
        return userDao.updateOtp(email, otp, expiry);
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        return userDao.verifyOtp(email, otp);
    }

    @Override
    public boolean activateUser(String email) {
        return userDao.activateUser(email);
    }

    @Override
    public boolean resetPassword(String email, String newPassword) {
        return userDao.updatePassword(email, newPassword);
    }

    @Override
    public User checkLogin(String username, String password) {
        return userDao.checkLogin(username, password);
    }

    @Override
    public boolean register(User user) {
        try {
            String otp = EmailUtil.generateOTP(6);
            user.setStatus(0); // Chưa kích hoạt
            user.setCode(otp);
            user.setOtpExpiry(LocalDateTime.now().plusMinutes(5));
            if (user.getCreatedDate() == null) {
                user.setCreatedDate(LocalDateTime.now());
            }
            if (user.getRoleid() == 0) {
                user.setRoleid(2); // Mặc định User
            }

            userDao.insert(user);

            // Gửi email OTP
            return EmailUtil.sendOtpEmail(user.getEmail(), otp, "Mã kích hoạt tài khoản của bạn", 
                    "Cảm ơn bạn đã đăng ký tài khoản. Vui lòng nhập mã OTP sau để kích hoạt tài khoản:");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean sendOtp(String email, String subject, String messageContent) {
        String otp = EmailUtil.generateOTP(6);
        boolean updated = updateOtp(email, otp);
        if (updated) {
            return EmailUtil.sendOtpEmail(email, otp, subject, messageContent);
        }
        return false;
    }
}
