<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Hệ Thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px 0;
        }
        .card-login {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            background: #ffffff;
            overflow: hidden;
        }
        .header-bg {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            padding: 30px 20px;
            color: #ffffff;
            text-align: center;
        }
        .btn-login {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            color: white;
            transition: all 0.3s;
        }
        .btn-login:hover {
            opacity: 0.9;
            transform: translateY(-1px);
            color: white;
        }
        .input-group-text {
            background-color: #f8f9fa;
            border-right: none;
        }
        .form-control {
            border-left: none;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #dee2e6;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card card-login">
                <div class="header-bg">
                    <i class="fa-solid fa-right-to-bracket fa-3x mb-2"></i>
                    <h3 class="fw-bold mb-1">Đăng Nhập</h3>
                    <p class="mb-0 text-white-50">Truy cập vào hệ thống quản lý và mua sắm</p>
                </div>
                <div class="card-body p-4 p-md-5">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i>${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/login'/>" method="post" class="needs-validation">
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Tên đăng nhập</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user text-muted"></i></span>
                                <input type="text" name="username" class="form-control" placeholder="Nhập username" 
                                       pattern="^[a-zA-Z0-9_]{3,30}$" title="Tên đăng nhập từ 3-30 ký tự và không chứa khoảng trắng" required autofocus>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <label class="form-label fw-semibold text-secondary">Mật khẩu</label>
                                <a href="<c:url value='/forgot-password'/>" class="text-decoration-none small text-primary">Quên mật khẩu?</a>
                            </div>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-lock text-muted"></i></span>
                                <input type="password" name="password" class="form-control" placeholder="Tối thiểu 6 ký tự" minlength="6" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-login w-100 mb-3">
                            <i class="fa-solid fa-arrow-right-to-bracket me-2"></i>Đăng Nhập
                        </button>

                        <div class="text-center mt-3">
                            <span class="text-muted">Chưa có tài khoản?</span>
                            <a href="<c:url value='/register'/>" class="fw-semibold text-decoration-none text-primary ms-1">Đăng ký ngay</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
