<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - Shop JPA</title>
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
        }
        .card-forgot {
            border: none;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            background: #ffffff;
        }
        .header-bg {
            background: #0d6efd;
            padding: 30px 20px;
            color: #ffffff;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card card-forgot">
                <div class="header-bg">
                    <h3 class="fw-bold mb-1"><i class="fa-solid fa-key me-2"></i>Quên Mật Khẩu</h3>
                    <p class="mb-0 text-white-50">Nhận mã OTP khôi phục qua email</p>
                </div>
                <div class="card-body p-4 p-md-5">
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/forgot-password'/>" method="post" class="needs-validation" novalidate>
                        <!-- Email Input -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary">Email tài khoản <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fa-solid fa-envelope text-muted"></i></span>
                                <input type="email" name="email" value="${email}" 
                                       class="form-control ${errors['email'] != null ? 'is-invalid' : ''}" 
                                       placeholder="example@email.com" 
                                       pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" required autofocus>
                                <div class="invalid-feedback">
                                    ${errors['email'] != null ? errors['email'] : 'Vui lòng nhập đúng định dạng email RFC!'}
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 mb-3 fw-bold py-2">
                            <i class="fa-solid fa-paper-plane me-2"></i>Gửi Mã Xác Thực OTP
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
