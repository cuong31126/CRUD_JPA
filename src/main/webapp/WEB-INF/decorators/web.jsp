<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Shop JPA - Hệ Thống Bán Hàng Trực Tuyến</sitemesh:write></title>
    
    <!-- Bootstrap 5.3 CSS & FontAwesome 6 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-wrapper {
            flex: 1;
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        .footer-bg {
            background: #212529;
            color: #adb5bd;
            margin-top: auto;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <!-- Header & Navigation Bar (SiteMesh Decorator) -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="<c:url value='/home'/>">
                <i class="fa-solid fa-store me-2"></i>SHOP JPA
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="mainNavbar">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/home'/>">
                            <i class="fa-solid fa-house me-1"></i>Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/product'/>">
                            <i class="fa-solid fa-box-open me-1"></i>Tất Cả Sản Phẩm
                        </a>
                    </li>
                    <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-info fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fa-solid fa-gear me-1"></i>Quản Trị Admin
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="<c:url value='/admin/categories'/>"><i class="fa-solid fa-list me-2"></i>Quản lý Danh mục</a></li>
                                <li><a class="dropdown-item" href="<c:url value='/admin/products'/>"><i class="fa-solid fa-boxes-stacked me-2"></i>Quản lý Sản phẩm</a></li>
                            </ul>
                        </li>
                    </c:if>
                </ul>

                <ul class="navbar-nav ms-auto align-items-center">
                    <c:choose>
                        <c:when test="${sessionScope.account != null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-light fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fa-solid fa-circle-user text-warning me-1"></i>${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <li><span class="dropdown-item-text text-muted small"><i class="fa-solid fa-envelope me-1"></i>${sessionScope.account.email}</span></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng Xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item me-2">
                                <a class="btn btn-sm btn-outline-light" href="<c:url value='/login'/>">
                                    <i class="fa-solid fa-right-to-bracket me-1"></i>Đăng Nhập
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-sm btn-warning fw-semibold text-dark" href="<c:url value='/register'/>">
                                    <i class="fa-solid fa-user-plus me-1"></i>Đăng Ký
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Dynamic Body injected by SiteMesh -->
    <main class="main-wrapper">
        <sitemesh:write property="body"/>
    </main>

    <!-- Footer (SiteMesh Decorator) -->
    <footer class="footer-bg pt-5 pb-4 border-top border-secondary">
        <div class="container text-center text-md-start">
            <div class="row">
                <div class="col-md-4 col-lg-4 col-xl-4 mx-auto mb-4">
                    <h5 class="text-uppercase fw-bold text-warning mb-3">
                        <i class="fa-solid fa-store me-2"></i>SHOP JPA SYSTEM
                    </h5>
                    <p class="text-white-50">
                        Hệ thống bán hàng và quản lý trực tuyến xây dựng trên nền tảng Java 17, Jakarta Servlet 6.0, Hibernate JPA 3.0, SiteMesh 3 Decorator và SQL Server.
                    </p>
                </div>

                <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-4">
                    <h6 class="text-uppercase fw-bold mb-3 text-light">Liên Kết Nhanh</h6>
                    <p class="mb-2"><a href="${pageContext.request.contextPath}/home" class="text-white-50 text-decoration-none">Trang Chủ</a></p>
                    <p class="mb-2"><a href="${pageContext.request.contextPath}/product" class="text-white-50 text-decoration-none">Tất Cả Sản Phẩm</a></p>
                    <p class="mb-2"><a href="${pageContext.request.contextPath}/login" class="text-white-50 text-decoration-none">Đăng Nhập / Đăng Ký</a></p>
                </div>

                <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
                    <h6 class="text-uppercase fw-bold mb-3 text-light">Hỗ Trợ & Liên Hệ</h6>
                    <p class="text-white-50 mb-2"><i class="fa-solid fa-location-dot me-2"></i>TP. Hồ Chí Minh, Việt Nam</p>
                    <p class="text-white-50 mb-2"><i class="fa-solid fa-envelope me-2"></i>support@iotstar.vn</p>
                    <p class="text-white-50 mb-2"><i class="fa-solid fa-phone me-2"></i>+84 987 654 321</p>
                </div>
            </div>
        </div>
        <div class="text-center p-3 border-top border-secondary mt-3 text-white-50 small">
            © 2026 Bản quyền thuộc về <b>Shop JPA Project (btjpa-02)</b> | SiteMesh 3 Template.
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
