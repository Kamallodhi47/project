<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Category Management</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #4cc9f0;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --hover-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }
        
        * {
            -webkit-tap-highlight-color: transparent;
            box-sizing: border-box;
        }
        
        body {
            background-color: #f5f7fb;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 70px;
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        /* ========== MOBILE FIRST STYLES ========== */
        .container-fluid-mobile {
            width: 100%;
            padding: 15px;
        }
        
        .card-sh {
            box-shadow: var(--card-shadow);
            border: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            margin-bottom: 15px;
            overflow: hidden;
        }
        
        .card-sh:active {
            transform: scale(0.99);
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 0 !important;
            padding: 12px 15px;
        }
        
        .card-header h5 {
            font-size: 1rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .card-body {
            padding: 15px;
        }
        
        /* Form Styles */
        .form-label {
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 5px;
            color: #333;
        }
        
        .form-control {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
            outline: none;
        }
        
        .form-text {
            font-size: 0.8rem;
            color: #666;
            margin-top: 5px;
        }
        
        .form-check-inline {
            margin-right: 15px;
        }
        
        .form-check-label {
            display: flex;
            align-items: center;
            font-size: 0.9rem;
            color: #333;
        }
        
        /* Button Styles */
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            width: 100%;
            color: white;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-height: 44px;
        }
        
        .btn-primary:active {
            background-color: var(--secondary-color);
            transform: scale(0.98);
        }
        
        .btn-sm {
            border-radius: 6px;
            padding: 8px 12px;
            font-size: 0.8rem;
            min-height: 36px;
            min-width: 36px;
        }
        
        /* Table Styles */
        .table-responsive {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            margin-bottom: 15px;
            border-radius: 8px;
            background: white;
        }
        
        .table {
            width: 100%;
            margin-bottom: 0;
            font-size: 0.9rem;
        }
        
        .table th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            padding: 12px 8px;
            font-weight: 600;
            color: #333;
            white-space: nowrap;
        }
        
        .table td {
            padding: 12px 8px;
            vertical-align: middle;
            border-bottom: 1px solid #eee;
        }
        
        .table-hover tbody tr:active {
            background-color: rgba(67, 97, 238, 0.05);
        }
        
        /* Status Badges */
        .status-active {
            color: #28a745;
            font-weight: 600;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .status-inactive {
            color: #dc3545;
            font-weight: 600;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        /* Image Styles */
        .category-image {
            border-radius: 6px;
            object-fit: cover;
            width: 50px;
            height: 50px;
        }
        
        /* Alert Messages */
        .alert-message {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* Pagination */
        .pagination {
            margin: 0;
            flex-wrap: wrap;
        }
        
        .page-link {
            padding: 8px 12px;
            border-radius: 6px;
            margin: 2px;
            font-size: 0.85rem;
            border: 1px solid #ddd;
            color: var(--primary-color);
        }
        
        .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }
        
        /* Empty State */
        .empty-state {
            padding: 40px 20px;
            text-align: center;
            color: #666;
        }
        
        .empty-state i {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: #ccc;
        }
        
        /* Mobile Actions */
        .mobile-actions {
            display: flex;
            gap: 5px;
            justify-content: center;
        }
        
        /* Summary */
        .summary-text {
            font-size: 0.9rem;
            font-weight: 600;
            color: #333;
        }
        
        /* ========== TABLET STYLES ========== */
        @media (min-width: 768px) {
            body {
                padding-top: 80px;
            }
            
            .container-fluid-mobile {
                max-width: 720px;
                margin: 0 auto;
                padding: 20px;
            }
            
            .row {
                display: grid;
                grid-template-columns: 1fr 2fr;
                gap: 20px;
                margin: 0;
            }
            
            .card-sh:hover {
                transform: translateY(-5px);
                box-shadow: var(--hover-shadow);
            }
            
            .card-header {
                padding: 15px 20px;
            }
            
            .card-header h5 {
                font-size: 1.1rem;
            }
            
            .card-body {
                padding: 20px;
            }
            
            .btn-primary:hover {
                background-color: var(--secondary-color);
                transform: translateY(-2px);
            }
            
            .table-hover tbody tr:hover {
                background-color: rgba(67, 97, 238, 0.05);
            }
            
            .form-control {
                font-size: 0.95rem;
                padding: 12px 15px;
            }
            
            .table {
                font-size: 0.95rem;
            }
            
            .table th, .table td {
                padding: 12px;
            }
        }
        
        /* ========== DESKTOP STYLES ========== */
        @media (min-width: 992px) {
            body {
                padding-top: 90px;
            }
            
            .container-fluid-mobile {
                max-width: 1140px;
                padding: 30px;
            }
            
            .card-header {
                padding: 18px 25px;
            }
            
            .card-header h5 {
                font-size: 1.2rem;
            }
            
            .card-body {
                padding: 25px;
            }
            
            .form-label {
                font-size: 1rem;
            }
            
            .form-control {
                font-size: 1rem;
                padding: 14px 18px;
            }
            
            .table {
                font-size: 1rem;
            }
            
            .btn-primary {
                font-size: 1rem;
                padding: 14px 20px;
            }
            
            .btn-sm {
                padding: 10px 15px;
                font-size: 0.9rem;
            }
        }
        
        /* ========== TOUCH OPTIMIZATION ========== */
        @media (hover: none) and (pointer: coarse) {
            .btn-primary:hover,
            .card-sh:hover,
            .table-hover tbody tr:hover {
                transform: none;
            }
            
            .btn-primary:active,
            .card-sh:active,
            .table-hover tbody tr:active {
                transform: scale(0.98);
                opacity: 0.9;
            }
            
            .form-check-input {
                width: 20px;
                height: 20px;
            }
        }
        
        /* ========== UTILITY CLASSES ========== */
        .text-center {
            text-align: center;
        }
        
        .fw-semibold {
            font-weight: 600;
        }
        
        .text-primary {
            color: var(--primary-color) !important;
        }
        
        .text-muted {
            color: #666 !important;
        }
        
        .mb-3 {
            margin-bottom: 15px !important;
        }
        
        .mt-3 {
            margin-top: 15px !important;
        }
        
        .mt-4 {
            margin-top: 20px !important;
        }
        
        .mb-0 {
            margin-bottom: 0 !important;
        }
        
        .d-flex {
            display: flex !important;
        }
        
        .justify-content-between {
            justify-content: space-between !important;
        }
        
        .align-items-center {
            align-items: center !important;
        }
        
        .w-100 {
            width: 100% !important;
        }
    </style>
</head>
<body>
<%@ include file="header1.jsp" %>
    
    <div class="container-fluid-mobile">
        <div class="row">
            <!-- Add Category Card -->
            <div>
                <div class="card card-sh">
                    <div class="card-header">
                        <h5><i class="fas fa-plus-circle"></i> Add New Category</h5>
                    </div>
                    <div class="card-body">
                        <!-- Success/Error Messages -->
                        <c:if test="${not empty sessionScope.succMsg}">
                            <div class="alert-message alert-success">
                                <i class="fas fa-check-circle"></i>
                                <span>${sessionScope.succMsg}</span>
                            </div>
                            <c:remove var="succMsg" scope="session"/>
                        </c:if>
                        
                        <c:if test="${not empty sessionScope.errorMsg}">
                            <div class="alert-message alert-error">
                                <i class="fas fa-exclamation-circle"></i>
                                <span>${sessionScope.errorMsg}</span>
                            </div>
                            <c:remove var="errorMsg" scope="session"/>
                        </c:if>
                        
                        <form action="/saveCategory" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label class="form-label">Category Name</label>
                                <input type="text" name="name" class="form-control" 
                                       placeholder="Enter category name" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Status</label>
                                <div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" 
                                               checked value="true" name="isActive" id="activeStatus">
                                        <label class="form-check-label" for="activeStatus">
                                            <i class="fas fa-circle text-success me-1"></i> Active
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" 
                                               name="isActive" value="false" id="inactiveStatus">
                                        <label class="form-check-label" for="inactiveStatus">
                                            <i class="fas fa-circle text-danger me-1"></i> Inactive
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Category Image</label>
                                <input type="file" name="file" class="form-control" 
                                       accept="image/*">
                                <div class="form-text">
                                    Upload an image for this category (JPEG, PNG, etc.)
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-primary mt-3">
                                <i class="fas fa-save"></i>
                                <span>Save Category</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Category List Card -->
            <div>
                <div class="card card-sh">
                    <div class="card-header">
                        <h5><i class="fas fa-list"></i> Category Details</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Category</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Image</th>
                                        <th scope="col" class="text-center">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cat" items="${categorys}" varStatus="c">
                                        <tr>
                                            <th scope="row">${c.count}</th>
                                            <td class="fw-semibold">${cat.name}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${cat.isActive}">
                                                        <span class="status-active">
                                                            <i class="fas fa-check-circle"></i>
                                                            Active
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-inactive">
                                                            <i class="fas fa-times-circle"></i>
                                                            Inactive
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${not empty cat.imageName}">
                                                    <img src="/img/category_img/${cat.imageName}" 
                                                         class="category-image" 
                                                         alt="${cat.name} image">
                                                </c:if>
                                                <c:if test="${empty cat.imageName}">
                                                    <span class="text-muted">No image</span>
                                                </c:if>
                                            </td>
                                            <td class="text-center">
                                                <div class="mobile-actions">
                                                    <a href="/admin/loadEditCategory/${cat.id}" 
                                                       class="btn btn-primary btn-sm" 
                                                       title="Edit Category">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="/admin/deleteCategory/${cat.id}" 
                                                       class="btn btn-danger btn-sm" 
                                                       title="Delete Category"
                                                       onclick="return confirm('Are you sure you want to delete this category?')">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    
                                    <c:if test="${empty categorys}">
                                        <tr>
                                            <td colspan="5" class="text-center">
                                                <div class="empty-state">
                                                    <i class="fas fa-inbox"></i>
                                                    <div>No categories found.</div>
                                                    <div class="text-muted">Add your first category!</div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination and Summary -->
                        <div class="d-flex justify-content-between align-items-center mt-4">
                            <div class="summary-text">
                                Total Categories: 
                                <span class="text-primary">${totalElements}</span>
                            </div>
                            
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Category pagination">
                                    <ul class="pagination mb-0">
                                        <li class="page-item ${pageNo == 0 ? 'disabled' : ''}">
                                            <a class="page-link" 
                                               href="/admin/category?pageNo=${pageNo-1}" 
                                               aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${pageNo+1 == i ? 'active' : ''}">
                                                <a class="page-link" 
                                                   href="/admin/category?pageNo=${i-1}">
                                                    ${i}
                                                </a>
                                            </li>
                                        </c:forEach>
                                        
                                        <li class="page-item ${pageNo+1 == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" 
                                               href="/admin/category?pageNo=${pageNo+1}" 
                                               aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="Footar.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Mobile touch optimization
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-hide alerts after 5 seconds
            const alerts = document.querySelectorAll('.alert-message');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.style.transition = 'opacity 0.5s';
                    alert.style.opacity = '0';
                    setTimeout(() => {
                        if (alert.parentNode) {
                            alert.remove();
                        }
                    }, 500);
                }, 5000);
            });
            
            // Add touch feedback to all buttons and cards
            const touchElements = document.querySelectorAll('.btn, .card-sh, .table-hover tbody tr');
            touchElements.forEach(el => {
                el.addEventListener('touchstart', function() {
                    this.style.opacity = '0.8';
                });
                
                el.addEventListener('touchend', function() {
                    setTimeout(() => {
                        this.style.opacity = '';
                    }, 150);
                });
            });
            
            // Prevent zoom on double tap for inputs
            const inputs = document.querySelectorAll('input, select, textarea');
            inputs.forEach(input => {
                input.addEventListener('touchstart', function() {
                    this.style.fontSize = '16px';
                });
            });
            
            // Better scroll for mobile
            if ('ontouchstart' in window) {
                document.body.style.overflowX = 'hidden';
                
                // Smooth scrolling for table on mobile
                const tableResponsive = document.querySelector('.table-responsive');
                if (tableResponsive) {
                    tableResponsive.style.webkitOverflowScrolling = 'touch';
                }
            }
            
            // Table row animation
            const tableRows = document.querySelectorAll('tbody tr');
            tableRows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateY(10px)';
                
                setTimeout(() => {
                    row.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
                    row.style.opacity = '1';
                    row.style.transform = 'translateY(0)';
                }, index * 50);
            });
        });
        
        // Handle form submission feedback
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', function(e) {
                const submitBtn = this.querySelector('button[type="submit"]');
                if (submitBtn) {
                    const originalHTML = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
                    submitBtn.disabled = true;
                    
                    // Re-enable button after 5 seconds (in case of error)
                    setTimeout(() => {
                        submitBtn.innerHTML = originalHTML;
                        submitBtn.disabled = false;
                    }, 5000);
                }
            });
        }
        
        // Handle window resize
        let resizeTimer;
        window.addEventListener('resize', function() {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(function() {
                // Adjust layout based on screen size
                const container = document.querySelector('.container-fluid-mobile');
                if (container) {
                    if (window.innerWidth <= 767) {
                        // Mobile
                        container.style.padding = '15px';
                    } else if (window.innerWidth <= 991) {
                        // Tablet
                        container.style.padding = '20px';
                    } else {
                        // Desktop
                        container.style.padding = '30px';
                    }
                }
            }, 250);
        });
        
        // Initial resize check
        window.dispatchEvent(new Event('resize'));
    </script>
</body>
</html>