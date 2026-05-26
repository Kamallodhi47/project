<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Orders | Premium Store</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f5f7fa; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; vertical-align: top; }
        th { background-color: #f2f2f2; }
        .status-badge { padding: 5px 10px; border-radius: 5px; color: white; font-weight: 500; }
        .status-pending { background-color: orange; }
        .status-delivered { background-color: green; }
        .btn-view, .btn-update { padding: 5px 10px; text-decoration: none; margin-right: 5px; border-radius: 5px; color: white; }
        .btn-view { background-color: #2196F3; }
        .btn-update { background-color: #4CAF50; }
        .pagination a, .pagination strong { margin: 0 3px; text-decoration: none; }
    </style>
</head>
<body>
<div class="container py-4">

    <h2 class="mb-4">Admin Orders</h2>

    <!-- Search / Filter Form -->
    <form method="get" action="/adminorders" class="row g-3 mb-3">
        <div class="col-md-3">
            <input type="text" name="search" value="${searchParam}" class="form-control" placeholder="Search by customer or ID">
        </div>
        <div class="col-md-2">
            <select name="status" class="form-control">
                <option value="">All Status</option>
                <option value="PENDING" ${statusParam=='PENDING' ? 'selected' : ''}>Pending</option>
                <option value="DELIVERED" ${statusParam=='DELIVERED' ? 'selected' : ''}>Delivered</option>
            </select>
        </div>
        <div class="col-md-3">
            <input type="text" name="dateRange" value="${dateRange}" class="form-control" placeholder="yyyy-mm-dd - yyyy-mm-dd">
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Filter</button>
        </div>
    </form>

    <!-- Orders Table -->
    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Order Date</th>
            <th>Items</th>
            <th>Total Amount</th>
            <th>Payment Status</th>
            <th>Order Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <!-- Order ID -->
                <td>#${order.id}</td>

                <!-- Customer Info -->
                <td>
                    <strong>${order.user.name}</strong><br/>
                    ${order.user.email}<br/>
                    ${order.user.mobileNumber}
                </td>

                <!-- Order Date -->
                <td>
                    <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy"/><br/>
                    <small><fmt:formatDate value="${order.orderDate}" pattern="hh:mm a"/></small>
                </td>

                <!-- Items -->
                <td>
                    <c:forEach var="item" items="${order.items}">
                        ${item.productName} × ${item.quantity} (₹ ${item.total})<br/>
                    </c:forEach>
                </td>

                <!-- Total Amount -->
                <td>₹ ${order.grandTotal}</td>

                <!-- Payment Status -->
                <td>
                    <c:choose>
                        <c:when test="${order.status == 'DELIVERED'}">
                            <span class="status-badge status-delivered">Paid</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge status-pending">Pending</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <!-- Order Status -->
                <td>
                    <c:choose>
                        <c:when test="${order.status == 'PENDING'}">
                            <button class="btn btn-warning btn-sm" onclick="updateStatus(${order.id}, 'DELIVERED')">Mark Delivered</button>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge status-delivered">${order.status}</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <!-- Actions -->
                <td>
                    <a href="/adminorders/view/${order.id}" class="btn-view btn btn-primary btn-sm">View</a>
                    <a href="/adminorders/update/${order.id}" class="btn-update btn btn-success btn-sm">Update</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Pagination -->
    <div class="pagination mt-3">
        <c:forEach begin="0" end="${totalPages - 1}" var="i">
            <c:choose>
                <c:when test="${i == pageNo}">
                    <strong>${i+1}</strong>
                </c:when>
                <c:otherwise>
                    <a href="?pageNo=${i}&pageSize=10&search=${searchParam}&status=${statusParam}&dateRange=${dateRange}">${i+1}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>

</div>

<!-- AJAX: Update Status -->
<script>
function updateStatus(orderId, newStatus) {
    if(!confirm("Are you sure to mark this order as delivered?")) return;
    
    fetch('/adminorders/updateStatus?orderId=' + orderId + '&status=' + newStatus, {
        method: 'POST'
    }).then(response => response.text())
      .then(result => {
          if(result === 'success'){
              alert('Order status updated successfully!');
              location.reload();
          } else {
              alert('Failed to update order status!');
          }
      }).catch(err => console.error(err));
}
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
