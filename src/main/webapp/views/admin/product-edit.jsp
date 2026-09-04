<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Sản Phẩm - Admin</title>
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
        .old-img-preview {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px dashed #0d6efd;
            padding: 2px;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card card-custom p-4 p-md-5">
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <h3 class="fw-bold text-primary mb-0"><i class="fa-solid fa-pen-to-square me-2"></i>Chỉnh Sửa Sản Phẩm</h3>
                    <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại danh sách
                    </a>
                </div>

                <form action="<c:url value='/admin/product/update'/>" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="productId" value="${product.productId}">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên Sản Phẩm <span class="text-danger">*</span></label>
                        <input type="text" name="productName" value="${product.productName}" class="form-control" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Danh Mục <span class="text-danger">*</span></label>
                            <select name="categoryId" class="form-select" required>
                                <c:forEach items="${categories}" var="cate">
                                    <option value="${cate.categoryId}" ${product.category != null && product.category.categoryId == cate.categoryId ? 'selected' : ''}>
                                        ${cate.categoryname}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Trạng Thái</label>
                            <select name="status" class="form-select">
                                <option value="1" ${product.status == 1 ? 'selected' : ''}>Hoạt động (Hiển thị)</option>
                                <option value="0" ${product.status == 0 ? 'selected' : ''}>Khóa (Ẩn)</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Giá Bán (VNĐ) <span class="text-danger">*</span></label>
                            <input type="number" step="1000" name="price" value="${product.price.intValue()}" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Số Lượng Trong Kho <span class="text-danger">*</span></label>
                            <input type="number" name="quantity" value="${product.quantity}" class="form-control" required>
                        </div>
                    </div>

                    <!-- Hình ảnh hiện tại -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold d-block">Hình Ảnh Hiện Tại</label>
                        <c:choose>
                            <c:when test="${product.images != null && product.images.startsWith('http')}">
                                <c:url value="${product.images}" var="imgUrl" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${product.images}" var="imgUrl" />
                            </c:otherwise>
                        </c:choose>
                        <img src="${imgUrl}" alt="${product.productName}" class="old-img-preview mb-2 shadow-sm"
                             onerror="this.src='https://via.placeholder.com/120'"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Thay Đổi Hình Ảnh (File mới)</label>
                        <input type="file" name="imageFile" class="form-control" accept="image/*">
                        <small class="text-muted">Để trống nếu muốn giữ nguyên hình ảnh hiện tại.</small>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Hoặc Cập Nhật Bằng Link Ảnh (URL)</label>
                        <input type="text" name="images" class="form-control" placeholder="https://example.com/image.jpg"
                               value="${product.images != null && product.images.startsWith('http') ? product.images : ''}">
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Mô Tả Sản Phẩm</label>
                        <textarea name="description" rows="4" class="form-control">${product.description}</textarea>
                    </div>

                    <div class="d-flex justify-content-end gap-2">
                        <a href="<c:url value='/admin/products'/>" class="btn btn-secondary px-4">Hủy</a>
                        <button type="submit" class="btn btn-primary px-5 fw-semibold">
                            <i class="fa-solid fa-floppy-disk me-2"></i>Cập Nhật Sản Phẩm
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
