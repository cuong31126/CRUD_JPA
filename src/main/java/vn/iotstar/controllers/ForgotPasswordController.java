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

@WebServlet(urlPatterns = { "/forgot-password" })
public class ForgotPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        Map<String, String> errors = new HashMap<>();

        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Vui lòng nhập địa chỉ email!");
        } else if (!email.trim().matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            errors.put("email", "Email không đúng định dạng RFC (Ví dụ: user@example.com)!");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
            return;
        }

        User user = userService.findByEmail(email.trim());
        if (user == null) {
            req.setAttribute("error", "Email này không tồn tại trong hệ thống!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
            return;
        }

        // Sinh mã OTP và gửi qua Email
        boolean sent = userService.sendOtp(email.trim(), "Yêu cầu đặt lại mật khẩu của bạn", 
                "Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Vui lòng sử dụng mã OTP sau:");
        
        if (sent) {
            HttpSession session = req.getSession();
            session.setAttribute("resetEmail", email.trim());
            resp.sendRedirect(req.getContextPath() + "/reset-password");
        } else {
            req.setAttribute("error", "Không thể gửi email chứa mã OTP. Vui lòng thử lại sau!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
        }
    }
}
