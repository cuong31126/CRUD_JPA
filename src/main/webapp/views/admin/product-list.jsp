<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar-admin {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        }
        .card-custom {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .product-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
        }
        .table thead th {
            background-color: #f1f4f9;
            color: #495057;
            font-weight: 600;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-admin shadow-sm mb-4">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold" href="<c:url value='/admin/products'/>">
            <i class="fa-solid fa-boxes-stacked me-2"></i>Admin Dashboard
        </a>
        <button class="navbar-toggler" type="button" data-bs-dismiss="collapse" data-bs-target="#adminNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/categories'/>"><i class="fa-solid fa-list me-1"></i>Danh Mục</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active fw-bold" href="<c:url value='/admin/products'/>"><i class="fa-solid fa-box me-1"></i>Sản Phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/home'/>" target="_blank"><i class="fa-solid fa-house me-1"></i>Xem Trang Chủ</a>
                </li>
            </ul>
            <div class="d-flex align-items-center text-white">
                <span class="me-3"><i class="fa-solid fa-circle-user me-1"></i>${sessionScope.account != null ? sessionScope.account.fullname : 'Admin'}</span>
                <a href="<c:url value='/logout'/>" class="btn btn-sm btn-outline-light"><i class="fa-solid fa-right-from-bracket me-1"></i>Đăng Xuất</a>
            </div>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 pb-5">
    <div class="card card-custom p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1 text-dark">Danh Sách Sản Phẩm</h3>
                <p class="text-muted mb-0">Quản lý và cập nhật thông tin sản phẩm trên hệ thống</p>
            </div>
            <a href="<c:url value='/admin/product/add'/>" class="btn btn-primary px-4 py-2 fw-semibold">
                <i class="fa-solid fa-plus me-2"></i>Thêm Sản Phẩm Mới
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead>
                    <tr>
                        <th style="width: 5%;">STT</th>
                        <th style="width: 10%;">Hình Ảnh</th>
                        <th style="width: 25%; text-align: left;">Tên Sản Phẩm</th>
                        <th style="width: 15%;">Danh Mục</th>
                        <th style="width: 15%;">Giá Bán</th>
                        <th style="width: 10%;">Số Lượng</th>
                        <th style="width: 10%;">Trạng Thái</th>
                        <th style="width: 10%;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${productList}" var="prod" varStatus="loop">
                        <tr>
                            <td class="fw-semibold text-muted">${loop.index + 1}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${prod.images != null && prod.images.startsWith('http')}">
                                        <c:url value="${prod.images}" var="imgUrl" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${prod.images}" var="imgUrl" />
                                    </c:otherwise>
                                </c:choose>
                                <img src="${imgUrl}" alt="${prod.productName}" class="product-img shadow-sm" 
                                     onerror="this.src='https://via.placeholder.com/70'"/>
                            </td>
                            <td class="text-start">
                                <div class="fw-bold text-dark">${prod.productName}</div>
                                <small class="text-muted text-truncate d-inline-block" style="max-width: 280px;">${prod.description}</small>
                            </td>
                            <td>
                                <span class="badge bg-info text-dark px-3 py-2 rounded-pill">
                                    <c:out value="${prod.category != null ? prod.category.categoryname : 'Chưa phân loại'}"/>
                                </span>
                            </td>
                            <td class="fw-bold text-danger">
                                <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </td>
                            <td>
                                <span class="badge ${prod.quantity > 0 ? 'bg-success' : 'bg-danger'} px-2 py-1">
                                    ${prod.quantity} chiếc
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${prod.status == 1}">
                                        <span class="badge bg-success-subtle text-success border border-success px-2 py-1">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary-subtle text-secondary border px-2 py-1">Đã ẩn</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="<c:url value='/admin/product/edit?id=${prod.productId}'/>" class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <a href="<c:url value='/admin/product/delete?id=${prod.productId}'/>" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?');" 
                                       class="btn btn-sm btn-outline-danger" title="Xóa">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty productList}">
                        <tr>
                            <td colspan="8" class="text-center py-5 text-muted">
                                <i class="fa-regular fa-folder-open fa-3x mb-3 d-block"></i>
                                Chưa có sản phẩm nào. Hãy bấm <b>"Thêm Sản Phẩm Mới"</b> để tạo sản phẩm!
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
