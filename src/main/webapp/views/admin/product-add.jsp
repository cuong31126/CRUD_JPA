<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Sản Phẩm Mới - Admin</title>
</head>
<body>

<div class="container-fluid" style="max-width: 900px;">
    <!-- Header & Back Button -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-cart-plus text-success me-2"></i>Thêm Sản Phẩm Mới
            </h3>
            <p class="text-muted mb-0">Điền thông tin chi tiết để thêm sản phẩm vào hệ thống</p>
        </div>
        <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary">
            <i class="fa-solid fa-arrow-left me-1"></i>Quay lại danh sách
        </a>
    </div>

    <!-- Alert error -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Form Card -->
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-body p-4 p-md-5">
            <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                
                <!-- Tên sản phẩm (Validation: 2 - 200 ký tự) -->
                <div class="mb-4">
                    <label for="productName" class="form-label fw-semibold">
                        Tên Sản Phẩm <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa-solid fa-box text-muted"></i></span>
                        <input type="text" class="form-control" id="productName" name="productName" 
                               required minlength="2" maxlength="200" 
                               placeholder="Ví dụ: iPhone 15 Pro Max 256GB Titanium">
                        <div class="invalid-feedback">Vui lòng nhập tên sản phẩm (2 - 200 ký tự).</div>
                    </div>
                </div>

                <div class="row g-3 mb-4">
                    <!-- Danh mục sản phẩm (Validation: Bắt buộc chọn) -->
                    <div class="col-md-6">
                        <label for="categoryId" class="form-label fw-semibold">
                            Thuộc Danh Mục <span class="text-danger">*</span>
                        </label>
                        <select class="form-select" id="categoryId" name="categoryId" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.categoryId}">${c.categoryname}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn danh mục cho sản phẩm.</div>
                    </div>

                    <!-- Đơn giá (Validation: min 0) -->
                    <div class="col-md-6">
                        <label for="price" class="form-label fw-semibold">
                            Đơn Giá (VNĐ) <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="fa-solid fa-tag text-muted"></i></span>
                            <input type="number" class="form-control" id="price" name="price" 
                                   required min="0" step="1000" placeholder="500000">
                            <span class="input-group-text">₫</span>
                            <div class="invalid-feedback">Vui lòng nhập giá hợp lệ (>= 0).</div>
                        </div>
                    </div>
                </div>

                <div class="row g-3 mb-4">
                    <!-- Số lượng tồn kho (Validation: min 0) -->
                    <div class="col-md-6">
                        <label for="quantity" class="form-label fw-semibold">
                            Số Lượng Tồn Kho <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="fa-solid fa-cubes text-muted"></i></span>
                            <input type="number" class="form-control" id="quantity" name="quantity" 
                                   required min="0" value="10" placeholder="10">
                            <div class="invalid-feedback">Vui lòng nhập số lượng hợp lệ (>= 0).</div>
                        </div>
                    </div>

                    <!-- Trạng thái kinh doanh -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold d-block">Trạng Thái Kinh Doanh</label>
                        <div class="pt-2">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="statusActive" value="1" checked>
                                <label class="form-check-label text-success fw-semibold" for="statusActive">
                                    <i class="fa-solid fa-check-circle me-1"></i>Đang bán
                                </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="statusInactive" value="0">
                                <label class="form-check-label text-secondary fw-semibold" for="statusInactive">
                                    <i class="fa-solid fa-ban me-1"></i>Tạm dừng
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tải lên hình ảnh -->
                <div class="mb-4">
                    <label for="images" class="form-label fw-semibold">Ảnh Đại Diện Sản Phẩm</label>
                    <input type="file" class="form-control" id="images" name="images" accept="image/*">
                    <div class="form-text text-muted">Hỗ trợ các tệp ảnh .jpg, .png, .webp (Tối đa 10MB)</div>
                </div>

                <!-- Mô tả chi tiết -->
                <div class="mb-4">
                    <label for="description" class="form-label fw-semibold">Mô Tả Chi Tiết Sản Phẩm</label>
                    <textarea class="form-control" id="description" name="description" rows="4" 
                              placeholder="Nhập thông số kỹ thuật, bảo hành, đặc điểm nổi bật..."></textarea>
                </div>

                <!-- Nút Submit -->
                <div class="d-flex justify-content-end gap-2 border-top pt-4">
                    <a href="<c:url value='/admin/products'/>" class="btn btn-light border px-4">Hủy Bỏ</a>
                    <button type="submit" class="btn btn-success px-4 fw-semibold">
                        <i class="fa-solid fa-floppy-disk me-1"></i>Lưu Sản Phẩm
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
