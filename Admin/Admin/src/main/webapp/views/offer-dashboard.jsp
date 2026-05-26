<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Offer Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        .card-hover:hover {
            transform: scale(1.02);
            transition: 0.3s;
        }
        .badge-high {
            background: #dc3545;
        }
        .badge-medium {
            background: #ffc107;
            color: black;
        }
        .badge-low {
            background: #198754;
        }
        .offer-img {
            height: 150px;
            object-fit: cover;
        }
    </style>
</head>

<body class="container mt-4">

<h2 class="text-center mb-4">🎯 Offer Management Dashboard</h2>

<div class="text-end mb-3">
    <a href="/admin/new" class="btn btn-primary">
        <i class="bi bi-plus-circle"></i> Create New Offer
    </a>
</div>

<!-- ================= GRID VIEW ================= -->
<div class="row">

    <c:forEach items="${offers}" var="offer">

        <div class="col-md-4 mb-4">
            <div class="card shadow card-hover">

                <c:if test="${not empty offer.bannerImage}">
                    <img src="/uploads/${offer.bannerImage}" 
                         class="card-img-top offer-img"/>
                </c:if>

                <div class="card-body">

                    <h5 class="card-title">
                        ${offer.title}
                    </h5>

                    <p class="text-muted small">
                        ${offer.offerType}
                    </p>

                    <!-- Priority Badge -->
                    <c:choose>
                        <c:when test="${offer.priority >= 8}">
                            <span class="badge badge-high">High Priority</span>
                        </c:when>
                        <c:when test="${offer.priority >= 5}">
                            <span class="badge badge-medium">Medium Priority</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-low">Low Priority</span>
                        </c:otherwise>
                    </c:choose>

                    <hr>

                    <p>
                        <strong>Discount:</strong> 
                        ${offer.discountPercentage}%
                    </p>

                    <p class="small text-muted">
                        <i class="bi bi-calendar"></i>
                        <c:if test="${not empty offer.startDate}">
                            ${offer.startDate.toLocalDate()}
                        </c:if>
                        →
                        <c:if test="${not empty offer.endDate}">
                            ${offer.endDate.toLocalDate()}
                        </c:if>
                    </p>

                    <div class="d-flex justify-content-between">

                        <a href="/admin/edit-offer/${offer.id}" 
                           class="btn btn-sm btn-warning">
                            Edit
                        </a>

                        <!--<a href="/delete/{id}"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this offer?')">
                            Delete
                        </a>-->
						<form action="/admin/delete/${offer.id}" 
						          method="post"
						          onsubmit="return confirm('Delete this offer?')">
						        <button type="submit" class="btn btn-sm btn-danger">
						            <i class="bi bi-trash"></i> Delete
						        </button>
						    </form>

                    </div>

                </div>
            </div>
        </div>

    </c:forEach>

</div>

<hr class="my-5">

<!-- ================= TABLE VIEW ================= -->

<h4 class="mb-3">All Offers (Table View)</h4>

<table class="table table-bordered table-striped">

    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Type</th>
            <th>Discount</th>
            <th>Priority</th>
            <th>Date Range</th>
            <th>Status</th>
        </tr>
    </thead>

    <tbody>

        <c:forEach items="${offers}" var="offer">

            <tr>

                <td>${offer.id}</td>

                <td>${offer.title}</td>

                <td>${offer.offerType}</td>

                <td>${offer.discountPercentage}%</td>

                <td>${offer.priority}</td>

                <td>
                    <small>
                        <c:if test="${not empty offer.startDate}">
                            ${offer.startDate.toLocalDate()}
                        </c:if>
                        <br>
                        <c:if test="${not empty offer.endDate}">
                            ${offer.endDate.toLocalDate()}
                        </c:if>
                    </small>
                </td>

                <td>
                    <c:choose>
                        <c:when test="${offer.active}">
                            <span class="badge bg-success">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                </td>

            </tr>

        </c:forEach>

    </tbody>

</table>

</body>
</html>