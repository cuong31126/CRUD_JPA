<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Danh Mục Mới - Admin</title>
</head>
<body>

<div class="container-fluid" style="max-width: 800px;">
    <!-- Breadcrumb & Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-plus-circle text-success me-2"></i>Thêm Danh Mục Mới
            </h3>
            <p class="text-muted mb-0">Nhập thông tin chi tiết để tạo mới danh mục sản phẩm</p>
        </div>
        <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary">
            <i class="fa-solid fa-arrow-left me-1"></i>Quay lại danh sách
        </a>
    </div>

    <!-- Thông báo lỗi nếu có -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Card Form Thêm Mới -->
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-body p-4 p-md-5">
            <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                
                <!-- Tên danh mục (Validation: 2 - 100 ký tự) -->
                <div class="mb-4">
                    <label for="categoryname" class="form-label fw-semibold">
                        Tên Danh Mục <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa-solid fa-tag text-muted"></i></span>
                        <input type="text" class="form-control" id="categoryname" name="categoryname" 
                               required minlength="2" maxlength="100" 
                               placeholder="Ví dụ: Điện Thoại, Laptop, Sách Lập Trình...">
                        <div class="invalid-feedback">Vui lòng nhập tên danh mục (từ 2 đến 100 ký tự).</div>
                    </div>
                </div>

                <!-- Tải lên hình ảnh -->
                <div class="mb-4">
                    <label for="images" class="form-label fw-semibold">
                        Ảnh Đại Diện Danh Mục
                    </label>
                    <div class="input-group">
                        <input type="file" class="form-control" id="images" name="images" accept="image/*">
                    </div>
                    <div class="form-text text-muted">Hỗ trợ định dạng: .jpg, .jpeg, .png, .webp (Tối đa 10MB)</div>
                </div>

                <!-- Trạng thái hoạt động -->
                <div class="mb-4">
                    <label class="form-label fw-semibold d-block">Trạng Thái Kích Hoạt</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" id="statusActive" value="1" checked>
                        <label class="form-check-label text-success fw-semibold" for="statusActive">
                            <i class="fa-solid fa-circle-check me-1"></i>Hoạt động (Hiển thị)
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" id="statusInactive" value="0">
                        <label class="form-check-label text-secondary fw-semibold" for="statusInactive">
                            <i class="fa-solid fa-lock me-1"></i>Tạm khóa (Ẩn)
                        </label>
                    </div>
                </div>

                <!-- Nút Submit -->
                <div class="d-flex justify-content-end gap-2 border-top pt-4">
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-light border px-4">Hủy Bỏ</a>
                    <button type="submit" class="btn btn-success px-4 fw-semibold">
                        <i class="fa-solid fa-floppy-disk me-1"></i>Lưu Danh Mục
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Client-side Bootstrap form validation script
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>

</body>
</html>
