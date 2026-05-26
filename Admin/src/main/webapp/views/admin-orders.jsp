<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Orders - Latest First</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Datepicker CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
    
    <style>
        .order-card {
            border-left: 4px solid #0d6efd;
            transition: all 0.3s;
            margin-bottom: 15px;
        }
        .order-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 25px;
            font-weight: 500;
        }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-confirmed { background-color: #d1ecf1; color: #0c5460; }
        .status-shipped { background-color: #cce5ff; color: #004085; }
        .status-delivered { background-color: #d4edda; color: #155724; }
        .status-cancelled { background-color: #f8d7da; color: #721c24; }
        .product-img-small {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }
        .filter-section {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .order-details {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-top: 10px;
        }
        .collapse-icon {
            transition: transform 0.3s;
        }
        .collapse-icon.rotated {
            transform: rotate(180deg);
        }
        .timeline-step {
            text-align: center;
            position: relative;
            flex: 1;
        }
        .timeline-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 5px;
            color: #6c757d;
        }
        .timeline-step.active .timeline-icon {
            background-color: #0d6efd;
            color: white;
        }
        .timeline-connector {
            flex: 1;
            height: 2px;
            background-color: #e9ecef;
            margin-top: 15px;
        }
        .timeline-step.active ~ .timeline-connector {
            background-color: #0d6efd;
        }
        .timeline-step.active {
            font-weight: bold;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .action-buttons .btn {
            flex: 1;
            min-width: 150px;
        }
        .empty-state {
            text-align: center;
            padding: 50px 20px;
        }
        .empty-state i {
            font-size: 48px;
            color: #6c757d;
            margin-bottom: 20px;
        }
        .toast-container {
            z-index: 9999;
        }
        .latest-order {
            border-left: 4px solid #ff6b6b;
            background-color: #fff9f9;
        }
        .order-date-badge {
            background-color: #0d6efd;
            color: white;
            padding: 4px 3px;
            border-radius: 4px;
            font-size: 12px;
        }
        .quick-actions {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 10;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2><i class="fas fa-shopping-bag me-2"></i>Orders Management</h2>
                <p class="text-muted mb-0"><i class="fas fa-sort-amount-down me-1"></i> Latest orders shown first</p>
            </div>
            <div>
                <span class="badge bg-primary fs-6">
                    <i class="fas fa-box me-1"></i> Total Orders: ${totalElements}
                </span>
            </div>
        </div>

        <!-- Filters Section -->
        <div class="filter-section">
            <form method="get" action="/adminorders" class="row g-3">
                <div class="col-md-3">
                    <label class="form-label"><i class="fas fa-search me-1"></i> Search</label>
                    <input type="text" class="form-control" name="search" 
                           value="${searchParam}" placeholder="Order ID, Customer Name...">
                </div>
                <div class="col-md-2">
                    <label class="form-label"><i class="fas fa-tag me-1"></i> Status</label>
                    <select class="form-select" name="status">
                        <option value="">All Status</option>
                        <option value="PENDING" ${statusParam == 'PENDING' ? 'selected' : ''}>Pending</option>
                        <option value="CONFIRMED" ${statusParam == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                        <option value="SHIPPED" ${statusParam == 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                        <option value="DELIVERED" ${statusParam == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                        <option value="CANCELLED" ${statusParam == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label"><i class="far fa-calendar-alt me-1"></i> Date Range</label>
                    <input type="text" class="form-control" id="dateRangePicker" name="dateRange" 
                           value="${dateRange}" placeholder="Select date range">
                </div>
                <div class="col-md-2">
                    <label class="form-label"><i class="fas fa-list-ol me-1"></i> Items per page</label>
                    <select class="form-select" name="pageSize">
                        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                        <option value="25" ${pageSize == 25 ? 'selected' : ''}>25</option>
                        <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                        <option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <div class="d-flex gap-2 w-100">
                        <button type="submit" class="btn btn-primary w-50">
                            <i class="fas fa-filter me-1"></i> Filter
                        </button>
                        <a href="/adminorders" class="btn btn-outline-secondary w-50">
                            <i class="fas fa-times me-1"></i> Clear
                        </a>
                    </div>
                </div>
            </form>
        </div>

        <!-- Quick Stats -->
        <div class="row mb-4">
            <div class="col-md-2 col-6">
                <div class="card text-center">
                    <div class="card-body py-3">
                        <h5 class="card-title text-warning">${pendingCount != null ? pendingCount : '0'}</h5>
                        <p class="card-text text-muted mb-0">Pending</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="card text-center">
                    <div class="card-body py-3">
                        <h5 class="card-title text-info">${confirmedCount != null ? confirmedCount : '0'}</h5>
                        <p class="card-text text-muted mb-0">Confirmed</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="card text-center">
                    <div class="card-body py-3">
                        <h5 class="card-title text-primary">${shippedCount != null ? shippedCount : '0'}</h5>
                        <p class="card-text text-muted mb-0">Shipped</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="card text-center">
                    <div class="card-body py-3">
                        <h5 class="card-title text-success">${deliveredCount != null ? deliveredCount : '0'}</h5>
                        <p class="card-text text-muted mb-0">Delivered</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="card text-center">
                    <div class="card-body py-3">
                        <h5 class="card-title text-danger">${cancelledCount != null ? cancelledCount : '0'}</h5>
                        <p class="card-text text-muted mb-0">Cancelled</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="card text-center">
                    <div class="card-body py-3">
                        <h5 class="card-title">${totalElements}</h5>
                        <p class="card-text text-muted mb-0">Total</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Orders List -->
        <c:choose>
            <c:when test="${empty orders}">
                <div class="empty-state">
                    <i class="fas fa-box-open"></i>
                    <h4 class="text-muted">No orders found</h4>
                    <p class="text-muted">Try changing your filters or check back later.</p>
                    <a href="/adminorders" class="btn btn-primary">
                        <i class="fas fa-sync-alt me-1"></i> Reset Filters
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row mb-3">
                    <div class="col">
                        <p class="text-muted mb-0">
                            <i class="fas fa-info-circle me-1"></i>
                            Showing ${pageNo * pageSize + 1} to 
                            ${(pageNo * pageSize + pageSize) > totalElements ? totalElements : (pageNo * pageSize + pageSize)} 
                            of ${totalElements} orders (Latest first)
                        </p>
                    </div>
                </div>

                <c:forEach var="order" items="${orders}" varStatus="loop">
                    <div class="card order-card ${loop.index == 0 ? 'latest-order' : ''}">
                        <div class="card-body">
                            <!-- Order Header with Quick Actions -->
                            <div class="quick-actions">
                                <span class="order-date-badge">
                                    <i class="far fa-clock me-1"></i>${order.orderDate}
                                </span>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-start">
                                <div style="flex: 1;">
                                    <h5 class="card-title mb-1">
                                        <i class="fas fa-hashtag me-1"></i>Order #${order.orderId}
                                        <c:if test="${loop.index == 0}">
                                            <span class="badge bg-danger ms-2">LATEST</span>
                                        </c:if>
                                        <span class="badge bg-secondary ms-2 fs-6">
                                            <i class="fas fa-credit-card me-1"></i>${order.paymentId}
                                        </span>
                                    </h5>
                                    <p class="text-muted mb-1">
                                        <i class="far fa-calendar me-1"></i>
                                        Ordered: ${order.orderDate}
                                    </p>
                                    <p class="mb-0">
                                        <i class="fas fa-user me-1"></i>
                                        <strong>${order.userName}</strong>
                                        <c:if test="${not empty order.user.mobileNumber}">
                                            <span class="ms-3">
                                                <i class="fas fa-phone me-1"></i>
                                                ${order.user.mobileNumber}
                                            </span>
                                        </c:if>
                                    </p>
                                </div>
                                <div class="text-end" style="min-width: 200px;">
                                    <div class="mb-2">
                                        <span class="status-badge status-${fn:toLowerCase(order.status)}">
                                            <c:choose>
                                                <c:when test="${order.status == 'PENDING'}">
                                                    <i class="fas fa-clock me-1"></i>
                                                </c:when>
                                                <c:when test="${order.status == 'CONFIRMED'}">
                                                    <i class="fas fa-check-circle me-1"></i>
                                                </c:when>
                                                <c:when test="${order.status == 'SHIPPED'}">
                                                    <i class="fas fa-shipping-fast me-1"></i>
                                                </c:when>
                                                <c:when test="${order.status == 'DELIVERED'}">
                                                    <i class="fas fa-home me-1"></i>
                                                </c:when>
                                                <c:when test="${order.status == 'CANCELLED'}">
                                                    <i class="fas fa-times-circle me-1"></i>
                                                </c:when>
                                            </c:choose>
                                            ${order.status}
                                        </span>
                                    </div>
                                    <c:if test="${not empty order.deliveredDate}">
                                        <div class="text-success small mb-1">
                                            <i class="fas fa-calendar-check me-1"></i>
                                            Delivered: ${order.deliveredDate}
                                        </div>
                                    </c:if>
                                    <h4 class="text-primary mt-1">₹${order.grandTotal}</h4>
                                    <div class="action-buttons mt-2">
                                        <button class="btn btn-sm btn-outline-primary" 
                                                type="button" 
                                                data-bs-toggle="collapse" 
                                                data-bs-target="#orderDetails${order.id}"
                                                onclick="rotateIcon(${order.id})">
                                            <i id="icon${order.id}" class="fas fa-chevron-down collapse-icon me-1"></i>
                                            Details
                                        </button>
                                        <a href="/invoice/${order.id}" class="btn btn-sm btn-outline-success" target="_blank">
                                            <i class="fas fa-file-invoice me-1"></i> Invoice
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- QUICK ACTION BUTTONS (ALWAYS VISIBLE) -->
                            <div class="row mt-3">
                                <div class="col">
                                    <div class="d-flex gap-2 flex-wrap">
                                        <!-- PENDING -> CONFIRM -->
                                        <c:if test="${order.status == 'PENDING'}">
                                            <button class="btn btn-success btn-sm" 
                                                    onclick="confirmOrder(${order.id})">
                                                <i class="fas fa-check me-1"></i> Confirm Order
                                            </button>
                                            <button class="btn btn-danger btn-sm" 
                                                    onclick="showCancelModal(${order.id})">
                                                <i class="fas fa-times me-1"></i> Cancel Order
                                            </button>
                                        </c:if>
                                        
                                        <!-- CONFIRMED -> SHIP -->
                                        <c:if test="${order.status == 'CONFIRMED'}">
                                            <button class="btn btn-info btn-sm" 
                                                    onclick="shipOrder(${order.id})">
                                                <i class="fas fa-shipping-fast me-1"></i> Mark as Shipped
                                            </button>
                                            <button class="btn btn-danger btn-sm" 
                                                    onclick="showCancelModal(${order.id})">
                                                <i class="fas fa-times me-1"></i> Cancel Order
                                            </button>
                                        </c:if>
                                        
                                        <!-- SHIPPED -> DELIVER -->
                                        <c:if test="${order.status == 'SHIPPED'}">
                                            <button class="btn btn-success btn-sm" 
                                                    onclick="deliverOrder(${order.id})">
                                                <i class="fas fa-home me-1"></i> Mark as Delivered
                                            </button>
                                        </c:if>
                                        
                                        <!-- DELIVERED (Completed) -->
                                        <c:if test="${order.status == 'DELIVERED'}">
                                            <button class="btn btn-secondary btn-sm" disabled>
                                                <i class="fas fa-check-circle me-1"></i> Order Completed
                                            </button>
                                        </c:if>
                                        
                                        <!-- CANCELLED -->
                                        <c:if test="${order.status == 'CANCELLED'}">
                                            <button class="btn btn-secondary btn-sm" disabled>
                                                <i class="fas fa-ban me-1"></i> Order Cancelled
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <!-- Order Details (Collapsible) -->
                            <div class="collapse" id="orderDetails${order.id}">
                                <div class="order-details mt-3">
                                    
                                    <!-- Order Items Table -->
                                    <h6 class="mb-3">
                                        <i class="fas fa-box me-2"></i>Order Items 
                                        <span class="badge bg-secondary ms-2">${order.items.size()} items</span>
                                    </h6>
                                    <div class="table-responsive">
                                        <table class="table table-sm table-bordered">
                                            <thead class="table-light">
                                                <tr>
                                                    <th width="60">Image</th>
                                                    <th>Product</th>
                                                    <th width="100">Price</th>
                                                    <th width="80">Qty</th>
                                                    <th width="120">Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${order.items}" varStatus="status">
                                                    <tr>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty item.productImage}">
                                                                    <img src="${item.productImage}" 
                                                                         alt="${item.productName}"
                                                                         class="product-img-small"
                                                                         onerror="this.onerror=null; this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAiIGhlaWdodD0iNTAiIHZpZXdCb3g9IjAgMCA1MCA1MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iNTAiIGhlaWdodD0iNTAiIGZpbGw9IiNFNUU1RTUiLz48cGF0aCBkPSJNMzUgMzVIMTVDMTMuODk1NCAzNSAxMyAzNC4xMDQ2IDEzIDMzVjE3QzEzIDE1Ljg5NTQgMTMuODk1NCAxNSAxNSAxNUgzNUMzNi4xMDQ2IDE1IDM3IDE1Ljg5NTQgMzcgMTdWMzNDMzcgMzQuMTA0NiAzNi4xMDQ2IDM1IDM1IDM1WiIgc3Ryb2tlPSIjQkRCREJEIiBzdHJva2Utd2lkdGg9IjIiLz48cGF0aCBkPSJNMjAgMjIuNUMxOC4wNzExIDIyLjUgMTYuNSAyMC45Mjg5IDE2LjUgMTlDMTYuNSAxNy4wNzExIDE4LjA3MTEgMTUuNSAyMCAxNS41QzIxLjkyODkgMTUuNSAyMy41IDE3LjA3MTEgMjMuNSAxOUMyMy41IDIwLjkyODkgMjEuOTI4OSAyMi41IDIwIDIyLjVaIiBzdHJva2U9IiNCREJEQkQiIHN0cm9rZS13aWR0aD0iMiIvPjxwYXRoIGQ9Ik0yNS41IDMwTDE1LjUgMjVMMjAuNSAzMEwyOC41IDI1TDM0LjUgMzAiIHN0cm9rZT0iI0JEQkRCRCIgc3Ryb2tlLXdpZHRoPSIyIi8+PC9zdmc+'">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="product-img-small bg-light d-flex align-items-center justify-content-center">
                                                                        <i class="fas fa-image text-muted"></i>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <strong>${item.productName}</strong><br>
                                                            <small class="text-muted">Product ID: ${item.productId}</small>
                                                        </td>
                                                        <td>₹${item.price}</td>
                                                        <td>
                                                            <span class="badge bg-primary">${item.quantity}</span>
                                                        </td>
                                                        <td><strong>₹${item.total}</strong></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot class="table-light">
                                                <tr>
                                                    <td colspan="3"></td>
                                                    <td class="text-end"><strong>Subtotal:</strong></td>
                                                    <td><strong>₹${order.amount}</strong></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3"></td>
                                                    <td class="text-end"><strong>Total:</strong></td>
                                                    <td><strong>₹${order.grandTotal}</strong></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>

                                    <!-- Status Timeline -->
                                    <div class="mt-4">
                                        <h6><i class="fas fa-history me-2"></i>Order Status Timeline</h6>
                                        <div class="d-flex align-items-center mt-3">
                                            <div class="timeline-step ${order.status == 'PENDING' || order.status == 'CONFIRMED' || order.status == 'SHIPPED' || order.status == 'DELIVERED' ? 'active' : ''}">
                                                <div class="timeline-icon">
                                                    <i class="fas fa-clock"></i>
                                                </div>
                                                <small>Pending</small>
                                                <c:if test="${order.status == 'PENDING'}">
                                                    <div class="mt-1">
                                                        <button class="btn btn-success btn-xs" 
                                                                onclick="confirmOrder(${order.id})">
                                                            Confirm
                                                        </button>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="timeline-connector"></div>
                                            <div class="timeline-step ${order.status == 'CONFIRMED' || order.status == 'SHIPPED' || order.status == 'DELIVERED' ? 'active' : ''}">
                                                <div class="timeline-icon">
                                                    <i class="fas fa-check-circle"></i>
                                                </div>
                                                <small>Confirmed</small>
                                                <c:if test="${not empty order.confirmedDate}">
                                                    <br><small class="text-muted">${order.confirmedDate}</small>
                                                </c:if>
                                                <c:if test="${order.status == 'CONFIRMED'}">
                                                    <div class="mt-1">
                                                        <button class="btn btn-info btn-xs" 
                                                                onclick="shipOrder(${order.id})">
                                                            Ship
                                                        </button>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="timeline-connector"></div>
                                            <div class="timeline-step ${order.status == 'SHIPPED' || order.status == 'DELIVERED' ? 'active' : ''}">
                                                <div class="timeline-icon">
                                                    <i class="fas fa-shipping-fast"></i>
                                                </div>
                                                <small>Shipped</small>
                                                <c:if test="${order.status == 'SHIPPED'}">
                                                    <div class="mt-1">
                                                        <button class="btn btn-success btn-xs" 
                                                                onclick="deliverOrder(${order.id})">
                                                            Deliver
                                                        </button>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="timeline-connector"></div>
                                            <div class="timeline-step ${order.status == 'DELIVERED' ? 'active' : ''}">
                                                <div class="timeline-icon">
                                                    <i class="fas fa-home"></i>
                                                </div>
                                                <small>Delivered</small>
                                                <c:if test="${not empty order.deliveredDate}">
                                                    <br><small class="text-muted">${order.deliveredDate}</small>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Additional Info -->
                                    <div class="row mt-4">
                                        <c:if test="${not empty order.review}">
                                            <div class="col-md-6 mb-3">
                                                <div class="card h-100">
                                                    <div class="card-body">
                                                        <h6><i class="fas fa-star me-2"></i>Customer Review</h6>
                                                        <div class="d-flex align-items-center mb-2">
                                                            <c:forEach begin="1" end="5" var="i">
                                                                <i class="fas fa-star ${i <= order.rating ? 'text-warning' : 'text-muted'}"></i>
                                                            </c:forEach>
                                                            <span class="ms-2">(${order.rating}/5)</span>
                                                        </div>
                                                        <p class="mb-0">"${order.review}"</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        
                                        <c:if test="${order.status == 'CANCELLED'}">
                                            <div class="col-md-6 mb-3">
                                                <div class="card border-danger h-100">
                                                    <div class="card-body">
                                                        <h6><i class="fas fa-times-circle me-2 text-danger"></i>Cancellation Details</h6>
                                                        <p class="mb-1"><strong>Reason:</strong> ${order.cancellationReason}</p>
                                                        <p class="mb-0"><strong>Cancelled on:</strong> ${order.cancelledDate}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <!-- First Page -->
                    <li class="page-item ${pageNo == 0 ? 'disabled' : ''}">
                        <a class="page-link" href="?pageNo=0&pageSize=${pageSize}&search=${searchParam}&status=${statusParam}&dateRange=${dateRange}">
                            <i class="fas fa-angle-double-left"></i>
                        </a>
                    </li>
                    
                    <!-- Previous Page -->
                    <li class="page-item ${pageNo == 0 ? 'disabled' : ''}">
                        <a class="page-link" href="?pageNo=${pageNo-1}&pageSize=${pageSize}&search=${searchParam}&status=${statusParam}&dateRange=${dateRange}">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </li>
                    
                    <!-- Page Numbers -->
                    <c:set var="startPage" value="${pageNo - 2}"/>
                    <c:set var="endPage" value="${pageNo + 2}"/>
                    
                    <c:if test="${startPage < 0}">
                        <c:set var="endPage" value="${endPage - startPage}"/>
                        <c:set var="startPage" value="0"/>
                    </c:if>
                    
                    <c:if test="${endPage > totalPages - 1}">
                        <c:set var="startPage" value="${startPage - (endPage - totalPages + 1)}"/>
                        <c:if test="${startPage < 0}">
                            <c:set var="startPage" value="0"/>
                        </c:if>
                        <c:set var="endPage" value="${totalPages - 1}"/>
                    </c:if>
                    
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li class="page-item ${i == pageNo ? 'active' : ''}">
                            <a class="page-link" href="?pageNo=${i}&pageSize=${pageSize}&search=${searchParam}&status=${statusParam}&dateRange=${dateRange}">
                                ${i+1}
                            </a>
                        </li>
                    </c:forEach>
                    
                    <!-- Next Page -->
                    <li class="page-item ${pageNo == totalPages-1 ? 'disabled' : ''}">
                        <a class="page-link" href="?pageNo=${pageNo+1}&pageSize=${pageSize}&search=${searchParam}&status=${statusParam}&dateRange=${dateRange}">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                    
                    <!-- Last Page -->
                    <li class="page-item ${pageNo == totalPages-1 ? 'disabled' : ''}">
                        <a class="page-link" href="?pageNo=${totalPages-1}&pageSize=${pageSize}&search=${searchParam}&status=${statusParam}&dateRange=${dateRange}">
                            <i class="fas fa-angle-double-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>

    <!-- Cancel Order Modal -->
    <div class="modal fade" id="cancelModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle me-2"></i>Cancel Order
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-warning">
                        <i class="fas fa-info-circle me-2"></i>
                        This action cannot be undone. The customer will be notified.
                    </div>
                    <input type="hidden" id="cancelOrderId">
                    <div class="mb-3">
                        <label class="form-label">Reason for Cancellation <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="cancellationReason" rows="3" 
                                  placeholder="Enter reason for cancellation..." required></textarea>
                        <div class="form-text">Please provide a clear reason for cancellation.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i> Close
                    </button>
                    <button type="button" class="btn btn-danger" onclick="processCancelOrder()">
                        <i class="fas fa-ban me-1"></i> Cancel Order
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Date Range Picker -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    
    <script>
        // Initialize date range picker
        $(function() {
            $('#dateRangePicker').daterangepicker({
                autoUpdateInput: false,
                locale: {
                    format: 'YYYY-MM-DD',
                    cancelLabel: 'Clear'
                }
            });
            
            $('#dateRangePicker').on('apply.daterangepicker', function(ev, picker) {
                $(this).val(picker.startDate.format('YYYY-MM-DD') + ' - ' + picker.endDate.format('YYYY-MM-DD'));
            });
            
            $('#dateRangePicker').on('cancel.daterangepicker', function(ev, picker) {
                $(this).val('');
            });
        });
        
        function rotateIcon(orderId) {
            const icon = document.getElementById('icon' + orderId);
            icon.classList.toggle('rotated');
        }

        let currentOrderId = null;

        function showCancelModal(orderId) {
            currentOrderId = orderId;
            document.getElementById('cancelOrderId').value = orderId;
            document.getElementById('cancellationReason').value = '';
            const modal = new bootstrap.Modal(document.getElementById('cancelModal'));
            modal.show();
        }

        // ✅ CONFIRM ORDER
        function confirmOrder(orderId) {
            if (confirm('Confirm this order?')) {
                updateStatus(orderId, 'CONFIRMED');
            }
        }

        // ✅ SHIP ORDER
        function shipOrder(orderId) {
            if (confirm('Mark this order as shipped?')) {
                updateStatus(orderId, 'SHIPPED');
            }
        }

        // ✅ DELIVER ORDER
        function deliverOrder(orderId) {
            if (confirm('Mark this order as delivered?')) {
                updateStatus(orderId, 'DELIVERED');
            }
        }

        // ✅ CANCEL ORDER
        function processCancelOrder() {
            const orderId = currentOrderId;
            const reason = document.getElementById('cancellationReason').value;
            
            if (!reason.trim()) {
                showToast('Please enter cancellation reason', 'error');
                return;
            }
            
            updateStatus(orderId, 'CANCELLED', reason);
            bootstrap.Modal.getInstance(document.getElementById('cancelModal')).hide();
        }

        // ✅ UNIVERSAL STATUS UPDATE FUNCTION
		function updateStatus(orderId, status, cancellationReason = null) {
		    const formData = new FormData();
		    formData.append('orderId', orderId);      // ✅ orderId must be an integer
		    formData.append('status', status);
		    if (cancellationReason) formData.append('cancellationReason', cancellationReason);

             fetch('/update', {
                method: 'POST',
                body: formData
            })
            .then(response => response.text())
			.then(result => {
			    result = result.trim();   // ⭐ IMPORTANT

			    if (result === 'success') {
			        showToast('Order status updated successfully!', 'success');
			        setTimeout(() => location.reload(), 1000);
			    } else {
			        showToast(result, 'error');
			    }
			})

            .catch(error => {
                showToast('Network error: ' + error.message, 'error');
            });
        }

        function sendNotification(orderId) {
            fetch('/api/orders/' + orderId + '/notify', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    message: 'Your order status has been updated'
                })
            })
            .then(response => {
                if (response.ok) {
                    showToast('Notification sent successfully', 'success');
                } else {
                    showToast('Failed to send notification', 'error');
                }
            });
        }
        
        function printOrder(orderId) {
            window.open('/print/order/' + orderId, '_blank');
        }
        
        function deleteOrder(orderId) {
            if (confirm('Are you sure you want to delete this order? This action cannot be undone.')) {
                fetch('/api/orders/' + orderId, {
                    method: 'DELETE'
                })
                .then(response => {
                    if (response.ok) {
                        showToast('Order deleted successfully', 'success');
                        setTimeout(() => location.reload(), 1000);
                    } else {
                        showToast('Failed to delete order', 'error');
                    }
                });
            }
        }
        
        function showToast(message, type = 'info') {
            // Create toast container if it doesn't exist
            let toastContainer = document.getElementById('toastContainer');
            if (!toastContainer) {
                toastContainer = document.createElement('div');
                toastContainer.id = 'toastContainer';
                toastContainer.className = 'toast-container position-fixed top-0 end-0 p-3';
                document.body.appendChild(toastContainer);
            }
            
            const toastId = 'toast-' + Date.now();
            const typeClass = type === 'error' ? 'danger' : type;
            const toastHtml = `
                <div id="${toastId}" class="toast align-items-center text-white bg-${typeClass} border-0" role="alert">
                    <div class="d-flex">
                        <div class="toast-body">
                            ${message}
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                    </div>
                </div>
            `;
            
            toastContainer.insertAdjacentHTML('beforeend', toastHtml);
            const toastElement = document.getElementById(toastId);
            const toast = new bootstrap.Toast(toastElement, { delay: 3000 });
            toast.show();
            
            // Remove toast after hiding
            toastElement.addEventListener('hidden.bs.toast', function () {
                this.remove();
            });
        }

        // Auto-close other collapsible when opening new one
        document.addEventListener('show.bs.collapse', function (event) {
            const allCollapses = document.querySelectorAll('.collapse.show');
            allCollapses.forEach(function (collapse) {
                if (collapse.id !== event.target.id) {
                    bootstrap.Collapse.getInstance(collapse).hide();
                    // Reset icons
                    const orderId = collapse.id.replace('orderDetails', '');
                    const icon = document.getElementById('icon' + orderId);
                    if (icon) icon.classList.remove('rotated');
                }
            });
        });
    </script>
</body>
</html>