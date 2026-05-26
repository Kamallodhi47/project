<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="bg-section">
    <div class="container">
        <!-- Section Header -->
        <div class="section-header text-center mb-5">
            <h2 class="section-title">Latest Products</h2>
            <p class="text-muted mb-0">Discover our newest arrivals with amazing discounts</p>
        </div>

        <!-- Product Grid -->
        <div class="row g-4">
            <c:forEach var="p" items="${products}" varStatus="status">
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card">
                        
                        <!-- Discount Badge -->
                        <c:if test="${p.discount > 0}">
                            <span class="discount-badge">
                                <i class="fas fa-tag me-1"></i>${p.discount}% OFF
                            </span>
                        </c:if>
                        
                        <!-- Product Image with Quick View -->
                        <div class="product-image-container position-relative">
                            <img src="${pageContext.request.contextPath}/assets/img/product_img/${p.image}"
                                 class="product-img" alt="${p.title}" 
                                 onerror="this.src='https://via.placeholder.com/400x300?text=Product+Image'">
                            
                            <!-- Quick View Button -->
                            <div class="quick-view d-none d-md-block">
                                <button class="btn btn-sm btn-outline-primary quick-view-btn" 
                                        data-product-id="${p.id}">
                                    <i class="fas fa-eye me-1"></i> Quick View
                                </button>
                            </div>
                            
                            <!-- New Badge -->
                            <c:if test="${status.index < 4}">
                                <span class="position-absolute top-0 end-0 m-2 new-badge">NEW</span>
                            </c:if>
                        </div>

                        <!-- Product Title -->
                        <h5 class="product-title mt-3 mb-2">
                            <a href="${pageContext.request.contextPath}/products?id=${p.id}"
                               class="text-dark text-decoration-none product-link">
                                ${p.title}
                            </a>
                        </h5>
                        
                        <!-- Star Rating (Optional - you can add to your model) -->
                        <div class="star-rating mb-2">
                            <c:forEach begin="1" end="5" var="star">
                                <i class="fas fa-star${star <= p.rating ? '' : '-half-alt'}"></i>
                            </c:forEach>
                            <span class="rating-text ms-1">(${p.reviewCount})</span>
                        </div>

                        <!-- Price -->
                        <div class="price-container mb-3">
                            <div class="d-flex align-items-center">
                                <span class="current-price text-danger fw-bold">₹${p.discountPrice}</span>
                                <c:if test="${p.discount > 0}">
                                    <span class="original-price text-decoration-line-through text-muted ms-2">
                                        ₹${p.price}
                                    </span>
                                    <span class="discount-saved badge bg-success ms-2">
                                        Save ₹${p.price - p.discountPrice}
                                    </span>
                                </c:if>
                            </div>
                        </div>

                        <!-- Add to Cart Button -->
                        <button class="btn-addcart" 
                                onclick="addToCart(${p.id}, '${p.title}', ${p.discountPrice}, '${p.image}')">
                            <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                        </button>
                        
                        <!-- Additional Options -->
                        <div class="product-options mt-3 d-flex justify-content-between">
                            <button class="btn btn-outline-secondary btn-sm wishlist-btn"
                                    onclick="addToWishlist(${p.id})">
                                <i class="far fa-heart"></i>
                            </button>
                            <button class="btn btn-outline-secondary btn-sm compare-btn"
                                    onclick="addToCompare(${p.id})">
                                <i class="fas fa-exchange-alt"></i>
                            </button>
                        </div>

                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- View All Button -->
        <div class="text-center mt-5">
            <a href="${pageContext.request.contextPath}/products" 
               class="btn btn-lg btn-outline-primary view-all-btn">
                <span>View All Products</span>
                <i class="fas fa-arrow-right ms-2"></i>
            </a>
        </div>
    </div>
</div>

<!-- Additional CSS -->
<style>
    /* Additional Styles for Enhanced Design */
    .product-image-container {
        position: relative;
        overflow: hidden;
        border-radius: 12px;
    }
    
    .new-badge {
        background: linear-gradient(135deg, #2ecc71, #27ae60);
        color: white;
        padding: 5px 15px;
        font-size: 0.75rem;
        font-weight: 700;
        border-radius: 20px;
        box-shadow: 0 4px 8px rgba(46, 204, 113, 0.3);
    }
    
    .quick-view-btn {
        border-radius: 25px;
        padding: 8px 20px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .quick-view-btn:hover {
        background-color: #3498db;
        color: white;
        transform: translateY(-2px);
    }
    
    .product-title {
        font-size: 1.1rem;
        line-height: 1.4;
        min-height: 3em;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }
    
    .current-price {
        font-size: 1.5rem;
    }
    
    .discount-saved {
        font-size: 0.8rem;
        padding: 5px 10px;
        border-radius: 15px;
    }
    
    .product-options .btn {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
    }
    
    .product-options .btn:hover {
        background-color: #3498db;
        color: white;
        transform: rotate(360deg);
    }
    
    .view-all-btn {
        padding: 15px 40px;
        border-radius: 50px;
        font-weight: 600;
        border-width: 2px;
        transition: all 0.3s ease;
    }
    
    .view-all-btn:hover {
        background-color: #3498db;
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(52, 152, 219, 0.3);
    }
</style>

<!-- JavaScript for Interactivity -->
<script>
// Add to Cart Function
function addToCart(productId, productName, price, image) {
    // Animation effect
    const btn = event.target;
    btn.innerHTML = '<i class="fas fa-check me-2"></i>Added!';
    btn.style.background = 'linear-gradient(135deg, #2ecc71, #27ae60)';
    
    // Send AJAX request to add to cart
    fetch('${pageContext.request.contextPath}/cart/add?productId=' + productId, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
        if(data.success) {
            // Show success message
            showNotification('Added to cart successfully!', 'success');
            
            // Update cart count
            updateCartCount();
        } else {
            showNotification('Failed to add to cart', 'error');
            btn.innerHTML = '<i class="fas fa-shopping-cart me-2"></i>Add to Cart';
            btn.style.background = 'linear-gradient(135deg, #3498db, #2980b9)';
        }
    })
    .catch(error => {
        console.error('Error:', error);
        btn.innerHTML = '<i class="fas fa-shopping-cart me-2"></i>Add to Cart';
        btn.style.background = 'linear-gradient(135deg, #3498db, #2980b9)';
    });
    
    // Reset button after 2 seconds
    setTimeout(() => {
        btn.innerHTML = '<i class="fas fa-shopping-cart me-2"></i>Add to Cart';
        btn.style.background = 'linear-gradient(135deg, #3498db, #2980b9)';
    }, 2000);
}

// Wishlist Function
function addToWishlist(productId) {
    const btn = event.target.closest('.wishlist-btn');
    const icon = btn.querySelector('i');
    
    if(icon.classList.contains('far')) {
        icon.classList.remove('far');
        icon.classList.add('fas');
        btn.style.color = '#e74c3c';
        showNotification('Added to wishlist!', 'success');
    } else {
        icon.classList.remove('fas');
        icon.classList.add('far');
        btn.style.color = '';
        showNotification('Removed from wishlist!', 'info');
    }
}

// Quick View Function
document.querySelectorAll('.quick-view-btn').forEach(btn => {
    btn.addEventListener('click', function() {
        const productId = this.dataset.productId;
        // Open quick view modal or redirect
        window.location.href = '${pageContext.request.contextPath}/products/quick-view?id=' + productId;
    });
});

// Notification Function
function showNotification(message, type) {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
        <div class="notification-content">
            <i class="fas fa-${type === 'success' ? 'check-circle' : 'info-circle'} me-2"></i>
            ${message}
        </div>
    `;
    
    document.body.appendChild(notification);
    
    // Remove after 3 seconds
    setTimeout(() => {
        notification.remove();
    }, 3000);
}

// Update Cart Count
function updateCartCount() {
    fetch('${pageContext.request.contextPath}/cart/count')
        .then(response => response.json())
        .then(data => {
            const cartCount = document.querySelector('.cart-count');
            if(cartCount) {
                cartCount.textContent = data.count;
                cartCount.style.animation = 'bounce 0.5s';
                setTimeout(() => {
                    cartCount.style.animation = '';
                }, 500);
            }
        });
}

// Add CSS for notifications
const style = document.createElement('style');
style.textContent = `
    .notification {
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 20px;
        border-radius: 10px;
        color: white;
        z-index: 9999;
        animation: slideIn 0.3s ease;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }
    
    .notification-success {
        background: linear-gradient(135deg, #2ecc71, #27ae60);
    }
    
    .notification-error {
        background: linear-gradient(135deg, #e74c3c, #c0392b);
    }
    
    .notification-info {
        background: linear-gradient(135deg, #3498db, #2980b9);
    }
    
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes bounce {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.2); }
    }
`;
document.head.appendChild(style);
</script>