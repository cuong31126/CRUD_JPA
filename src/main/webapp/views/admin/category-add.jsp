<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm Danh mục</title>
</head>
<body>

<h2>Thêm Danh mục Mới</h2>

<form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
  <label for="categoryname">Category name:</label><br>
  <input type="text" id="categoryname" name="categoryname" required><br><br>

  <label for="images">Link images (URL online):</label><br>
  <input type="text" id="images" name="images"><br><br>

  <label for="images1">Upload images (Từ máy tính):</label><br>
  <input type="file" id="images1" name="images1"><br><br>

  <label>Status:</label><br>
  <input type="radio" id="ston" name="status" value="1" checked>
  <label for="ston">Hoạt động</label><br>
  <input type="radio" id="stoff" name="status" value="0">
  <label for="stoff">Khóa</label><br><br>

  <input type="submit" value="Insert">
  <a href="<c:url value='/admin/categories'/>">Hủy</a>
</form>

</body>
</html>
