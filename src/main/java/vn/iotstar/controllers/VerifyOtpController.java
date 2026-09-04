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

@WebServlet(urlPatterns = { "/verify-otp", "/resend-otp" })
public class VerifyOtpController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("registeredEmail");

        if (url.contains("/resend-otp")) {
            if (email != null && !email.isEmpty()) {
                boolean sent = userService.sendOtp(email, "Mã OTP kích hoạt mới", 
                        "Dưới đây là mã OTP kích hoạt mới của bạn:");
                if (sent) {
                    req.setAttribute("message", "Mã OTP mới đã được gửi tới email: " + email);
                } else {
                    req.setAttribute("error", "Lỗi gửi lại mã OTP. Vui lòng thử lại!");
                }
            } else {
                req.setAttribute("error", "Không tìm thấy thông tin email. Vui lòng đăng ký lại!");
            }
        }

        req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        String email = req.getParameter("email");
        if (email == null || email.isEmpty()) {
            email = (String) session.getAttribute("registeredEmail");
        }
        String otp = req.getParameter("otp");

        if (email == null || email.trim().isEmpty() || otp == null || otp.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ mã OTP!");
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
            return;
        }

        boolean isValid = userService.verifyOtp(email.trim(), otp.trim());
        if (isValid) {
            // Kích hoạt tài khoản
            userService.activateUser(email.trim());
            session.removeAttribute("registeredEmail");
            resp.sendRedirect(req.getContextPath() + "/login?activated=true");
        } else {
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn (sau 5 phút)!");
            req.setAttribute("email", email.trim());
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
        }
    }
}
