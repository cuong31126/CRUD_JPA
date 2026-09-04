# BÁO CÁO DỰ ÁN LẬP TRÌNH WEB (JPA - SERVLET - MVC) - BTJPA-02

> **Repository GitHub:** [https://github.com/cuong31126/CRUD_JPA.git](https://github.com/cuong31126/CRUD_JPA.git)  
> **Nền tảng:** Java 17 LTS | Jakarta EE 10 | Apache Tomcat 10.1.44 | Microsoft SQL Server (LTWEB2)  
> **Kiến trúc:** Model - View - Controller (MVC) + JPA Hibernate ORM 6.5 + SiteMesh Decorator 3

---

## 🛠️ CÔNG NGHỆ VÀ THƯ VIỆN SỬ DỤNG
* **Ngôn ngữ lập trình:** Java 17 (LTS)
* **Web Server / Servlet Container:** Apache Tomcat 10.1.x (Jakarta EE 10)
* **ORM & JPA:** Hibernate ORM 6.5.2.Final, Jakarta Persistence API 3.0
* **Decorator Framework:** SiteMesh 3.2.3 (Bản tương thích Jakarta EE 10 / Tomcat 10.1+)
* **Validation:** Hibernate Validator 8.0.1.Final, Jakarta Validation API 3.0.2 & Bootstrap 5.3 Validation
* **View Layer:** JSP 3.1, JSTL 3.0 (`jakarta.tags.core`, `jakarta.tags.fmt`), Bootstrap 5.3, FontAwesome 6
* **Database:** Microsoft SQL Server (`LTWEB2`) với driver `mssql-jdbc 12.6.1`
* **Email Service:** Jakarta Mail API 2.1 + Angus Mail 2.0 (SMTP Gmail TLS Port 587)
* **Upload:** Jakarta Servlet `@MultipartConfig` lưu trữ tại `Constant.DIR` (`D:\HK5\LapTrinhWeb\upload`)

---

# 📌 PHẦN 1: TỔNG KẾT BÀI TẬP 03 (BT03)
*Mục tiêu: Xây dựng hệ thống xác thực người dùng bảo mật qua Email OTP, quản lý quan hệ 1 - N giữa Category và Product bằng JPA/Hibernate, CRUD có upload ảnh và các trang xem sản phẩm cho khách hàng.*

### 1. Phân Hệ Xác Thực & Bảo Mật OTP Email
1. **Đăng ký tài khoản (`/register`):**
   - Kiểm tra trùng lặp `username` và `email`.
   - Sinh mã OTP ngẫu nhiên 6 chữ số (`EmailUtil.generateOTP(6)`) có thời hạn hiệu lực **5 phút**.
   - Gửi thư HTML chuyên nghiệp qua máy chủ Gmail SMTP (`smtp.gmail.com:587`) và tự động in log ra console.
2. **Kích hoạt tài khoản bằng OTP (`/verify-otp` & `/resend-otp`):**
   - Kiểm tra mã OTP và thời gian hết hạn (`otpExpiry`). Kích hoạt tài khoản (`status = 1`).
   - Hỗ trợ nút **Gửi lại mã OTP**.
3. **Đăng nhập & Phân quyền (`/login` & `/logout`):**
   - Kiểm tra mật khẩu và trạng thái kích hoạt tài khoản.
   - **Tự động chuyển hướng theo Role:**
     - **Admin (`roleid = 1`):** Chuyển vào trang quản trị (`/admin/categories`).
     - **User (`roleid = 2`):** Chuyển vào trang mua sắm (`/home`).
4. **Quên mật khẩu & Đặt lại mật khẩu (`/forgot-password` & `/reset-password`):**
   - Xác thực email người dùng, gửi mã OTP khôi phục mật khẩu.
   - Nhập OTP cùng mật khẩu mới và xác nhận mật khẩu để hoàn tất đổi mật khẩu.

### 2. Phân Hệ Quản Lý Danh Mục & Sản Phẩm (Quan hệ 1 - N)
1. **Quan hệ 1 - N JPA/Hibernate:**
   - Entity `Product.java` (`@ManyToOne @JoinColumn(name = "categoryId") Category category`).
   - Entity `Category.java` (`@OneToMany(mappedBy = "category") List<Product> products`).
2. **Upload File Ảnh Jakarta Servlet Multipart:**
   - Servlet [AdminProductController.java](file:///d:/CauHinh_Java/workspace_sts/btjpa-02/src/main/java/vn/iotstar/controllers/AdminProductController.java) và [CategoryController.java](file:///d:/CauHinh_Java/workspace_sts/btjpa-02/src/main/java/vn/iotstar/controllers/CategoryController.java) sử dụng `@MultipartConfig`:
     - Tự động sinh tên file bằng `System.currentTimeMillis() + ext` chống trùng lặp.
     - Lưu trữ tệp tin tại thư mục cấu hình `Constant.DIR` (`D:\HK5\LapTrinhWeb\upload`).
     - Servlet [DownloadImageController.java](file:///d:/CauHinh_Java/workspace_sts/btjpa-02/src/main/java/vn/iotstar/controllers/DownloadImageController.java) (`/image?fname=...`) xuất ảnh an toàn hoặc hiển thị link trực tuyến.
3. **CRUD Admin:** Xem danh sách, thêm mới, sửa, xóa danh mục và sản phẩm.

### 3. Phân Hệ Giao Diện Web Khách Hàng
1. **Trang Chủ (`/home`):** Hiển thị danh mục nổi bật và **10 sản phẩm mới nhất** theo thứ tự giảm dần `productId DESC`.
2. **Tất Cả Sản Phẩm (`/product`):** **Phân trang chuẩn 6 sản phẩm/trang**, tính toán tổng số trang và thanh điều hướng linh hoạt (`?page=1, 2, 3...`).
3. **Chi Tiết Sản Phẩm (`/product/detail?id=X`):** Xem thông tin chi tiết, giá tiền định dạng VNĐ, số lượng tồn kho, trạng thái và sản phẩm cùng loại.

---

# 🚀 PHẦN 2: BÀI TẬP 04 (BT04) - SITEMESH 3 DECORATOR & VALIDATION TOÀN DIỆN

*Mục tiêu: Nâng cấp kiến trúc giao diện với SiteMesh 3 Decorator (tách riêng layout Web và Admin) và xây dựng Cơ chế Validation 2 Lớp (Client-side Bootstrap 5 + Server-side Servlet/Hibernate Validator) cho toàn bộ 9 form.*

```
                                  KIẾN TRÚC SITEMESH 3 DECORATOR
                                  
                       ┌────────────────────────────────────────────────┐
                       │           ConfigurableSiteMeshFilter           │
                       └───────────────────────┬────────────────────────┘
                                               │
               ┌───────────────────────────────┴───────────────────────────────┐
               ▼                                                               ▼
   /admin/* (Trang Quản Trị)                                       /home, /product* (Trang Khách)
┌───────────────────────────────────────────────┐               ┌───────────────────────────────────────────────┐
│       Decorator: WEB-INF/decorators/admin.jsp │               │        Decorator: WEB-INF/decorators/web.jsp  │
│ ┌───────────────────────────────────────────┐ │               │ ┌───────────────────────────────────────────┐ │
│ │ Top Header (User info, Link to client)    │ │               │ │ Top Navbar (Store, Products, Admin menu)  │ │
│ ├──────────────┬────────────────────────────┤ │               │ ├───────────────────────────────────────────┤ │
│ │ Sidebar Nav  │ <sitemesh:write property=  │ │               │ │      <sitemesh:write property='body'/>    │ │
│ │ - Danh Mục   │           'body'/>         │ │               │ │     (home.jsp, product-list.jsp, ...)     │ │
│ │ - Sản Phẩm   │  (category-list.jsp, ...)  │ │               │ ├───────────────────────────────────────────┤ │
│ ├──────────────┴────────────────────────────┤ │               │ │               Footer Hệ Thống             │ │
│ │               Footer Admin                │ │               └─────────────────────────────────────────────┘ │
│ └───────────────────────────────────────────┘ │                                                               
└───────────────────────────────────────────────┘                                                               
```

### 1. Tích Hợp SiteMesh 3 Decorator Chuẩn Jakarta EE 10
* **Bước 1 (pom.xml):** Bổ sung dependency `org.sitemesh:sitemesh:3.2.3` tương thích Servlet 6.0 / Jakarta EE 10.
* **Bước 2 (web.xml):** Đăng ký filter `ConfigurableSiteMeshFilter` ánh xạ URL pattern `/*`.
* **Bước 3 (sitemesh3.xml):** Cấu hình phân luồng giao diện:
  - Ánh xạ `/admin/*` vào decorator `admin.jsp`.
  - Ánh xạ `/home`, `/product*`, `/*` vào decorator `web.jsp`.
  - Loại trừ (`exclude="true"`) cho các trang auth (`/login`, `/register`, `/verify-otp`, `/forgot-password`, `/reset-password`) và servlet tài nguyên `/image*`.
* **Bước 4 (Templates Decorator):**
  - **[web.jsp](file:///d:/CauHinh_Java/workspace_sts/btjpa-02/src/main/webapp/WEB-INF/decorators/web.jsp):** Header Navbar người dùng, Dropdown Admin Role, thẻ `<sitemesh:write property='body'/>`, Footer Shop JPA System.
  - **[admin.jsp](file:///d:/CauHinh_Java/workspace_sts/btjpa-02/src/main/webapp/WEB-INF/decorators/admin.jsp):** Header Admin Portal, Sidebar menu điều hướng Quản lý Danh mục & Sản phẩm, thẻ `<sitemesh:write property='body'/>`, Footer Admin.
* **Tối ưu hóa Child JSPs:** Lược bỏ toàn bộ thẻ html/head/navbar/footer thừa, giúp các trang JSP con cực kỳ gọn gàng, chỉ tập trung vào nghiệp vụ.

---

### 2. Cơ Chế Validation 2 Lớp Toàn Diện (Client-side & Server-side)

#### 🔹 Lớp 1: Client-side Validation (Giao diện người dùng)
* Tích hợp chuẩn **Bootstrap 5 Validation** với class `needs-validation novalidate` trên các form.
* Đặt các thuộc tính HTML5 Constraint: `required`, `pattern`, `minlength`, `maxlength`, `min`, `step`, `accept`.
* Thẻ thông báo trực quan `<div class="invalid-feedback">...</div>` ngay dưới từng ô nhập liệu.
* Script JavaScript lắng nghe sự kiện `submit`: Khi có lỗi, form tự động kích hoạt `was-validated`, viền đỏ ô input lỗi và hiển thị thông báo lỗi tương ứng.

#### 🔹 Lớp 2: Server-side Validation (Java Servlet & Entity Model)
* Đặt các Annotation Jakarta/Hibernate Validation trên các Entity (`@NotBlank`, `@Email`, `@Size`, `@Pattern`, `@NotNull`, `@Min`).
* Trong phương thức `doPost()` của các Controller, kiểm tra và thu thập tất cả lỗi vào `Map<String, String> errors = new HashMap<>()`.
* Khi phát hiện lỗi:
  - Controller gắn `req.setAttribute("errors", errors)`.
  - Giữ lại toàn bộ dữ liệu đã nhập (`username`, `email`, `fullname`, `phone`, `price`, `quantity`,...) để người dùng không phải nhập lại từ đầu.
  - Giao diện tự động render class `is-invalid` và hiển thị câu thông báo lỗi chi tiết từ Server.

---

## 📋 BẢNG TỔNG HỢP 9 FORM ĐÃ TRIỂN KHAI VALIDATION 2 LỚP

| STT | Tên Form | URL Route | Quy Tắc Kiểm Tra Client-side | Quy Tắc Kiểm Tra Server-side |
| :--- | :--- | :--- | :--- | :--- |
| **1** | **Đăng Nhập** | `/login` | `username` (required), `password` (required, minlength 6). | Kiểm tra rỗng, xác thực tài khoản & mật khẩu trong DB, kiểm tra trạng thái kích hoạt. |
| **2** | **Đăng Ký** | `/register` | `username` (4-30 ký tự, `^[a-zA-Z0-9_]+$`), `email` (RFC format), `phone` (`^0[0-9]{9}$`), `password` (minlength 6). | Kiểm tra rỗng, Regex format, kiểm tra trùng `username` & trùng `email` trong Database. |
| **3** | **Xác Thực OTP** | `/verify-otp` | `otp` (required, maxlength 6, pattern `^[0-9]{6}$`). | Kiểm tra đúng 6 chữ số, so khớp mã OTP trong DB, kiểm tra thời hạn hết hạn 5 phút. |
| **4** | **Quên Mật Khẩu** | `/forgot-password` | `email` (required, RFC email regex). | Kiểm tra rỗng, định dạng email, kiểm tra email có tồn tại trong hệ thống. |
| **5** | **Đặt Lại Mật Khẩu** | `/reset-password` | `otp` (6 chữ số), `newPassword` (minlength 6), `confirmPassword` (minlength 6). | Kiểm tra mã OTP hợp lệ, kiểm tra độ dài mật khẩu, so khớp `newPassword == confirmPassword`. |
| **6** | **Thêm Danh Mục** | `/admin/category/add` | `categoryname` (required, minlength 2, maxlength 100), `images` (file accept image/*). | Kiểm tra rỗng, độ dài tên danh mục 2-100 ký tự, xử lý upload file multipart an toàn. |
| **7** | **Sửa Danh Mục** | `/admin/category/edit` | `categoryname` (required, minlength 2, maxlength 100), giữ lại ảnh cũ nếu không chọn ảnh mới. | Kiểm tra rỗng, độ dài 2-100 ký tự, cập nhật DB và dọn dẹp file ảnh cũ nếu tải ảnh mới. |
| **8** | **Thêm Sản Phẩm** | `/admin/product/add` | `productName` (2-200 ký tự), `categoryId` (required), `price` (min 0), `quantity` (min 0). | Kiểm tra rỗng, danh mục tồn tại, `price >= 0`, `quantity >= 0`, xử lý upload ảnh multipart. |
| **9** | **Sửa Sản Phẩm** | `/admin/product/edit` | `productName` (2-200 ký tự), `categoryId` (required), `price` (min 0), `quantity` (min 0). | Kiểm tra rỗng, tính hợp lệ số học `price` & `quantity`, cập nhật DB và lưu trữ ảnh mới. |

---

## 🎯 CÁCH CÀI ĐẶT & CHẠY DỰ ÁN
1. **Import Database:** Chạy file kịch bản SQL `create_tables.sql` trên cơ sở dữ liệu `LTWEB2` của SQL Server (đã có sẵn 18 sản phẩm mẫu và 3 tài khoản).
2. **Cấu hình persistence.xml & Constant.java:**
   - [persistence.xml](file:///d:/CauHinh_Java/workspace_sts/btjpa-02/src/main/resources/META-INF/persistence.xml): Kiểm tra user/password SQL Server (`sa` / `123456`).
   - [Constant.java](file:///d:/CauHinh_Java/workspace_sts/btjpa-02/src/main/java/vn/iotstar/utils/Constant.java): Thư mục upload ảnh `Constant.DIR = "D:\\HK5\\LapTrinhWeb\\upload"`.
3. **Build & Deploy:**
   ```bash
   mvn clean package -DskipTests
   ```
4. **Truy Cập Ứng Dụng:**
   - Trang chủ người dùng: `http://localhost:8080/btjpa-02/home`
   - Tất cả sản phẩm (Phân trang 6 sp): `http://localhost:8080/btjpa-02/product`
   - Đăng nhập: `http://localhost:8080/btjpa-02/login`
   - Đăng ký: `http://localhost:8080/btjpa-02/register`
   - Quản trị Admin: `http://localhost:8080/btjpa-02/admin/categories` và `http://localhost:8080/btjpa-02/admin/products`
   - Tài khoản Admin mẫu: `admin` / `123456`
   - Tài khoản User mẫu: `user1` / `123456`
