<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Danh Mục - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-custom {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        .old-img-preview {
            width: 120px;
            height: 90px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #dee2e6;
            padding: 2px;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card card-custom p-4 bg-white">
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <h4 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-pen-to-square text-primary me-2"></i>Cập Nhật Danh Mục</h4>
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary btn-sm">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                    </a>
                </div>

                <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="categoryid" value="${cate.categoryid}">

                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary">Tên Danh Mục <span class="text-danger">*</span></label>
                        <input type="text" id="categoryname" name="categoryname" class="form-control" value="${cate.categoryname}" required>
                    </div>

                    <!-- Ảnh hiện tại -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary d-block">Hình Ảnh Hiện Tại</label>
                        <c:choose>
                            <c:when test="${cate.images != null && cate.images.startsWith('https')}">
                                <c:url value="${cate.images}" var="imgUrl" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${cate.images}" var="imgUrl" />
                            </c:otherwise>
                        </c:choose>
                        <img src="${imgUrl}" alt="Category Image" class="old-img-preview mb-2 shadow-sm"
                             onerror="this.src='https://via.placeholder.com/120x90'"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary">Thay Đổi Hình Ảnh (File mới)</label>
                        <input type="file" id="images1" name="images1" class="form-control" accept="image/*">
                        <small class="text-muted">Để trống nếu muốn giữ nguyên ảnh hiện tại.</small>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary">Hoặc Cập Nhật Link Ảnh (URL)</label>
                        <input type="text" id="images" name="images" class="form-control" 
                               value="${cate.images != null && cate.images.startsWith('http') ? cate.images : ''}" 
                               placeholder="https://picsum.photos/200/150">
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold text-secondary d-block">Trạng Thái</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}>
                            <label class="form-check-label text-success fw-semibold" for="ston">Hoạt động</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}>
                            <label class="form-check-label text-secondary fw-semibold" for="stoff">Khóa</label>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 pt-2 border-top">
                        <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary px-4">Hủy</a>
                        <button type="submit" class="btn btn-primary px-4 fw-semibold">
                            <i class="fa-solid fa-floppy-disk me-1"></i>Cập Nhật
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
