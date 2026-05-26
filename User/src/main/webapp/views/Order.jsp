<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        h1 {
            margin-bottom: 10px;
        }
        .summary {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .card {
            background: #fff;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            flex: 1;
        }
        .orders-section {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background: #f0f0f0;
        }
        .status {
            font-weight: bold;
        }
        .PENDING { color: orange; }
        .CONFIRMED { color: blue; }
        .PROCESSING { color: purple; }
        .DELIVERED { color: green; }
        .CANCELLED { color: red; }

        .btn {
            padding: 6px 12px;
            background: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 13px;
        }
    </style>
</head>
<body>

<h1>My Orders</h1>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<div class="summary">
    <div class="card">
        <h3>Total Orders</h3>
        <p>${totalOrders}</p>
    </div>
    <div class="card">
        <h3>Pending Orders</h3>
        <p>${pendingCount}</p>
    </div>
    <div class="card">
        <h3>Delivered Orders</h3>
        <p>${deliveredCount}</p>
    </div>
</div>

<!-- ========== All Orders ========== -->
<div class="orders-section">
    <h2>All Orders</h2>

    <c:if test="${empty allOrders}">
        <p>No orders found.</p>
    </c:if>

    <c:if test="${not empty allOrders}">
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Total Amount</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${allOrders}">
                    <tr>
                        <td>${o.orderId}</td>
                        <td>
                            <fmt:formatDate value="${o.orderDate}" pattern="dd MMM yyyy"/>
                        </td>
                        <td class="status ${o.status}">${o.status}</td>
                        <td>₹${o.amount}</td>
                        <td>
                            <a class="btn" href="${pageContext.request.contextPath}/Order/details/${o.orderId}">
                                View Details
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

</body>
</html>
