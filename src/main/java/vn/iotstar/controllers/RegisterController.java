package vn.iotstar.controllers;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = { "/register" })
public class RegisterController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        Map<String, String> errors = new HashMap<>();

        // 1. Server-side Validation: Username
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Tên đăng nhập không được để trống!");
        } else if (!username.trim().matches("^[a-zA-Z0-9_]{4,30}$")) {
            errors.put("username", "Tên đăng nhập từ 4-30 ký tự, chỉ chứa chữ cái, số và dấu gạch dưới!");
        } else if (userService.findByUsername(username.trim()) != null) {
            errors.put("username", "Tên đăng nhập đã được sử dụng!");
        }

        // 2. Server-side Validation: Email
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email không được để trống!");
        } else if (!email.trim().matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            errors.put("email", "Email không đúng định dạng RFC (Ví dụ: name@domain.com)!");
        } else if (userService.findByEmail(email.trim()) != null) {
            errors.put("email", "Email này đã được đăng ký tài khoản khác!");
        }

        // 3. Server-side Validation: Password
        if (password == null || password.trim().length() < 6) {
            errors.put("password", "Mật khẩu phải có tối thiểu 6 ký tự!");
        }

        // 4. Server-side Validation: Phone (Tùy chọn)
        if (phone != null && !phone.trim().isEmpty() && !phone.trim().matches("^0[0-9]{9}$")) {
            errors.put("phone", "Số điện thoại phải gồm đúng 10 chữ số và bắt đầu bằng số 0!");
        }

        // Nếu có lỗi validation phía server
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("fullname", fullname);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username.trim());
        user.setPassword(password.trim());
        user.setEmail(email.trim());
        user.setFullname(fullname != null ? fullname.trim() : "");
        user.setPhone(phone != null ? phone.trim() : "");

        boolean success = userService.register(user);
        if (success) {
            HttpSession session = req.getSession();
            session.setAttribute("registeredEmail", email.trim());
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            req.setAttribute("error", "Đăng ký không thành công hoặc lỗi gửi mã OTP. Vui lòng thử lại!");
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("fullname", fullname);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        }
    }
}
