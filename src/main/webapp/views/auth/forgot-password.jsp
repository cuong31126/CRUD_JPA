<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - Nhận Mã OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px 0;
        }
        .card-forgot {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            background: #ffffff;
            overflow: hidden;
        }
        .header-bg {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            padding: 30px 20px;
            color: #ffffff;
            text-align: center;
        }
        .btn-forgot {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            color: white;
            transition: all 0.3s;
        }
        .btn-forgot:hover {
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
            <div class="card card-forgot">
                <div class="header-bg">
                    <i class="fa-solid fa-key fa-3x mb-2"></i>
                    <h3 class="fw-bold mb-1">Quên Mật Khẩu</h3>
                    <p class="mb-0 text-white-50">Nhập email tài khoản để nhận mã OTP đặt lại mật khẩu</p>
                </div>
                <div class="card-body p-4 p-md-5">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/forgot-password'/>" method="post">
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary">Địa chỉ Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-envelope text-muted"></i></span>
                                <input type="email" name="email" class="form-control" placeholder="example@email.com" required autofocus>
                            </div>
                            <small class="text-muted mt-1 d-block">Hệ thống sẽ gửi mã OTP gồm 6 chữ số tới email này.</small>
                        </div>

                        <button type="submit" class="btn btn-forgot w-100 mb-3">
                            <i class="fa-solid fa-paper-plane me-2"></i>Gửi Mã OTP
                        </button>

                        <div class="text-center mt-3">
                            <a href="<c:url value='/login'/>" class="fw-semibold text-decoration-none text-danger">
                                <i class="fa-solid fa-arrow-left me-1"></i>Quay lại Đăng nhập
                            </a>
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
