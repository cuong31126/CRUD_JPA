<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Shop JPA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-login {
            border: none;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            background: #ffffff;
        }
        .header-bg {
            background: #212529;
            padding: 30px 20px;
            color: #ffffff;
            text-align: center;
        }
        .btn-login {
            background: #212529;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-login:hover {
            background: #343a40;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card card-login">
                <div class="header-bg">
                    <h3 class="fw-bold mb-1"><i class="fa-solid fa-lock me-2 text-warning"></i>Đăng Nhập</h3>
                    <p class="mb-0 text-white-50">Hệ thống Shop JPA System</p>
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

                    <form action="<c:url value='/login'/>" method="post" class="needs-validation" novalidate>
                        <!-- Username -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Tên đăng nhập <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fa-solid fa-user text-muted"></i></span>
                                <input type="text" name="username" value="${username}" 
                                       class="form-control ${errors['username'] != null ? 'is-invalid' : ''}" 
                                       placeholder="Nhập username" required autofocus>
                                <div class="invalid-feedback">
                                    ${errors['username'] != null ? errors['username'] : 'Vui lòng nhập tên đăng nhập!'}
                                </div>
                            </div>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">Mật khẩu <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fa-solid fa-key text-muted"></i></span>
                                <input type="password" name="password" 
                                       class="form-control ${errors['password'] != null ? 'is-invalid' : ''}" 
                                       placeholder="Nhập mật khẩu" minlength="6" required>
                                <div class="invalid-feedback">
                                    ${errors['password'] != null ? errors['password'] : 'Vui lòng nhập mật khẩu (tối thiểu 6 ký tự)!'}
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rememberMe">
                                <label class="form-check-label small text-muted" for="rememberMe">Ghi nhớ</label>
                            </div>
                            <a href="<c:url value='/forgot-password'/>" class="small text-decoration-none text-danger fw-semibold">Quên mật khẩu?</a>
                        </div>

                        <button type="submit" class="btn btn-dark btn-login w-100 mb-3 text-white">
                            <i class="fa-solid fa-right-to-bracket me-2"></i>Đăng Nhập
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
