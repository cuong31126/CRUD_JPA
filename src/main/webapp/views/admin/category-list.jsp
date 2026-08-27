<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh Sách Category</title>
</head>
<body>

<h2>Quản lý Danh mục</h2>
<a href="<c:url value='/admin/category/add'/>">Thêm Danh mục Mới</a>
<br><hr>

<table border="1" width="100%" style="border-collapse: collapse; text-align: center;">
  <thead>
    <tr>
      <th>STT</th>
      <th>Hình ảnh</th>
      <th>Tên Danh mục</th>
      <th>Trạng thái</th>
      <th>Hành động</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${listcate}" var="cate" varStatus="STT">
      <tr>
        <td>${STT.index + 1}</td>
        <td>
          <c:choose>
            <c:when test="${cate.images != null && cate.images.startsWith('https')}">
              <c:url value="${cate.images}" var="imgUrl" />
            </c:when>
            <c:otherwise>
              <c:url value="/image?fname=${cate.images}" var="imgUrl" />
            </c:otherwise>
          </c:choose>
          <img height="100" width="150" src="${imgUrl}" alt="Category Image" />
        </td>
        <td>${cate.categoryname}</td>
        <td>
          <c:if test="${cate.status == 1}">Hoạt động</c:if>
          <c:if test="${cate.status != 1}">Khóa</c:if>
        </td>
        <td>
          <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>">Sửa</a>
          | 
          <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

</body>
</html>
