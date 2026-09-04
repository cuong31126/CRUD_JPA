-- SQL Script khởi tạo bảng và dữ liệu mẫu cho Database LTWEB2
USE LTWEB2;
GO

IF OBJECT_ID('categories', 'U') IS NULL
BEGIN
    CREATE TABLE categories (
        CategoryId INT IDENTITY(1,1) PRIMARY KEY,
        CategoryName NVARCHAR(50) NOT NULL,
        Images NVARCHAR(500) NULL,
        Status INT NULL
    );
END
GO

IF OBJECT_ID('Videos', 'U') IS NULL
BEGIN
    CREATE TABLE Videos (
        VideoId VARCHAR(255) PRIMARY KEY,
        Active INT NULL,
        Description NVARCHAR(500) NULL,
        Poster NVARCHAR(500) NULL,
        Title NVARCHAR(500) NULL,
        Views INT NULL,
        CategoryId INT FOREIGN KEY REFERENCES categories(CategoryId)
    );
END
GO

IF OBJECT_ID('users', 'U') IS NULL
BEGIN
    CREATE TABLE users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        email VARCHAR(100) NOT NULL UNIQUE,
        fullname NVARCHAR(100) NULL,
        phone VARCHAR(20) NULL,
        images NVARCHAR(500) NULL,
        roleid INT DEFAULT 2, -- 1: Admin, 2: User
        status INT DEFAULT 0, -- 0: Chua kich hoat, 1: Da kich hoat
        code VARCHAR(10) NULL,
        otpExpiry DATETIME NULL,
        createdDate DATETIME DEFAULT GETDATE()
    );
END
GO

IF OBJECT_ID('products', 'U') IS NULL
BEGIN
    CREATE TABLE products (
        productId INT IDENTITY(1,1) PRIMARY KEY,
        productName NVARCHAR(255) NOT NULL,
        description NVARCHAR(MAX) NULL,
        price FLOAT NOT NULL,
        quantity INT DEFAULT 0,
        images NVARCHAR(500) NULL,
        status INT DEFAULT 1,
        createDate DATETIME DEFAULT GETDATE(),
        categoryId INT FOREIGN KEY REFERENCES categories(CategoryId)
    );
END
GO

-- Xóa dữ liệu cũ và nạp lại bộ dữ liệu mẫu phong phú
DELETE FROM products;
DELETE FROM categories;
DELETE FROM users;
GO

-- 1. NẠP DANH MỤC MẪU (4 Danh mục chính)
SET IDENTITY_INSERT categories ON;
INSERT INTO categories (CategoryId, CategoryName, Images, Status) VALUES
(1, N'Laptop & Máy Tính Cao Cấp', 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500', 1),
(2, N'Điện Thoại & Tablet', 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500', 1),
(3, N'Phụ Kiện & Thiết Bị Ngoại Vi', 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=500', 1),
(4, N'Sách & Giáo Trình CNTT', 'https://images.unsplash.com/photo-1532012164546-f432f2e3edd3?w=500', 1);
SET IDENTITY_INSERT categories OFF;
GO

-- 2. NẠP TÀI KHOẢN MẪU (Admin & User)
INSERT INTO users (username, password, email, fullname, phone, roleid, status, createdDate) VALUES
('admin', '123456', 'admin@iotstar.vn', N'Quản Trị Viên Hệ Thống', '0987654321', 1, 1, GETDATE()),
('cuong123', '123456', 'lequoccuong31126@gmail.com', N'Lê Quốc Cường (Admin)', '0901234567', 1, 1, GETDATE()),
('user_demo', '123456', 'user.demo@iotstar.vn', N'Khách Hàng Thân Thiết', '0912345678', 2, 1, GETDATE());
GO

-- 3. NẠP 18 SẢN PHẨM MẪU ĐA DẠNG (Đủ phân trang 3 trang x 6 sp)
INSERT INTO products (productName, description, price, quantity, images, status, createDate, categoryId) VALUES
-- Nhóm 1: Laptop & Máy Tính
(N'MacBook Pro 14 M3 Pro', N'Chip Apple M3 Pro 12-core CPU, 18-core GPU, 18GB Unified Memory, 512GB SSD. Màn hình Liquid Retina XDR 120Hz siêu nét.', 49990000, 15, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500', 1, DATEADD(minute, -10, GETDATE()), 1),
(N'Dell XPS 15 9530', N'Intel Core i7-13700H, RAM 32GB DDR5, SSD 1TB NVMe, Card đồ họa RTX 4060 8GB, Màn hình 3.5K OLED cảm ứng cao cấp.', 38500000, 10, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500', 1, DATEADD(minute, -20, GETDATE()), 1),
(N'Asus ROG Zephyrus G14', N'Laptop Gaming mỏng nhẹ hàng đầu, AMD Ryzen 9 7940HS, RTX 4070, màn hình 2.5K 165Hz chuẩn màu 100% DCI-P3.', 36900000, 8, 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=500', 1, DATEADD(minute, -30, GETDATE()), 1),
(N'MacBook Air M2 13.6 inch', N'Thiết kế mỏng nhẹ 1.24kg, chip Apple M2 tiết kiệm pin đến 18 giờ liên tục, 8GB RAM, 256GB SSD màu Midnight sang trọng.', 24500000, 20, 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=500', 1, DATEADD(minute, -40, GETDATE()), 1),

-- Nhóm 2: Điện Thoại & Tablet
(N'iPhone 15 Pro Max 256GB', N'Khung viền Titan siêu bền nhẹ, Chip A17 Pro mạnh mẽ hỗ trợ chơi game đồ họa cao, Camera zoom quang học 5x.', 29500000, 25, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500', 1, DATEADD(minute, -50, GETDATE()), 2),
(N'Samsung Galaxy S24 Ultra', N'Tích hợp quyền năng Galaxy AI thông minh, bút S-Pen tiện lợi, Camera 200MP bắt trọn chi tiết, màn hình Dynamic AMOLED 2X.', 28900000, 18, 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=500', 1, DATEADD(minute, -60, GETDATE()), 2),
(N'iPad Pro 11 inch M2', N'Màn hình Liquid Retina ProMotion 120Hz mượt mà, hỗ trợ Apple Pencil 2 và Magic Keyboard, hoàn hảo cho vẽ và đồ họa.', 20490000, 14, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500', 1, DATEADD(minute, -70, GETDATE()), 2),
(N'Xiaomi 14 Ultra 5G', N'Ống kính quang học Leica Summilux đỉnh cao nhiếp ảnh di động, Snapdragon 8 Gen 3, sạc siêu nhanh 90W HyperCharge.', 26990000, 12, 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=500', 1, DATEADD(minute, -80, GETDATE()), 2),

-- Nhóm 3: Phụ Kiện & Thiết Bị Ngoại Vi
(N'Bàn Phím Cơ Keychron Q1 Pro', N'Vỏ nhôm CNC nguyên khối, kết nối Bluetooth 5.1/Type-C, Switch cơ học Gateron Jupiter, hỗ trợ custom mạch hotswap.', 3950000, 30, 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500', 1, DATEADD(minute, -90, GETDATE()), 3),
(N'Chuột Logitech MX Master 3S', N'Cảm biến 8000 DPI siêu chuẩn xác trên mọi bề mặt, cuộn vô cực MagSpeed cực nhanh, phím bấm êm ái giảm 90% tiếng ồn.', 2290000, 45, 'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500', 1, DATEADD(minute, -100, GETDATE()), 3),
(N'Màn Hình Dell UltraSharp U2723QE', N'Độ phân giải 4K IPS Black độ tương phản 2000:1, chuẩn màu 98% DCI-P3, cổng kết nối Type-C Hub 90W sạc laptop.', 12890000, 9, 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=500', 1, DATEADD(minute, -110, GETDATE()), 3),
(N'Tai Nghe Sony WH-1000XM5', N'Công nghệ chống ồn chủ động HD QN1 kép, thời lượng pin 30 giờ, đàm thoại chuẩn xác với 4 micro định dạng chùm sóng.', 7490000, 16, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500', 1, DATEADD(minute, -120, GETDATE()), 3),
(N'Loa Bluetooth Marshall Stanmore III', N'Âm thanh Stereo sống động mang phong cách Vintage đặc trưng của Marshall, kết nối Bluetooth 5.2 và cổng RCA/3.5mm.', 8990000, 11, 'https://images.unsplash.com/photo-1545454675-3531b543be5d?w=500', 1, DATEADD(minute, -130, GETDATE()), 3),
(N'Ổ Cứng SSD Samsung 990 Pro 2TB', N'Tốc độ đọc/ghi tuần tự lên đến 7450/6900 MB/s, chuẩn giao tiếp PCIe 4.0 NVMe M.2 2280 tối ưu cho game thủ và render video.', 4890000, 35, 'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=500', 1, DATEADD(minute, -140, GETDATE()), 3),

-- Nhóm 4: Sách & Giáo Trình CNTT
(N'Sách Lập Trình Java & Jakarta EE', N'Giáo trình chuyên sâu từ lập trình hướng đối tượng OOP đến xây dựng ứng dụng Web MVC với Jakarta Servlet, JSP và Hibernate.', 280000, 60, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=500', 1, DATEADD(minute, -150, GETDATE()), 4),
(N'Giáo Trình Thiết Kế Cơ Sở Dữ Liệu SQL Server', N'Hướng dẫn phân tích, thiết kế mô hình thực thể ERD, tối ưu hóa truy vấn SQL và chuẩn hóa quan hệ trong hệ quản trị CSDL.', 195000, 80, 'https://images.unsplash.com/photo-1532012164546-f432f2e3edd3?w=500', 1, DATEADD(minute, -160, GETDATE()), 4),
(N'Sách Clean Code - Nghệ Thuật Viết Mã Sạch', N'Tác phẩm kinh điển của Robert C. Martin giúp lập trình viên rèn luyện tư duy viết mã dễ đọc, dễ bảo trì và mở rộng hệ thống.', 320000, 50, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=500', 1, DATEADD(minute, -170, GETDATE()), 4),
(N'Kiến Trúc Microservices & Spring Cloud', N'Hướng dẫn xây dựng hệ thống phần mềm phân tán, cân bằng tải, API Gateway và triển khai với Docker, Kubernetes.', 350000, 40, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500', 1, DATEADD(minute, -180, GETDATE()), 4);
GO

-- 4. KIỂM TRA LẠI DỮ LIỆU
SELECT COUNT(*) AS [Tổng Số Danh Mục] FROM categories;
SELECT COUNT(*) AS [Tổng Số Sản Phẩm] FROM products;
SELECT COUNT(*) AS [Tổng Số Người Dùng] FROM users;
GO

