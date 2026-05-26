<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>FreshpickKart</title>

<!-- FontAwesome Icons -->
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- Bootstrap CSS -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet">

<style>
/* =================== GLOBAL RESET =================== */
* {       
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    -webkit-tap-highlight-color: transparent;
}

html {
    font-size: 16px;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    overflow-x: hidden;
}

/* =================== MOBILE FIRST DESIGN =================== */

/* =================== HEADER =================== */
.main-header {
    background: linear-gradient(135deg, #d0dbe7 0%,  #225db5 100%);
    color: #fff;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

/* =================== MOBILE HEADER CONTAINER =================== */
.header-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 60px;
    padding: 8px 15px;
    z-index: 1000;
}

/* =================== LOGO - PRODUCTION LEVEL WITH ROUNDED CORNERS =================== */
.logo-wrapper {
    display: flex;
    align-items: center;
    height: 100%;
    max-height: 60px;
    width: auto;
    overflow: visible;  /* Changed from hidden to visible */
    flex-shrink: 0;
}

.logo-link {
    display: flex;
    align-items: center;
    height: 100%;
    text-decoration: none;
}

.logo-img {
    height: auto;
    width: auto;
    max-height: 60px;
    max-width: 160px;
    object-fit: contain;
    transition: all 0.3s ease;
    /*border-radius: 12px; */ /* Rounded corners */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);  /* Subtle shadow for depth */
    border: 2px solid rgba(255, 255, 255, 0.3);  /* Light border */
   /* background-color: white;*/  /* Background color in case of transparent PNG */
    padding: 2px;  /* Inner padding */
}

/* Logo hover effect */
/*.logo-img:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
    border-color: #ff9900;
}
*/
/* Small Mobile Devices */
@media (max-width: 480px) {
    .logo-img {
        max-height: 40px;
        max-width: 140px;
        border-radius: 10px;
        border-width: 1.5px;
    }
}

/* Handle extremely small screens */
@media (max-width: 360px) {
    .logo-img {
        max-height: 35px;
        max-width: 120px;
        border-radius: 8px;
        border-width: 1px;
    }
}

/* Tablet Optimizations */
@media (min-width: 768px) {
    .header-container {
        height: 70px;
        padding: 10px 20px;
    }
    
    .logo-wrapper {
        max-height: 70px;
    }
    
    .logo-img {
        max-height: 55px;
        max-width: 200px;
        border-radius: 16px;
        border-width: 2px;
    }
}

/* Desktop Optimizations */
@media (min-width: 992px) {
    .header-container {
        height: 80px;
        padding: 12px 30px;
        max-width: 1400px;
        margin: 0 auto;
    }
    
    .logo-wrapper {
        max-height: 80px;
    }
    
    .logo-img {
        max-height: 65px;
        max-width: 260px;
        border-radius: 20px;
        border-width: 3px;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.25);
    }
}

/* Large Desktop */
@media (min-width: 1200px) {
    .logo-img {
        max-height: 70px;
        max-width: 300px;
        border-radius: 24px;
    }
}

/* =================== SEARCH - MOBILE FIRST =================== */
.search-section {
    position: relative;
    width: 100%;
    margin: 0 10px;
}

.search-container {
    display: flex;
    width: 100%;
    height: 40px;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
    background: white;
}

.search-input {
    flex: 1;
    padding: 0 15px;
    border: none;
    outline: none;
    font-size: 14px;
    color: #333;
    background: transparent;
}

.search-input::placeholder {
    color: #888;
    font-size: 13px;
}

.search-btn {
    padding: 0 18px;
    background: linear-gradient(135deg, #ff9900 0%, #ffac31 100%);
    border: none;
    color: white;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 50px;
    transition: all 0.3s ease;
}

.search-btn:hover {
    background: linear-gradient(135deg, #ff8c00 0%, #ff9a00 100%);
}

.search-btn i {
    font-size: 16px;
}

/* Tablet Search */
@media (min-width: 768px) {
    .search-section {
        margin: 0 15px;
    }
    
    .search-container {
        height: 44px;
    }
    
    .search-input {
        font-size: 15px;
        padding: 0 20px;
    }
    
    .search-btn {
        padding: 0 25px;
        min-width: 60px;
    }
}

/* Desktop Search */
@media (min-width: 992px) {
    .search-section {
        max-width: 600px;
        margin: 0 20px;
    }
    
    .search-container {
        height: 48px;
    }
    
    .search-input {
        font-size: 16px;
    }
    
    .search-btn {
        padding: 0 30px;
        min-width: 70px;
    }
}

/* =================== ACTION BUTTONS - MOBILE FIRST =================== */
.action-section {
    display: flex;
    align-items: center;
    gap: 5px;
    justify-content: flex-end;
    flex-shrink: 0;
}

.header-btn {
    color: #fff;
    text-decoration: none;
    font-size: 12px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 2px;
    position: relative;
    cursor: pointer;
    padding: 6px 8px;
    border-radius: 8px;
    transition: all 0.3s ease;
    min-width: 44px;
    min-height: 44px;
    justify-content: center;
    background: rgba(255, 255, 255, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.1);
}

.header-btn i {
    font-size: 18px;
    margin-bottom: 2px;
}

.header-btn span:not(.cart-count) {
    font-size: 10px;
    font-weight: 500;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 60px;
}

.header-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-2px);
}

/* Tablet Action Buttons */
@media (min-width: 768px) {
    .action-section {
        gap: 12px;
    }
    
    .header-btn {
        flex-direction: row;
        gap: 6px;
        padding: 8px 12px;
        font-size: 14px;
        min-width: auto;
        min-height: auto;
    }
    
    .header-btn i {
        margin-bottom: 0;
        font-size: 20px;
    }
    
    .header-btn span:not(.cart-count) {
        font-size: 13px;
        max-width: none;
    }
}

/* Desktop Action Buttons */
@media (min-width: 992px) {
    .action-section {
        gap: 20px;
    }
    
    .header-btn {
        padding: 10px 16px;
        font-size: 15px;
        gap: 8px;
    }
    
    .header-btn i {
        font-size: 22px;
    }
}

/* CART COUNT - MOBILE FIRST */
.cart-count {
    background: linear-gradient(135deg, #ff4444 0%, #ff6b6b 100%);
    color: white;
    font-size: 10px;
    font-weight: bold;
    padding: 1px 5px;
    border-radius: 50%;
    position: absolute;
    top: 2px;
    right: 2px;
    min-width: 16px;
    height: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

@media (min-width: 768px) {
    .cart-count {
        top: 5px;
        right: 5px;
        font-size: 11px;
        min-width: 18px;
        height: 18px;
    }
}

/* =================== ACCOUNT DROPDOWN - MOBILE FIRST =================== */
.account-dropdown {
    position: relative;
}

.manual-dropdown-menu {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1100;
    background-color: white;
    border-radius: 16px;
    width: 90%;
    max-width: 320px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
    display: none;
    overflow: hidden;
    animation: slideUp 0.3s ease;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translate(-50%, -40%);
    }
    to {
        opacity: 1;
        transform: translate(-50%, -50%);
    }
}

.manual-dropdown-menu.show {
    display: block !important;
}

.dropdown-item {
    color: #333 !important;
    padding: 14px 20px;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 12px;
    font-size: 15px;
    border-bottom: 1px solid #f0f0f0;
    transition: all 0.2s ease;
}

.dropdown-item:last-child {
    border-bottom: none;
}

.dropdown-item:hover {
    background-color: #f8f9fa;
    padding-left: 25px;
}

.dropdown-item i {
    width: 20px;
    text-align: center;
    color: #666;
}

.user-welcome {
    padding: 18px 20px;
    background: linear-gradient(135deg, #4a6cf7 0%, #6c63ff 100%);
    color: white;
    font-weight: 600;
    font-size: 16px;
    text-align: center;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.dropdown-divider {
    height: 1px;
    background: #eee;
    margin: 5px 0;
}

.text-danger {
    color: #ff4444 !important;
}

.text-danger:hover {
    color: #ff0000 !important;
    background: rgba(255, 68, 68, 0.1);
}

/* Desktop Dropdown */
@media (min-width: 992px) {
    .manual-dropdown-menu {
        position: absolute;
        top: 100%;
        left: 0;
        transform: none;
        width: 280px;
        max-width: 280px;
        animation: slideDown 0.3s ease;
    }
    
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
}

/* =================== MOBILE NAVIGATION =================== */
.main-nav {
    background: linear-gradient(135deg, #062953 0%, #6f98d3 100%);
    padding: 12px 0;
    margin-top: 60px;
    position: sticky;
    top: 60px;
    z-index: 999;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.nav-container {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 0 15px;
    overflow-x: auto;
    white-space: nowrap;
    -webkit-overflow-scrolling: touch;
    scrollbar-width: none;
}

.nav-container::-webkit-scrollbar {
    display: none;
}

.nav-btn {
    padding: 10px 14px;
    border-radius: 25px;
    font-size: 13px;
    text-decoration: none;
    color: #fff;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 15px;
    transition: all 0.3s ease;
    white-space: nowrap;
    flex-shrink: 0;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.1);
    min-height: 40px;
}

.nav-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.nav-btn i {
    font-size: 14px;
}

/* Tablet Navigation */
@media (min-width: 768px) {
    .main-nav {
        margin-top: 70px;
        padding: 15px 0;
    }
    
    .nav-btn {
        padding: 12px 18px;
        font-size: 14px;
        gap: 8px;
    }
    
    .nav-btn i {
        font-size: 16px;
    }
}

/* Desktop Navigation */
@media (min-width: 992px) {
    .main-nav {
        margin-top: 80px;
        padding: 15px 0;
    }
    
    .nav-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 30px;
        justify-content: flex-start;
        gap: 15px;
        overflow-x: visible;
    }
    
    .nav-btn {
        padding: 12px 20px;
        font-size: 15px;
        gap: 10px;
    }
}

/* =================== CATEGORIES DROPDOWN - MOBILE FIRST =================== */
.dropdown {
    position: relative;
    flex-shrink: 0;
}

.category-dropdown-menu {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1100;
    background-color: white;
    border-radius: 16px;
    width: 90%;
    max-width: 320px;
    max-height: 70vh;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
    display: none;
    overflow-y: auto;
    animation: slideUp 0.3s ease;
}

.category-dropdown-menu.show {
    display: block !important;
}

.category-item {
    color: #333 !important;
    padding: 14px 20px;
    display: flex;
    align-items: center;
    gap: 12px;
    font-size: 15px;
    border-bottom: 1px solid #f0f0f0;
    transition: all 0.2s ease;
}

.category-item:hover {
    background: #f8f9fa;
    padding-left: 25px;
}

.category-item i {
    color: #4a6cf7;
    width: 20px;
    text-align: center;
}

/* Desktop Category Dropdown */
@media (min-width: 992px) {
    .category-dropdown-menu {
        position: absolute;
        top: 100%;
        left: 0;
        transform: none;
        width: 280px;
        max-width: 280px;
        animation: slideDown 0.3s ease;
    }
    
    .dropdown-overlay {
        display: none !important;
    }
}

/* =================== MOBILE OVERLAY =================== */
.dropdown-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.7);
    z-index: 1099;
    display: none;
    backdrop-filter: blur(5px);
    animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

.dropdown-overlay.show {
    display: block;
}

/* =================== MOBILE BOTTOM NAV =================== */
.mobile-bottom-nav {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    background: white;
    display: none;
    justify-content: space-around;
    padding: 12px 0 8px;
    box-shadow: 0 -4px 20px rgba(0,0,0,0.1);
    z-index: 1000;
    border-top: 1px solid #eee;
    backdrop-filter: blur(10px);
}

.mobile-nav-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-decoration: none;
    color: #666;
    font-size: 10px;
    flex: 1;
    padding: 4px 0;
    transition: all 0.3s ease;
}

.mobile-nav-item i {
    font-size: 18px;
    margin-bottom: 4px;
    color: #4a6cf7;
}

.mobile-nav-item.active {
    color: #4a6cf7;
    font-weight: 600;
}

.mobile-nav-item span {
    font-size: 10px;
}

/* Hide mobile bottom nav on tablet and above */
@media (min-width: 768px) {
    .mobile-bottom-nav {
        display: none !important;
    }
}

/* =================== UTILITY CLASSES =================== */
.text-center {
    text-align: center;
}

.d-none {
    display: none !important;
}

/* =================== TOUCH OPTIMIZATIONS =================== */
@media (hover: none) and (pointer: coarse) {
    .header-btn:hover,
    .nav-btn:hover,
    .dropdown-item:hover,
    .category-item:hover {
        transform: none;
        background: none;
    }
    
    .header-btn:active,
    .nav-btn:active {
        background: rgba(255, 255, 255, 0.2);
        transform: scale(0.95);
    }
}

/* =================== DARK MODE SUPPORT =================== */
@media (prefers-color-scheme: dark) {
    .manual-dropdown-menu,
    .category-dropdown-menu {
        background-color: #1e1e1e;
        border: 1px solid #333;
    }
    
    .dropdown-item,
    .category-item {
        color: #e0e0e0 !important;
        border-bottom-color: #333;
    }
    
    .dropdown-item:hover,
    .category-item:hover {
        background-color: #2a2a2a;
    }
    
    .user-welcome {
        background: linear-gradient(135deg, #3a5ce5 0%, #5b52e6 100%);
    }
    
    .text-danger {
        color: #ff6b6b !important;
    }
}
</style>
</head>

<body>

    <!-- Header - MOBILE FIRST DESIGN -->
    <header class="main-header">
        <div class="header-container">
            <!-- Logo Section - LEFT (Fixed with rounded corners) -->
            <div class="logo-wrapper">
                <a href="${pageContext.request.contextPath}/" class="logo-link" aria-label="FreshpickKart Home">
                    <img src="${pageContext.request.contextPath}/assets/img/Seller_img/logo1234.png" 
                         alt="FreshpickKart - Your Fresh Shopping Destination" 
                         class="logo-img"
                         loading="eager"
                         fetchpriority="high"
                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/fallback-logo.png';">
                </a>
            </div>

            <!-- Search Section - CENTER -->
            <div class="search-section">
                <div class="search-container">
                    <input type="text" class="search-input"
                        placeholder="Search products..." id="searchInput">
                    <button class="search-btn" id="searchButton">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>

            <!-- Action Buttons - RIGHT -->
            <div class="action-section">
                <!-- Account Dropdown -->
                <div class="account-dropdown">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <!-- LOGGED IN USER -->
                            <a class="header-btn" href="javascript:void(0)"
                                onclick="toggleDropdown('userMenu')" id="accountButton"> 
                                <i class="fas fa-user-circle"></i> 
                                <span class="btn-text">${fn:substringBefore(sessionScope.user.name, ' ')}</span>
                            </a>

                            <div class="manual-dropdown-menu" id="userMenu">
                                <div class="user-welcome">Hello, ${sessionScope.user.name}!</div>
                                <a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/profile"> 
                                    <i class="fas fa-user"></i> My Profile 
                                </a> 
                                <a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/orders"> 
                                    <i class="fas fa-shopping-bag"></i> My Orders
                                </a> 
                                <a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/wishlist"> 
                                    <i class="fas fa-heart"></i> Wishlist
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-danger"
                                    href="${pageContext.request.contextPath}/logout"> 
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- GUEST USER -->
                            <a class="header-btn" href="javascript:void(0)"
                                onclick="toggleDropdown('guestMenu')" id="accountButton"> 
                                <i class="fas fa-user"></i> 
                                <span class="btn-text">Account</span>
                            </a>

                            <div class="manual-dropdown-menu" id="guestMenu">
                                <a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/Login"> 
                                    <i class="fas fa-sign-in-alt"></i> Login
                                </a> 
                                <a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/register"> 
                                    <i class="fas fa-user-plus"></i> Register
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/service"> 
                                    <i class="fas fa-headset"></i> Customer Service
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Wishlist -->
                <a href="${pageContext.request.contextPath}/wishlist" class="header-btn" id="wishlistButton"> 
                    <i class="fas fa-heart"></i> 
                    <span class="btn-text">Wishlist</span>
                </a>

                <!-- Cart -->
                <a href="${pageContext.request.contextPath}/cart" class="header-btn" id="cartButton">
                    <i class="fas fa-shopping-cart"></i> 
                    <span class="btn-text">Cart</span> 
                    <span class="cart-count" id="cartCount"> 
                        <c:choose>
                            <c:when test="${not empty sessionScope.cartCount && sessionScope.cartCount > 0}">
                                ${sessionScope.cartCount}
                            </c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </span>
                </a>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="main-nav">
        <div class="nav-container">
            <!-- Categories Dropdown -->
            <div class="dropdown">
                <button class="nav-btn" type="button"
                    onclick="toggleDropdown('categoryMenu')" id="categoryButton">
                    <i class="fas fa-bars"></i> 
                    <span class="btn-text">Categories</span>
                </button>

                <div class="category-dropdown-menu" id="categoryMenu">
                    <!-- Categories loaded from server-side -->
                    <c:forEach var="c" items="${categories}">
                        <a class="dropdown-item category-item"
                        href="${pageContext.request.contextPath}/products?categories=${c.name}"> 
                            <i class="fas fa-tag"></i> 
                            <span>${c.name}</span>
                        </a>
                    </c:forEach>
                </div>
            </div>
            
            <!-- Home -->
            <a href="${pageContext.request.contextPath}/" class="nav-btn" id="homeButton">
                <i class="fas fa-home"></i> 
                <span class="btn-text">Home</span>
            </a>
            
            <!-- Products -->
            <a href="${pageContext.request.contextPath}/products" class="nav-btn" id="productsButton">
                <i class="fas fa-store"></i> 
                <span class="btn-text">Products</span>
            </a> 
            
            <!-- Offers -->
            <a href="${pageContext.request.contextPath}/offers" class="nav-btn" id="offersButton">
                <i class="fas fa-tags"></i> 
                <span class="btn-text">Offers</span>
            </a> 
            
            <!-- Customer Service -->
            <a href="${pageContext.request.contextPath}/service" class="nav-btn" id="serviceButton"> 
                <i class="fas fa-headset"></i> 
                <span class="btn-text">Service</span>
            </a>
        </div>
    </nav>

    <!-- Mobile Bottom Navigation (Only for small screens) -->
    <nav class="mobile-bottom-nav" id="mobileBottomNav">
        <a href="${pageContext.request.contextPath}/" class="mobile-nav-item active">
            <i class="fas fa-home"></i>
            <span>Home</span>
        </a>
        <a href="javascript:void(0)" class="mobile-nav-item" onclick="toggleDropdown('categoryMenu')">
            <i class="fas fa-th-large"></i>
            <span>Categories</span>
        </a>
        <a href="${pageContext.request.contextPath}/cart" class="mobile-nav-item">
            <i class="fas fa-shopping-cart"></i>
            <span>Cart</span>
        </a>
        <a href="javascript:void(0)" class="mobile-nav-item" onclick="toggleDropdown('guestMenu')">
            <i class="fas fa-user"></i>
            <span>Account</span>
        </a>
    </nav>

    <!-- Dropdown Overlay for Mobile -->
    <div class="dropdown-overlay" id="dropdownOverlay"
        onclick="closeAllDropdowns()"></div>

    <script>
// ================= MOBILE DETECTION =================
const isMobile = () => {
    return window.innerWidth <= 768 || 
           /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
};

// ================= DROPDOWN MANAGEMENT =================
let currentDropdown = null;

function toggleDropdown(menuId) {
    const menu = document.getElementById(menuId);
    const overlay = document.getElementById('dropdownOverlay');
    
    if (!menu) return;
    
    if (currentDropdown === menuId) {
        closeDropdown();
    } else {
        closeDropdown();
        currentDropdown = menuId;
        menu.classList.add('show');
        
        // Mobile specific behavior
        if (isMobile()) {
            if (overlay) overlay.classList.add('show');
            document.body.style.overflow = 'hidden';
        }
    }
}

function closeDropdown() {
    if (currentDropdown) {
        const menu = document.getElementById(currentDropdown);
        const overlay = document.getElementById('dropdownOverlay');
        
        if (menu) menu.classList.remove('show');
        if (overlay) overlay.classList.remove('show');
        
        document.body.style.overflow = '';
        currentDropdown = null;
    }
}

function closeAllDropdowns() {
    document.querySelectorAll('.manual-dropdown-menu, .category-dropdown-menu').forEach(function(menu) {
        menu.classList.remove('show');
    });
    const overlay = document.getElementById('dropdownOverlay');
    if (overlay) overlay.classList.remove('show');
    document.body.style.overflow = '';
    currentDropdown = null;
}

// ================= SEARCH FUNCTIONALITY =================
const searchInput = document.getElementById('searchInput');
const searchButton = document.getElementById('searchButton');

function performSearch() {
    const searchTerm = searchInput.value.trim();
    if (searchTerm) {
        window.location.href = '${pageContext.request.contextPath}/products?search=' + encodeURIComponent(searchTerm);
    } else {
        searchInput.focus();
        if (isMobile()) {
            searchInput.style.border = '2px solid #ff4444';
            setTimeout(() => {
                searchInput.style.border = '';
            }, 300);
        }
    }
}

if (searchButton) {
    searchButton.addEventListener('click', performSearch);
}

if (searchInput) {
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            performSearch();
        }
    });
}

// Mobile search enhancement
if (isMobile() && searchInput) {
    searchInput.addEventListener('focus', function() {
        this.parentElement.style.boxShadow = '0 5px 20px rgba(255, 153, 0, 0.3)';
    });
    
    searchInput.addEventListener('blur', function() {
        this.parentElement.style.boxShadow = '0 3px 8px rgba(0, 0, 0, 0.2)';
    });
}

// ================= CART FUNCTIONALITY =================
function updateCartCount(count) {
    const cartCountElement = document.getElementById('cartCount');
    if (cartCountElement) {
        cartCountElement.textContent = count;
        
        if (isMobile() && navigator.vibrate) {
            navigator.vibrate(50);
        }
    }
}

// ================= MOBILE TOUCH OPTIMIZATIONS =================
document.addEventListener('DOMContentLoaded', function() {
    const mobileBottomNav = document.getElementById('mobileBottomNav');
    
    function checkScreenSize() {
        if (window.innerWidth <= 480) {
            if (mobileBottomNav) mobileBottomNav.style.display = 'flex';
            document.body.style.paddingBottom = '60px';
        } else {
            if (mobileBottomNav) mobileBottomNav.style.display = 'none';
            document.body.style.paddingBottom = '';
        }
    }
    
    checkScreenSize();
    window.addEventListener('resize', checkScreenSize);
    
    // Touch optimizations
    const touchElements = document.querySelectorAll('.header-btn, .nav-btn, .mobile-nav-item');
    touchElements.forEach(el => {
        el.addEventListener('touchstart', function() {
            this.style.opacity = '0.8';
            this.style.transform = 'scale(0.95)';
        }, { passive: true });
        
        el.addEventListener('touchend', function() {
            this.style.opacity = '';
            this.style.transform = '';
        }, { passive: true });
    });
    
    // Desktop click outside to close
    if (!isMobile()) {
        document.addEventListener('click', function(event) {
            if (!event.target.closest('.account-dropdown') && 
                !event.target.closest('.dropdown') &&
                !event.target.closest('.manual-dropdown-menu') &&
                !event.target.closest('.category-dropdown-menu')) {
                closeAllDropdowns();
            }
        });
    }
    
    // Escape key to close
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            closeAllDropdowns();
        }
    });
    
    // Prevent double-tap zoom
    let lastTouchEnd = 0;
    document.addEventListener('touchend', function(event) {
        const now = Date.now();
        if (now - lastTouchEnd <= 300) {
            event.preventDefault();
        }
        lastTouchEnd = now;
    }, false);
});

// ================= WINDOW RESIZE HANDLER =================
let resizeTimeout;
window.addEventListener('resize', function() {
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(function() {
        if (!isMobile()) {
            closeAllDropdowns();
        }
        
        const mobileBottomNav = document.getElementById('mobileBottomNav');
        if (window.innerWidth <= 480) {
            if (mobileBottomNav) mobileBottomNav.style.display = 'flex';
            document.body.style.paddingBottom = '60px';
        } else {
            if (mobileBottomNav) mobileBottomNav.style.display = 'none';
            document.body.style.paddingBottom = '';
        }
    }, 150);
});

// ================= MOBILE PERFORMANCE OPTIMIZATIONS =================
if (isMobile()) {
    document.addEventListener('touchmove', function() {}, { passive: true });
    document.documentElement.style.setProperty('--scroll-behavior', 'auto');
}

// ================= LOGO ERROR HANDLING =================
document.querySelectorAll('.logo-img').forEach(img => {
    img.addEventListener('error', function() {
        this.onerror = null;
        this.src = '${pageContext.request.contextPath}/assets/img/fallback-logo.png';
        this.classList.add('logo-fallback');
    });
});

// ================= INITIALIZE =================
closeAllDropdowns();

// Expose utilities globally
window.mobileUtils = {
    updateCartCount: updateCartCount,
    isMobile: isMobile,
    closeAllDropdowns: closeAllDropdowns,
    toggleDropdown: toggleDropdown
};
</script>
</body>
</html>