package vn.iotstar.controllers;

import java.io.IOException;
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

        // Validate đầu vào
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ các trường bắt buộc!");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra trùng username
        if (userService.findByUsername(username.trim()) != null) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra trùng email
        if (userService.findByEmail(email.trim()) != null) {
            req.setAttribute("error", "Email này đã được sử dụng!");
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
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        }
    }
}
