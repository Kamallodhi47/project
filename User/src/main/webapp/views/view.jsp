<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${product.title}- Product Details</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
:root {
	--primary-blue: #4a6cf7;
	--secondary-blue: #6c63ff;
	--success-green: #28a745;
	--danger-red: #dc3545;
}

.product-box {
	background: #fff;
	border-radius: 20px;
	padding: 25px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.product-img {
	width: 100%;
	height: 350px;
	object-fit: contain;
	border-radius: 15px;
}

.price-box {
	font-size: 20px;
}

.btn-add-to-cart {
	padding: 12px 32px;
	border-radius: 12px;
	background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
	color: #fff;
	border: none;
	font-size: 18px;
	font-weight: bold;
	cursor: pointer;
	transition: all 0.3s ease;
	box-shadow: 0 6px 20px rgba(74, 108, 247, 0.3);
	display: inline-flex;
	align-items: center;
	gap: 10px;
}

.btn-add-to-cart:hover {
	background: linear-gradient(135deg, var(--secondary-blue) 0%, var(--primary-blue) 100%);
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(74, 108, 247, 0.4);
	color: #fff;
}

.btn-add-to-cart:disabled {
	opacity: 0.7;
	cursor: not-allowed;
	transform: none;
}

.success-message {
	background: var(--success-green);
	color: white;
	padding: 12px 20px;
	border-radius: 50px;
	margin-top: 15px;
	display: none;
	align-items: center;
	gap: 10px;
	font-weight: 600;
	box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
	animation: slideIn 0.3s ease;
}

@keyframes slideIn {
	from {
		opacity: 0;
		transform: translateY(-10px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.stock-badge {
	background: #e8f5e9;
	color: #2e7d32;
	padding: 5px 12px;
	border-radius: 20px;
	font-size: 14px;
	font-weight: 600;
	display: inline-block;
}

.category-badge {
	background: #e3f2fd;
	color: var(--primary-blue);
	padding: 5px 12px;
	border-radius: 20px;
	font-size: 14px;
	font-weight: 600;
	display: inline-block;
}

.price-highlight {
	font-size: 32px;
	font-weight: 800;
	color: var(--primary-blue);
}

.original-price {
	font-size: 18px;
	color: #64748b;
	text-decoration: line-through;
}

.discount-badge {
	background: var(--success-green);
	color: white;
	padding: 4px 10px;
	border-radius: 15px;
	font-size: 14px;
	font-weight: 700;
	display: inline-block;
}
</style>
</head>

<body>

	<%@ include file="header1.jsp"%>

	<div class="container my-5">
		<div class="row g-4">

			<!-- LEFT SIDE IMAGE -->
			<div class="col-md-5">
				<div class="product-box">
					<img
						src="${pageContext.request.contextPath}/assets/img/product_img/${product.image}"
						alt="${product.title}" class="product-img">
				</div>
			</div>

			<!-- RIGHT SIDE DETAILS -->
			<div class="col-md-7">
				<div class="product-box">
					<!-- Category and Stock Badges -->
					<div class="d-flex gap-2 mb-3">
						<span class="category-badge">
							<i class="fas fa-tag me-1"></i>${product.category}
						</span>
						<span class="stock-badge">
							<i class="fas fa-box me-1"></i>${product.stockQty} ${product.stockUnit}
						</span>
					</div>

					<h2 class="mb-3">${product.title}</h2>

					<!-- Price Section -->
					<div class="d-flex align-items-center gap-3 mb-4">
						<span class="price-highlight">₹${product.discountPrice}</span>
						<span class="original-price">₹${product.price}</span>
						<span class="discount-badge">${product.discount}% OFF</span>
					</div>

					<!-- Description -->
					<div class="mb-4">
						<h5 class="fw-bold mb-2">Description</h5>
						<p class="text-muted">${product.description}</p>
					</div>

					<!-- Add to Cart Button -->
					<button class="btn-add-to-cart" onclick="addToCart()">
						<i class="fas fa-cart-plus"></i> Add to Cart
					</button>
					
					<!-- Success Message -->
					<div id="successMessage" class="success-message">
						<i class="fas fa-check-circle"></i> 
						<span id="successMessageText">Product added to cart successfully!</span>
					</div>
				</div>
			</div>

		</div>
	</div>

	<%@ include file="Footar.jsp"%>
	
	<script>
		function addToCart() {
			const productId = ${product.id};
			const btn = event.currentTarget;
			
			// Show loading state
			const originalText = btn.innerHTML;
			btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Adding...';
			btn.disabled = true;
			
			// Make API call to add to cart
			fetch('${pageContext.request.contextPath}/cart/add', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
				},
				body: JSON.stringify({
					productId: productId,
					quantity: 1
				})
			})
			.then(response => {
				if (!response.ok) {
					throw new Error('Network response was not ok');
				}
				return response.json();
			})
			.then(data => {
				// Success - show success message
				btn.innerHTML = '<i class="fas fa-check"></i> Added!';
				btn.style.background = '#28a745';
				btn.style.boxShadow = '0 6px 20px rgba(40, 167, 69, 0.3)';
				
				// Show success message
				const successMsg = document.getElementById('successMessage');
				successMsg.style.display = 'flex';
				
				// Update cart count in header
				updateCartCount(data.cartCount || 1);
				
				// Reset button after 2 seconds
				setTimeout(() => {
					btn.innerHTML = originalText;
					btn.style.background = 'linear-gradient(135deg, #4a6cf7 0%, #6c63ff 100%)';
					btn.style.boxShadow = '0 6px 20px rgba(74, 108, 247, 0.3)';
					btn.disabled = false;
					successMsg.style.display = 'none';
				}, 2000);
			})
			.catch(error => {
				console.error('Error:', error);
				
				// Show error state
				btn.innerHTML = '<i class="fas fa-exclamation-circle"></i> Failed';
				btn.style.background = '#dc3545';
				btn.style.boxShadow = '0 6px 20px rgba(220, 53, 69, 0.3)';
				
				// Show error message
				const successMsg = document.getElementById('successMessage');
				successMsg.style.background = '#dc3545';
				successMsg.innerHTML = '<i class="fas fa-exclamation-circle"></i> Failed to add to cart. Please try again.';
				successMsg.style.display = 'flex';
				
				// Reset after 2 seconds
				setTimeout(() => {
					btn.innerHTML = originalText;
					btn.style.background = 'linear-gradient(135deg, #4a6cf7 0%, #6c63ff 100%)';
					btn.style.boxShadow = '0 6px 20px rgba(74, 108, 247, 0.3)';
					btn.disabled = false;
					successMsg.style.display = 'none';
					successMsg.style.background = '#28a745'; // Reset to original color
					successMsg.innerHTML = '<i class="fas fa-check-circle"></i> <span id="successMessageText">Product added to cart successfully!</span>';
				}, 2000);
			});
		}
		
		function updateCartCount(count) {
			// Update header cart count - try different possible selectors
			const cartCountSelectors = [
				'.cart-count',
				'#cart-count',
				'.cart-counter',
				'#cartCounter',
				'.badge.bg-danger',
				'.cart-badge'
			];
			
			for (const selector of cartCountSelectors) {
				const elements = document.querySelectorAll(selector);
				elements.forEach(el => {
					if (el) {
						el.textContent = count;
						
						// Add animation
						el.style.transform = 'scale(1.3)';
						el.style.transition = 'transform 0.2s ease';
						setTimeout(() => {
							el.style.transform = 'scale(1)';
						}, 200);
					}
				});
			}
			
			// Also update any element with data-cart-count attribute
			document.querySelectorAll('[data-cart-count]').forEach(el => {
				el.setAttribute('data-cart-count', count);
			});
		}
		
		// Load cart count on page load
		document.addEventListener('DOMContentLoaded', function() {
			fetch('${pageContext.request.contextPath}/cart/count')
				.then(response => response.json())
				.then(data => {
					if (data.count !== undefined) {
						updateCartCount(data.count);
					}
				})
				.catch(error => {
					console.error('Error fetching cart count:', error);
				});
		});
	</script>
</body>
</html>