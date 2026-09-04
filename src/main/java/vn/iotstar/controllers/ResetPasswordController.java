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
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = { "/reset-password" })
public class ResetPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        String email = req.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            email = (String) session.getAttribute("resetEmail");
        }
        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        Map<String, String> errors = new HashMap<>();

        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Vui lòng nhập địa chỉ email!");
        }

        if (otp == null || otp.trim().isEmpty()) {
            errors.put("otp", "Vui lòng nhập mã OTP!");
        } else if (!otp.trim().matches("^[0-9]{6}$")) {
            errors.put("otp", "Mã OTP phải gồm đúng 6 chữ số!");
        }

        if (newPassword == null || newPassword.trim().isEmpty()) {
            errors.put("newPassword", "Vui lòng nhập mật khẩu mới!");
        } else if (newPassword.trim().length() < 6) {
            errors.put("newPassword", "Mật khẩu mới phải có tối thiểu 6 ký tự!");
        }

        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errors.put("confirmPassword", "Vui lòng xác nhận lại mật khẩu!");
        } else if (!confirmPassword.equals(newPassword)) {
            errors.put("confirmPassword", "Xác nhận mật khẩu không khớp với mật khẩu mới!");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("email", email);
            req.setAttribute("otp", otp);
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra OTP
        boolean isValidOtp = userService.verifyOtp(email.trim(), otp.trim());
        if (!isValidOtp) {
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn (sau 5 phút)!");
            req.setAttribute("email", email.trim());
            req.setAttribute("otp", otp.trim());
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
            return;
        }

        // Cập nhật mật khẩu mới và xóa mã OTP
        boolean updated = userService.resetPassword(email.trim(), newPassword.trim());
        if (updated) {
            session.removeAttribute("resetEmail");
            resp.sendRedirect(req.getContextPath() + "/login?reset=true");
        } else {
            req.setAttribute("error", "Có lỗi xảy ra khi cập nhật mật khẩu. Vui lòng thử lại!");
            req.setAttribute("email", email.trim());
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        }
    }
}
