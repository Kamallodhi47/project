<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Premium Products | FreshpickKart</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts: Fraunces + Plus Jakarta Sans -->
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300;0,9..144,600;0,9..144,700;0,9..144,800;1,9..144,600&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        /* ============================================================
           DESIGN TOKENS — FreshpickKart Premium (Same as Homepage)
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

        /* ============================================================
           BASE STYLES
           ============================================================ */
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
            font-size: 1.8rem;
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
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--teal-3) 0%, var(--saffron) 100%);
            border-radius: 3px;
        }

        @media (max-width: 768px) {
            .section-title { font-size: 1.5rem; margin-bottom: 20px; }
        }

        /* ============================================================
           FILTERS BAR
           ============================================================ */
        .filters-bar {
            background: var(--ivory);
            border-radius: var(--r-lg);
            padding: 16px 20px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            border: 1px solid var(--ivory-3);
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .filter-label {
            font-weight: 700;
            color: var(--teal);
            font-size: 0.85rem;
        }

        .sort-select {
            padding: 10px 35px 10px 15px;
            border-radius: var(--r-sm);
            border: 2px solid var(--ivory-3);
            background: var(--white);
            font-weight: 600;
            color: var(--ink);
            font-size: 0.85rem;
            font-family: 'Plus Jakarta Sans', sans-serif;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%230d4f5c' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 14px;
        }

        .filter-btn {
            padding: 8px 16px;
            border-radius: var(--r-sm);
            border: 2px solid var(--ivory-3);
            background: var(--white);
            font-weight: 600;
            color: var(--ink);
            font-size: 0.8rem;
            transition: all 0.3s ease;
            cursor: pointer;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .filter-btn.active {
            background: var(--teal);
            color: var(--ivory);
            border-color: var(--teal);
        }

        .product-count {
            background: var(--teal-light);
            padding: 8px 18px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.85rem;
            color: var(--teal);
        }

        @media (max-width: 768px) {
            .filters-bar {
                flex-direction: column;
                align-items: stretch;
                padding: 15px;
            }
            .filter-group { justify-content: space-between; }
            .sort-select { flex: 1; }
            .filter-btn { flex: 1; text-align: center; }
        }

        /* ============================================================
           PRODUCT GRID
           ============================================================ */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        @media (max-width: 1200px) {
            .product-grid { grid-template-columns: repeat(3, 1fr); }
        }

        @media (max-width: 768px) {
            .product-grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }
        }

        /* ============================================================
           PRODUCT CARD
           ============================================================ */
        .product-card {
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

        .product-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--teal-2) 0%, var(--saffron) 100%);
        }

        @media (min-width: 992px) {
            .product-card:hover {
                transform: translateY(-8px);
                box-shadow: var(--shadow-md);
                border-color: var(--teal-3);
            }
        }

        /* Discount Badge */
        .discount-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: var(--teal);
            color: var(--ivory);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 10px;
            font-weight: 800;
            padding: 5px 10px;
            border-radius: 20px;
            z-index: 2;
            box-shadow: 0 2px 8px rgba(13,79,92,0.22);
        }

        /* Product Image */
        .product-img-container {
            height: 160px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
            background: var(--white);
            border-radius: var(--r-md);
            padding: 12px;
        }

        .product-img {
            max-width: 100%;
            max-height: 130px;
            width: auto;
            height: auto;
            object-fit: contain;
            transition: transform 0.4s ease;
        }

        .product-card:hover .product-img {
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .product-img-container { height: 130px; }
            .product-img { max-height: 100px; }
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
        }

        /* Price Section */
        .price-container {
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

        .save-percent {
            font-size: 0.7rem;
            font-weight: 700;
            color: var(--leaf);
            background: var(--leaf-light);
            padding: 2px 8px;
            border-radius: 12px;
        }

        /* Quantity Selector */
        .qty-selector {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin: 10px 0;
        }

        .qty-btn {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: 2px solid var(--ivory-3);
            background: var(--white);
            color: var(--teal);
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.22s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .qty-btn:active {
            transform: scale(0.92);
            background: var(--teal);
            color: var(--ivory);
        }

        .qty-input {
            width: 45px;
            text-align: center;
            border: 2px solid var(--ivory-3);
            border-radius: var(--r-sm);
            padding: 6px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-weight: 700;
            font-size: 0.85rem;
            background: var(--white);
        }

        .qty-input:focus {
            outline: none;
            border-color: var(--teal);
        }

        /* Add to Cart Button */
        .add-to-cart-btn {
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

        .add-to-cart-btn:active {
            transform: scale(0.96);
            background: var(--teal-2);
        }

        @media (min-width: 992px) {
            .add-to-cart-btn:hover {
                transform: translateY(-2px);
                background: var(--teal-2);
                box-shadow: 0 6px 20px rgba(13,79,92,0.3);
            }
        }

        /* ============================================================
           CATEGORY SIDEBAR (Desktop)
           ============================================================ */
        .category-sidebar {
            background: var(--white);
            border-radius: var(--r-xl);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            border: 1px solid var(--ivory-3);
            position: sticky;
            top: 100px;
        }

        .category-header {
            background: linear-gradient(135deg, var(--teal) 0%, var(--teal-2) 100%);
            color: var(--ivory);
            padding: 18px 20px;
            font-weight: 800;
            font-size: 1.1rem;
            font-family: 'Fraunces', serif;
        }

        .category-list {
            padding: 10px 0;
        }

        .category-item {
            padding: 12px 20px;
            border-bottom: 1px solid var(--ivory-3);
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: var(--ink-2);
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .category-item:hover {
            background: rgba(13, 79, 92, 0.08);
            color: var(--teal);
            padding-left: 28px;
        }

        .category-item.active {
            background: linear-gradient(90deg, rgba(13, 79, 92, 0.12) 0%, transparent 100%);
            color: var(--teal);
            border-left: 3px solid var(--saffron);
            font-weight: 800;
        }

        .category-badge {
            background: var(--teal-light);
            color: var(--teal);
            padding: 2px 8px;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 700;
        }

        /* Mobile Category Toggle */
        .mobile-category-toggle {
            display: none;
            background: linear-gradient(135deg, var(--teal) 0%, var(--teal-2) 100%);
            color: var(--ivory);
            padding: 14px 20px;
            border-radius: var(--r-lg);
            margin: 0 15px 20px 15px;
            font-weight: 800;
            text-align: center;
            cursor: pointer;
            border: none;
            width: calc(100% - 30px);
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        @media (max-width: 767px) {
            .category-sidebar { display: none; }
            .mobile-category-toggle { display: block; }
        }

        /* ============================================================
           PAGINATION
           ============================================================ */
        .pagination-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }

        .pagination-custom {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .page-link {
            width: 42px;
            height: 42px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: var(--r-sm);
            background: var(--white);
            border: 2px solid var(--ivory-3);
            color: var(--ink-2);
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .page-link.active {
            background: var(--teal);
            color: var(--ivory);
            border-color: var(--teal);
        }

        /* ============================================================
           NO PRODUCTS
           ============================================================ */
        .no-products {
            text-align: center;
            padding: 60px 20px;
            background: var(--ivory);
            border-radius: var(--r-xl);
            border: 1px solid var(--ivory-3);
        }

        .no-products i {
            font-size: 4rem;
            color: var(--teal-3);
            margin-bottom: 20px;
            opacity: 0.6;
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
            }
            body { background-color: var(--surface); }
            .main-container, .category-sidebar { background: var(--white); border-color: var(--ivory-3); }
            .product-card { background: var(--ivory); border-color: var(--ivory-3); }
            .product-img-container { background: var(--ivory-2); }
            .qty-input, .qty-btn, .sort-select, .filter-btn, .page-link { background: var(--ivory-2); border-color: var(--ivory-3); color: var(--ink); }
        }
    </style>
</head>
<body>

<%@ include file="header1.jsp" %>

<!-- Mobile Category Toggle -->
<button class="mobile-category-toggle" onclick="toggleMobileCategories()">
    <i class="fas fa-filter me-2"></i> Browse Categories
</button>

<!-- Mobile Floating Cart -->
<div class="mobile-cart-float" onclick="window.location.href='/cart'">
    <i class="fas fa-shopping-cart"></i>
    <span class="mobile-cart-count" id="mobileCartCount">0</span>
</div>

<div class="main-container">
    <div class="row g-4">
        <!-- Category Sidebar -->
        <div class="col-lg-3 col-md-4">
            <div class="category-sidebar">
                <div class="category-header">
                    <i class="fas fa-tags me-2"></i> Categories
                </div>
                <div class="category-list">
                    <a href="/products" class="category-item ${empty param.category ? 'active' : ''}">
                        <span><i class="fas fa-box me-2"></i>All Products</span>
                        <span class="category-badge">${fn:length(products)}</span>
                    </a>
                    <c:forEach var="c" items="${categories}">
                        <c:set var="categoryCount" value="0" />
                        <c:forEach var="p" items="${products}">
                            <c:if test="${p.category eq c.name}">
                                <c:set var="categoryCount" value="${categoryCount + 1}" />
                            </c:if>
                        </c:forEach>
                        <a href="/products?category=${c.name}" class="category-item ${param.category eq c.name ? 'active' : ''}">
                            <span><i class="fas fa-tag me-2"></i>${c.name}</span>
                            <span class="category-badge">${categoryCount}</span>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- Products Section -->
        <div class="col-lg-9 col-md-8">
            <!-- Section Title -->
            <h1 class="section-title">
                <c:choose>
                    <c:when test="${not empty param.category}">${param.category}</c:when>
                    <c:otherwise>Fresh Picks</c:otherwise>
                </c:choose>
            </h1>

            <!-- Filters Bar -->
            

            <!-- Products Grid -->
            <c:choose>
                <c:when test="${not empty products}">
                    <div class="product-grid" id="productGrid">
                        <c:forEach var="p" items="${products}">
                            <div class="product-card" data-product-id="${p.id}" data-price="${p.discountPrice}" data-discount="${p.discount}">
                                <c:if test="${p.discount > 0}">
                                    <span class="discount-badge">${p.discount}% OFF</span>
                                </c:if>
                                
                                <div class="product-img-container">
                                    <img src="${pageContext.request.contextPath}/assets/img/product_img/${p.image}"
                                         class="product-img"
                                         alt="${p.title}"
                                         loading="lazy"
                                         onerror="this.src='https://via.placeholder.com/200x200?text=Product'">
                                </div>
                                
                                <h3 class="product-title">${p.title}</h3>
                                <div class="product-stock">
                                    <i class="fas fa-weight-hanging me-1"></i> ${p.stockQty} ${p.stockUnit}
                                </div>
                                
                                <div class="price-container">
                                    <span class="current-price">₹${p.discountPrice}</span>
                                    <c:if test="${p.discount > 0}">
                                        <span class="original-price">₹${p.price}</span>
                                        <span class="save-percent">Save ${p.discount}%</span>
                                    </c:if>
                                </div>
                                
                                <div class="qty-selector">
                                    <button class="qty-btn" onclick="changeQty(this, -1)">−</button>
                                    <input type="text" class="qty-input" value="0" readonly>
                                    <button class="qty-btn" onclick="changeQty(this, 1)">+</button>
                                </div>
                                
                                <button class="add-to-cart-btn" onclick="addToCart(this, ${p.id}, '${p.title}', ${p.discountPrice})">
                                    <i class="fas fa-cart-plus"></i> Add to Cart
                                </button>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- Pagination -->
                    <c:if test="${fn:length(products) > 12}">
                        <div class="pagination-wrapper">
                            <div class="pagination-custom">
                                <a href="#" class="page-link"><i class="fas fa-chevron-left"></i></a>
                                <a href="#" class="page-link active">1</a>
                                <a href="#" class="page-link">2</a>
                                <a href="#" class="page-link">3</a>
                                <a href="#" class="page-link"><i class="fas fa-chevron-right"></i></a>
                            </div>
                        </div>
                    </c:if>
                </c:when>
                
                <c:otherwise>
                    <div class="no-products">
                        <i class="fas fa-box-open"></i>
                        <h3>No Products Found</h3>
                        <p class="text-muted">Try browsing other categories or check back later!</p>
                        <button class="add-to-cart-btn" onclick="window.location.href='/products'" style="width: auto; padding: 12px 30px; margin-top: 20px;">
                            Browse All Products
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Toast Notification -->
<div id="toastNotification" class="toast-notification">
    <i class="fas fa-check-circle"></i>
    <span id="toastMessage">Added to cart!</span>
</div>

<%@ include file="Footar.jsp" %>

<script>
    // ========== QUANTITY CHANGE ==========
    function changeQty(btn, delta) {
        const qtySelector = btn.closest('.qty-selector');
        const input = qtySelector.querySelector('.qty-input');
        let val = parseInt(input.value) || 0;
        val += delta;
		if (val < 0) val = 0;
        if (val > 99) val = 99;
        input.value = val;
        
        // Mobile vibration
        if (window.innerWidth <= 768 && navigator.vibrate) {
            navigator.vibrate(10);
        }
    }
    
    // ========== ADD TO CART ==========
    function addToCart(button, productId, productTitle, price) {
        const card = button.closest('.product-card');
        const qtyInput = card.querySelector('.qty-input');
        const quantity = parseInt(qtyInput.value) || 1;
        
        // Show loading state
        const originalHTML = button.innerHTML;
        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Adding...';
        button.disabled = true;
        
        // Mobile vibration
        if (window.innerWidth <= 768 && navigator.vibrate) {
            navigator.vibrate(50);
        }
        
        // Add ripple effect on mobile
        if (window.innerWidth <= 768) {
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
        
        // API Call
        fetch('/cart/add', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ productId: productId, quantity: quantity })
        })
        .then(response => response.json())
        .then(data => {
            button.innerHTML = '<i class="fas fa-check"></i> Added!';
            button.style.background = 'var(--leaf)';
            
            setTimeout(() => {
                button.innerHTML = originalHTML;
                button.style.background = '';
                button.disabled = false;
            }, 1500);
            
            showToast(`${productTitle} added to cart!`);
            updateCartCount(data.cartCount);
        })
        .catch(error => {
            console.error('Error:', error);
            button.innerHTML = originalHTML;
            button.disabled = false;
            showToast('Failed to add to cart', 'error');
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
    
    // ========== UPDATE CART COUNT ==========
    function updateCartCount(count) {
        const cartCount = document.getElementById('mobileCartCount');
        if (cartCount) {
            cartCount.textContent = count;
            cartCount.style.transform = 'scale(1.3)';
            setTimeout(() => {
                cartCount.style.transform = 'scale(1)';
            }, 200);
        }
        
        // Also update header cart count if exists
        const headerCart = document.querySelector('.cart-count, #cartCount');
        if (headerCart) {
            headerCart.textContent = count;
        }
    }
    
    // ========== LOAD CART COUNT ==========
    function loadCartCount() {
        fetch('/cart/count')
            .then(response => response.json())
            .then(data => {
                if (data.count !== undefined) {
                    updateCartCount(data.count);
                }
            })
            .catch(console.error);
    }
    
    // ========== MOBILE CATEGORY TOGGLE ==========
    function toggleMobileCategories() {
        const sidebar = document.querySelector('.category-sidebar');
        const btn = document.querySelector('.mobile-category-toggle');
        
        if (sidebar.style.display === 'block') {
            sidebar.style.display = 'none';
            btn.innerHTML = '<i class="fas fa-filter me-2"></i> Browse Categories';
            document.body.style.overflow = '';
        } else {
            sidebar.style.display = 'block';
            sidebar.style.position = 'fixed';
            sidebar.style.top = '70px';
            sidebar.style.left = '15px';
            sidebar.style.right = '15px';
            sidebar.style.width = 'calc(100% - 30px)';
            sidebar.style.zIndex = '999';
            sidebar.style.maxHeight = '80vh';
            sidebar.style.overflowY = 'auto';
            btn.innerHTML = '<i class="fas fa-times me-2"></i> Close Categories';
            document.body.style.overflow = 'hidden';
        }
    }
    
    // ========== FILTER FUNCTIONS ==========
    let activeFilters = { instock: false, discount: false };
    
    function toggleFilter(btn, filterType) {
        btn.classList.toggle('active');
        activeFilters[filterType] = btn.classList.contains('active');
        applyFilters();
    }
    
    function handleSortChange(select) {
        const sortValue = select.value;
        applyFilters(sortValue);
    }
    
    function applyFilters(sortBy = null) {
        const products = document.querySelectorAll('.product-card');
        let visibleCount = 0;
        
        products.forEach(product => {
            let show = true;
            
            if (activeFilters.instock) {
                const stockText = product.querySelector('.product-stock')?.innerText || '';
                if (stockText.includes('0') || stockText.toLowerCase().includes('out')) show = false;
            }
            
            if (activeFilters.discount) {
                const discountBadge = product.querySelector('.discount-badge');
                if (!discountBadge) show = false;
            }
            
            product.style.display = show ? 'flex' : 'none';
            if (show) visibleCount++;
        });
        
        // Update product count
        const countEl = document.querySelector('.product-count');
        if (countEl) {
            countEl.innerHTML = `<i class="fas fa-box me-1"></i> ${visibleCount} Products`;
        }
        
        // Apply sorting if needed
        if (sortBy && sortBy !== 'featured') {
            sortProducts(sortBy);
        }
    }
    
    function sortProducts(sortBy) {
        const grid = document.getElementById('productGrid');
        const products = Array.from(document.querySelectorAll('.product-card'));
        
        products.sort((a, b) => {
            const priceA = parseFloat(a.dataset.price);
            const priceB = parseFloat(b.dataset.price);
            const discountA = parseFloat(a.dataset.discount);
            const discountB = parseFloat(b.dataset.discount);
            
            if (sortBy === 'price-low') return priceA - priceB;
            if (sortBy === 'price-high') return priceB - priceA;
            if (sortBy === 'discount') return discountB - discountA;
            return 0;
        });
        
        products.forEach(product => {
            grid.appendChild(product);
        });
    }
    
    // ========== WINDOW RESIZE HANDLER ==========
    window.addEventListener('resize', function() {
        const sidebar = document.querySelector('.category-sidebar');
        const btn = document.querySelector('.mobile-category-toggle');
        
        if (window.innerWidth > 767) {
            if (sidebar) sidebar.style.display = '';
            if (btn) btn.innerHTML = '<i class="fas fa-filter me-2"></i> Browse Categories';
            document.body.style.overflow = '';
        } else {
            if (sidebar) sidebar.style.display = 'none';
        }
    });
    
    // ========== CSS RIPPLE ANIMATION ==========
    const style = document.createElement('style');
    style.textContent = `
        @keyframes ripple {
            to { transform: scale(4); opacity: 0; }
        }
    `;
    document.head.appendChild(style);
    
    // ========== INITIALIZE ==========
    document.addEventListener('DOMContentLoaded', function() {
        loadCartCount();
        
        // Touch feedback for mobile
        if (window.innerWidth <= 768) {
            const btns = document.querySelectorAll('.add-to-cart-btn, .qty-btn, .filter-btn, .category-item');
            btns.forEach(btn => {
                btn.addEventListener('touchstart', function() {
                    this.style.opacity = '0.8';
                }, { passive: true });
                btn.addEventListener('touchend', function() {
                    this.style.opacity = '';
                }, { passive: true });
            });
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>