package vn.iotstar.utils;

import java.security.SecureRandom;
import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    // Cấu hình Email gửi đi (Có thể thay thế bằng email và mật khẩu ứng dụng Gmail
    // của bạn)
    private static final String FROM_EMAIL = "lequoccuong31126@gmail.com";
    private static final String APP_PASSWORD = "wqsc orpu pwqn ezia";
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    /**
     * Sinh mã OTP ngẫu nhiên gồm các chữ số
     * 
     * @param length Độ dài mã OTP (thường là 6)
     * @return Chuỗi OTP
     */
    public static String generateOTP(int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < length; i++) {
            otp.append(random.nextInt(10));
        }
        return otp.toString();
    }

    /**
     * Gửi email OTP tới người dùng
     * 
     * @param toEmail Email người nhận
     * @param otpCode Mã OTP
     * @param subject Tiêu đề email
     * @param content Nội dung thông điệp
     * @return true nếu gửi thành công, false nếu thất bại
     */
    public static boolean sendOtpEmail(String toEmail, String otpCode, String subject, String content) {
        System.out.println("==================================================");
        System.out.println("  [OTP EMAIL] Đang gửi OTP tới: " + toEmail);
        System.out.println("  [OTP CODE]: " + otpCode);
        System.out.println("==================================================");

        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Hệ Thống Xác Thực"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject != null ? subject : "Mã xác thực OTP của bạn");

            String htmlContent = "<div style=\"font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px;\">"
                    + "<h2 style=\"color: #2c3e50; text-align: center;\">XÁC THỰC TÀI KHOẢN</h2>"
                    + "<p>" + (content != null ? content : "Xin chào, dưới đây là mã OTP xác thực của bạn:") + "</p>"
                    + "<div style=\"background-color: #f4f6f7; padding: 15px; text-align: center; font-size: 28px; font-weight: bold; letter-spacing: 5px; color: #e74c3c; border-radius: 6px; margin: 20px 0;\">"
                    + otpCode
                    + "</div>"
                    + "<p style=\"color: #7f8c8d; font-size: 13px;\">* Mã OTP này có hiệu lực trong vòng <b>5 phút</b>. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>"
                    + "<hr style=\"border: none; border-top: 1px solid #eee; margin: 20px 0;\">"
                    + "<p style=\"text-align: center; color: #95a5a6; font-size: 12px;\">Email được gửi tự động từ hệ thống.</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
