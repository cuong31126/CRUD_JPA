<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ - Shop JPA</title>
    <style>
        .hero-banner {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 60px 0;
            border-radius: 0 0 20px 20px;
            margin-bottom: 40px;
        }
        .product-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
            background: white;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.12);
        }
        .product-img-wrapper {
            height: 220px;
            overflow: hidden;
            background-color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        .product-img-wrapper img {
            max-height: 100%;
            width: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        .product-card:hover .product-img-wrapper img {
            transform: scale(1.05);
        }
        .badge-new {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #e74c3c;
            color: white;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 11px;
            text-transform: uppercase;
        }
        .product-price {
            font-size: 1.15rem;
            font-weight: 700;
            color: #d9534f;
        }
    </style>
</head>
<body>

<!-- Hero Banner -->
<section class="hero-banner shadow-sm text-center">
    <div class="container">
        <h1 class="fw-bold display-5 mb-3">Chào Mừng Đến Với Shop JPA</h1>
        <p class="lead text-white-50 mb-4">Khám phá các sản phẩm công nghệ, sách lập trình và phụ kiện chất lượng cao với giá ưu đãi nhất.</p>
        <a href="<c:url value='/product'/>" class="btn btn-warning btn-lg px-4 fw-semibold text-dark">
            <i class="fa-solid fa-cart-shopping me-2"></i>Xem Tất Cả Sản Phẩm
        </a>
    </div>
</section>

<div class="container">
    <!-- Danh mục nổi bật -->
    <div class="row mb-5">
        <div class="col-12 text-center mb-4">
            <h3 class="fw-bold text-dark"><i class="fa-solid fa-layer-group text-primary me-2"></i>Danh Mục Sản Phẩm</h3>
            <p class="text-muted">Các nhóm ngành hàng nổi bật</p>
        </div>
        <c:forEach items="${categoryList}" var="cate">
            <div class="col-6 col-md-4 col-lg-3 mb-3">
                <a href="<c:url value='/product'/>" class="text-decoration-none">
                    <div class="card border-0 shadow-sm text-center p-3 h-100 bg-white hover-shadow" style="border-radius: 12px;">
                        <i class="fa-solid fa-tag fa-2x text-primary mb-2"></i>
                        <h6 class="fw-bold text-dark mb-0">${cate.categoryname}</h6>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>

    <!-- 10 Sản Phẩm Mới Nhất -->
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-fire text-danger me-2"></i>10 Sản Phẩm Mới Nhất
            </h3>
            <p class="text-muted mb-0">Các sản phẩm vừa được cập nhật lên hệ thống</p>
        </div>
        <a href="<c:url value='/product'/>" class="btn btn-outline-primary btn-sm fw-semibold">
            Xem tất cả <i class="fa-solid fa-arrow-right ms-1"></i>
        </a>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4 mb-5">
        <c:forEach items="${top10Products}" var="p">
            <div class="col">
                <div class="product-card">
                    <div class="product-img-wrapper">
                        <span class="badge-new">Mới</span>
                        <c:choose>
                            <c:when test="${p.images != null && p.images.startsWith('http')}">
                                <c:url value="${p.images}" var="imgUrl" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${p.images}" var="imgUrl" />
                            </c:otherwise>
                        </c:choose>
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>">
                            <img src="${imgUrl}" alt="${p.productName}" onerror="this.src='https://via.placeholder.com/220'">
                        </a>
                    </div>
                    <div class="card-body p-3 d-flex flex-column justify-content-between">
                        <div>
                            <small class="text-muted d-block mb-1">
                                <i class="fa-solid fa-folder me-1"></i>${p.category != null ? p.category.categoryname : 'Sản phẩm'}
                            </small>
                            <h6 class="card-title fw-bold mb-2" style="font-size: 0.95rem; line-height: 1.4;">
                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark text-decoration-none">
                                    ${p.productName}
                                </a>
                            </h6>
                        </div>
                        <div class="mt-2">
                            <div class="product-price mb-2">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </div>
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-sm btn-outline-dark w-100 fw-semibold">
                                <i class="fa-solid fa-eye me-1"></i>Xem Chi Tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty top10Products}">
            <div class="col-12 text-center py-5 text-muted">
                <i class="fa-solid fa-box-open fa-3x mb-3"></i>
                <p>Chưa có sản phẩm nào được hiển thị.</p>
            </div>
        </c:if>
    </div>
</div>

</body>
</html>
