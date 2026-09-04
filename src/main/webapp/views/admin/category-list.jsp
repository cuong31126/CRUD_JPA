<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Danh Mục - Admin</title>
    <style>
        .cate-img {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-layer-group text-primary me-2"></i>Quản Lý Danh Mục
            </h3>
            <p class="text-muted mb-0">Xem danh sách, thêm mới, cập nhật hoặc xóa danh mục hàng hóa</p>
        </div>
        <a href="<c:url value='/admin/category/add'/>" class="btn btn-success shadow-sm">
            <i class="fa-solid fa-plus me-1"></i>Thêm Danh Mục Mới
        </a>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Bảng danh sách danh mục -->
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center" style="width: 70px;">ID</th>
                            <th class="text-center" style="width: 120px;">Hình Ảnh</th>
                            <th>Tên Danh Mục</th>
                            <th class="text-center" style="width: 150px;">Trạng Thái</th>
                            <th class="text-center" style="width: 180px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cateList}" var="c">
                            <tr>
                                <td class="text-center fw-bold text-secondary">#${c.categoryId}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${c.images != null && c.images.startsWith('http')}">
                                            <c:url value="${c.images}" var="cImg" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${c.images}" var="cImg" />
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${cImg}" class="cate-img shadow-sm" alt="${c.categoryname}" onerror="this.src='https://via.placeholder.com/80x60'">
                                </td>
                                <td>
                                    <div class="fw-bold text-dark fs-6">${c.categoryname}</div>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${c.status == 1}">
                                            <span class="badge bg-success-subtle text-success border border-success px-3 py-2 rounded-pill">
                                                <i class="fa-solid fa-check me-1"></i>Hoạt động
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary-subtle text-secondary border border-secondary px-3 py-2 rounded-pill">
                                                <i class="fa-solid fa-lock me-1"></i>Khóa
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group" role="group">
                                        <a href="<c:url value='/admin/category/edit?id=${c.categoryId}'/>" class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                            <i class="fa-solid fa-pen-to-square me-1"></i>Sửa
                                        </a>
                                        <a href="<c:url value='/admin/category/delete?id=${c.categoryId}'/>" 
                                           class="btn btn-sm btn-outline-danger" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục &quot;${c.categoryname}&quot; không?');" 
                                           title="Xóa danh mục">
                                            <i class="fa-solid fa-trash me-1"></i>Xóa
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty cateList}">
                            <tr>
                                <td colspan="5" class="text-center py-4 text-muted">
                                    <i class="fa-solid fa-folder-open fa-2x mb-2 d-block"></i>
                                    Chưa có danh mục nào trong hệ thống.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
