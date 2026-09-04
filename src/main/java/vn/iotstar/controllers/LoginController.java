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

@WebServlet(urlPatterns = { "/login" })
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            User user = (User) session.getAttribute("account");
            if (user.getRoleid() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
            return;
        }

        String activated = req.getParameter("activated");
        if ("true".equals(activated)) {
            req.setAttribute("message", "Kích hoạt tài khoản thành công! Vui lòng đăng nhập.");
        }
        String reset = req.getParameter("reset");
        if ("true".equals(reset)) {
            req.setAttribute("message", "Đổi mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.");
        }

        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập tên đăng nhập và mật khẩu!");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        User user = userService.checkLogin(username.trim(), password.trim());
        if (user == null) {
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        if (user.getStatus() != 1) {
            HttpSession session = req.getSession();
            session.setAttribute("registeredEmail", user.getEmail());
            req.setAttribute("error", "Tài khoản chưa được kích hoạt! <a href='" + req.getContextPath() + "/verify-otp' class='alert-link'>Kích hoạt ngay</a>");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        // Đăng nhập thành công
        HttpSession session = req.getSession();
        session.setAttribute("account", user);

        if (user.getRoleid() == 1) {
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}
