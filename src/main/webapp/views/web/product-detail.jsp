<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product != null ? product.productName : 'Chi Tiết Sản Phẩm'} - Shop JPA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .detail-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            background: white;
            overflow: hidden;
        }
        .main-product-img {
            width: 100%;
            max-height: 420px;
            object-fit: cover;
            border-radius: 12px;
            border: 1px solid #eee;
        }
        .price-tag {
            font-size: 2rem;
            font-weight: 800;
            color: #d9534f;
        }
        .related-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .related-card:hover {
            transform: translateY(-4px);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<div class="container py-4 mb-5">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/product'/>" class="text-decoration-none">Sản Phẩm</a></li>
            <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
        </ol>
    </nav>

    <c:choose>
        <c:when test="${product != null}">
            <!-- Card Chi tiết sản phẩm -->
            <div class="card detail-card p-4 p-md-5 mb-5">
                <div class="row g-5">
                    <!-- Cột Ảnh sản phẩm -->
                    <div class="col-md-5 text-center">
                        <c:choose>
                            <c:when test="${product.images != null && product.images.startsWith('http')}">
                                <c:url value="${product.images}" var="imgUrl" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${product.images}" var="imgUrl" />
                            </c:otherwise>
                        </c:choose>
                        <img src="${imgUrl}" alt="${product.productName}" class="main-product-img shadow-sm"
                             onerror="this.src='https://via.placeholder.com/400x350'"/>
                    </div>

                    <!-- Cột Thông tin sản phẩm -->
                    <div class="col-md-7 d-flex flex-column justify-content-between">
                        <div>
                            <div class="d-flex align-items-center gap-2 mb-2">
                                <span class="badge bg-primary px-3 py-2 rounded-pill">
                                    <i class="fa-solid fa-folder me-1"></i>${product.category != null ? product.category.categoryname : 'Chung'}
                                </span>
                                <c:if test="${product.status == 1}">
                                    <span class="badge bg-success px-3 py-2 rounded-pill">Còn hàng</span>
                                </c:if>
                            </div>

                            <h2 class="fw-bold text-dark mb-3">${product.productName}</h2>

                            <div class="price-tag mb-3">
                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </div>

                            <div class="mb-4 text-muted">
                                <p class="mb-1"><i class="fa-solid fa-boxes-stacked me-2 text-secondary"></i>Số lượng còn lại: <b class="text-dark">${product.quantity}</b> chiếc</p>
                                <p class="mb-1"><i class="fa-regular fa-calendar-days me-2 text-secondary"></i>Ngày cập nhật: <fmt:formatDate value="${product.createDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                            </div>

                            <hr>

                            <div class="mb-4">
                                <h5 class="fw-bold text-dark"><i class="fa-solid fa-circle-info me-2 text-primary"></i>Mô Tả Sản Phẩm:</h5>
                                <p class="text-secondary lh-lg" style="white-space: pre-line;">
                                    ${not empty product.description ? product.description : 'Đang cập nhật mô tả chi tiết cho sản phẩm này.'}
                                </p>
                            </div>
                        </div>

                        <div class="d-flex gap-3">
                            <a href="<c:url value='/product'/>" class="btn btn-outline-secondary px-4 py-2">
                                <i class="fa-solid fa-arrow-left me-2"></i>Quay lại danh sách
                            </a>
                            <button class="btn btn-warning px-4 py-2 fw-semibold text-dark" onclick="alert('Đã thêm sản phẩm vào giỏ hàng demo!')">
                                <i class="fa-solid fa-cart-plus me-2"></i>Thêm Vào Giỏ Hàng
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sản phẩm liên quan cùng danh mục -->
            <c:if test="${not empty relatedProducts}">
                <div class="mt-5">
                    <h4 class="fw-bold mb-4 text-dark"><i class="fa-solid fa-tags text-primary me-2"></i>Sản Phẩm Cùng Danh Mục</h4>
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
                        <c:forEach items="${relatedProducts}" var="rp">
                            <c:if test="${rp.productId != product.productId}">
                                <div class="col">
                                    <div class="card related-card h-100 p-3">
                                        <c:choose>
                                            <c:when test="${rp.images != null && rp.images.startsWith('http')}">
                                                <c:url value="${rp.images}" var="rImgUrl" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:url value="/image?fname=${rp.images}" var="rImgUrl" />
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="<c:url value='/product/detail?id=${rp.productId}'/>" class="text-decoration-none text-dark">
                                            <img src="${rImgUrl}" alt="${rp.productName}" class="card-img-top rounded" style="height: 160px; object-fit: cover;"
                                                 onerror="this.src='https://via.placeholder.com/160'"/>
                                            <div class="card-body p-2 mt-2">
                                                <h6 class="card-title fw-bold text-truncate mb-1">${rp.productName}</h6>
                                                <div class="text-danger fw-bold">
                                                    <fmt:formatNumber value="${rp.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </c:when>
        <c:otherwise>
            <div class="alert alert-warning text-center py-5">
                <i class="fa-solid fa-triangle-exclamation fa-3x mb-3"></i>
                <h4>Không tìm thấy sản phẩm!</h4>
                <p>Sản phẩm này có thể đã bị xóa hoặc không tồn tại.</p>
                <a href="<c:url value='/product'/>" class="btn btn-primary mt-2">Xem Tất Cả Sản Phẩm</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
