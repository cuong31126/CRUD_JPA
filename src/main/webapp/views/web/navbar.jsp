<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
                    <a class="nav-link ${pageContext.request.requestURI.endsWith('home') || pageContext.request.requestURI.endsWith('/') ? 'active fw-bold' : ''}" 
                       href="<c:url value='/home'/>"><i class="fa-solid fa-house me-1"></i>Trang Chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('product') && !pageContext.request.requestURI.contains('admin') ? 'active fw-bold' : ''}" 
                       href="<c:url value='/product'/>"><i class="fa-solid fa-box-open me-1"></i>Tất Cả Sản Phẩm</a>
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
