<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cập Nhật Danh Mục #${category.categoryId} - Admin</title>
</head>
<body>

<div class="container-fluid" style="max-width: 800px;">
    <!-- Header & Back Button -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-pen-to-square text-primary me-2"></i>Cập Nhật Danh Mục #${category.categoryId}
            </h3>
            <p class="text-muted mb-0">Chỉnh sửa thông tin danh mục "${category.categoryname}"</p>
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

    <!-- Card Form Cập Nhật -->
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-body p-4 p-md-5">
            <form action="<c:url value='/admin/category/edit'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="categoryId" value="${category.categoryId}">
                <input type="hidden" name="images" value="${category.images}">

                <!-- Tên danh mục (Validation: 2 - 100 ký tự) -->
                <div class="mb-4">
                    <label for="categoryname" class="form-label fw-semibold">
                        Tên Danh Mục <span class="text-danger">*</span>
                    </label>
                    <div class="input-group has-validation">
                        <span class="input-group-text bg-light"><i class="fa-solid fa-tag text-muted"></i></span>
                        <input type="text" class="form-control ${errors['categoryname'] != null ? 'is-invalid' : ''}" 
                               id="categoryname" name="categoryname" 
                               value="${category.categoryname}" required minlength="2" maxlength="100">
                        <div class="invalid-feedback">
                            ${errors['categoryname'] != null ? errors['categoryname'] : 'Vui lòng nhập tên danh mục hợp lệ (2 - 100 ký tự).'}
                        </div>
                    </div>
                </div>

                <!-- Ảnh hiện tại & Tải lên ảnh mới -->
                <div class="mb-4">
                    <label class="form-label fw-semibold d-block">Hình Ảnh Hiện Tại</label>
                    <div class="d-flex align-items-center gap-3 p-3 bg-light rounded border mb-2">
                        <c:choose>
                            <c:when test="${category.images != null && category.images.startsWith('http')}">
                                <c:url value="${category.images}" var="cImg" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${category.images}" var="cImg" />
                            </c:otherwise>
                        </c:choose>
                        <img src="${cImg}" class="rounded border shadow-sm" style="width: 80px; height: 60px; object-fit: cover;" onerror="this.src='https://via.placeholder.com/80x60'">
                        <div class="small text-muted">
                            <div><b>File hiện tại:</b> ${category.images != null ? category.images : 'Chưa có ảnh'}</div>
                            <div>Chọn file bên dưới nếu muốn thay đổi ảnh đại diện.</div>
                        </div>
                    </div>
                    
                    <label for="images_file" class="form-label fw-semibold">Tải Ảnh Mới Thay Thế</label>
                    <input type="file" class="form-control" id="images_file" name="images_file" accept="image/*">
                </div>

                <!-- Trạng thái hoạt động -->
                <div class="mb-4">
                    <label class="form-label fw-semibold d-block">Trạng Thái Kích Hoạt</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" id="statusActive" value="1" ${category.status == 1 ? 'checked' : ''}>
                        <label class="form-check-label text-success fw-semibold" for="statusActive">
                            <i class="fa-solid fa-circle-check me-1"></i>Hoạt động (Hiển thị)
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" id="statusInactive" value="0" ${category.status == 0 ? 'checked' : ''}>
                        <label class="form-check-label text-secondary fw-semibold" for="statusInactive">
                            <i class="fa-solid fa-lock me-1"></i>Tạm khóa (Ẩn)
                        </label>
                    </div>
                </div>

                <!-- Nút Submit -->
                <div class="d-flex justify-content-end gap-2 border-top pt-4">
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-light border px-4">Hủy Bỏ</a>
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">
                        <i class="fa-solid fa-floppy-disk me-1"></i>Cập Nhật Danh Mục
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
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
