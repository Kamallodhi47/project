<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>FreshpickKart - My Account</title>
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts: Fraunces + Plus Jakarta Sans -->
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300;0,9..144,600;0,9..144,700;0,9..144,800;1,9..144,600&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        /* ============================================================
           DESIGN TOKENS — FreshpickKart Premium (Matching Index)
           ============================================================ */
        :root {
            --teal: #0d4f5c;
            --teal-2: #1a6b7a;
            --teal-3: #2a8fa0;
            --teal-light: #e0f4f7;
            --saffron: #e07b24;
            --saffron-2: #f59332;
            --saffron-light: #fef0e0;
            --ivory: #faf8f3;
            --ivory-2: #f2ede3;
            --ivory-3: #e8e1d4;
            --leaf: #2d6a4f;
            --leaf-2: #40916c;
            --leaf-light: #d8f3dc;
            --crimson: #b5281c;
            --crimson-light: #fdecea;
            --ink: #1a1a1a;
            --ink-2: #2e2e2e;
            --muted: #6b6b6b;
            --muted-2: #999999;
            --white: #ffffff;
            --surface: #f5f2ec;
            --shadow-xs: 0 1px 3px rgba(13,79,92,0.08);
            --shadow-sm: 0 2px 10px rgba(13,79,92,0.10), 0 6px 24px rgba(13,79,92,0.06);
            --shadow-md: 0 6px 24px rgba(13,79,92,0.12), 0 16px 48px rgba(13,79,92,0.07);
            --shadow-lg: 0 12px 48px rgba(13,79,92,0.16), 0 32px 80px rgba(13,79,92,0.08);
            --r-sm: 8px;
            --r-md: 14px;
            --r-lg: 20px;
            --r-xl: 28px;
            --r-2xl: 36px;
        }

        /* ============================================================
           RESET & BASE
           ============================================================ */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            -webkit-tap-highlight-color: transparent;
        }

        html {
            font-size: 16px;
            scroll-behavior: smooth;
        }

        body {
            background-color: var(--surface);
            background-image: radial-gradient(ellipse 80% 50% at 15% -10%, rgba(13,79,92,0.07) 0%, transparent 60%),
                              radial-gradient(ellipse 60% 40% at 90% 110%, rgba(224,123,36,0.06) 0%, transparent 55%);
            font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
            color: var(--ink);
            min-height: 100vh;
            padding-top: 0px;
            overflow-x: hidden;
            -webkit-font-smoothing: antialiased;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            color: var(--teal);
        }

        /* ============================================================
           HEADER SECTION (Matching Hero Style)
           ============================================================ */
        .account-header {
            background: linear-gradient(135deg, var(--ivory) 0%, var(--ivory-2) 60%, #ecdfc8 100%);
            padding: 48px 0 56px;
            position: relative;
            overflow: hidden;
            margin-bottom: 0;
        }

        .account-header::before {
            content: '';
            position: absolute;
            top: -160px;
            right: -160px;
            width: 560px;
            height: 560px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(13,79,92,0.07) 0%, transparent 65%);
            pointer-events: none;
        }

        .account-header::after {
            content: '';
            position: absolute;
            bottom: 20px;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, transparent 0%, var(--teal-3) 25%, var(--saffron) 55%, var(--leaf-2) 80%, transparent 100%);
            opacity: 0.5;
        }

        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 24px;
            position: relative;
            z-index: 2;
        }

        .profile-section {
            display: flex;
            align-items: center;
            gap: 32px;
            flex-wrap: wrap;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--teal), var(--teal-2));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 42px;
            font-weight: 700;
            border: 4px solid rgba(255, 255, 255, 0.4);
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
        }

        .profile-avatar:hover {
            transform: scale(1.05);
            border-color: var(--saffron);
        }

        .profile-info h1 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 8px;
            color: var(--teal);
        }

        .profile-info .email {
            font-size: 0.95rem;
            color: var(--muted);
            margin-bottom: 12px;
        }

        .premium-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(135deg, var(--saffron), var(--saffron-2));
            color: white;
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 700;
            box-shadow: var(--shadow-xs);
        }

        /* ============================================================
           MAIN CONTAINER
           ============================================================ */
        .main-container {
            max-width: 1400px;
            margin: -20px auto 40px;
            padding: 0 24px 40px;
            position: relative;
            z-index: 10;
        }

        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 340px 1fr;
            gap: 32px;
        }

        /* ============================================================
           QUICK ACTIONS PANEL
           ============================================================ */
        .quick-actions-panel {
            background: var(--white);
            border-radius: var(--r-xl);
            padding: 28px;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--ivory-3);
            position: relative;
            overflow: hidden;
            height: fit-content;
            position: sticky;
            top: 90px;
        }

        .quick-actions-panel::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--teal-3) 0%, var(--saffron) 40%, var(--leaf-2) 80%, var(--teal-3) 100%);
        }

        .panel-title {
            font-size: 1.35rem;
            font-weight: 700;
            color: var(--teal);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-family: 'Fraunces', serif;
        }

        .panel-title i {
            color: var(--saffron);
            font-size: 1.4rem;
        }

        .actions-grid {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .action-card {
            display: flex;
            align-items: center;
            gap: 16px;
            text-decoration: none;
            padding: 16px 20px;
            border-radius: var(--r-md);
            background: var(--ivory);
            border: 1px solid var(--ivory-3);
            transition: all 0.3s cubic-bezier(0.34, 1.2, 0.64, 1);
            cursor: pointer;
            width: 100%;
        }

        .action-card:hover {
            transform: translateX(6px);
            border-color: var(--teal-3);
            box-shadow: var(--shadow-sm);
        }

        .action-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, var(--teal-light), var(--ivory-2));
            border-radius: var(--r-md);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--teal);
            font-size: 1.3rem;
            transition: all 0.3s ease;
        }

        .action-card:hover .action-icon {
            background: linear-gradient(135deg, var(--teal), var(--teal-2));
            color: white;
            transform: scale(1.05);
        }

        .action-info {
            flex: 1;
        }

        .action-label {
            font-size: 1rem;
            font-weight: 700;
            color: var(--ink-2);
            margin-bottom: 4px;
        }

        .action-desc {
            font-size: 0.75rem;
            color: var(--muted);
        }

        /* Today's Orders Section */
        .today-orders-section {
            margin-top: 28px;
            padding-top: 24px;
            border-top: 2px dashed var(--ivory-3);
        }

        .today-orders-title {
            font-size: 0.9rem;
            font-weight: 700;
            color: var(--teal);
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .orders-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            max-height: 280px;
            overflow-y: auto;
        }

        .orders-list::-webkit-scrollbar {
            width: 4px;
        }

        .orders-list::-webkit-scrollbar-track {
            background: var(--ivory-2);
            border-radius: 4px;
        }

        .orders-list::-webkit-scrollbar-thumb {
            background: var(--teal);
            border-radius: 4px;
        }

        .order-complain-item {
            width: 100%;
        }

        .order-complain-btn {
            width: 100%;
            text-align: left;
            padding: 14px 16px;
            border: 1px solid var(--ivory-3);
            border-radius: var(--r-md);
            background: var(--ivory);
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .order-complain-btn:hover {
            border-color: var(--crimson);
            background: var(--crimson-light);
            transform: translateX(4px);
        }

        .order-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .complain-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--crimson-light);
            color: var(--crimson);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
        }

        .order-details {
            flex: 1;
        }

        .order-id {
            font-weight: 700;
            font-size: 0.85rem;
            color: var(--ink-2);
        }

        .order-date {
            font-size: 0.7rem;
            color: var(--muted);
        }

        .no-orders-message {
            text-align: center;
            padding: 32px 20px;
            background: var(--ivory);
            border-radius: var(--r-md);
            color: var(--muted);
        }

        /* ============================================================
           MENU GRID
           ============================================================ */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
        }

        .menu-category {
            background: var(--white);
            border-radius: var(--r-xl);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--ivory-3);
            transition: all 0.3s ease;
        }

        .menu-category:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }

        .category-header {
            padding: 18px 24px;
            background: linear-gradient(135deg, var(--ivory), var(--ivory-2));
            border-bottom: 1px solid var(--ivory-3);
        }

        .category-header h3 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--teal);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .category-header i {
            color: var(--saffron);
            font-size: 1.1rem;
        }

        .menu-list {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 16px 24px;
            text-decoration: none;
            color: var(--ink-2);
            border-bottom: 1px solid var(--ivory-3);
            transition: all 0.3s ease;
            width: 100%;
            background: none;
            border: none;
            border-bottom: 1px solid var(--ivory-3);
            cursor: pointer;
        }

        .menu-item:last-child {
            border-bottom: none;
        }

        .menu-item:hover {
            background: linear-gradient(90deg, var(--ivory), transparent);
            padding-left: 28px;
        }

        .item-icon {
            width: 32px;
            height: 32px;
            margin-right: 16px;
            color: var(--teal);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .menu-item:hover .item-icon {
            color: var(--saffron);
            transform: scale(1.1);
        }

        .item-content {
            flex: 1;
        }

        .item-title {
            font-size: 0.95rem;
            font-weight: 600;
            margin-bottom: 2px;
        }

        .item-subtitle {
            font-size: 0.7rem;
            color: var(--muted);
        }

        .item-arrow {
            color: var(--muted-2);
            font-size: 0.8rem;
            transition: all 0.3s ease;
        }

        .menu-item:hover .item-arrow {
            color: var(--saffron);
            transform: translateX(4px);
        }

        /* Logout Section */
        .logout-section {
            margin-top: 40px;
            text-align: center;
        }

        .logout-btn {
            background: transparent;
            border: 2px solid var(--crimson);
            color: var(--crimson);
            padding: 14px 40px;
            border-radius: var(--r-lg);
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: var(--crimson);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(181, 40, 28, 0.2);
        }

        /* Footer */
        .app-footer {
            text-align: center;
            padding: 40px 24px 24px;
            color: var(--muted);
            font-size: 0.85rem;
            border-top: 1px solid var(--ivory-3);
            margin-top: 48px;
        }

        .brand-name {
            font-family: 'Fraunces', serif;
            color: var(--teal);
            font-weight: 800;
            font-size: 1.3rem;
            margin-bottom: 12px;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 24px;
            margin-top: 16px;
            flex-wrap: wrap;
        }

        .footer-links a {
            color: var(--muted);
            text-decoration: none;
            font-size: 0.8rem;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--saffron);
        }

        /* ============================================================
           RESPONSIVE
           ============================================================ */
        @media (max-width: 1024px) {
            .dashboard-grid {
                grid-template-columns: 300px 1fr;
                gap: 24px;
            }
            
            .menu-grid {
                gap: 20px;
            }
        }

        @media (max-width: 768px) {
            body {
                padding-top: 60px;
            }
            
            .profile-section {
                flex-direction: column;
                text-align: center;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: 24px;
            }
            
            .quick-actions-panel {
                position: static;
            }
            
            .menu-grid {
                grid-template-columns: 1fr;
            }
            
            .actions-grid {
                grid-template-columns: repeat(2, 1fr);
                flex-direction: row;
                flex-wrap: wrap;
            }
            
            .action-card {
                flex: 1;
                min-width: 140px;
            }
            
            .header-container {
                padding: 0 16px;
            }
            
            .main-container {
                padding: 0 16px 32px;
            }
        }

        @media (max-width: 480px) {
            .actions-grid {
                grid-template-columns: 1fr;
            }
            
            .profile-avatar {
                width: 80px;
                height: 80px;
                font-size: 32px;
            }
            
            .profile-info h1 {
                font-size: 1.5rem;
            }
        }

        /* Dark Mode */
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
            
            .account-header {
                background: linear-gradient(135deg, #141f21 0%, #1a2830 60%, #1e2d20 100%);
            }
            
            .quick-actions-panel,
            .menu-category {
                background: var(--white);
                border-color: var(--ivory-3);
            }
            
            .action-card {
                background: var(--ivory);
                border-color: var(--ivory-3);
            }
            
            .order-complain-btn {
                background: var(--ivory);
                border-color: var(--ivory-3);
            }
            
            .order-complain-btn:hover {
                background: #2a1f1f;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .quick-actions-panel,
        .menu-category,
        .logout-section {
            animation: fadeInUp 0.5s ease-out forwards;
        }

        .menu-category:nth-child(2) { animation-delay: 0.1s; }
        .menu-category:nth-child(3) { animation-delay: 0.2s; }
        .menu-category:nth-child(4) { animation-delay: 0.3s; }
    </style>
    
</head>

<body>
	<%@ include file="header1.jsp"%>
    <!-- Account Header Section -->
    <section class="account-header">
        <div class="header-container">
            <div class="profile-section">
                <div class="profile-avatar">
                    <i class="fas fa-user-alt"></i>
                </div>
                <div class="profile-info">
                    <h1>Welcome back, ${sessionScope.user.name != null ? sessionScope.user.name : 'Fresh Shopper'}</h1>
                    <div class="email">${sessionScope.user.email != null ? sessionScope.user.email : 'member@freshpickkart.com'}</div>
                    <span class="premium-badge">
                        <i class="fas fa-crown"></i> Premium Member
                    </span>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="main-container">
        <div class="dashboard-grid">
            <!-- Quick Actions Panel -->
            <aside class="quick-actions-panel">
                <h2 class="panel-title">
                    <i class="fas fa-bolt"></i>
                    Quick Access
                </h2>
                <div class="actions-grid">
                    <a href="${pageContext.request.contextPath}/todayOrder" class="action-card">
                        <div class="action-icon">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                        <div class="action-info">
                            <div class="action-label">My Orders</div>
                            <div class="action-desc">Track & manage orders</div>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/profile" class="action-card">
                        <div class="action-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="action-info">
                            <div class="action-label">My Address</div>
                            <div class="action-desc">Manage delivery addresses</div>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/payment/verify" class="action-card">
                        <div class="action-icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        <div class="action-info">
                            <div class="action-label">Payment Methods</div>
                            <div class="action-desc">Manage cards & wallets</div>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/Order" class="action-card">
                        <div class="action-icon">
                            <i class="fas fa-history"></i>
                        </div>
                        <div class="action-info">
                            <div class="action-label">Order History</div>
                            <div class="action-desc">View past orders</div>
                        </div>
                    </a>
                    
                    <form action="${pageContext.request.contextPath}/complain" method="get" class="action-card" style="padding: 0;">
                        <button type="submit" class="action-card" style="background: none; border: none; padding: 16px 20px;">
                            <div class="action-icon">
                                <i class="fas fa-exclamation-circle"></i>
                            </div>
                            <div class="action-info">
                                <div class="action-label">Complaint Center</div>
                                <div class="action-desc">Submit an issue or feedback</div>
                            </div>
                        </button>
                    </form>
                </div>
                
                <!-- Today's Orders with Complain Options -->
                <c:if test="${not empty todayOrders}">
                    <div class="today-orders-section">
                        <div class="today-orders-title">
                            <i class="fas fa-clock"></i>
                            Today's Orders - Quick Complain
                        </div>
                        <div class="orders-list">
                            <c:forEach var="order" items="${todayOrders}">
                                <div class="order-complain-item">
                                    <form action="${pageContext.request.contextPath}/complain" method="get" style="margin:0;">
                                        <input type="hidden" name="orderId" value="${order.id}">
                                        <button type="submit" class="order-complain-btn">
                                            <div class="order-info">
                                                <div class="complain-icon">
                                                    <i class="fas fa-exclamation"></i>
                                                </div>
                                                <div class="order-details">
                                                    <div class="order-id">Order #${order.id}</div>
                                                    <div class="order-date">${order.orderDate != null ? order.orderDate : 'Today'}</div>
                                                </div>
                                            </div>
                                            <i class="fas fa-chevron-right"></i>
                                        </button>
                                    </form>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty todayOrders}">
                    <div class="today-orders-section">
                        <div class="today-orders-title">
                            <i class="fas fa-clock"></i>
                            Today's Orders
                        </div>
                        <div class="no-orders-message">
                            <i class="fas fa-box-open" style="font-size: 2rem; margin-bottom: 12px; display: block; opacity: 0.5;"></i>
                            No orders placed today
                        </div>
                    </div>
                </c:if>
            </aside>

            <!-- Main Menu Sections -->
            <div class="menu-grid">
                <!-- Account Section -->
                <section class="menu-category">
                    <div class="category-header">
                        <h3>
                            <i class="fas fa-user-circle"></i>
                            Account Settings
                        </h3>
                    </div>
                    <ul class="menu-list">
                        <li>
                            <a href="${pageContext.request.contextPath}/profile" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-user-edit"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">Profile Information</div>
                                    <div class="item-subtitle">Update personal details</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        
                        <li>
                            <a href="${pageContext.request.contextPath}/payment/verify" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-credit-card"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">Payment Methods</div>
                                    <div class="item-subtitle">Manage cards & wallets</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        
                        <li>
                            <a href="${pageContext.request.contextPath}/profile/addresses" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">Saved Addresses</div>
                                    <div class="item-subtitle">Manage delivery locations</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                    </ul>
                </section>

                <!-- Order Management -->
                <section class="menu-category">
                    <div class="category-header">
                        <h3>
                            <i class="fas fa-shopping-cart"></i>
                            Order Management
                        </h3>
                    </div>
                    <ul class="menu-list">
                        <li>
                            <a href="${pageContext.request.contextPath}/todayOrder" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">Today's Orders</div>
                                    <div class="item-subtitle">Track current deliveries</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        
                        <li>
                            <a href="${pageContext.request.contextPath}/Order" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-history"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">Order History</div>
                                    <div class="item-subtitle">View all past orders</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        
                        <li>
                            <a href="${pageContext.request.contextPath}/returns" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-undo-alt"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">Returns & Refunds</div>
                                    <div class="item-subtitle">Manage returns & track refunds</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                    </ul>
                </section>

                <!-- Support & Help -->
                <section class="menu-category">
                    <div class="category-header">
                        <h3>
                            <i class="fas fa-headset"></i>
                            Support Center
                        </h3>
                    </div>
                    <ul class="menu-list">
                        <li>
                            <a href="${pageContext.request.contextPath}/help" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-question-circle"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">Help Center</div>
                                    <div class="item-subtitle">FAQs & guides</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        
                        <li>
                            <a href="${pageContext.request.contextPath}/contact" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-comments"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">Contact Us</div>
                                    <div class="item-subtitle">24/7 customer support</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        
                        <li>
                            <form action="${pageContext.request.contextPath}/complain" method="get" style="margin:0; width:100%;">
                                <button type="submit" class="menu-item" style="width:100%; text-align:left;">
                                    <div class="item-icon">
                                        <i class="fas fa-exclamation-triangle"></i>
                                    </div>
                                    <div class="item-content">
                                        <div class="item-title">File a Complaint</div>
                                        <div class="item-subtitle">Report issues with orders</div>
                                    </div>
                                    <div class="item-arrow">
                                        <i class="fas fa-chevron-right"></i>
                                    </div>
                                </button>
                            </form>
                        </li>
                    </ul>
                </section>

                <!-- Information -->
                <section class="menu-category">
                    <div class="category-header">
                        <h3>
                            <i class="fas fa-info-circle"></i>
                            Information
                        </h3>
                    </div>
                    <ul class="menu-list">
                        <li>
                            <a href="${pageContext.request.contextPath}/about" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-building"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">About Us</div>
                                    <div class="item-subtitle">Our story & mission</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        
                        <li>
                            <a href="${pageContext.request.contextPath}/terms" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-file-contract"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">Terms & Conditions</div>
                                    <div class="item-subtitle">Legal policies</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        
                        <li>
                            <a href="${pageContext.request.contextPath}/privacy" class="menu-item">
                                <div class="item-icon">
                                    <i class="fas fa-shield-alt"></i>
                                </div>
                                <div class="item-content">
                                    <div class="item-title">Privacy Policy</div>
                                    <div class="item-subtitle">Data protection & privacy</div>
                                </div>
                                <div class="item-arrow">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                    </ul>
                </section>
            </div>
        </div>

        <!-- Logout Button -->
        <div class="logout-section">
            <button class="logout-btn" onclick="handleLogout()">
                <i class="fas fa-sign-out-alt"></i>
                Logout Account
            </button>
        </div>

        <!-- Footer -->
        <footer class="app-footer">
            <div class="brand-name">FreshpickKart</div>
            <p>Delivering freshness to your doorstep</p>
            <div class="footer-links">
                <a href="${pageContext.request.contextPath}/terms">Terms of Service</a>
                <a href="${pageContext.request.contextPath}/about">About Us</a>
                <a href="${pageContext.request.contextPath}/contact">Contact</a>
                <a href="${pageContext.request.contextPath}/help">Help Center</a>
            </div>
            <p style="margin-top: 16px;">
                <i class="fas fa-leaf" style="color: var(--leaf);"></i> 100% Fresh Guaranteed
            </p>
        </footer>
    </main>

    <script>
        // ========== LOGOUT FUNCTION ==========
        function handleLogout() {
            if (confirm('Are you sure you want to logout from your account?')) {
                const logoutBtn = document.querySelector('.logout-btn');
                const originalHTML = logoutBtn.innerHTML;
                
                logoutBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Logging out...';
                logoutBtn.disabled = true;
                
                setTimeout(() => {
                    window.location.href = '${pageContext.request.contextPath}/logout';
                }, 500);
            }
        }
        
        // ========== SMOOTH SCROLL ==========
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth' });
                }
            });
        });
        
        // ========== MOBILE RESPONSIVE TOUCH ==========
        if (window.innerWidth <= 768) {
            const cards = document.querySelectorAll('.action-card, .menu-item');
            cards.forEach(card => {
                card.addEventListener('touchstart', function() {
                    this.style.transform = 'scale(0.98)';
                });
                card.addEventListener('touchend', function() {
                    this.style.transform = '';
                });
            });
        }
    </script>
</body>
</html>