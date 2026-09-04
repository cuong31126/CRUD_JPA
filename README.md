# BÁO CÁO DỰ ÁN LẬP TRÌNH WEB (JPA - SERVLET - MVC) - BTJPA-02

## 📌 1. Giới Thiệu Tổng Quan
Dự án **`btjpa-02`** được xây dựng theo mô hình kiến trúc **MVC (Model - View - Controller)** kết hợp **JPA (Hibernate 6.5)** và **Jakarta Servlet API 6.0** trên nền tảng **Java 17**, kết nối cơ sở dữ liệu **Microsoft SQL Server**.

Hệ thống đã triển khai đầy đủ các phân hệ chức năng xác thực người dùng bảo mật qua mã OTP Email, quản trị CRUD danh mục & sản phẩm có upload file Multipart, trang chủ hiển thị 10 sản phẩm mới nhất và trang danh sách phân trang 6 sản phẩm/trang.

---

## 🛠️ 2. Công Nghệ & Thư Viện Sử Dụng
* **Ngôn ngữ:** Java 17 (LTS)
* **Web Server / Servlet Container:** Apache Tomcat 10.1.x (Jakarta EE 10)
* **ORM & JPA:** Hibernate ORM 6.5.2.Final, Jakarta Persistence API 3.0
* **Decorator Framework:** SiteMesh 3.2.3 (Jakarta EE Compatible / ConfigurableSiteMeshFilter)
* **View Layer:** JSP 3.1, JSTL 3.0 (`jakarta.tags.core`, `jakarta.tags.fmt`), Bootstrap 5.3, FontAwesome 6
* **Database:** Microsoft SQL Server (`LTWEB2`) với driver `mssql-jdbc 12.6.1`
* **Email Service:** Jakarta Mail API 2.1 + Angus Mail 2.0 (SMTP Gmail TLS Port 587)
* **Upload:** Jakarta Servlet `@MultipartConfig`

---

## 🚀 3. Danh Sách Các Chức Năng Đã Hoàn Thành

### 🔐 A. Phân Hệ Xác Thực & Bảo Mật (Authentication & OTP)
1. **Đăng ký tài khoản có kích hoạt qua Email OTP (`/register` & `/verify-otp`):**
   - Kiểm tra trùng lặp `username` và `email`.
   - Sinh mã OTP ngẫu nhiên 6 chữ số (`EmailUtil.generateOTP(6)`) có thời hạn hiệu lực **5 phút**.
   - Gửi thư định dạng HTML chuyên nghiệp qua máy chủ Gmail SMTP và tự động in log ra Console.
   - Khi nhập đúng mã OTP, tài khoản được chuyển sang trạng thái kích hoạt (`status = 1`).
   - Hỗ trợ nút **Gửi lại mã OTP** (`/resend-otp`).
2. **Đăng nhập & Đăng xuất (`/login` & `/logout`):**
   - Kiểm tra thông tin đăng nhập và trạng thái kích hoạt tài khoản.
   - Lưu thông tin người dùng vào Session (`account`).
   - **Phân quyền tự động:**
     - **Admin (`roleid = 1`):** Tự động điều hướng vào trang quản trị (`/admin/categories` hoặc `/admin/products`).
     - **User (`roleid = 2`):** Điều hướng vào trang chủ mua sắm (`/home`).
   - Hỗ trợ đăng xuất và hủy Session an toàn.
3. **Quên mật khẩu & Đặt lại mật khẩu mới (`/forgot-password` & `/reset-password`):**
   - Nhập email đăng ký để nhận mã OTP xác thực.
   - Nhập mã OTP cùng mật khẩu mới và xác nhận mật khẩu.
   - Hệ thống kiểm tra tính hợp lệ và cập nhật mật khẩu mới vào cơ sở dữ liệu.

---

### 📦 B. Phân Hệ Quản Lý Danh Mục & Sản Phẩm (Category & Product CRUD)
4. **Thiết kế Cơ sở dữ liệu & Quan hệ 1 - N:**
   - Bảng `categories` quan hệ 1 - N với bảng `products` qua khóa ngoại `categoryId`.
   - Entity `Product.java` (`@ManyToOne @JoinColumn(name = "categoryId") Category category`).
   - Entity `Category.java` (`@OneToMany(mappedBy = "category") List<Product> products`).
5. **Upload file hình ảnh bằng Multipart Jakarta Servlet:**
   - Servlet [AdminProductController.java](file:///d:/CauHinh_Java/workspace_sts/btjpa-02/src/main/java/vn/iotstar/controllers/AdminProductController.java) sử dụng `@MultipartConfig`:
     ```java
     @MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                      maxFileSize = 1024 * 1024 * 10,      // 10MB
                      maxRequestSize = 1024 * 1024 * 50)   // 50MB
     ```
   - Tự động sinh tên file bằng `System.currentTimeMillis() + ext` để tránh trùng lặp.
   - Lưu trữ an toàn tại thư mục cấu hình `Constant.DIR` (`D:\HK5\LapTrinhWeb\upload`).
   - Hiển thị ảnh linh hoạt thông qua [DownloadImageController.java](file:///d:/CauHinh_Java/workspace_sts/btjpa-02/src/main/java/vn/iotstar/controllers/DownloadImageController.java) (`/image?fname=...`) hoặc đường dẫn URL trực tuyến.
6. **CRUD Danh mục & Sản phẩm cho Admin:**
   - Xem danh sách bảng dạng Clean Bootstrap 5.
   - Thêm mới, Chỉnh sửa (có xem trước ảnh cũ) và Xóa (có hộp thoại xác nhận).

---

### 🌐 C. Phân Hệ Giao Diện Người Dùng (Client Web Views)
7. **Trang Chủ (`/home` hoặc `/`):**
   - Hero Banner và Danh mục nổi bật.
   - Hiển thị danh sách **10 Sản phẩm mới nhất** được sắp xếp giảm dần theo thời gian tạo.
8. **Trang Danh Sách Sản Phẩm Phân Trang (`/product`):**
   - Hiển thị chính xác **6 sản phẩm mỗi trang**.
   - Thanh phân trang (Pagination) điều hướng qua lại giữa các trang (`/product?page=1`, `/product?page=2`,...).
9. **Trang Chi Tiết Sản Phẩm (`/product/detail?id=...`):**
   - Khi bấm vào bất kỳ sản phẩm nào từ Trang chủ hoặc Trang sản phẩm, hệ thống mở trang chi tiết sản phẩm.
   - Hiển thị: Ảnh lớn, Tên, Danh mục, Giá tiền (`₫`), Tình trạng kho, Ngày đăng và Mô tả chi tiết.
   - Đề xuất các **Sản phẩm cùng danh mục liên quan** ở phía dưới.

---

## 📝 4. Bảng Quy Chuẩn 9 Form & Validation

| STT | Tên Form | File JSP | Các trường & Quy tắc Validation |
| :---: | :--- | :--- | :--- |
| **1** | Đăng nhập | `/views/auth/login.jsp` | `username` (không khoảng trắng, 3-30 ký tự), `password` (>= 6 ký tự). |
| **2** | Đăng ký | `/views/auth/register.jsp` | `username` (4-30 ký tự), `email` (RFC format), `phone` (10 số `^0[0-9]{9}$`), `password` (>= 6 ký tự). |
| **3** | Xác thực OTP | `/views/auth/verify-otp.jsp` | `email` (email hợp lệ), `otp` (đúng 6 chữ số `^[0-9]{6}$`). |
| **4** | Quên mật khẩu | `/views/auth/forgot-password.jsp` | `email` (bắt buộc, đúng định dạng email). |
| **5** | Đặt lại mật khẩu | `/views/auth/reset-password.jsp` | `otp` (6 chữ số), `newPassword` (>= 6 ký tự), `confirmPassword` (phải trùng khớp). |
| **6** | Thêm Danh mục | `/views/admin/category-add.jsp` | `categoryname` (2-100 ký tự), `images1` (.jpg, .png, .jpeg, .webp), `status` (1 hoặc 0). |
| **7** | Sửa Danh mục | `/views/admin/category-edit.jsp` | `categoryid` (hidden), `categoryname` (bắt buộc), `images1`/`images`, `status`. |
| **8** | Thêm Sản phẩm | `/views/admin/product-add.jsp` | `productName` (bắt buộc), `categoryId` (bắt buộc chọn), `price` (>= 0), `quantity` (>= 0), `imageFile`. |
| **9** | Sửa Sản phẩm | `/views/admin/product-edit.jsp` | `productId` (hidden), `productName`, `categoryId`, `price`, `quantity`, `status`, `imageFile`. |

---

## ⚡ 5. Hướng Dẫn Cài Đặt & Chạy Ứng Dụng

### Bước 1: Khởi tạo Cơ sở dữ liệu
Chạy toàn bộ nội dung file [create_tables.sql](file:///d:/CauHinh_Java/workspace_sts/btjpa-02/create_tables.sql) trong **SQL Server Management Studio (SSMS)** để tạo bảng và nạp bộ 18 sản phẩm mẫu phong phú.

### Bước 2: Chạy Server Tomcat 10
Mở Terminal tại thư mục `workspace_sts` và chạy:
```powershell
.\.vscode\deploy_and_run.ps1 -ProjectName btjpa-02
```

### Bước 3: Truy cập ứng dụng
* 🏠 **Trang chủ:** [http://localhost:8080/btjpa-02/home](http://localhost:8080/btjpa-02/home)
* 📦 **Tất cả sản phẩm (6 SP/trang):** [http://localhost:8080/btjpa-02/product](http://localhost:8080/btjpa-02/product)
* 🔑 **Đăng nhập:** [http://localhost:8080/btjpa-02/login](http://localhost:8080/btjpa-02/login)
* 📝 **Đăng ký:** [http://localhost:8080/btjpa-02/register](http://localhost:8080/btjpa-02/register)
* ⚙️ **Quản trị Sản phẩm:** [http://localhost:8080/btjpa-02/admin/products](http://localhost:8080/btjpa-02/admin/products)
* 📁 **Quản trị Danh mục:** [http://localhost:8080/btjpa-02/admin/categories](http://localhost:8080/btjpa-02/admin/categories)
