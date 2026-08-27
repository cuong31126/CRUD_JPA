<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cập nhật Danh mục</title>
</head>
<body>

<h2>Cập nhật Danh mục</h2>

<form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
  <input type="hidden" name="categoryid" value="${cate.categoryid}">

  <label for="categoryname">Category name:</label><br>
  <input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" required><br><br>

  <label for="images">Link images:</label><br>
  <input type="text" id="images" name="images" value="${cate.images}"><br><br>

  <label>Ảnh hiện tại:</label><br>
  <c:choose>
    <c:when test="${cate.images != null && cate.images.startsWith('https')}">
      <c:url value="${cate.images}" var="imgUrl" />
    </c:when>
    <c:otherwise>
      <c:url value="/image?fname=${cate.images}" var="imgUrl" />
    </c:otherwise>
  </c:choose>
  <img height="100" width="150" src="${imgUrl}" alt="Category Image" /><br><br>

  <label for="images1">Upload images mới:</label><br>
  <input type="file" id="images1" name="images1"><br><br>

  <label>Status:</label><br>
  <input type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}>
  <label for="ston">Hoạt động</label><br>
  <input type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}>
  <label for="stoff">Khóa</label><br><br>

  <input type="submit" value="Update">
  <a href="<c:url value='/admin/categories'/>">Hủy</a>
</form>

</body>
</html>
