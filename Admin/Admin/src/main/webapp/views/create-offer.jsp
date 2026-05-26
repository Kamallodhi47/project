<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit' : 'Create'} Offer</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }
        
        .form-container {
            max-width: 900px;
            margin: 0 auto;
        }
        
        .offer-card {
            background: white;
            border-radius: 1.5rem;
            padding: 2rem;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        
        .section-title {
            color: #2d3748;
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e9ecef;
        }
        
        .form-label {
            font-weight: 500;
            color: #4a5568;
            margin-bottom: 0.5rem;
        }
        
        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 0.75rem;
            padding: 0.625rem 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 0.75rem;
            color: white;
            width: 100%;
            transition: all 0.3s ease;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .preview-image {
            max-width: 200px;
            max-height: 200px;
            border-radius: 1rem;
            border: 3px solid #e2e8f0;
            padding: 0.5rem;
            background: #f8f9fa;
        }
        
        .product-preview {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 0.5rem;
            margin-right: 0.5rem;
        }
    </style>
</head>
<body>

<div class="container form-container">
    <div class="offer-card">
        
        <!-- Header -->
        <div class="d-flex align-items-center mb-4">
            <a href="/admin/offers" class="btn btn-link text-decoration-none me-3">
                <i class="bi bi-arrow-left fs-4"></i>
            </a>
            <div>
                <h2 class="fw-bold mb-1">${isEdit ? 'Edit Offer' : 'Create New Offer'}</h2>
                <p class="text-muted mb-0">${isEdit ? 'Update offer details' : 'Fill in the information to create a new offer'}</p>
            </div>
        </div>
        
        <!-- Form -->
        <form action="/admin/save" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${offer.id}"/>
            
            <!-- Basic Information -->
            <div class="section-title">
                <i class="bi bi-info-circle me-2"></i>Basic Information
            </div>
            
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <label class="form-label">Offer Title *</label>
                    <input type="text" name="title" class="form-control" 
                           value="${offer.title}" placeholder="e.g., Diwali Sale 2024" required>
                    <div class="form-text">Give your offer a catchy title</div>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label">Offer Type *</label>
                    <select name="offerType" class="form-select" required>
                        <c:forEach items="${offerTypes}" var="type">
                            <option value="${type}" ${offer.offerType == type ? 'selected' : ''}>${type}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="col-12">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3" 
                              placeholder="Describe your offer...">${offer.description}</textarea>
                </div>
            </div>
            
            <!-- Offer Configuration -->
            <div class="section-title">
                <i class="bi bi-gear me-2"></i>Offer Configuration
            </div>
            
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <label class="form-label">Priority</label>
                    <input type="number" name="priority" class="form-control" 
                           value="${offer.priority}" min="0" max="10">
                    <div class="form-text">Higher priority = better placement</div>
                </div>
                
                <div class="col-md-4">
                    <label class="form-label">Discount %</label>
                    <input type="number" name="discountPercentage" class="form-control" 
                           value="${offer.discountPercentage}" min="0" max="100">
                </div>
                
                <div class="col-md-4">
                    <label class="form-label">Min. Cart Value</label>
                    <input type="number" name="minCartValue" class="form-control" 
                           value="${offer.minCartValue}" min="0" step="0.01">
                </div>
            </div>
            
            <!-- Product Selection -->
            <div class="section-title">
                <i class="bi bi-box me-2"></i>Product Configuration
            </div>
            
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <label class="form-label">Eligible Products</label>
                    <select name="eligibleProductIds" class="form-select product-select" multiple>
                        <c:forEach items="${products}" var="product">
                            <option value="${product.id}" 
							data-image="${pageContext.request.contextPath}/assets/img/product_img/${product.image}"   
							
						       System.out.println(data-image);
                                    ${offer.eligibleProducts.contains(product) ? 'selected' : ''}>
                                ${product.title} - ₹${product.price}
                            </option>
                        </c:forEach>
                    </select>
                    <div class="form-text">Products this offer applies to</div>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label">Free Products</label>
                    <select name="freeProductIds" class="form-select product-select" multiple>
                        <c:forEach items="${products}" var="product">
                            <option value="${product.id}" 
							data-image="${pageContext.request.contextPath}/assets/img/product_img/${product.image}" 
                                    ${offer.freeProducts.contains(product) ? 'selected' : ''}>
                                ${product.title} - ₹${product.price}
                            </option>
                        </c:forEach>
                    </select>
                    <div class="form-text">Products given as free (for BOGO)</div>
                </div>
            </div>
            
            <!-- Validity -->
            <div class="section-title">
                <i class="bi bi-calendar-range me-2"></i>Validity Period
            </div>
            
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <label class="form-label">Start Date *</label>
                    <input type="datetime-local" name="startDate" class="form-control" 
                           value="${offer.startDate}" required>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label">End Date *</label>
                    <input type="datetime-local" name="endDate" class="form-control" 
                           value="${offer.endDate}" required>
                </div>
            </div>
            
            <!-- Banner & Limits -->
            <div class="section-title">
                <i class="bi bi-image me-2"></i>Media & Limits
            </div>
            
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <label class="form-label">Banner Image</label>
                    <input type="file" name="bannerFile" class="form-control" accept="image/*">
                    <c:if test="${not empty offer.bannerImage}">
                        <div class="mt-3">
                            <img src="${offer.bannerImage}" class="preview-image" alt="Current banner">
                        </div>
                    </c:if>
                </div>
                
                <div class="col-md-3">
                    <label class="form-label">Max Usage/User</label>
                    <input type="number" name="maxUsagePerUser" class="form-control" 
                           value="${offer.maxUsagePerUser}" min="1">
                </div>
                
                <div class="col-md-3">
                    <label class="form-label">Total Usage Limit</label>
                    <input type="number" name="totalUsageLimit" class="form-control" 
                           value="${offer.totalUsageLimit}" min="1">
                </div>
            </div>
            
            <!-- Active Status -->
            <div class="mb-4">
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" name="active" 
                           id="activeSwitch" ${offer.active ? 'checked' : ''}>
                    <label class="form-check-label" for="activeSwitch">Active</label>
                </div>
            </div>
            
            <!-- Submit -->
            <button type="submit" class="btn-submit">
                <i class="bi bi-check-lg me-2"></i>${isEdit ? 'Update Offer' : 'Create Offer'}
            </button>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
$(document).ready(function() {
    // Initialize Select2 for product selection
    $('.product-select').select2({
        placeholder: "Select products...",
        allowClear: true,
        templateResult: formatProduct,
        templateSelection: formatProductSelection,
        width: '100%'
    });
    
    function formatProduct(product) {
        if (!product.id) return product.text;
        
        var image = $(product.element).data('image');
        if (!image) return product.text;
        
        var $product = $(
            '<span><img src="' + image + '" class="product-preview" /> ' + product.text + '</span>'
        );
        return $product;
    }
    
    function formatProductSelection(product) {
        return product.text;
    }
});
</script>

</body>
</html>