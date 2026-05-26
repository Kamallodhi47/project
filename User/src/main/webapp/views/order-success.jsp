<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Success - MilkBasket</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: #fdf6f0;
        }
        .success-card {
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            padding: 30px;
            background: #ffffff;
            text-align: center;
            animation: fadeIn 1s ease-out;
        }
        .success-icon {
            font-size: 60px;
            color: #4BB543;
            margin-bottom: 20px;
            animation: pop 0.6s ease-out;
        }
        @keyframes pop {
            0% { transform: scale(0.5); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }
        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(-20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        table th {
            width: 35%;
        }
        .btn-primary {
            background: #FF6F61;
            border: none;
        }
        .btn-primary:hover {
            background: #ff856f;
        }
        .btn-secondary {
            border-radius: 50px;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <div class="success-card">
                <div class="success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h2 class="fw-bold mb-2">Payment Successful!</h2>
                <p class="text-muted mb-4">Thank you for your purchase, <strong>${order.userName}</strong>!</p>

                <!-- Order Details -->
                <h5 class="mb-3">Order Details</h5>
                <table class="table table-borderless text-start mx-auto" style="max-width: 500px;">
                    <tr>
                        <th>Order ID:</th>
                        <td>${order.orderId}</td>
                    </tr>
                    <tr>
                        <th>Payment ID:</th>
                        <td>${order.paymentId}</td>
                    </tr>
                    <tr>
                        <th>Amount Paid:</th>
                        <td>₹ ${order.amount}</td>
                    </tr>
                    <tr>
                        <th>Order Date:</th>
                        <td>${order.orderDate}</td>
                    </tr>
                </table>

                <!-- Delivery Address -->
                <c:if test="${not empty location}">
                    <h5 class="mb-3 mt-4">Delivery Address</h5>
                    <table class="table table-borderless text-start mx-auto" style="max-width: 500px;">
                        <tr>
                            <th>House / Flat:</th>
                            <td>${location.house}</td>
                        </tr>
                        <tr>
                            <th>Area:</th>
                            <td>${location.area}</td>
                        </tr>
                        <tr>
                            <th>Landmark:</th>
                            <td>${location.landmark}</td>
                        </tr>
                        <tr>
                            <th>City:</th>
                            <td>${location.city}</td>
                        </tr>
                        <tr>
                            <th>State:</th>
                            <td>${location.state}</td>
                        </tr>
                        <tr>
                            <th>Pincode:</th>
                            <td>${location.pincode}</td>
                        </tr>
                        <tr>
                            <th>Mobile:</th>
                            <td>${location.mobile}</td>
                        </tr>
                    </table>
                </c:if>

                <!-- Buttons -->
                <div class="mt-4 d-flex justify-content-center gap-3">
                    <a href="${pageContext.request.contextPath}/Order" class="btn btn-primary px-4 py-2">
                        <i class="fas fa-shopping-bag me-2"></i>My Orders
                    </a>
                    <a href="${pageContext.request.contextPath}/Order/details/${order.orderId}" class="btn btn-secondary px-4 py-2">
                        <i class="fas fa-home me-2"></i>Home
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Font Awesome -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>
