<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Trang Quản Trị - Admin Shop JPA</sitemesh:write></title>
    
    <!-- Bootstrap 5.3 CSS & FontAwesome 6 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .admin-sidebar {
            width: 250px;
            background-color: #212529;
            min-height: calc(100vh - 56px);
        }
        .admin-sidebar .nav-link {
            color: #c2c7d0;
            padding: 12px 20px;
            border-radius: 4px;
            margin: 2px 10px;
            transition: all 0.2s ease;
        }
        .admin-sidebar .nav-link:hover, .admin-sidebar .nav-link.active {
            color: #ffffff;
            background-color: #0d6efd;
        }
        .admin-sidebar .nav-link i {
            width: 24px;
        }
        .admin-content {
            flex: 1;
            padding: 24px;
        }
        .footer-admin {
            background: #ffffff;
            border-top: 1px solid #dee2e6;
            color: #6c757d;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <!-- Top Admin Header -->
    <nav class="navbar navbar-expand navbar-dark bg-dark sticky-top border-bottom border-secondary px-3">
        <a class="navbar-brand fw-bold text-warning" href="<c:url value='/admin/categories'/>">
            <i class="fa-solid fa-shield-halved me-2"></i>ADMIN PORTAL
        </a>

        <ul class="navbar-nav me-auto">
            <li class="nav-item">
                <a class="nav-link text-light" href="<c:url value='/home'/>" target="_blank">
                    <i class="fa-solid fa-arrow-up-right-from-square me-1"></i>Xem Website Khách
                </a>
            </li>
        </ul>

        <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle text-light fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="fa-solid fa-circle-user text-warning me-1"></i>
                    ${sessionScope.account != null ? (sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username) : 'Quản trị viên'}
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow">
                    <li><span class="dropdown-item-text text-muted small"><i class="fa-solid fa-user-shield me-1"></i>Vai trò: Administrator</span></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng Xuất</a></li>
                </ul>
            </li>
        </ul>
    </nav>

    <!-- Main Container with Sidebar + Content -->
    <div class="d-flex flex-grow-1">
        <!-- Sidebar Navigation -->
        <nav class="admin-sidebar d-none d-md-block p-3">
            <div class="text-white-50 small text-uppercase fw-bold px-3 mb-2">QUẢN LÝ DANH MỤC</div>
            <ul class="nav nav-pills flex-column mb-3">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('/category') ? 'active' : ''}" href="<c:url value='/admin/categories'/>">
                        <i class="fa-solid fa-folder-tree"></i> Danh Sách Danh Mục
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/category/add'/>">
                        <i class="fa-solid fa-plus-circle"></i> Thêm Danh Mục Mới
                    </a>
                </li>
            </ul>

            <div class="text-white-50 small text-uppercase fw-bold px-3 mb-2">QUẢN LÝ SẢN PHẨM</div>
            <ul class="nav nav-pills flex-column mb-3">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('/product') ? 'active' : ''}" href="<c:url value='/admin/products'/>">
                        <i class="fa-solid fa-boxes-stacked"></i> Danh Sách Sản Phẩm
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/product/add'/>">
                        <i class="fa-solid fa-cart-plus"></i> Thêm Sản Phẩm Mới
                    </a>
                </li>
            </ul>

            <div class="text-white-50 small text-uppercase fw-bold px-3 mb-2">HỆ THỐNG</div>
            <ul class="nav nav-pills flex-column">
                <li class="nav-item">
                    <a class="nav-link text-danger" href="<c:url value='/logout'/>">
                        <i class="fa-solid fa-right-from-bracket"></i> Đăng Xuất
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Admin Main Content Injected by SiteMesh -->
        <main class="admin-content">
            <sitemesh:write property="body"/>
        </main>
    </div>

    <!-- Admin Footer -->
    <footer class="footer-admin py-3 text-center small">
        <div class="container-fluid">
            © 2026 Hệ Thống Quản Trị Shop JPA (btjpa-02) | Sử dụng SiteMesh 3 Decorator & Bootstrap 5.
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
