<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Premium Offers | FreshpickKart</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300;0,9..144,600;0,9..144,700;0,9..144,800;1,9..144,600&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>
    /* ============================================================
       DESIGN TOKENS — FreshpickKart Premium
       ============================================================ */
    :root {
        --teal:        #0d4f5c;
        --teal-2:      #1a6b7a;
        --teal-3:      #2a8fa0;
        --teal-light:  #e0f4f7;
        --saffron:     #e07b24;
        --saffron-2:   #f59332;
        --saffron-light: #fef0e0;
        --ivory:       #faf8f3;
        --ivory-2:     #f2ede3;
        --ivory-3:     #e8e1d4;
        --leaf:        #2d6a4f;
        --leaf-2:      #40916c;
        --leaf-light:  #d8f3dc;
        --crimson:     #b5281c;
        --crimson-light: #fdecea;
        --ink:         #1a1a1a;
        --ink-2:       #2e2e2e;
        --muted:       #6b6b6b;
        --muted-2:     #999999;
        --white:       #ffffff;
        --surface:     #f5f2ec;
        --shadow-xs:   0 1px 3px rgba(13,79,92,0.08);
        --shadow-sm:   0 2px 10px rgba(13,79,92,0.10);
        --shadow-md:   0 6px 24px rgba(13,79,92,0.12);
        --shadow-lg:   0 12px 48px rgba(13,79,92,0.16);
        --r-sm:  8px;
        --r-md:  14px;
        --r-lg:  20px;
        --r-xl:  28px;
        --r-2xl: 36px;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        -webkit-tap-highlight-color: transparent;
    }

    body {
        background-color: var(--surface);
        background-image: radial-gradient(ellipse 80% 50% at 15% -10%, rgba(13,79,92,0.07) 0%, transparent 60%);
        font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
        color: var(--ink);
        min-height: 100vh;
        padding-top: 70px;
        overflow-x: hidden;
    }

    h1, h2, h3, h4, h5, h6 {
        font-family: 'Fraunces', serif;
        font-weight: 700;
        color: var(--teal);
    }

    /* ============================================================
       MAIN CONTAINER
       ============================================================ */
    .main-container {
        width: 94%;
        max-width: 1600px;
        margin: 36px auto 24px;
        padding: 28px 24px;
        background: var(--white);
        border-radius: var(--r-xl);
        box-shadow: var(--shadow-md);
        border: 1px solid var(--ivory-3);
        position: relative;
    }

    .main-container::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, var(--teal-3) 0%, var(--saffron) 40%, var(--leaf-2) 80%, var(--teal-3) 100%);
        border-radius: var(--r-xl) var(--r-xl) 0 0;
    }

    @media (max-width: 768px) {
        body { padding-top: 60px; }
        .main-container { width: 92%; margin: 20px auto; padding: 20px 15px; }
    }

    /* ============================================================
       SECTION TITLE
       ============================================================ */
    .section-title {
        font-family: 'Fraunces', serif;
        text-align: center;
        font-weight: 800;
        font-size: 2rem;
        color: var(--teal);
        margin-bottom: 30px;
        position: relative;
        padding-bottom: 15px;
    }

    .section-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 80px;
        height: 4px;
        background: linear-gradient(90deg, var(--teal-3) 0%, var(--saffron) 100%);
        border-radius: 4px;
    }

    .section-title i {
        color: var(--saffron);
        margin-right: 10px;
    }

    @media (max-width: 768px) {
        .section-title { font-size: 1.5rem; margin-bottom: 20px; }
        .section-title::after { width: 60px; height: 3px; }
    }

    /* ============================================================
       PRODUCT GRID
       ============================================================ */
    .product-grid {
        display: grid;
        grid-template-columns: repeat(6, 1fr);
        gap: 20px;
    }

    @media (max-width: 1200px) {
        .product-grid { grid-template-columns: repeat(4, 1fr); }
    }

    @media (max-width: 768px) {
        .product-grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }
    }

    /* ============================================================
       OFFER CARD (Premium)
       ============================================================ */
    .offer-card {
        background: var(--ivory);
        border-radius: var(--r-lg);
        padding: 16px 12px;
        text-align: center;
        box-shadow: var(--shadow-sm);
        transition: all 0.3s cubic-bezier(0.34, 1.2, 0.64, 1);
        position: relative;
        border: 1px solid var(--ivory-3);
        overflow: hidden;
        display: flex;
        flex-direction: column;
        height: 100%;
    }

    .offer-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 4px;
        background: linear-gradient(90deg, var(--teal-2) 0%, var(--saffron) 100%);
    }

    @media (min-width: 992px) {
        .offer-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-md);
            border-color: var(--teal-3);
        }
        .offer-card:hover .offer-img {
            transform: scale(1.05);
        }
    }

    /* Discount Badge */
    .discount-badge {
        position: absolute;
        top: 12px;
        left: 12px;
        background: var(--crimson);
        color: var(--white);
        font-family: 'Plus Jakarta Sans', sans-serif;
        font-size: 11px;
        font-weight: 800;
        padding: 5px 12px;
        border-radius: 20px;
        z-index: 2;
        box-shadow: 0 2px 8px rgba(185, 40, 28, 0.3);
        letter-spacing: 0.5px;
    }

    /* Product Image */
    .offer-img {
        width: 100%;
        height: 140px;
        object-fit: contain;
        margin-bottom: 12px;
        transition: transform 0.4s ease;
        padding: 8px;
        filter: drop-shadow(0 4px 8px rgba(13,79,92,0.10));
    }

    @media (max-width: 768px) {
        .offer-img { height: 110px; }
    }

    /* Product Title */
    .product-title {
        font-family: 'Plus Jakarta Sans', sans-serif;
        font-size: 0.85rem;
        font-weight: 700;
        color: var(--ink-2);
        margin: 8px 0 5px;
        line-height: 1.3;
        min-height: 40px;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    /* Stock Info */
    .product-stock {
        font-size: 0.7rem;
        color: var(--muted-2);
        margin-bottom: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 4px;
    }

    .product-stock i {
        color: var(--teal-3);
        font-size: 0.65rem;
    }

    /* Price Section */
    .price-info-compact {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        flex-wrap: wrap;
        margin: 8px 0;
    }

    .current-price {
        font-size: 1.1rem;
        font-weight: 800;
        color: var(--crimson);
    }

    .original-price {
        font-size: 0.75rem;
        color: var(--muted-2);
        text-decoration: line-through;
    }

    /* Add to Cart Button */
    .btn-addcart {
        padding: 10px 12px;
        border-radius: var(--r-sm);
        background: var(--teal);
        border: none;
        color: var(--ivory);
        font-family: 'Plus Jakarta Sans', sans-serif;
        font-weight: 700;
        font-size: 0.8rem;
        transition: all 0.26s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        cursor: pointer;
        width: 100%;
        margin-top: auto;
    }

    .btn-addcart:active {
        transform: scale(0.96);
        background: var(--teal-2);
    }

    @media (min-width: 992px) {
        .btn-addcart:hover {
            transform: translateY(-2px);
            background: var(--teal-2);
            box-shadow: 0 6px 20px rgba(13,79,92,0.3);
        }
    }

    /* ============================================================
       TOAST NOTIFICATION
       ============================================================ */
    .toast-notification {
        position: fixed;
        bottom: 30px;
        left: 50%;
        transform: translateX(-50%) translateY(100px);
        background: var(--teal);
        color: var(--ivory);
        padding: 12px 24px;
        border-radius: 50px;
        font-weight: 600;
        z-index: 10000;
        transition: transform 0.3s ease;
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 0.9rem;
        box-shadow: var(--shadow-lg);
        font-family: 'Plus Jakarta Sans', sans-serif;
    }

    .toast-notification.show {
        transform: translateX(-50%) translateY(0);
    }

    /* ============================================================
       MOBILE FLOATING CART
       ============================================================ */
    .mobile-cart-float {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 56px;
        height: 56px;
        background: var(--teal);
        border-radius: 50%;
        display: none;
        align-items: center;
        justify-content: center;
        color: var(--ivory);
        font-size: 1.3rem;
        box-shadow: var(--shadow-lg);
        z-index: 999;
        cursor: pointer;
        border: 3px solid var(--white);
    }

    .mobile-cart-count {
        position: absolute;
        top: -5px;
        right: -5px;
        background: var(--saffron);
        color: var(--white);
        font-size: 0.7rem;
        font-weight: 800;
        width: 22px;
        height: 22px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    @media (max-width: 768px) {
        .mobile-cart-float { display: flex; }
        body { padding-bottom: 80px; }
    }

    /* ============================================================
       DARK MODE
       ============================================================ */
    @media (prefers-color-scheme: dark) {
        :root {
            --surface: #111a1c;
            --white: #1c2a2d;
            --ivory: #1e2a2d;
            --ivory-2: #243133;
            --ivory-3: #2d3f42;
            --ink: #e8e4dc;
            --ink-2: #d8d4cc;
            --muted: #8a9a9d;
            --muted-2: #6b7a7d;
        }
        body {
            background-color: var(--surface);
            background-image: radial-gradient(ellipse 80% 50% at 15% -10%, rgba(13,79,92,0.18) 0%, transparent 60%);
        }
        .main-container { background: var(--white); border-color: var(--ivory-3); }
        .offer-card { background: var(--ivory); border-color: var(--ivory-3); }
    }

    /* ============================================================
       LOADING & ANIMATIONS
       ============================================================ */
    @keyframes ripple {
        to { transform: scale(4); opacity: 0; }
    }

    .fade-in {
        animation: fadeIn 0.5s ease forwards;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

</head>

<body>

<%@ include file="header1.jsp"%>

<!-- Mobile Floating Cart -->
<div class="mobile-cart-float" onclick="window.location.href='/cart'">
    <i class="fas fa-shopping-cart"></i>
    <span class="mobile-cart-count" id="mobileCartCount">0</span>
</div>

<div class="main-container">
    <h2 class="section-title">
        <i class="fas fa-fire"></i> Top Discounted Products
    </h2>

    <div class="product-grid">
        <c:forEach var="o" items="${offerProducts}" varStatus="status">
            <div class="offer-card fade-in" style="animation-delay: ${status.index * 0.05}s">
                <c:set var="discountPercent" value="${((o.price - o.discountPrice) / o.price) * 100}" />
                <c:set var="discountInt" value="${fn:substringBefore(discountPercent, '.')}" />
                
                <span class="discount-badge">
                    <i class="fas fa-tag"></i> ${discountInt}% OFF
                </span>
                
                <img src="${pageContext.request.contextPath}/assets/img/product_img/${o.image}"
                     class="offer-img"
                     alt="${o.title}"
                     loading="lazy"
                     onerror="this.src='https://via.placeholder.com/200x200?text=Product'">
                
                <h3 class="product-title">${o.title}</h3>
                
                <div class="product-stock">
                    <i class="fas fa-weight-hanging"></i> ${o.stockQty} ${o.stockUnit}
                </div>
                
                <div class="price-info-compact">
                    <span class="current-price">₹${o.discountPrice}</span>
                    <span class="original-price">₹${o.price}</span>
                </div>
                
                <button class="btn-addcart" onclick="mobileAddToCart(event, ${o.id}, 1)">
                    <i class="fas fa-cart-plus"></i> Add to Cart
                </button>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Toast Notification -->
<div id="toastNotification" class="toast-notification">
    <i class="fas fa-check-circle"></i>
    <span id="toastMessage">Added to cart!</span>
</div>

<%@ include file="Footar.jsp"%>

<script>
    // ========== ADD TO CART FUNCTION ==========
    function mobileAddToCart(event, productId, quantity) {
        if (!quantity || quantity < 1) {
            quantity = 1;
        }

        const button = event.target.closest("button");
        
        // Save original content
        const originalHTML = button ? button.innerHTML : null;
        
        // Show loading state
        if (button) {
            button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Adding...';
            button.disabled = true;
        }
        
        // Mobile vibration feedback
        if (window.innerWidth <= 768 && navigator.vibrate) {
            navigator.vibrate(50);
        }
        
        // Add ripple effect on mobile
        if (window.innerWidth <= 768 && button) {
            const ripple = document.createElement('span');
            ripple.style.cssText = `
                position: absolute;
                border-radius: 50%;
                background: rgba(255,255,255,0.5);
                transform: scale(0);
                animation: ripple 0.6s linear;
                pointer-events: none;
            `;
            const rect = button.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            ripple.style.width = ripple.style.height = size + 'px';
            button.style.position = 'relative';
            button.style.overflow = 'hidden';
            button.appendChild(ripple);
            setTimeout(() => ripple.remove(), 600);
        }

        fetch('${pageContext.request.contextPath}/cart/add', {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
            },
            body: JSON.stringify({
                productId: productId,
                quantity: quantity
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                if (button) {
                    button.innerHTML = '<i class="fas fa-check"></i> Added!';
                    button.style.background = "var(--leaf)";
                    
                    setTimeout(() => {
                        button.innerHTML = originalHTML;
                        button.style.background = "";
                        button.disabled = false;
                    }, 1500);
                }
                
                showToast('Product added to cart!', 'success');
                updateCartCount(data.cartCount || 0);
                updateMobileCartCount(data.cartCount || 0);
            } else {
                if (button) {
                    button.innerHTML = originalHTML;
                    button.disabled = false;
                }
                showToast('Failed to add product', 'error');
            }
        })
        .catch(error => {
            console.error("Error:", error);
            if (button) {
                button.innerHTML = originalHTML;
                button.disabled = false;
            }
            showToast('Network error. Please try again.', 'error');
        });
    }

    // ========== TOAST NOTIFICATION ==========
    function showToast(message, type = 'success') {
        const toast = document.getElementById('toastNotification');
        const toastMsg = document.getElementById('toastMessage');
        const icon = toast.querySelector('i');
        
        if (type === 'error') {
            icon.className = 'fas fa-exclamation-circle';
            toast.style.background = 'var(--crimson)';
        } else {
            icon.className = 'fas fa-check-circle';
            toast.style.background = 'var(--teal)';
        }
        
        toastMsg.textContent = message;
        toast.classList.add('show');
        
        setTimeout(() => {
            toast.classList.remove('show');
        }, 2500);
    }

    // ========== CART COUNT UPDATE ==========
    function updateCartCount(count) {
        const cartCount = document.querySelector(".cart-count");
        if (cartCount) {
            cartCount.textContent = count;
            cartCount.style.transform = 'scale(1.3)';
            setTimeout(() => {
                cartCount.style.transform = 'scale(1)';
            }, 200);
        }
    }

    function updateMobileCartCount(count) {
        const mobileCount = document.getElementById("mobileCartCount");
        if (mobileCount) {
            mobileCount.textContent = count;
            mobileCount.style.transform = 'scale(1.3)';
            setTimeout(() => {
                mobileCount.style.transform = 'scale(1)';
            }, 200);
        }
    }

    // ========== LOAD CART COUNT ==========
    function loadCartCount() {
        fetch('${pageContext.request.contextPath}/cart/count')
            .then(res => res.json())
            .then(data => {
                if (data.count !== undefined) {
                    updateCartCount(data.count);
                    updateMobileCartCount(data.count);
                }
            })
            .catch(console.error);
    }

    // ========== TOUCH OPTIMIZATIONS FOR MOBILE ==========
    function initTouchOptimizations() {
        if (window.innerWidth <= 768) {
            const buttons = document.querySelectorAll('.btn-addcart');
            buttons.forEach(btn => {
                btn.addEventListener('touchstart', function() {
                    this.style.opacity = '0.8';
                }, { passive: true });
                btn.addEventListener('touchend', function() {
                    this.style.opacity = '';
                }, { passive: true });
            });
        }
    }

    // ========== INITIALIZE ==========
    document.addEventListener("DOMContentLoaded", function() {
        loadCartCount();
        initTouchOptimizations();
        
        // Add CSS animation style
        const style = document.createElement('style');
        style.textContent = `@keyframes ripple { to { transform: scale(4); opacity: 0; } }`;
        document.head.appendChild(style);
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>