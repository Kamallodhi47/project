<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #4e73df;
            --success: #1cc88a;
            --warning: #f6c23e;
            --danger: #e74a3b;
            --light: #f8f9fc;
            --dark: #5a5c69;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--primary), #224abe);
            border-bottom: none;
            padding: 1.5rem;
        }
        
        .form-control, .form-select {
            border: 1.5px solid #e3e6f0;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            transition: all 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
        }
        
        .form-label {
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary), #224abe);
            border: none;
            border-radius: 10px;
            padding: 0.75rem;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(78, 115, 223, 0.4);
        }
        
        .image-preview-container {
            width: 200px;
            height: 200px;
            border: 2px dashed #e3e6f0;
            border-radius: 10px;
            margin: 15px auto;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            background: var(--light);
        }
        
        .image-preview-container img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        
        .upload-area {
            border: 3px dashed var(--primary);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: rgba(78, 115, 223, 0.05);
        }
        
        .upload-area:hover {
            background: rgba(78, 115, 223, 0.1);
            border-color: #224abe;
        }
        
        .upload-icon {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }
        
        .alert-custom {
            border: none;
            border-radius: 10px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .spinner-border {
            width: 1rem;
            height: 1rem;
            margin-right: 0.5rem;
        }
        
        .price-display {
            background: var(--light);
            border-radius: 10px;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .discount-badge {
            background: var(--success);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        
        @media (max-width: 768px) {
            .container {
                padding-left: 15px;
                padding-right: 15px;
            }
            
            .row {
                margin-left: 0;
                margin-right: 0;
            }
        }
    </style>
</head>

<body class="bg-light">

<section>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-8">
                <div class="card shadow-lg">
                    <div class="card-header text-white">
                        <h4 class="mb-0"><i class="fas fa-plus-circle me-2"></i> Add New Product</h4>
                        <p class="mb-0 opacity-75">Fill all required information below</p>
                    </div>

                    <div class="card-body p-4">
                        <!-- Messages -->
                        <c:if test="${not empty sessionScope.succMsg}">
                            <div class="alert alert-success alert-custom alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i> ${sessionScope.succMsg}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <c:remove var="succMsg" scope="session" />
                        </c:if>

                        <c:if test="${not empty sessionScope.errorMsg}">
                            <div class="alert alert-danger alert-custom alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i> ${sessionScope.errorMsg}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <c:remove var="errorMsg" scope="session" />
                        </c:if>

                        <form id="productForm" action="/saveProduct" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                            
                            <!-- Product Title -->
                            <div class="mb-4">
                                <label class="form-label">Product Title <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-heading"></i></span>
                                    <input type="text" name="title" class="form-control" placeholder="Enter product title" required>
                                </div>
                            </div>

                            <!-- Description -->
                            <div class="mb-4">
                                <label class="form-label">Description <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                                    <textarea rows="4" class="form-control" name="description" placeholder="Enter product description" required></textarea>
                                </div>
                                <div class="form-text">Minimum 50 characters recommended</div>
                            </div>

                            <div class="row">
                                <!-- Category -->
                                <div class="col-md-6 mb-4">
                                    <label class="form-label">Category <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-tag"></i></span>
                                        <select class="form-select" name="category" required>
                                            <option value="">-- Select Category --</option>
                                            <c:forEach var="c" items="${categories}">
                                                <option value="${c.name}">${c.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <!-- Stock -->
                                <!-- Stock Quantity -->
	
															
<div class="col-md-6 mb-4">
    <label class="form-label">Stock Quantity <span class="text-danger">*</span></label>
    <div class="input-group">
        <span class="input-group-text"><i class="fas fa-boxes"></i></span>
        <input type="number" name="stockQty" class="form-control" placeholder="Enter stock quantity" min="0" required>
    </div>
</div>

<!-- Stock Unit -->
<div class="col-md-6 mb-4">
    <label class="form-label">Stock Unit <span class="text-danger">*</span></label>
    <div class="input-group">
        <span class="input-group-text"><i class="fas fa-box"></i></span>
        <select name="stockUnit" class="form-select" required>
            <option value="">-- Select Unit --</option>
            <option value="kg">Kg</option>
			<option value="kg">gram</option>
            <option value="liter">Liter</option>
            <option value="pcs">Pcs</option>
            <option value="quintal">Quintal</option>
        </select>
    </div>
</div>
                            </div>

                            <div class="row">
                                <!-- Price -->
                                <div class="col-md-6 mb-4">
                                    <label class="form-label">Price (₹) <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-rupee-sign"></i></span>
                                        <input type="number" name="price" class="form-control" placeholder="Enter price" min="1" step="0.01" required 
                                               oninput="calculateFinalPrice()" id="priceInput">
                                    </div>
                                </div>

                                <!-- Discount -->
                                <div class="col-md-6 mb-4">
                                    <label class="form-label">Discount (%)</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-percentage"></i></span>
                                        <input type="number" name="discount" class="form-control" placeholder="Enter discount" 
                                               min="0" max="100" value="0" oninput="calculateFinalPrice()" id="discountInput">
                                    </div>
                                </div>
                            </div>

                            <!-- Price Calculation Display -->
                            <div class="price-display mb-4">
                                <div class="row">
                                    <div class="col-md-4">
                                        <p class="mb-1 text-muted">Original Price</p>
                                        <h5 class="mb-0" id="originalPrice">₹0.00</h5>
                                    </div>
                                    <div class="col-md-4">
                                        <p class="mb-1 text-muted">Discount Amount</p>
                                        <h5 class="mb-0 text-success" id="discountAmount">₹0.00</h5>
                                    </div>
                                    <div class="col-md-4">
                                        <p class="mb-1 text-muted">Final Price</p>
                                        <h5 class="mb-0 text-primary" id="finalPrice">₹0.00</h5>
                                    </div>
                                </div>
                            </div>

                            <!-- Single Image Upload -->
                            <div class="mb-4">
                                <label class="form-label">Product Image <span class="text-danger">*</span></label>
                                <p class="text-muted mb-2">Upload product image (Max 5MB)</p>
                                
                                <!-- Image Preview -->
                                <div class="image-preview-container" id="imagePreviewContainer">
                                    <div class="upload-area" onclick="document.getElementById('imageInput').click()">
                                        <div class="upload-icon">
                                            <i class="fas fa-cloud-upload-alt"></i>
                                        </div>
                                        <h5>Click to Upload Image</h5>
                                        <p class="text-muted mb-0">or drag and drop</p>
                                        <small class="text-muted">Supported: JPG, PNG | Max: 5MB</small>
                                    </div>
                                </div>
                                
                                <!-- File Input (Hidden) -->
                                <input type="file" name="file" id="imageInput" accept="image/*" 
                                       class="d-none" onchange="previewImage(event)">
                                
                                <!-- File name display -->
                                <div class="text-center mt-2">
                                    <small id="fileName" class="text-muted">No file selected</small>
                                </div>
                            </div>

                            <!-- Status -->
                            <div class="mb-4">
                                <label class="form-label">Product Status</label>
                                <div class="d-flex gap-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" value="true" name="isActive" id="active" checked>
                                        <label class="form-check-label" for="active">
                                            <span class="badge bg-success"><i class="fas fa-check me-1"></i> Active</span>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" value="false" name="isActive" id="inactive">
                                        <label class="form-check-label" for="inactive">
                                            <span class="badge bg-danger"><i class="fas fa-times me-1"></i> Inactive</span>
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="d-grid gap-2 mt-4">
                                <button type="submit" class="btn btn-primary btn-lg" id="submitBtn">
                                    <i class="fas fa-save me-2"></i> Save Product
                                </button>
                                <button type="reset" class="btn btn-outline-secondary" onclick="resetImagePreview()">
                                    <i class="fas fa-redo me-2"></i> Reset Form
                                </button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    let selectedImage = null;
    const maxSizeMB = 5;

    // Preview single image
    function previewImage(event) {
        const file = event.target.files[0];
        const previewContainer = document.getElementById('imagePreviewContainer');
        const fileNameDisplay = document.getElementById('fileName');
        
        if (!file) return;
        
        // Validate file size
        if (file.size > maxSizeMB * 1024 * 1024) {
            alert(`File exceeds ${maxSizeMB}MB limit.`);
            event.target.value = '';
            return;
        }
        
        // Validate file type
        if (!file.type.startsWith('image/')) {
            alert('Please select an image file.');
            event.target.value = '';
            return;
        }
        
        // Update selected image
        selectedImage = file;
        fileNameDisplay.textContent = file.name;
        fileNameDisplay.classList.remove('text-muted');
        fileNameDisplay.classList.add('text-primary');
        
        // Create preview
        const reader = new FileReader();
        reader.onload = function(e) {
            previewContainer.innerHTML = `
                <img src="${e.target.result}" alt="Preview" id="previewImage">
                <button type="button" class="btn btn-danger btn-sm" 
                        style="position: absolute; top: 10px; right: 10px;"
                        onclick="removeImage()">
                    <i class="fas fa-times"></i>
                </button>
            `;
        };
        
        reader.readAsDataURL(file);
    }

    // Remove image
    function removeImage() {
        selectedImage = null;
        const previewContainer = document.getElementById('imagePreviewContainer');
        const fileNameDisplay = document.getElementById('fileName');
        const fileInput = document.getElementById('imageInput');
        
        previewContainer.innerHTML = `
            <div class="upload-area" onclick="document.getElementById('imageInput').click()">
                <div class="upload-icon">
                    <i class="fas fa-cloud-upload-alt"></i>
                </div>
                <h5>Click to Upload Image</h5>
                <p class="text-muted mb-0">or drag and drop</p>
                <small class="text-muted">Supported: JPG, PNG | Max: 5MB</small>
            </div>
        `;
        
        fileNameDisplay.textContent = 'No file selected';
        fileNameDisplay.classList.remove('text-primary');
        fileNameDisplay.classList.add('text-muted');
        fileInput.value = '';
    }

    // Reset image preview on form reset
    function resetImagePreview() {
        removeImage();
    }

    // Calculate final price with discount
    function calculateFinalPrice() {
        const price = parseFloat(document.getElementById('priceInput').value) || 0;
        const discount = parseFloat(document.getElementById('discountInput').value) || 0;
        
        const discountAmount = (price * discount) / 100;
        const finalPrice = price - discountAmount;
        
        document.getElementById('originalPrice').textContent = '₹' + price.toFixed(2);
        document.getElementById('discountAmount').textContent = '₹' + discountAmount.toFixed(2);
        document.getElementById('finalPrice').textContent = '₹' + finalPrice.toFixed(2);
    }

    // Form validation
    function validateForm() {
        const submitBtn = document.getElementById('submitBtn');
        const price = parseFloat(document.getElementById('priceInput').value) || 0;
        const discount = parseFloat(document.getElementById('discountInput').value) || 0;
        
        // Validate price
        if (price <= 0) {
            alert('Please enter a valid price greater than 0.');
            return false;
        }
        
        // Validate discount
        if (discount < 0 || discount > 100) {
            alert('Discount must be between 0 and 100.');
            return false;
        }
        
        // Validate image
        if (!selectedImage) {
            alert('Please upload a product image.');
            return false;
        }
        
        // Show loading on button
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...';
        submitBtn.disabled = true;
        
        return true;
    }

    // Drag and drop functionality
    document.addEventListener('DOMContentLoaded', function() {
        const uploadArea = document.querySelector('.upload-area');
        const fileInput = document.getElementById('imageInput');
        
        uploadArea.addEventListener('dragover', function(e) {
            e.preventDefault();
            uploadArea.style.borderColor = '#224abe';
            uploadArea.style.background = 'rgba(78, 115, 223, 0.15)';
        });
        
        uploadArea.addEventListener('dragleave', function(e) {
            e.preventDefault();
            uploadArea.style.borderColor = 'var(--primary)';
            uploadArea.style.background = 'rgba(78, 115, 223, 0.05)';
        });
        
        uploadArea.addEventListener('drop', function(e) {
            e.preventDefault();
            uploadArea.style.borderColor = 'var(--primary)';
            uploadArea.style.background = 'rgba(78, 115, 223, 0.05)';
            
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                // Only use the first file
                const event = { target: { files: [files[0]] } };
                previewImage(event);
                fileInput.files = files;
            }
        });
        
        // Initialize price calculation
        calculateFinalPrice();
    });

    // Real-time character count for description
    document.addEventListener('input', function(e) {
        if (e.target.name === 'description') {
            const charCount = e.target.value.length;
            const charCountElement = e.target.parentElement.nextElementSibling;
            charCountElement.textContent = `${charCount} characters (Minimum 50 recommended)`;
            
            if (charCount < 50) {
                charCountElement.classList.add('text-danger');
                charCountElement.classList.remove('text-success');
            } else {
                charCountElement.classList.remove('text-danger');
                charCountElement.classList.add('text-success');
            }
        }
    });
</script>

</body>
</html>