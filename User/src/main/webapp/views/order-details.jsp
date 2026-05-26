<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Details #${order.orderId} | FreshBasket</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/styles.css">
    <style>
        body {
            padding: 20px;
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h1 { margin-bottom: 30px; font-size: 28px; }
        .order-info { display: flex; justify-content: space-between; flex-wrap: wrap; margin-bottom: 30px; }
        .info-section { flex: 1 1 200px; margin-bottom: 15px; }
        .info-section h3 { font-size: 16px; color: #555; margin-bottom: 5px; }
        .info-section p { font-size: 18px; font-weight: bold; }
        .status.PENDING { color: #ffc107; }
        .status.CONFIRMED { color: #17a2b8; }
        .status.DELIVERED { color: #28a745; }
        .status.CANCELLED { color: #dc3545; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        table th, table td { padding: 12px 15px; border: 1px solid #dee2e6; text-align: left; }
        table th { background-color: #f1f1f1; }
        .order-actions a, .order-actions button { margin-right: 10px; margin-bottom: 10px; }
        .address-box { background: #f1f1f1; padding: 15px; border-radius: 5px; margin-bottom: 30px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Order Details #${order.orderId}</h1>

    <!-- Order Info -->
    <div class="order-info">
        <div class="info-section">
            <h3>Status</h3>
            <p class="status ${order.status}">${order.status}</p>
        </div>
        <div class="info-section">
            <h3>Order Date</h3>
            <p><fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a" /></p>
        </div>
        <div class="info-section">
            <h3>Total Amount</h3>
            <p>₹${order.grandTotal}</p>
        </div>
        <div class="info-section">
            <h3>Payment ID</h3>
            <p>${order.paymentId}</p>
        </div>
    </div>

    <!-- Delivery Address -->
    <div class="address-box">
        <h3>Delivery Address</h3>
        <p>${address.house}, ${address.area}</p>
        <p>${address.city} - ${address.pincode}, ${address.state}</p>
        <p>Mobile: ${address.mobile}</p>
    </div>

    <!-- Order Items -->
    <div class="order-items">
        <h3>Items in Your Order</h3>
        <table>
            <thead>
            <tr>
                <th>Product</th>
                <th>Qty</th>
                <th>Price (₹)</th>
                <th>Total (₹)</th>
            </tr>
            </thead>
            <tbody>
				<c:forEach var="item" items="${order.items}">
				    <tr>
				        <td>${item.productName}</td>
				        <td>${item.quantity}</td>
				        <td>${item.price}</td>
				        <td>${item.total}</td>
				    </tr>
				</c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Actions -->
    <div class="order-actions">
        <a href="/order/track/${order.orderId}" class="btn btn-primary">Track Order</a>
        <a href="/order/invoice/${order.orderId}" class="btn btn-secondary">Download Invoice</a>

        <c:if test="${order.status == 'PENDING'}">
            <button onclick="cancelOrder('${order.orderId}')" class="btn btn-danger">Cancel Order</button>
        </c:if>

        <c:if test="${order.status == 'DELIVERED'}">
            <button onclick="rateOrder('${order.orderId}')" class="btn btn-success">Rate Order</button>
        </c:if>
    </div>
</div>

<!-- Scripts -->
<script>
    function cancelOrder(orderId) {
        if(confirm('Are you sure you want to cancel this order?')) {
            const reason = prompt('Please enter reason for cancellation:');
            if(reason) {
                fetch('/order/cancel', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ orderId, reason })
                })
                .then(res => res.json())
                .then(data => {
                    if(data.success) { alert('Order cancelled successfully'); location.reload(); }
                    else { alert('Error: ' + data.message); }
                });
            }
        }
    }

    function rateOrder(orderId) {
        const rating = prompt('Rate your order (1-5 stars):');
        if(rating && rating >= 1 && rating <= 5) {
            const review = prompt('Please share your experience:');
            fetch('/order/rate', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ orderId, rating, review })
            })
            .then(res => res.json())
            .then(data => {
                if(data.success) { alert('Thank you for your feedback!'); }
                else { alert('Error: ' + data.message); }
            });
        }
    }
</script>
</body>
</html>
