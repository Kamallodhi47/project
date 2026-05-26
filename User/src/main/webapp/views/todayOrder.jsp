<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recent Orders</title>

<style>
body {
    font-family: Arial, sans-serif;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}
th, td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: left;
}
th {
    background-color: #f2f2f2;
}
</style>
</head>

<body>

<h2>🕒 Recent Orders (Today)</h2>

<c:if test="${empty todayOrders}">
    <p>No orders placed today.</p>
</c:if>

<c:if test="${not empty todayOrders}">
<table>
    <tr>
        <th>Order ID</th>
        <th>Status</th>
        <th>Total Amount</th>
        <th>Order Time</th>
    </tr>
	<c:forEach var="order" items="${todayOrders}">
		<tr>
		    <td>${order.id}</td>
		    <td>${order.status}</td>
		    <td>₹ ${order.grandTotal}</td>
		    <td>${order.orderDate}</td>
		</tr>
		</c:forEach>
</table>
</c:if>

<br>
<a href="/Order">⬅ Back to All Orders</a>

</body>
</html>
