<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tất Cả Sản Phẩm - Phân Trang 6 SP/Trang</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
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
            background-color: #2a5298;
            border-color: #2a5298;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<!-- Header -->
<div class="page-header-bg text-center">
    <div class="container">
        <h2 class="fw-bold mb-1"><i class="fa-solid fa-boxes-stacked me-2"></i>Danh Sách Sản Phẩm</h2>
        <p class="mb-0 text-white-50">Hiển thị phân trang 6 sản phẩm mỗi trang (Tổng số: ${totalCount} sản phẩm)</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 mb-5">
        <c:forEach items="${productList}" var="p">
            <div class="col">
                <div class="product-card">
                    <div class="product-img-wrapper">
                        <c:choose>
                            <c:when test="${p.images != null && p.images.startsWith('http')}">
                                <c:url value="${p.images}" var="imgUrl" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${p.images}" var="imgUrl" />
                            </c:otherwise>
                        </c:choose>
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>">
                            <img src="${imgUrl}" alt="${p.productName}" onerror="this.src='https://via.placeholder.com/240'">
                        </a>
                    </div>
                    <div class="card-body p-4 d-flex flex-column justify-content-between">
                        <div>
                            <span class="badge bg-secondary-subtle text-dark mb-2">
                                <i class="fa-solid fa-folder me-1"></i>${p.category != null ? p.category.categoryname : 'Chưa phân loại'}
                            </span>
                            <h5 class="card-title fw-bold mb-2">
                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark text-decoration-none">
                                    ${p.productName}
                                </a>
                            </h5>
                            <p class="card-text text-muted small text-truncate mb-3" style="max-height: 40px;">
                                ${p.description}
                            </p>
                        </div>
                        <div>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="product-price">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </div>
                                <span class="small text-muted">Kho: <b>${p.quantity}</b></span>
                            </div>
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-primary w-100 fw-semibold">
                                <i class="fa-solid fa-circle-info me-1"></i>Xem Chi Tiết Sản Phẩm
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty productList}">
            <div class="col-12 text-center py-5 text-muted">
                <i class="fa-solid fa-box-open fa-3x mb-3"></i>
                <p>Không tìm thấy sản phẩm nào trong danh mục này.</p>
            </div>
        </c:if>
    </div>

    <!-- Thanh Phân Trang (Pagination) 6 sp / trang -->
    <c:if test="${totalPage > 1}">
        <nav aria-label="Page navigation" class="mt-4">
            <ul class="pagination justify-content-center">
                <!-- Nút Previous -->
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/product?page=${currentPage - 1}'/>" aria-label="Previous">
                        <span aria-hidden="true">&laquo; Trang trước</span>
                    </a>
                </li>

                <!-- Danh sách các trang -->
                <c:forEach begin="1" end="${totalPage}" var="pageIndex">
                    <li class="page-item ${pageIndex == currentPage ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/product?page=${pageIndex}'/>">${pageIndex}</a>
                    </li>
                </c:forEach>

                <!-- Nút Next -->
                <li class="page-item ${currentPage == totalPage ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/product?page=${currentPage + 1}'/>" aria-label="Next">
                        <span aria-hidden="true">Trang sau &raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>

<!-- Footer -->
<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
