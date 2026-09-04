<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar-admin {
            background: #2a5298;
        }
        .card-custom {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        .cate-img {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>

<!-- Navbar Admin -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-admin shadow-sm mb-4">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold" href="<c:url value='/admin/categories'/>">
            <i class="fa-solid fa-boxes-stacked me-2"></i>Admin Dashboard
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active fw-bold" href="<c:url value='/admin/categories'/>">
                        <i class="fa-solid fa-list me-1"></i>Danh Mục
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/products'/>">
                        <i class="fa-solid fa-box me-1"></i>Sản Phẩm
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/home'/>" target="_blank">
                        <i class="fa-solid fa-house me-1"></i>Xem Trang Chủ
                    </a>
                </li>
            </ul>
            <div class="d-flex align-items-center text-white">
                <span class="me-3"><i class="fa-solid fa-circle-user me-1"></i>${sessionScope.account != null ? sessionScope.account.fullname : 'Admin'}</span>
                <a href="<c:url value='/logout'/>" class="btn btn-sm btn-outline-light">
                    <i class="fa-solid fa-right-from-bracket me-1"></i>Đăng Xuất
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 pb-5">
    <div class="card card-custom p-4 bg-white">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <div>
                <h4 class="fw-bold mb-1 text-dark">Quản Lý Danh Mục</h4>
                <p class="text-muted small mb-0">Danh sách các nhóm danh mục ngành hàng</p>
            </div>
            <a href="<c:url value='/admin/category/add'/>" class="btn btn-primary px-3 py-2 fw-semibold">
                <i class="fa-solid fa-plus me-1"></i>Thêm Danh Mục Mới
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle text-center mb-0">
                <thead class="table-light">
                    <tr>
                        <th style="width: 5%;">STT</th>
                        <th style="width: 15%;">Hình Ảnh</th>
                        <th style="width: 40%; text-align: left;">Tên Danh Mục</th>
                        <th style="width: 20%;">Trạng Thái</th>
                        <th style="width: 20%;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listcate}" var="cate" varStatus="STT">
                        <tr>
                            <td class="text-muted fw-semibold">${STT.index + 1}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${cate.images != null && cate.images.startsWith('https')}">
                                        <c:url value="${cate.images}" var="imgUrl" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${cate.images}" var="imgUrl" />
                                    </c:otherwise>
                                </c:choose>
                                <img src="${imgUrl}" alt="Category Image" class="cate-img shadow-sm"
                                     onerror="this.src='https://via.placeholder.com/80x60'"/>
                            </td>
                            <td class="text-start fw-semibold text-dark">
                                ${cate.categoryname}
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${cate.status == 1}">
                                        <span class="badge bg-success-subtle text-success border border-success px-3 py-2">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary-subtle text-secondary border px-3 py-2">Khóa</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn btn-sm btn-outline-primary me-1">
                                    <i class="fa-solid fa-pen-to-square me-1"></i>Sửa
                                </a>
                                <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');" 
                                   class="btn btn-sm btn-outline-danger">
                                    <i class="fa-solid fa-trash me-1"></i>Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty listcate}">
                        <tr>
                            <td colspan="5" class="text-center py-4 text-muted">
                                Chưa có danh mục nào. Hãy bấm "Thêm Danh Mục Mới" để tạo!
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
