<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực Mã OTP - Shop JPA</title>
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
        }
        .card-otp {
            border: none;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            background: #ffffff;
        }
        .header-bg {
            background: #198754;
            padding: 30px 20px;
            color: #ffffff;
            text-align: center;
        }
        .otp-input {
            letter-spacing: 8px;
            font-size: 1.6rem;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card card-otp">
                <div class="header-bg">
                    <h3 class="fw-bold mb-1"><i class="fa-solid fa-shield-check me-2"></i>Xác Thực OTP</h3>
                    <p class="mb-0 text-white-50">Nhập mã 6 chữ số gửi qua email</p>
                </div>
                <div class="card-body p-4 p-md-5">
                    
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i>${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/verify-otp'/>" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="email" value="${not empty email ? email : sessionScope.registeredEmail}">
                        
                        <div class="text-center mb-3">
                            <span class="text-muted small">Mã OTP đã được gửi đến:</span>
                            <div class="fw-bold text-primary">${not empty email ? email : sessionScope.registeredEmail}</div>
                            <div class="text-danger small mt-1"><i class="fa-solid fa-clock me-1"></i>Mã có hiệu lực trong 5 phút</div>
                        </div>

                        <!-- OTP Input (6 chữ số) -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary text-center d-block">Nhập Mã OTP (6 Số) <span class="text-danger">*</span></label>
                            <div class="has-validation">
                                <input type="text" name="otp" maxlength="6" 
                                       class="form-control otp-input ${errors['otp'] != null ? 'is-invalid' : ''}" 
                                       placeholder="••••••" 
                                       pattern="^[0-9]{6}$" required autofocus>
                                <div class="invalid-feedback text-center">
                                    ${errors['otp'] != null ? errors['otp'] : 'Vui lòng nhập đúng 6 chữ số OTP!'}
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success w-100 mb-3 fw-bold py-2">
                            <i class="fa-solid fa-circle-check me-2"></i>Kích Hoạt Tài Khoản
                        </button>

                        <div class="text-center mt-3">
                            <a href="<c:url value='/resend-otp'/>" class="text-decoration-none text-muted small">
                                <i class="fa-solid fa-rotate-right me-1"></i>Chưa nhận được mã? <b>Gửi lại OTP</b>
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>
</body>
</html>
