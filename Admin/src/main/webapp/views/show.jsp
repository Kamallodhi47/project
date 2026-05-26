<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4">All Orders</h2>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>Order ID</th>
                <th>User</th>
                <th>Mobile</th>
                <th>Address</th>
                <th>Payment</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Order Date</th>
                <th>Location</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="o" items="${orders}">
                <tr>
                    <td>${o.orderId}</td>
                    <td>${o.fullname}</td>
                    <td>${o.mobile}</td>
                    <td>
                        ${o.house}, ${o.area}, ${o.city}, ${o.state}, ${o.pincode}<br>
                        Landmark: ${o.landmark}
                    </td>
                    <td>${o.paymentType}</td>
                    <td>₹${o.orderAmount}</td>
                    <td>${o.status}</td>
                    <td>${o.orderDate}</td>
                    <td>
                        <a href="https://www.google.com/maps?q=${o.latitude},${o.longitude}" target="_blank">
                            📍 View Map
                        </a><br>
                        Full Address: ${o.fullAddress}<br>
                        Lat: ${o.latitude}, Lon: ${o.longitude}
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
