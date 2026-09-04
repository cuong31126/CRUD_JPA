<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản - Xác Thực OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-register {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            background: #ffffff;
        }
        .header-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 30px 20px;
            color: #ffffff;
            text-align: center;
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-register:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card card-register">
                <div class="header-bg">
                    <h3 class="fw-bold mb-1"><i class="fa-solid fa-user-plus me-2"></i>Tạo Tài Khoản</h3>
                    <p class="mb-0 text-white-50">Đăng ký để trải nghiệm hệ thống</p>
                </div>
                <div class="card-body p-4 p-md-5">
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/register'/>" method="post" class="needs-validation" novalidate>
                        <!-- Username -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Tên đăng nhập <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fa-solid fa-user text-muted"></i></span>
                                <input type="text" name="username" value="${username}" 
                                       class="form-control ${errors['username'] != null ? 'is-invalid' : ''}" 
                                       placeholder="Từ 4 - 30 ký tự (chữ và số)" 
                                       pattern="^[a-zA-Z0-9_]{4,30}$" required autofocus>
                                <div class="invalid-feedback">
                                    ${errors['username'] != null ? errors['username'] : 'Tên đăng nhập từ 4-30 ký tự (chữ, số hoặc gạch dưới)!'}
                                </div>
                            </div>
                        </div>

                        <!-- Fullname -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Họ và tên</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-id-card text-muted"></i></span>
                                <input type="text" name="fullname" value="${fullname}" class="form-control" placeholder="Nguyễn Văn A" maxlength="100">
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Email nhận mã OTP <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fa-solid fa-envelope text-muted"></i></span>
                                <input type="email" name="email" value="${email}" 
                                       class="form-control ${errors['email'] != null ? 'is-invalid' : ''}" 
                                       placeholder="example@email.com" 
                                       pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" required>
                                <div class="invalid-feedback">
                                    ${errors['email'] != null ? errors['email'] : 'Vui lòng nhập đúng định dạng email RFC!'}
                                </div>
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Số điện thoại</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fa-solid fa-phone text-muted"></i></span>
                                <input type="tel" name="phone" value="${phone}" 
                                       class="form-control ${errors['phone'] != null ? 'is-invalid' : ''}" 
                                       placeholder="0901234567 (10 số)" 
                                       pattern="^0[0-9]{9}$">
                                <div class="invalid-feedback">
                                    ${errors['phone'] != null ? errors['phone'] : 'Số điện thoại gồm 10 chữ số bắt đầu bằng 0!'}
                                </div>
                            </div>
                        </div>

                        <!-- Password -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary">Mật khẩu <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fa-solid fa-lock text-muted"></i></span>
                                <input type="password" name="password" 
                                       class="form-control ${errors['password'] != null ? 'is-invalid' : ''}" 
                                       placeholder="Tối thiểu 6 ký tự" minlength="6" required>
                                <div class="invalid-feedback">
                                    ${errors['password'] != null ? errors['password'] : 'Mật khẩu bắt buộc và tối thiểu 6 ký tự!'}
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-register w-100 mb-3 text-white">
                            <i class="fa-solid fa-paper-plane me-2"></i>Đăng Ký & Nhận OTP
                        </button>

                        <div class="text-center mt-3">
                            <span class="text-muted">Đã có tài khoản?</span>
                            <a href="<c:url value='/login'/>" class="fw-semibold text-decoration-none text-primary ms-1">Đăng nhập</a>
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
