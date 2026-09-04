<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực Mã OTP - Kích Hoạt Tài Khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px 0;
        }
        .card-otp {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            background: #ffffff;
            overflow: hidden;
        }
        .header-bg {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            padding: 30px 20px;
            color: #ffffff;
            text-align: center;
        }
        .otp-input {
            letter-spacing: 12px;
            font-size: 28px;
            font-weight: 700;
            text-align: center;
            border: 2px dashed #11998e;
            border-radius: 8px;
        }
        .otp-input:focus {
            border-color: #11998e;
            box-shadow: 0 0 0 0.25rem rgba(17, 153, 142, 0.25);
        }
        .btn-verify {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            color: white;
            transition: all 0.3s;
        }
        .btn-verify:hover {
            opacity: 0.9;
            transform: translateY(-1px);
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card card-otp">
                <div class="header-bg">
                    <i class="fa-solid fa-envelope-circle-check fa-3x mb-2"></i>
                    <h3 class="fw-bold mb-1">Xác Thực Mã OTP</h3>
                    <p class="mb-0 text-white-50">Nhập mã xác nhận 6 chữ số đã gửi qua email</p>
                </div>
                <div class="card-body p-4 p-md-5">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i>${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/verify-otp'/>" method="post">
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Email nhận mã</label>
                            <input type="email" name="email" class="form-control bg-light" 
                                   value="${sessionScope.registeredEmail != null ? sessionScope.registeredEmail : email}" 
                                   placeholder="Email nhận mã" required>
                        </div>

                        <div class="mb-4 text-center">
                            <label class="form-label fw-semibold text-secondary d-block text-start">Mã OTP (6 chữ số)</label>
                            <input type="text" name="otp" maxlength="6" minlength="6" pattern="^[0-9]{6}$" 
                                   class="form-control otp-input mb-2" placeholder="------" title="Vui lòng nhập đúng 6 chữ số OTP" required autofocus>
                            <small class="text-muted"><i class="fa-regular fa-clock me-1"></i>Mã OTP có hiệu lực trong vòng <b>5 phút</b></small>
                        </div>

                        <button type="submit" class="btn btn-verify w-100 mb-3">
                            <i class="fa-solid fa-shield-halved me-2"></i>Xác Nhận & Kích Hoạt
                        </button>

                        <div class="text-center mt-3">
                            <span class="text-muted">Chưa nhận được mã?</span>
                            <a href="<c:url value='/resend-otp'/>" class="fw-semibold text-decoration-none text-success ms-1">
                                <i class="fa-solid fa-rotate-right me-1"></i>Gửi lại mã OTP
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
