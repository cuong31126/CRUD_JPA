<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tất Cả Sản Phẩm - Phân Trang 6 SP/Trang</title>
    <style>
        .page-header-bg {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
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
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }
        .product-img-wrapper {
            height: 240px;
            overflow: hidden;
            background-color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
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
        .product-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: #d9534f;
        }
        .pagination .page-item.active .page-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
        .pagination .page-link {
            color: #0d6efd;
            border-radius: 6px;
            margin: 0 3px;
        }
    </style>
</head>
<body>

<!-- Header Banner -->
<div class="page-header-bg text-center shadow-sm">
    <div class="container">
        <h2 class="fw-bold mb-2">Tất Cả Sản Phẩm</h2>
        <p class="text-white-50 mb-0">Hiển thị danh sách sản phẩm với phân trang 6 sản phẩm / trang</p>
    </div>
</div>

<div class="container mb-5">
    <!-- Breadcrumb & Stats -->
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Sản Phẩm</li>
            </ol>
        </nav>
        <span class="badge bg-primary fs-6 fw-normal px-3 py-2">
            Tổng cộng: <b>${totalProducts}</b> sản phẩm (Trang ${currentPage} / ${totalPages > 0 ? totalPages : 1})
        </span>
    </div>

    <!-- Product Grid (6 items/page) -->
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 mb-5">
        <c:forEach items="${productList}" var="p">
            <div class="col">
                <div class="product-card">
                    <div class="product-img-wrapper position-relative">
                        <c:choose>
                            <c:when test="${p.images != null && p.images.startsWith('http')}">
                                <c:url value="${p.images}" var="imgUrl" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${p.images}" var="imgUrl" />
                            </c:otherwise>
                        </c:choose>
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>">
                            <img src="${imgUrl}" alt="${p.productName}" onerror="this.src='https://via.placeholder.com/300x240'">
                        </a>
                    </div>
                    <div class="card-body p-4 d-flex flex-column justify-content-between">
                        <div>
                            <span class="badge bg-light text-primary border mb-2">
                                <i class="fa-solid fa-tag me-1"></i>${p.category != null ? p.category.categoryname : 'Chung'}
                            </span>
                            <h5 class="card-title fw-bold mb-2">
                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark text-decoration-none">
                                    ${p.productName}
                                </a>
                            </h5>
                            <p class="text-muted small text-truncate-2 mb-3" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; height: 38px;">
                                ${p.description != null ? p.description : 'Sản phẩm chất lượng cao, chính hãng.'}
                            </p>
                        </div>
                        <div class="border-top pt-3">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="product-price">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </span>
                                <span class="small text-muted">
                                    <i class="fa-solid fa-cubes me-1"></i>Còn: <b>${p.quantity}</b>
                                </span>
                            </div>
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-primary w-100 fw-semibold">
                                <i class="fa-solid fa-circle-info me-1"></i>Xem Chi Tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty productList}">
            <div class="col-12 text-center py-5">
                <i class="fa-solid fa-box-open fa-3x text-muted mb-3"></i>
                <h5 class="text-muted">Không tìm thấy sản phẩm nào trên trang này.</h5>
                <a href="<c:url value='/product?page=1'/>" class="btn btn-outline-primary mt-3">Quay lại Trang 1</a>
            </div>
        </c:if>
    </div>

    <!-- Pagination (Phân trang 6 sp/trang) -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="d-flex justify-content-center mt-4">
            <ul class="pagination shadow-sm">
                <!-- Nút Previous -->
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/product?page=${currentPage - 1}'/>" aria-label="Previous">
                        <span aria-hidden="true">&laquo; Trang Trước</span>
                    </a>
                </li>
                
                <!-- Danh sách số trang -->
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/product?page=${i}'/>">${i}</a>
                    </li>
                </c:forEach>
                
                <!-- Nút Next -->
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/product?page=${currentPage + 1}'/>" aria-label="Next">
                        <span aria-hidden="true">Trang Sau &raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>

</body>
</html>
