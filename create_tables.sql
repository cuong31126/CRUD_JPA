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

-- Chèn dữ liệu mẫu thử nghiệm
INSERT INTO categories (CategoryName, Images, Status) 
VALUES (N'Công nghệ thông tin', 'https://picsum.photos/200/150', 1);

INSERT INTO categories (CategoryName, Images, Status) 
VALUES (N'Lập trình Java JPA', 'https://picsum.photos/200/150', 1);
GO

SELECT * FROM categories;
GO
