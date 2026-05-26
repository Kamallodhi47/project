<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    .card-sh {
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        border-radius: 10px;
    }
    .status-btn {
        min-width: 90px;
    }
    .category-img {
        object-fit: cover;
        border-radius: 5px;
        border: 1px solid #dee2e6;
    }
    .action-btns {
        display: flex;
        gap: 5px;
        flex-wrap: wrap;
    }
</style>

</head>
<body>

<section>
    <div class="container-fluid p-5 mt-5">
        <div class="row">

            <!-- ================= ADD CATEGORY ================= -->
            <div class="col-md-4">
                <div class="card card-sh mb-4">
                    <div class="card-header text-center bg-primary text-white">
                        <p class="fs-4 mb-0">Add New Category</p>
                    </div>

                    <div class="card-body">
                        <!-- Success message -->
                        <c:if test="${not empty succMsg}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${succMsg}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <c:remove var="succMsg" scope="session" />
                        </c:if>

                        <!-- Error message -->
                        <c:if test="${not empty errorMsg}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${errorMsg}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <c:remove var="errorMsg" scope="session" />
                        </c:if>

                        <form action="${pageContext.request.contextPath}/saveCategory"
                            method="post" enctype="multipart/form-data" id="categoryForm">

                            <div class="mb-3">
                                <label class="form-label fw-bold">Category Name</label>
                                <input type="text" name="name" class="form-control" 
                                    placeholder="Enter category name" required />
                                <div class="form-text">Enter a unique category name</div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Status</label>
                                <div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="isActive"
                                            id="active" value="true" checked>
                                        <label class="form-check-label" for="active">
                                            Active
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="isActive"
                                            id="inactive" value="false">
                                        <label class="form-check-label" for="inactive">
                                            Inactive
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Category Image</label>
                                <input type="file" name="file" class="form-control" 
                                    accept="image/*" onchange="previewImage(event)" />
                                <div class="form-text">Recommended size: 200x200 pixels</div>
                                <div class="mt-2">
                                    <img id="imagePreview" src="" alt="Image Preview" 
                                        style="max-width: 100px; max-height: 100px; display: none;" 
                                        class="category-img" />
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 mt-2">
                                <i class="fas fa-save"></i> Save Category
                            </button>

                        </form>
                    </div>
                </div>
            </div>

            <!-- ================= SHOW CATEGORY LIST ================= -->
            <div class="col-md-8">
                <div class="card card-sh">
                    <div class="card-header text-center bg-primary text-white">
                        <h4 class="mb-0">Category List</h4>
                    </div>

                    <div class="card-body">
                        <!-- Search and Filter -->
                        <div class="row mb-3">
                            <div class="col-md-8">
                                <input type="text" id="searchInput" class="form-control" 
                                    placeholder="Search categories..." />
                            </div>
                            <div class="col-md-4">
                                <select id="statusFilter" class="form-select">
                                    <option value="">All Status</option>
                                    <option value="true">Active</option>
                                    <option value="false">Inactive</option>
                                </select>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover" id="categoryTable">
                                <thead class="table-dark">
                                    <tr>
                                        <th width="5%">#</th>
                                        <th width="25%">Category Name</th>
                                        <th width="15%">Status</th>
                                        <th width="15%">Image</th>
                                        <th width="25%">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty categories}">
                                            <c:forEach var="cat" items="${categories}" varStatus="c">
                                                <tr>
                                                    <td>${(pageNo * 10) + c.count}</td>
                                                    <td>
                                                        <strong>${cat.name}</strong>
                                                        <div class="text-muted small">
                                                            ID: ${cat.id}
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <button onclick="toggleStatus(${cat.id}, ${cat.isActive})" 
                                                            class="btn btn-sm status-btn ${cat.isActive ? 'btn-success' : 'btn-danger'}" 
                                                            id="statusBtn${cat.id}">
                                                            ${cat.isActive ? 'Active' : 'Inactive'}
                                                        </button>
                                                    </td>
                                                    <td>
                                                        <c:if test="${not empty cat.imageName}">
                                                            <img src="${pageContext.request.contextPath}/assets/img/category_img/${cat.imageName}"
                                                                width="60" height="60" class="category-img"
                                                                data-bs-toggle="modal" data-bs-target="#imageModal"
                                                                onclick="showImage('${pageContext.request.contextPath}/assets/img/category_img/${cat.imageName}')"
                                                                style="cursor: pointer;">
                                                        </c:if>
                                                        <c:if test="${empty cat.imageName}">
                                                            <span class="badge bg-secondary">No Image</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <div class="action-btns">
                                                            <a href="${pageContext.request.contextPath}/loadEditCategory/${cat.id}"
                                                                class="btn btn-warning btn-sm">
                                                                <i class="fas fa-edit"></i> Edit
                                                            </a>
                                                            <button onclick="confirmDelete(${cat.id}, '${cat.name}')"
                                                                class="btn btn-danger btn-sm">
                                                                <i class="fas fa-trash"></i> Delete
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="text-center py-4">
                                                    <div class="text-muted">
                                                        <i class="fas fa-folder-open fa-2x mb-2"></i>
                                                        <p class="mb-0">No categories found</p>
                                                        <small>Add your first category using the form on the left</small>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- ================= Pagination ================= -->
                        <c:if test="${totalPages > 1}">
                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <p class="text-muted mb-0">
                                        Showing ${pageNo * 10 + 1} to ${pageNo * 10 + categorys.size()} 
                                        of ${totalElements} categories
                                    </p>
                                </div>
                                
                                <div class="col-md-6">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-end">
                                            <li class="page-item ${isFirst ? 'disabled' : ''}">
                                                <a class="page-link" 
                                                    href="${pageContext.request.contextPath}/category?pageNo=${pageNo - 1}">
                                                    &laquo; Previous
                                                </a>
                                            </li>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <c:if test="${i == 1 || i == totalPages || (i >= pageNo && i <= pageNo + 2)}">
                                                    <li class="page-item ${pageNo + 1 == i ? 'active' : ''}">
                                                        <a class="page-link"
                                                            href="${pageContext.request.contextPath}/category?pageNo=${i - 1}">
                                                            ${i}
                                                        </a>
                                                    </li>
                                                </c:if>
                                                <c:if test="${i == pageNo + 3 && i < totalPages - 1}">
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                </c:if>
                                            </c:forEach>

                                            <li class="page-item ${isLast ? 'disabled' : ''}">
                                                <a class="page-link"
                                                    href="${pageContext.request.contextPath}/category?pageNo=${pageNo + 1}">
                                                    Next &raquo;
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Image Preview Modal -->
<div class="modal fade" id="imageModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Category Image</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <img id="modalImage" src="" alt="Category Image" class="img-fluid">
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    // Image preview in form
    function previewImage(event) {
        const reader = new FileReader();
        const imagePreview = document.getElementById('imagePreview');
        
        reader.onload = function() {
            imagePreview.src = reader.result;
            imagePreview.style.display = 'block';
        }
        
        if(event.target.files[0]) {
            reader.readAsDataURL(event.target.files[0]);
        }
    }
    
    // Show image in modal
    function showImage(imageUrl) {
        document.getElementById('modalImage').src = imageUrl;
    }
    
    // Toggle status with AJAX
    function toggleStatus(categoryId, currentStatus) {
        if(confirm('Are you sure you want to change the status?')) {
            $.ajax({
                url: '${pageContext.request.contextPath}/toggleCategoryStatus/' + categoryId,
                type: 'POST',
                success: function(response) {
                    if(response.success) {
                        const btn = $('#statusBtn' + categoryId);
                        if(response.isActive) {
                            btn.removeClass('btn-danger').addClass('btn-success').text('Active');
                        } else {
                            btn.removeClass('btn-success').addClass('btn-danger').text('Inactive');
                        }
                        
                        // Show success message
                        showAlert('Status updated successfully!', 'success');
                    } else {
                        showAlert('Error updating status: ' + response.message, 'danger');
                    }
                },
                error: function() {
                    showAlert('Something went wrong! Please try again.', 'danger');
                }
            });
        }
    }
    
    // Confirm delete
    function confirmDelete(categoryId, categoryName) {
        if(confirm('Are you sure you want to delete "' + categoryName + '"?\n\nThis action cannot be undone.')) {
            window.location.href = '${pageContext.request.contextPath}/deleteCategory/' + categoryId;
        }
    }
    
    // Search functionality
    $('#searchInput').on('keyup', function() {
        const value = $(this).val().toLowerCase();
        $('#categoryTable tbody tr').filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });
    
    // Filter by status
    $('#statusFilter').on('change', function() {
        const value = $(this).val();
        $('#categoryTable tbody tr').each(function() {
            if(value === '') {
                $(this).show();
            } else {
                const statusBtn = $(this).find('.status-btn');
                const isActive = statusBtn.hasClass('btn-success');
                $(this).toggle((value === 'true' && isActive) || (value === 'false' && !isActive));
            }
        });
    });
    
    // Show alert function
    function showAlert(message, type) {
        const alertDiv = $('<div>').addClass('alert alert-' + type + ' alert-dismissible fade show')
            .html(message + '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>');
        
        $('.container-fluid').prepend(alertDiv);
        
        setTimeout(() => {
            alertDiv.alert('close');
        }, 3000);
    }
    
    // Form validation
    $('#categoryForm').on('submit', function(e) {
        const nameInput = $('input[name="name"]');
        if(!nameInput.val().trim()) {
            e.preventDefault();
            nameInput.addClass('is-invalid');
            showAlert('Please enter category name', 'danger');
            return false;
        }
        return true;
    });
    
    // Remove validation class on input
    $('input[name="name"]').on('input', function() {
        $(this).removeClass('is-invalid');
    });
</script>

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>