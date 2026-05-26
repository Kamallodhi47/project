<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | FreshBasket</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-green: #28a745;
            --primary-blue: #007bff;
            --primary-orange: #fd7e14;
            --primary-purple: #6f42c1;
            --primary-teal: #20c997;
            --light-bg: #f8fafc;
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --card-shadow-hover: 0 10px 30px rgba(0, 0, 0, 0.12);
        }
        
        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            color: #333;
            line-height: 1.6;
        }
        
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px;
        }
        
        /* Header Styles */
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .header-title h1 {
            font-size: 28px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 5px;
        }
        
        .header-title p {
            color: #718096;
            font-size: 15px;
            margin-bottom: 0;
        }
        
        .header-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .admin-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            background: white;
            padding: 10px 18px;
            border-radius: 50px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        
        .profile-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(45deg, var(--primary-blue), #5dade2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 18px;
        }
        
        .profile-info h5 {
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 2px;
            color: #2d3748;
        }
        
        .profile-info p {
            font-size: 13px;
            color: #718096;
            margin-bottom: 0;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border-top: 4px solid;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }
        
        .stat-card.users {
            border-top-color: var(--primary-blue);
        }
        
        .stat-card.orders {
            border-top-color: var(--primary-green);
        }
        
        .stat-card.pending {
            border-top-color: #ffc107;
        }
        
        .stat-card.confirmed {
            border-top-color: var(--primary-orange);
        }
        
        .stat-card.delivered {
            border-top-color: var(--primary-teal);
        }
        
        .stat-card.revenue {
            border-top-color: var(--primary-purple);
        }
        
        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        
        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: white;
        }
        
        .stat-card.users .stat-icon {
            background: linear-gradient(135deg, var(--primary-blue), #5dade2);
        }
        
        .stat-card.orders .stat-icon {
            background: linear-gradient(135deg, var(--primary-green), #58d68d);
        }
        
        .stat-card.pending .stat-icon {
            background: linear-gradient(135deg, #ffc107, #f7dc6f);
        }
        
        .stat-card.confirmed .stat-icon {
            background: linear-gradient(135deg, var(--primary-orange), #f0b27a);
        }
        
        .stat-card.delivered .stat-icon {
            background: linear-gradient(135deg, var(--primary-teal), #76eec5);
        }
        
        .stat-card.revenue .stat-icon {
            background: linear-gradient(135deg, var(--primary-purple), #9b6bff);
        }
        
        .stat-trend {
            font-size: 13px;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
        }
        
        .trend-up {
            background-color: rgba(40, 167, 69, 0.1);
            color: var(--primary-green);
        }
        
        .trend-down {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        
        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 5px;
            line-height: 1;
        }
        
        .stat-label {
            font-size: 14px;
            color: #718096;
            font-weight: 500;
            margin-bottom: 0;
        }
        
        .stat-comparison {
            font-size: 13px;
            color: #a0aec0;
            margin-top: 10px;
            display: flex;
            align-items: center;
        }
        
        /* Order Status Row */
        .order-status-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .order-status-card {
            background: white;
            border-radius: 16px;
            padding: 22px;
            box-shadow: var(--card-shadow);
            display: flex;
            align-items: center;
            gap: 18px;
        }
        
        .status-icon {
            width: 56px;
            height: 56px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            flex-shrink: 0;
        }
        
        .status-pending .status-icon {
            background: linear-gradient(135deg, #ffc107, #ffdb6d);
        }
        
        .status-confirmed .status-icon {
            background: linear-gradient(135deg, #fd7e14, #ffa94d);
        }
        
        .status-delivered .status-icon {
            background: linear-gradient(135deg, #20c997, #63e6be);
        }
        
        .status-info h3 {
            font-size: 28px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 2px;
            line-height: 1;
        }
        
        .status-info p {
            font-size: 14px;
            color: #718096;
            margin-bottom: 0;
            font-weight: 500;
        }
        
        /* Revenue Summary */
        .revenue-summary {
            background: white;
            border-radius: 16px;
            padding: 28px;
            box-shadow: var(--card-shadow);
            margin-bottom: 40px;
        }
        
        .revenue-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .revenue-header h3 {
            font-size: 22px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 0;
        }
        
        .revenue-period {
            font-size: 14px;
            color: #718096;
            background: #f8fafc;
            padding: 6px 16px;
            border-radius: 20px;
            font-weight: 500;
        }
        
        .revenue-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 25px;
        }
        
        .revenue-item {
            text-align: center;
            padding: 20px;
            border-radius: 12px;
            background: #f8fafc;
        }
        
        .revenue-item h4 {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-purple);
            margin-bottom: 8px;
        }
        
        .revenue-item p {
            font-size: 14px;
            color: #718096;
            margin-bottom: 0;
            font-weight: 500;
        }
        
        .revenue-growth {
            display: inline-flex;
            align-items: center;
            font-size: 13px;
            font-weight: 600;
            color: var(--primary-green);
            background: rgba(40, 167, 69, 0.1);
            padding: 4px 12px;
            border-radius: 20px;
            margin-top: 10px;
        }
        
        /* Quick Actions */
        .quick-actions {
            margin-bottom: 30px;
        }
        
        .quick-actions h3 {
            font-size: 22px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 25px;
        }
        
        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .action-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            display: block;
            text-align: center;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
            text-decoration: none;
            color: inherit;
        }
        
        .action-icon {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            margin: 0 auto 18px;
        }
        
        .action-orders .action-icon {
            background: linear-gradient(135deg, var(--primary-green), #58d68d);
        }
        
        .action-users .action-icon {
            background: linear-gradient(135deg, var(--primary-blue), #5dade2);
        }
        
        .action-products .action-icon {
            background: linear-gradient(135deg, var(--primary-orange), #f0b27a);
        }
        
        .action-analytics .action-icon {
            background: linear-gradient(135deg, var(--primary-purple), #9b6bff);
        }
        
        .action-card h4 {
            font-size: 17px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #2d3748;
        }
        
        .action-card p {
            font-size: 13px;
            color: #718096;
            margin-bottom: 0;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 20px;
            }
            
            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }
            
            .header-actions {
                width: 100%;
                justify-content: space-between;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .order-status-row {
                grid-template-columns: 1fr;
            }
            
            .action-cards {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 576px) {
            .action-cards {
                grid-template-columns: 1fr;
            }
            
            .admin-profile {
                padding: 8px 15px;
            }
            
            .profile-info {
                display: none;
            }
        }
        
        /* Animation for numbers */
        @keyframes countUp {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .stat-value {
            animation: countUp 0.8s ease-out;
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    
    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <div class="header-title">
            <h1>Admin Dashboard</h1>
            <p>Welcome to FreshBasket Admin Panel</p>
        </div>
        
        <div class="header-actions">
            <div class="admin-profile">
                <div class="profile-avatar">A</div>
                <div class="profile-info">
                    <h5>Administrator</h5>
                    <p>Super Admin</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Stats Grid -->
    <div class="stats-grid">
        <!-- Total Users -->
        <div class="stat-card users">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <span class="stat-trend trend-up">
                    <i class="fas fa-arrow-up me-1"></i> 12%
                </span>
            </div>
            <div class="stat-value">${totalUsers}</div>
            <p class="stat-label">Total Users</p>
            <div class="stat-comparison">
                <i class="fas fa-user-plus me-1"></i> 45 new this month
            </div>
        </div>
        
        <!-- Total Orders -->
        <div class="stat-card orders">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <span class="stat-trend trend-up">
                    <i class="fas fa-arrow-up me-1"></i> 8%
                </span>
            </div>
            <div class="stat-value">${totalOrders}</div>
            <p class="stat-label">Total Orders</p>
            <div class="stat-comparison">
                <i class="fas fa-chart-line me-1"></i> 15% growth from last month
            </div>
        </div>
        
        <!-- Revenue Summary -->
        <div class="stat-card revenue">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-rupee-sign"></i>
                </div>
                <span class="stat-trend trend-up">
                    <i class="fas fa-arrow-up me-1"></i> 22%
                </span>
            </div>
            <div class="stat-value">₹ <fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="0"/></div>
            <p class="stat-label">Total Revenue</p>
            <div class="stat-comparison">
                <i class="fas fa-wallet me-1"></i> Total earnings
            </div>
        </div>
    </div>
    
    <!-- Order Status Row -->
    <div class="order-status-row">
        <!-- Pending Orders -->
        <div class="order-status-card status-pending">
            <div class="status-icon">
                <i class="fas fa-clock"></i>
            </div>
            <div class="status-info">
                <h3>${pendingOrders}</h3>
                <p>Pending Orders</p>
            </div>
        </div>
        
        <!-- Confirmed Orders -->
        <div class="order-status-card status-confirmed">
            <div class="status-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="status-info">
                <h3>${confirmedOrders}</h3>
                <p>Confirmed Orders</p>
            </div>
        </div>
        
        <!-- Delivered Orders -->
        <div class="order-status-card status-delivered">
            <div class="status-icon">
                <i class="fas fa-truck"></i>
            </div>
            <div class="status-info">
                <h3>${deliveredOrders}</h3>
                <p>Delivered Orders</p>
            </div>
        </div>
    </div>
    
    <!-- Revenue Summary Section -->
    <div class="revenue-summary">
        <div class="revenue-header">
            <h3>Revenue Summary</h3>
            <span class="revenue-period">This Month</span>
        </div>
        
        <div class="revenue-stats">
            <div class="revenue-item">
                <h4>₹ <fmt:formatNumber value="${monthlyRevenue}" type="number" maxFractionDigits="0"/></h4>
                <p>Monthly Revenue</p>
                <span class="revenue-growth">
                    <i class="fas fa-arrow-up me-1"></i> 15% from last month
                </span>
            </div>
            
            <div class="revenue-item">
                <h4>₹ <fmt:formatNumber value="${weeklyRevenue}" type="number" maxFractionDigits="0"/></h4>
                <p>Weekly Revenue</p>
                <span class="revenue-growth">
                    <i class="fas fa-arrow-up me-1"></i> 8% from last week
                </span>
            </div>
            
            <div class="revenue-item">
                <h4>${averageOrderValue}</h4>
                <p>Average Order Value</p>
                <span class="revenue-growth">
                    <i class="fas fa-arrow-up me-1"></i> 5% increase
                </span>
            </div>
        </div>
    </div>
    
    <!-- Quick Actions -->
    <div class="quick-actions">
        <h3>Quick Actions</h3>
        
        <div class="action-cards">
            <a href="/adminorders" class="action-card action-orders">
                <div class="action-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <h4>Manage Orders</h4>
                <p>View and process customer orders</p>
            </a>
            
            <a href="/complain" class="action-card action-users">
                <div class="action-icon">
                    <i class="fas fa-user-cog"></i>
                </div>
                <h4>Complain user</h4>
                <p>View and Complain user accounts</p>
            </a>
            
            <a href="/admin/products" class="action-card action-products">
                <div class="action-icon">
                    <i class="fas fa-box-open"></i>
                </div>
                <h4>Manage Products</h4>
                <p>Add, edit or remove products</p>
            </a>
            
            <a href="/admin/analytics" class="action-card action-analytics">
                <div class="action-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <h4>View Analytics</h4>
                <p>Detailed reports and insights</p>
            </a>
        </div>
    </div>
    
</div>

<script>
    // Add number counting animation
    document.addEventListener('DOMContentLoaded', function() {
        const statValues = document.querySelectorAll('.stat-value');
        
        statValues.forEach(value => {
            const originalText = value.textContent;
            value.textContent = '0';
            
            let counter = 0;
            const target = parseInt(originalText.replace(/[^0-9]/g, ''));
            const increment = target / 50;
            
            const updateCount = () => {
                if (counter < target) {
                    counter += increment;
                    value.textContent = originalText.startsWith('₹') 
                        ? '₹ ' + Math.floor(counter).toLocaleString()
                        : Math.floor(counter).toLocaleString();
                    setTimeout(updateCount, 30);
                } else {
                    value.textContent = originalText;
                }
            };
            
            updateCount();
        });
    });
</script>

</body>
</html>