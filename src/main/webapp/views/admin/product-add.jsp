<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-custom {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card card-custom p-4 p-md-5">
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <h3 class="fw-bold text-primary mb-0"><i class="fa-solid fa-plus-circle me-2"></i>Thêm Sản Phẩm Mới</h3>
                    <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại danh sách
                    </a>
                </div>

                <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên Sản Phẩm <span class="text-danger">*</span></label>
                        <input type="text" name="productName" class="form-control" placeholder="Nhập tên sản phẩm" required autofocus>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Danh Mục <span class="text-danger">*</span></label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach items="${categories}" var="cate">
                                    <option value="${cate.categoryId}">${cate.categoryname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Trạng Thái</label>
                            <select name="status" class="form-select">
                                <option value="1">Hoạt động (Hiển thị)</option>
                                <option value="0">Khóa (Ẩn)</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Giá Bán (VNĐ) <span class="text-danger">*</span></label>
                            <input type="number" step="1000" name="price" class="form-control" placeholder="Ví dụ: 150000" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Số Lượng Trong Kho <span class="text-danger">*</span></label>
                            <input type="number" name="quantity" class="form-control" placeholder="Ví dụ: 50" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Upload Hình Ảnh (File từ máy tính)</label>
                        <input type="file" name="imageFile" class="form-control" accept="image/*">
                        <small class="text-muted">Chọn file ảnh (.jpg, .png, .jpeg, .webp) để upload lên thư mục máy chủ.</small>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Hoặc Đường Dẫn Ảnh Trực Tuyến (URL)</label>
                        <input type="text" name="images" class="form-control" placeholder="https://example.com/image.jpg">
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Mô Tả Sản Phẩm</label>
                        <textarea name="description" rows="4" class="form-control" placeholder="Nhập thông tin mô tả chi tiết sản phẩm..."></textarea>
                    </div>

                    <div class="d-flex justify-content-end gap-2">
                        <a href="<c:url value='/admin/products'/>" class="btn btn-secondary px-4">Hủy</a>
                        <button type="submit" class="btn btn-primary px-5 fw-semibold">
                            <i class="fa-solid fa-floppy-disk me-2"></i>Lưu Sản Phẩm
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
