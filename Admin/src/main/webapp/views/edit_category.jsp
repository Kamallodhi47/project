<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="header1.jsp" %>

    <title>Category Management</title>
    
    <!-- Bootstrap CSS -->
   <!--  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    Font Awesome
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> -->
    
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #4cc9f0;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --hover-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }
        
  
        
        .card-sh {
            box-shadow: var(--card-shadow);
            border: none;
            border-radius: 10px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .card-sh:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 15px 20px;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            border-radius: 6px;
            padding: 10px 15px;
            transition: all 0.3s;
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }
        
        .btn-sm {
            border-radius: 4px;
            margin: 2px;
        }
        
        .table th {
            background-color: #e9ecef;
            border-top: none;
        }
        
        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .pagination .page-link {
            color: var(--primary-color);
        }
        
        .status-active {
            color: #28a745;
            font-weight: bold;
        }
        
        .status-inactive {
            color: #dc3545;
            font-weight: bold;
        }
        
        .alert-message {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
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
        
        .category-image {
            border-radius: 5px;
            object-fit: cover;
        }
        
        .section-title {
            color: var(--primary-color);
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
    </style>


    <!-- Navigation would be included here -->
    
        <section>
        <div class="main-content">
            <div class="container">
                <div class="edit-category-container">
                    <div class="col-lg-5 col-md-7 col-sm-9">
                        <!-- Back Button -->
                        <a href="/categories" class="back-link">
                            <i class="fas fa-arrow-left me-2"></i> Back to Categories
                        </a>
                        
                        <div class="card category-card">
                            <div class="card-header card-header-custom">
                                <h2><i class="fas fa-edit me-2"></i>Edit Category</h2>
                            </div>
                            <div class="card-body card-body-custom">
                                <!-- Success Message -->
                                <c:if test="${not empty sessionScope.succMsg}">
                                    <div class="alert alert-success-custom alert-message">
                                        <i class="fas fa-check-circle me-2"></i>${sessionScope.succMsg}
                                    </div>
                                    <c:remove var="succMsg" scope="session"/>
                                </c:if>
                                
                                <!-- Error Message -->
                                <c:if test="${not empty sessionScope.errorMsg}">
                                    <div class="alert alert-danger-custom alert-message">
                                        <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.errorMsg}
                                    </div>
                                    <c:remove var="errorMsg" scope="session"/>
                                </c:if>

                                <form action="/updateCategory" method="post" enctype="multipart/form-data" id="categoryForm">
                                    <input type="hidden" name="id" value="${category.id}">
                                    
                                    <!-- Category Name -->
                                    <div class="mb-4">
                                        <label class="form-label">Category Name</label>
                                        <input type="text" name="name" value="${category.name}" 
                                               class="form-control form-control-custom" 
                                               placeholder="Enter category name" required>
                                    </div>

                                    <!-- Status -->
                                    <div class="mb-4">
                                        <label class="form-label">Status</label>
                                        <div class="status-group">
                                            <div class="form-check form-check-custom">
                                                <input class="form-check-input form-check-input-custom" 
                                                       type="radio" ${category.isActive ? 'checked' : ''} 
                                                       value="true" name="isActive" id="activeStatus">
                                                <label class="form-check-label form-check-label-custom" for="activeStatus">
                                                    <i class="fas fa-check-circle text-success me-2"></i>Active
                                                </label>
                                            </div>
                                            <div class="form-check form-check-custom">
                                                <input class="form-check-input form-check-input-custom" 
                                                       type="radio" name="isActive" 
                                                       ${not category.isActive ? 'checked' : ''} 
                                                       value="false" id="inactiveStatus">
                                                <label class="form-check-label form-check-label-custom" for="inactiveStatus">
                                                    <i class="fas fa-times-circle text-danger me-2"></i>Inactive
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Image Upload -->
                                    <div class="mb-4">
                                        <label class="form-label">Category Image</label>
                                        <div class="file-upload-area" id="fileUploadArea">
                                            <div class="upload-icon">
                                                <i class="fas fa-cloud-upload-alt"></i>
                                            </div>
                                            <h5>Drag & Drop your image here</h5>
                                            <p class="text-muted">or click to browse</p>
                                            <input type="file" name="file" class="form-control d-none" id="fileInput" accept="image/*">
                                        </div>
                                        <div class="text-center mt-2">
                                            <small class="text-muted">Supported formats: JPG, PNG, GIF (Max: 5MB)</small>
                                        </div>
                                    </div>

                                    <!-- Current Image Preview -->
                                    <c:if test="${not empty category.imageName}">
                                        <div class="image-preview">
                                            <p class="form-label mb-3">Current Image</p>
                                            <img src="/img/category_img/${category.imageName}" 
                                                 alt="${category.name}" 
                                                 class="preview-img">
                                            <p class="text-muted mt-2">${category.imageName}</p>
                                        </div>
                                    </c:if>

                                    <!-- Update Button -->
                                    <button type="submit" class="btn btn-update">
                                        <i class="fas fa-save me-2"></i>Update Category
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Add some interactive functionality
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-hide alerts after 5 seconds
            const alerts = document.querySelectorAll('.alert-message');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.style.transition = 'opacity 0.5s';
                    alert.style.opacity = '0';
                    setTimeout(() => alert.remove(), 500);
                }, 5000);
            });
            
            // Add animation to table rows
            const tableRows = document.querySelectorAll('tbody tr');
            tableRows.forEach(row => {
                row.style.opacity = '0';
                row.style.transform = 'translateY(10px)';
                
                setTimeout(() => {
                    row.style.transition = 'opacity 0.3s, transform 0.3s';
                    row.style.opacity = '1';
                    row.style.transform = 'translateY(0)';
                }, 100 * Array.from(tableRows).indexOf(row));
            });
        });
    </script>
    
     <%@ include file="Footar.jsp" %>
