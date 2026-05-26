<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Products</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        table img {
            height: 70px;
            width: 70px;
            object-fit: contain;
            border-radius: 5px;
        }
    </style>
</head>

<body class="bg-light">

<div class="container py-4">

    <!-- Success / Error Messages -->
    <c:if test="${not empty succMsg}">
        <div class="alert alert-success">${succMsg}</div>
        <c:remove var="succMsg"/>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">${errorMsg}</div>
        <c:remove var="errorMsg"/>
    </c:if>

    <h3 class="text-center mb-4">All Products</h3>

    <table class="table table-bordered table-striped text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Image</th>
            <th>Title</th>
            <th>Category</th>
            <th>Price</th>
            <th>Discount (%)</th>
            <th>Final Price</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="p" items="${products}">
            <tr>
                <td>${p.id}</td>

                <!-- Product Image -->
                <td>
                    <img src="${pageContext.request.contextPath}/assets/img/product_img/${p.image}"
                         alt="${p.title}">
                </td>

                <td>${p.title}</td>
                <td>${p.category}</td>
                <td>₹ ${p.price}</td>
                <td>${p.discount}%</td>
                <td>₹ ${p.discountPrice}</td>

                <td>
                    <!-- FIXED: boolean check without == -->
                    <c:choose>
                        <c:when test="${p.active}">
                            <span class="badge bg-success">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <a href="editProduct/${p.id}" class="btn btn-sm btn-primary">Edit</a>
                    <a href="deleteProduct/${p.id}" class="btn btn-sm btn-danger"
                       onclick="return confirm('Are you sure?');">
                        Delete
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>

    </table>

</div>

</body>
</html>
