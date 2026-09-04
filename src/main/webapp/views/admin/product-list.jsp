<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Sản Phẩm - Admin</title>
    <style>
        .product-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <!-- Header & Action Button -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-boxes-stacked text-primary me-2"></i>Quản Lý Sản Phẩm
            </h3>
            <p class="text-muted mb-0">Xem danh sách, thêm mới, chỉnh sửa hoặc xóa sản phẩm trong hệ thống</p>
        </div>
        <a href="<c:url value='/admin/product/add'/>" class="btn btn-success shadow-sm">
            <i class="fa-solid fa-plus me-1"></i>Thêm Sản Phẩm Mới
        </a>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Table Card -->
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center" style="width: 70px;">ID</th>
                            <th class="text-center" style="width: 100px;">Hình Ảnh</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Danh Mục</th>
                            <th class="text-end">Đơn Giá</th>
                            <th class="text-center">Số Lượng</th>
                            <th class="text-center">Trạng Thái</th>
                            <th class="text-center" style="width: 180px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productList}" var="p">
                            <tr>
                                <td class="text-center fw-bold text-secondary">#${p.productId}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${p.images != null && p.images.startsWith('http')}">
                                            <c:url value="${p.images}" var="pImg" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${p.images}" var="pImg" />
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${pImg}" class="product-img shadow-sm" alt="${p.productName}" onerror="this.src='https://via.placeholder.com/70'">
                                </td>
                                <td>
                                    <div class="fw-bold text-dark fs-6">${p.productName}</div>
                                    <small class="text-muted text-truncate d-inline-block" style="max-width: 250px;">
                                        ${p.description != null ? p.description : ''}
                                    </small>
                                </td>
                                <td>
                                    <span class="badge bg-light text-primary border">
                                        <i class="fa-solid fa-tag me-1"></i>${p.category != null ? p.category.categoryname : 'N/A'}
                                    </span>
                                </td>
                                <td class="text-end fw-bold text-danger">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </td>
                                <td class="text-center">
                                    <span class="badge ${p.quantity > 0 ? 'bg-info-subtle text-dark border' : 'bg-danger text-white'} px-2 py-1">
                                        ${p.quantity} cái
                                    </span>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${p.status == 1}">
                                            <span class="badge bg-success-subtle text-success border border-success px-2 py-1 rounded-pill">
                                                <i class="fa-solid fa-check me-1"></i>Kinh Doanh
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary-subtle text-secondary border border-secondary px-2 py-1 rounded-pill">
                                                <i class="fa-solid fa-ban me-1"></i>Tạm Dừng
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group" role="group">
                                        <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn btn-sm btn-outline-primary" title="Sửa sản phẩm">
                                            <i class="fa-solid fa-pen-to-square me-1"></i>Sửa
                                        </a>
                                        <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" 
                                           class="btn btn-sm btn-outline-danger" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm &quot;${p.productName}&quot; không?');"
                                           title="Xóa sản phẩm">
                                            <i class="fa-solid fa-trash me-1"></i>Xóa
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty productList}">
                            <tr>
                                <td colspan="8" class="text-center py-5 text-muted">
                                    <i class="fa-solid fa-box-open fa-3x mb-3 d-block"></i>
                                    Chưa có sản phẩm nào trong hệ thống.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
