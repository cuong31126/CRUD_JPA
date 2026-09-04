<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu - Shop JPA</title>
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
        .card-reset {
            border: none;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            background: #ffffff;
        }
        .header-bg {
            background: #d63384;
            padding: 30px 20px;
            color: #ffffff;
            text-align: center;
        }
        .otp-input {
            letter-spacing: 4px;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card card-reset">
                <div class="header-bg">
                    <h3 class="fw-bold mb-1"><i class="fa-solid fa-lock-open me-2"></i>Đặt Lại Mật Khẩu</h3>
                    <p class="mb-0 text-white-50">Nhập mã OTP và mật khẩu mới của bạn</p>
                </div>
                <div class="card-body p-4 p-md-5">
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/reset-password'/>" method="post" class="needs-validation" novalidate>
                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Email nhận mã</label>
                            <input type="email" name="email" value="${not empty email ? email : sessionScope.resetEmail}" 
                                   class="form-control bg-light" readonly>
                        </div>

                        <!-- OTP (6 số) -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Mã OTP (6 Số) <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fa-solid fa-shield-halved text-muted"></i></span>
                                <input type="text" name="otp" value="${otp}" maxlength="6" 
                                       class="form-control otp-input ${errors['otp'] != null ? 'is-invalid' : ''}" 
                                       placeholder="••••••" 
                                       pattern="^[0-9]{6}$" required autofocus>
                                <div class="invalid-feedback">
                                    ${errors['otp'] != null ? errors['otp'] : 'Vui lòng nhập đúng 6 chữ số OTP!'}
                                </div>
                            </div>
                        </div>

                        <!-- Mật khẩu mới -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Mật khẩu mới <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fa-solid fa-lock text-muted"></i></span>
                                <input type="password" name="newPassword" 
                                       class="form-control ${errors['newPassword'] != null ? 'is-invalid' : ''}" 
                                       placeholder="Tối thiểu 6 ký tự" minlength="6" required>
                                <div class="invalid-feedback">
                                    ${errors['newPassword'] != null ? errors['newPassword'] : 'Mật khẩu mới tối thiểu 6 ký tự!'}
                                </div>
                            </div>
                        </div>

                        <!-- Xác nhận mật khẩu -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fa-solid fa-circle-check text-muted"></i></span>
                                <input type="password" name="confirmPassword" 
                                       class="form-control ${errors['confirmPassword'] != null ? 'is-invalid' : ''}" 
                                       placeholder="Nhập lại mật khẩu mới" minlength="6" required>
                                <div class="invalid-feedback">
                                    ${errors['confirmPassword'] != null ? errors['confirmPassword'] : 'Vui lòng xác nhận lại mật khẩu!'}
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-danger w-100 mb-3 fw-bold py-2" style="background: #d63384; border-color: #d63384;">
                            <i class="fa-solid fa-floppy-disk me-2"></i>Lưu Mật Khẩu Mới
                        </button>

                        <div class="text-center mt-3">
                            <a href="<c:url value='/login'/>" class="text-decoration-none text-secondary small">
                                <i class="fa-solid fa-arrow-left me-1"></i>Quay lại <b>Đăng nhập</b>
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
