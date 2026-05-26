<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Category Management - Admin Panel</title>

<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
:root {
	--primary-color: #6366f1;
	--primary-dark: #4f46e5;
	--success-color: #10b981;
	--danger-color: #ef4444;
	--warning-color: #f59e0b;
	--dark-color: #1f2937;
	--light-color: #f8fafc;
	--card-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px
		rgba(0, 0, 0, 0.04);
	--card-hover: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px
		rgba(0, 0, 0, 0.04);
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	color: var(--dark-color);
}

.admin-container {
	min-height: 100vh;
	padding: 2rem 0;
}

.glass-card {
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(10px);
	border-radius: 20px;
	border: 1px solid rgba(255, 255, 255, 0.2);
	box-shadow: var(--card-shadow);
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.glass-card:hover {
	box-shadow: var(--card-hover);
	transform: translateY(-5px);
}

.card-header-gradient {
	background: linear-gradient(135deg, var(--primary-color),
		var(--primary-dark));
	color: white;
	border-radius: 20px 20px 0 0 !important;
	padding: 1.5rem 2rem;
	border: none;
}

.card-header-gradient h3 {
	margin: 0;
	font-weight: 700;
	font-size: 1.5rem;
	display: flex;
	align-items: center;
	gap: 0.5rem;
}

.card-body-padded {
	padding: 2rem;
}

.form-group-modern {
	margin-bottom: 1.5rem;
}

.form-label-modern {
	font-weight: 600;
	color: var(--dark-color);
	margin-bottom: 0.5rem;
	display: block;
	font-size: 0.9rem;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.form-control-modern {
	border: 2px solid #e2e8f0;
	border-radius: 12px;
	padding: 0.75rem 1rem;
	font-size: 1rem;
	transition: all 0.3s ease;
	background: #fff;
}

.form-control-modern:focus {
	border-color: var(--primary-color);
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
	transform: translateY(-2px);
}

.status-toggle-group {
	display: flex;
	gap: 1rem;
	background: #f8fafc;
	padding: 1rem;
	border-radius: 12px;
	border: 2px solid #e2e8f0;
}

.toggle-option {
	flex: 1;
	text-align: center;
}

.toggle-input {
	display: none;
}

.toggle-label {
	display: block;
	padding: 0.75rem 1rem;
	border: 2px solid #e2e8f0;
	border-radius: 10px;
	cursor: pointer;
	transition: all 0.3s ease;
	font-weight: 500;
	background: white;
}

.toggle-input:checked+.toggle-label {
	border-color: var(--primary-color);
	background: var(--primary-color);
	color: white;
	transform: scale(1.05);
}

.file-upload-modern {
	border: 3px dashed #cbd5e1;
	border-radius: 16px;
	padding: 2.5rem;
	text-align: center;
	background: #f8fafc;
	transition: all 0.3s ease;
	cursor: pointer;
	position: relative;
	overflow: hidden;
}

.file-upload-modern:hover {
	border-color: var(--primary-color);
	background: rgba(99, 102, 241, 0.05);
}

.file-upload-modern.dragover {
	border-color: var(--primary-color);
	background: rgba(99, 102, 241, 0.1);
	transform: scale(1.02);
}

.upload-icon {
	font-size: 3rem;
	color: var(--primary-color);
	margin-bottom: 1rem;
	transition: all 0.3s ease;
}

.btn-modern-primary {
	background: linear-gradient(135deg, var(--primary-color),
		var(--primary-dark));
	border: none;
	border-radius: 12px;
	padding: 1rem 2rem;
	font-weight: 600;
	font-size: 1rem;
	color: white;
	width: 100%;
	transition: all 0.3s ease;
	position: relative;
	overflow: hidden;
}

.btn-modern-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px -5px rgba(99, 102, 241, 0.4);
}

.btn-modern-primary:active {
	transform: translateY(0);
}

/* Table Styles */
.table-modern {
	background: white;
	border-radius: 16px;
	overflow: hidden;
	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
	border: 1px solid #e2e8f0;
}

.table-modern thead th {
	background: linear-gradient(135deg, var(--primary-color),
		var(--primary-dark));
	color: white;
	border: none;
	padding: 1.25rem 1rem;
	font-weight: 600;
	font-size: 0.9rem;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.table-modern tbody td {
	padding: 1rem;
	vertical-align: middle;
	border-color: #f1f5f9;
	transition: all 0.3s ease;
}

.table-modern tbody tr:hover td {
	background: #f8fafc;
	transform: scale(1.01);
}

.status-badge-modern {
	padding: 0.5rem 1rem;
	border-radius: 20px;
	font-weight: 600;
	font-size: 0.8rem;
	display: inline-flex;
	align-items: center;
	gap: 0.5rem;
}

.status-active {
	background: rgba(16, 185, 129, 0.15);
	color: var(--success-color);
	border: 1px solid rgba(16, 185, 129, 0.3);
}

.status-inactive {
	background: rgba(239, 68, 68, 0.15);
	color: var(--danger-color);
	border: 1px solid rgba(239, 68, 68, 0.3);
}

.category-image-modern {
	width: 60px;
	height: 60px;
	border-radius: 12px;
	object-fit: cover;
	border: 3px solid #e2e8f0;
	transition: all 0.3s ease;
}

.category-image-modern:hover {
	transform: scale(1.1);
	border-color: var(--primary-color);
}

.action-buttons {
	display: flex;
	gap: 0.5rem;
}

.btn-action {
	padding: 0.5rem 1rem;
	border-radius: 10px;
	font-size: 0.8rem;
	font-weight: 600;
	text-decoration: none;
	transition: all 0.3s ease;
	display: inline-flex;
	align-items: center;
	gap: 0.5rem;
	border: 2px solid transparent;
}

.btn-edit {
	background: rgba(99, 102, 241, 0.1);
	color: var(--primary-color);
	border-color: var(--primary-color);
}

.btn-edit:hover {
	background: var(--primary-color);
	color: white;
	transform: translateY(-2px);
}

.btn-delete {
	background: rgba(239, 68, 68, 0.1);
	color: var(--danger-color);
	border-color: var(--danger-color);
}

.btn-delete:hover {
	background: var(--danger-color);
	color: white;
	transform: translateY(-2px);
}

/* Alert Messages */
.alert-modern {
	border-radius: 12px;
	padding: 1rem 1.5rem;
	margin-bottom: 1.5rem;
	border: none;
	font-weight: 500;
	display: flex;
	align-items: center;
	gap: 0.75rem;
}

.alert-success-modern {
	background: rgba(16, 185, 129, 0.1);
	color: var(--success-color);
	border-left: 4px solid var(--success-color);
}

.alert-danger-modern {
	background: rgba(239, 68, 68, 0.1);
	color: var(--danger-color);
	border-left: 4px solid var(--danger-color);
}

/* Pagination */
.pagination-modern {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-top: 2rem;
	padding-top: 1.5rem;
	border-top: 2px solid #e2e8f0;
}

.total-count-modern {
	font-weight: 600;
	color: var(--primary-color);
	background: rgba(99, 102, 241, 0.1);
	padding: 0.75rem 1.5rem;
	border-radius: 10px;
	display: inline-flex;
	align-items: center;
	gap: 0.5rem;
}

.pagination-nav .page-link {
	border: 2px solid #e2e8f0;
	border-radius: 10px;
	padding: 0.75rem 1rem;
	margin: 0 0.25rem;
	color: var(--primary-color);
	font-weight: 600;
	transition: all 0.3s ease;
}

.pagination-nav .page-item.active .page-link {
	background: var(--primary-color);
	border-color: var(--primary-color);
	color: white;
}

.pagination-nav .page-item.disabled .page-link {
	color: #94a3b8;
	background: #f1f5f9;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.admin-container {
		padding: 1rem 0;
	}
	.card-body-padded {
		padding: 1.5rem;
	}
	.table-responsive {
		font-size: 0.85rem;
	}
	.action-buttons {
		flex-direction: column;
	}
	.btn-action {
		justify-content: center;
	}
	.pagination-modern {
		flex-direction: column;
		gap: 1rem;
		text-align: center;
	}
}

/* Animation */
@keyframes fadeIn {
	from {
		opacity: 0;
		transform: translateY(20px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}
.fade-in {
	animation: fadeIn 0.6s ease-out;
}

/* File input styling */
.file-input-hidden {
	display: none;
}

.file-info {
	margin-top: 1rem;
	padding: 0.75rem;
	background: rgba(99, 102, 241, 0.05);
	border-radius: 8px;
	border: 1px solid rgba(99, 102, 241, 0.2);
	display: none;
}

.file-info.active {
	display: block;
}
</style>
</head>
<body>
	<%@ include file="header1.jsp"%>

	<!-- Your content -->
	<section class="admin-container">
		<div class="container-fluid">
			<div class="row g-4 fade-in">
				<!-- Add Category Form -->
				<div class="col-xl-4 col-lg-5 col-md-6">
					<div class="glass-card">
						<div class="card-header-gradient">
							<h3>
								<i class="fas fa-plus-circle"></i> Add New Category
							</h3>
						</div>
						<div class="card-body-padded">
							<!-- Success Message -->
							<c:if test="${not empty sessionScope.succMsg}">
								<div class="alert-modern alert-success-modern">
									<i class="fas fa-check-circle fa-lg"></i>
									${sessionScope.succMsg}
								</div>
								<c:remove var="succMsg" scope="session" />
							</c:if>

							<!-- Error Message -->
							<c:if test="${not empty sessionScope.errorMsg}">
								<div class="alert-modern alert-danger-modern">
									<i class="fas fa-exclamation-circle fa-lg"></i>
									${sessionScope.errorMsg}
								</div>
								<c:remove var="errorMsg" scope="session" />
							</c:if>

							<form action="/saveCategory" method="post"
								enctype="multipart/form-data" id="categoryForm">

								<!-- Category Name -->
								<div class="form-group-modern">
									<label class="form-label-modern">Category Name</label> <input
										type="text" name="name"
										class="form-control form-control-modern"
										placeholder="Enter category name" required>
								</div>

								<!-- Status -->
								<div class="form-group-modern">
									<label class="form-label-modern">Status</label>
									<div class="status-toggle-group">
										<div class="toggle-option">
											<input type="radio" class="toggle-input" checked value="true"
												name="isActive" id="activeStatus"> <label
												class="toggle-label" for="activeStatus"> <i
												class="fas fa-check me-1"></i>Active
											</label>
										</div>
										<div class="toggle-option">
											<input type="radio" class="toggle-input" name="isActive"
												value="false" id="inactiveStatus"> <label
												class="toggle-label" for="inactiveStatus"> <i
												class="fas fa-times me-1"></i>Inactive
											</label>
										</div>
									</div>
								</div>

								<!-- Image Upload -->
								<div class="form-group-modern">
									<label class="form-label-modern">Category Image</label>
									<div class="file-upload-modern" id="fileUploadArea">
										<div class="upload-icon">
											<i class="fas fa-cloud-upload-alt"></i>
										</div>
										<h5 class="mb-2">Upload Category Image</h5>
										<p class="text-muted mb-3">Drag & drop or click to browse</p>
										 <input type="file" name="file" id="file" accept="image/*" required>
										<small class="text-muted">Supports: JPG, PNG, WEBP | Max: 5MB</small>
									</div>
									<div class="file-info" id="fileInfo">
										<i class="fas fa-file-image text-primary me-2"></i>
										<span id="fileName"></span>
										<span id="fileSize" class="ms-2 text-muted"></span>
									</div>
								</div>

								<!-- Save Button -->
								<button type="submit" class="btn btn-modern-primary">
									<i class="fas fa-save me-2"></i>Save Category
								</button>
						</form>
						</div>
					</div>
				</div>

				<!-- Category List -->
				<div class="col-xl-8 col-lg-7 col-md-6">
					<div class="glass-card">
						<div class="card-header-gradient">
							<h3>
								<i class="fas fa-list"></i> Category Details
							</h3>
						</div>
						<div class="card-body-padded">
							<div class="table-responsive">
								<table class="table table-modern">
									<thead>
										<tr>
											<th scope="col">#</th>
											<th scope="col">Category Name</th>
											<th scope="col">Status</th>
											<th scope="col">Image</th>
											<th scope="col">Actions</th>
										</tr>
									</thead>
									<tbody>
										<!-- Categories Loop -->
										<c:forEach var="cat" items="${categories}" varStatus="c">
											<tr>
												<th scope="row" class="fw-bold">${c.count}</th>
												<td class="fw-semibold">${cat.name}</td>
												<td><span
													class="status-badge-modern ${cat.isActive ? 'status-active' : 'status-inactive'}">
														<i class="fas ${cat.isActive ? 'fa-check' : 'fa-times'}"></i>
														${cat.isActive ? 'Active' : 'Inactive'}
												</span></td>
												<td><c:choose>
														<c:when test="${not empty cat.imageName}">
															<img src="../assets/img/category_img/${cat.imageName}"
																alt="${cat.name}" class="category-image-modern">
														</c:when>
														<c:otherwise>
															<div class="text-muted fst-italic">
																<i class="fas fa-image me-1"></i>No Image
															</div>
														</c:otherwise>
													</c:choose></td>
												<td>
													<div class="action-buttons">
														<a href="/loadEditCategory/${cat.id}"
															class="btn-action btn-edit"> <i class="fas fa-edit"></i>Edit
														</a> <a href="/deleteCategory/${cat.id}"
															class="btn-action btn-delete"
															onclick="return confirm('Are you sure you want to delete ${cat.name}?')">
															<i class="fas fa-trash"></i>Delete
														</a>
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

							<!-- Pagination -->
							<div class="pagination-modern">
								<div class="total-count-modern">
									<i class="fas fa-layer-group"></i> Total Categories:
									${totalElements}
								</div>

								<c:if test="${totalElements > 0}">
									<nav class="pagination-nav" aria-label="Category pagination">
										<ul class="pagination mb-0">
											<li class="page-item ${isFirst ? 'disabled' : ''}"><a
												class="page-link" href="/admin/category?pageNo=${pageNo-1}"
												aria-label="Previous"> <i class="fas fa-chevron-left"></i>
											</a></li>

											<c:forEach begin="1" end="${totalPages}" var="i">
												<li class="page-item ${pageNo+1 == i ? 'active' : ''}">
													<a class="page-link" href="/admin/category?pageNo=${i-1}">${i}</a>
												</li>
											</c:forEach>

											<li class="page-item ${isLast ? 'disabled' : ''}"><a
												class="page-link" href="/admin/category?pageNo=${pageNo+1}"
												aria-label="Next"> <i class="fas fa-chevron-right"></i>
											</a></li>
										</ul>
									</nav>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="Footar.jsp"%>

	<script>
document.addEventListener('DOMContentLoaded', function() {
    const fileUploadArea = document.getElementById('fileUploadArea');
    const fileInput = document.getElementById('fileInput');
    const fileInfo = document.getElementById('fileInfo');
    const fileName = document.getElementById('fileName');
    const fileSize = document.getElementById('fileSize');
    const form = document.getElementById('categoryForm');

    // Click handler to open file chooser
    fileUploadArea.addEventListener('click', () => {
        fileInput.click();
    });

    // File input change handler
    fileInput.addEventListener('change', () => {
        if(fileInput.files.length > 0){
            const file = fileInput.files[0];
            const fileNameText = file.name;
            const fileSizeText = (file.size / 1024 / 1024).toFixed(2) + ' MB';
            
            // Update file info display
            fileName.textContent = fileNameText;
            fileSize.textContent = fileSizeText;
            fileInfo.classList.add('active');
            
            // Update upload area appearance
            fileUploadArea.innerHTML = `
                <div class="upload-icon text-success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h5 class="text-success mb-2">File Selected</h5>
                <p class="text-success fw-bold mb-1">${fileNameText}</p>
                <small class="text-muted">${fileSizeText} - Click to change</small>
            `;
        }
    });

    // Drag & Drop functionality
    ['dragover','dragenter'].forEach(evt => {
        fileUploadArea.addEventListener(evt, e => {
            e.preventDefault();
            fileUploadArea.classList.add('dragover');
        });
    });

    ['dragleave','dragend','drop'].forEach(evt => {
        fileUploadArea.addEventListener(evt, e => {
            e.preventDefault();
            fileUploadArea.classList.remove('dragover');
        });
    });

    fileUploadArea.addEventListener('drop', e => {
        e.preventDefault();
        if(e.dataTransfer.files.length > 0){
            fileInput.files = e.dataTransfer.files;
            
            // Trigger change event manually
            const event = new Event('change');
            fileInput.dispatchEvent(event);
        }
    });

    // Form validation for category name
    form.addEventListener('submit', e => {
        const nameInput = document.querySelector('input[name="name"]');
        if(!nameInput.value.trim()){
            e.preventDefault();
            nameInput.focus();
            nameInput.style.borderColor = 'red';
            setTimeout(() => nameInput.style.borderColor = '', 2000);
        }
    });
});
</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>