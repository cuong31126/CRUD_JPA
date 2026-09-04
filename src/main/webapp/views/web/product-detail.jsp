<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${product != null ? product.productName : 'Chi Tiết Sản Phẩm'} - Shop JPA</title>
    <style>
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
            <div class="card detail-card p-4 p-md-5">
                <div class="row g-5">
                    <!-- Ảnh sản phẩm -->
                    <div class="col-md-5 text-center">
                        <c:choose>
                            <c:when test="${product.images != null && product.images.startsWith('http')}">
                                <c:url value="${product.images}" var="pImg" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${product.images}" var="pImg" />
                            </c:otherwise>
                        </c:choose>
                        <img src="${pImg}" alt="${product.productName}" class="main-product-img shadow-sm mb-3" onerror="this.src='https://via.placeholder.com/450'">
                        
                        <div class="d-flex justify-content-center gap-2">
                            <span class="badge ${product.status == 1 ? 'bg-success' : 'bg-secondary'} px-3 py-2">
                                <i class="fa-solid fa-circle-check me-1"></i>${product.status == 1 ? 'Đang kinh doanh' : 'Tạm hết hàng'}
                            </span>
                            <span class="badge bg-info text-dark px-3 py-2">
                                <i class="fa-solid fa-cubes me-1"></i>Số lượng tồn: ${product.quantity}
                            </span>
                        </div>
                    </div>

                    <!-- Thông tin chi tiết -->
                    <div class="col-md-7 d-flex flex-column justify-content-between">
                        <div>
                            <span class="badge bg-primary fs-6 mb-2">
                                <i class="fa-solid fa-layer-group me-1"></i>${product.category != null ? product.category.categoryname : 'Danh mục chung'}
                            </span>
                            <h2 class="fw-bold text-dark mb-3">${product.productName}</h2>
                            
                            <div class="price-tag mb-4">
                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </div>

                            <h5 class="fw-bold text-secondary mb-2"><i class="fa-solid fa-circle-info me-2 text-primary"></i>Mô Tả Sản Phẩm:</h5>
                            <p class="text-muted lead fs-6" style="line-height: 1.8;">
                                ${product.description != null && !product.description.isEmpty() ? product.description : 'Sản phẩm chính hãng với chất lượng đảm bảo, đầy đủ chính sách bảo hành.'}
                            </p>
                        </div>

                        <!-- Các nút tương tác -->
                        <div class="border-top pt-4 mt-4">
                            <div class="row g-3">
                                <div class="col-sm-6">
                                    <button class="btn btn-warning btn-lg w-100 fw-bold text-dark py-3">
                                        <i class="fa-solid fa-cart-arrow-down me-2"></i>Thêm Vào Giỏ Hàng
                                    </button>
                                </div>
                                <div class="col-sm-6">
                                    <a href="<c:url value='/product'/>" class="btn btn-outline-secondary btn-lg w-100 py-3">
                                        <i class="fa-solid fa-arrow-left me-2"></i>Xem Sản Phẩm Khác
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sản phẩm cùng loại gợi ý -->
            <c:if test="${not empty relatedProducts}">
                <div class="mt-5">
                    <h4 class="fw-bold mb-4"><i class="fa-solid fa-thumbs-up text-warning me-2"></i>Sản Phẩm Cùng Danh Mục</h4>
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
                        <c:forEach items="${relatedProducts}" var="rel">
                            <div class="col">
                                <div class="card related-card h-100 p-3">
                                    <c:choose>
                                        <c:when test="${rel.images != null && rel.images.startsWith('http')}">
                                            <c:url value="${rel.images}" var="relImg" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${rel.images}" var="relImg" />
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${relImg}" alt="${rel.productName}" class="card-img-top rounded" style="height: 140px; object-fit: cover;" onerror="this.src='https://via.placeholder.com/150'">
                                    <div class="card-body p-2 d-flex flex-column justify-content-between mt-2">
                                        <h6 class="card-title text-truncate fw-bold mb-1">
                                            <a href="<c:url value='/product/detail?id=${rel.productId}'/>" class="text-dark text-decoration-none">${rel.productName}</a>
                                        </h6>
                                        <div class="text-danger fw-bold">
                                            <fmt:formatNumber value="${rel.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

        </c:when>
        <c:otherwise>
            <div class="alert alert-danger text-center p-5 shadow-sm rounded-4">
                <i class="fa-solid fa-triangle-exclamation fa-3x mb-3"></i>
                <h3>Không tìm thấy sản phẩm!</h3>
                <p class="text-muted">Sản phẩm bạn đang tìm kiếm có thể đã bị xóa hoặc không tồn tại.</p>
                <a href="<c:url value='/product'/>" class="btn btn-primary mt-2"><i class="fa-solid fa-arrow-left me-1"></i>Quay lại danh sách sản phẩm</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
