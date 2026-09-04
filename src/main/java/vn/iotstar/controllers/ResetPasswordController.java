package vn.iotstar.controllers;

import java.io.IOException;
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

        if (email == null || email.trim().isEmpty() ||
            otp == null || otp.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ các thông tin!");
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Xác nhận mật khẩu mới không khớp!");
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
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        }
    }
}
