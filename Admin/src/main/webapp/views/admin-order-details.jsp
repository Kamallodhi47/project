<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Admin | Order Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        h1, h2 {
            color: #333;
        }
        .section {
            background-color: #fff;
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        table th, table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        table th {
            background-color: #f0f0f0;
        }
        .total {
            font-weight: bold;
            color: #000;
        }
        .status {
            font-weight: bold;
            color: green;
        }
        .cancelled {
            color: red;
        }
    </style>
</head>
<body>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<h1>Order Details (Admin)</h1>

<!-- ================= Order Info ================= -->
<div class="section">
    <h2>Order Info</h2>
    <p><b>Order ID:</b> ${order.orderId}</p>
    <p><b>Status:</b> 
        <span class="${order.status == 'CANCELLED' ? 'cancelled' : 'status'}">
            ${order.status}
        </span>
    </p>
    <p><b>Payment Status:</b> ${order.paymentId}</p>
    <p><b>Total Amount:</b> ₹${order.amount}</p>
    <p><b>Order Date:</b> <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a"/></p>
    <c:if test="${not empty order.cancelledDate}">
        <p><b>Cancelled Date:</b> <fmt:formatDate value="${order.cancelledDate}" pattern="dd MMM yyyy, hh:mm a"/></p>
        <p><b>Cancellation Reason:</b> ${order.cancellationReason}</p>
    </c:if>
</div>

<!-- ================= User Info ================= -->
<div class="section">
    <h2>User Info</h2>
    <p><b>Name:</b> ${user.name}</p>
    <p><b>Email:</b> ${user.email}</p>
    <p><b>Contact:</b> ${user.mobile}</p>
</div>

<!-- ================= Delivery Address ================= -->
<div class="section">
    <h2>Delivery Address</h2>
    <p>${address.house}, ${address.area}</p>
    <p>${address.city} - ${address.pincode}</p>
    <p>${address.state}</p>
    <p>Mobile: ${address.mobile}</p>
</div>

<!-- ================= Ordered Items ================= -->
<div class="section">
    <h2>Ordered Items</h2>
    <table>
        <thead>
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price (₹)</th>
                <th>Total (₹)</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${order.items}">
                <tr>
                    <td>${item.product.name}</td>
                    <td>${item.quantity}</td>
                    <td>${item.price}</td>
                    <td>${item.total}</td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="3" class="total">Grand Total</td>
                <td class="total">₹${order.amount}</td>
            </tr>
        </tbody>
    </table>
</div>

<!-- ================= Payment Info ================= -->
<div class="section">
    <h2>Payment Info</h2>
    <p><b>Payment ID:</b> ${order.paymentId}</p>
    <p><b>Payment Method:</b> ${order.paymentMethod != null ? order.paymentMethod : "Not Specified"}</p>
    <p><b>Payment Status:</b> ${order.paymentStatus != null ? order.paymentStatus : "Pending"}</p>
</div>

</body>
</html>
