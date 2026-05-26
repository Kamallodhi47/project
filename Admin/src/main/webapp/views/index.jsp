<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
:root {
	--primary: #4361ee;
	--secondary: #3a0ca3;
	--success: #4cc9f0;
	--warning: #f8961e;
	--info: #4895ef;
	--light: #f8f9fa;
	--dark: #212529;
	--gradient-primary: linear-gradient(135deg, #4361ee, #3a0ca3);
	--gradient-success: linear-gradient(135deg, #4cc9f0, #4895ef);
	--gradient-warning: linear-gradient(135deg, #f8961e, #f3722c);
	--shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	--shadow-hover: 0 20px 40px rgba(0, 0, 0, 0.15);
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	min-height: 100vh;
	color: var(--dark);
}

.dashboard-container {
	max-width: 1400px;
	margin: 0 auto;
	padding: 30px 20px;
}

.dashboard-header {
	text-align: center;
	margin-bottom: 40px;
}

.dashboard-title {
	font-size: 2.8rem;
	font-weight: 700;
	background: var(--gradient-primary);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	margin-bottom: 10px;
	position: relative;
	display: inline-block;
}

.dashboard-title::after {
	content: '';
	position: absolute;
	bottom: -10px;
	left: 50%;
	transform: translateX(-50%);
	width: 100px;
	height: 4px;
	background: var(--gradient-primary);
	border-radius: 2px;
}

.dashboard-subtitle {
	color: #6c757d;
	font-size: 1.1rem;
	font-weight: 400;
}

.card-dashboard {
	background: white;
	border-radius: 16px;
	box-shadow: var(--shadow);
	transition: all 0.3s ease;
	border: none;
	overflow: hidden;
	height: 100%;
	position: relative;
}

.card-dashboard::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 5px;
	background: var(--gradient-primary);
}

.card-dashboard:hover {
	transform: translateY(-10px);
	box-shadow: var(--shadow-hover);
}

.card-dashboard-success::before {
	background: var(--gradient-success);
}

.card-dashboard-warning::before {
	background: var(--gradient-warning);
}

.card-dashboard-info::before {
	background: var(--gradient-primary);
}

.card-body-dashboard {
	padding: 30px 25px;
	text-align: center;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 100%;
}

.dashboard-icon {
	font-size: 3.5rem;
	margin-bottom: 20px;
	background: var(--gradient-primary);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	transition: transform 0.3s ease;
}

.card-dashboard:hover .dashboard-icon {
	transform: scale(1.1);
}

.card-dashboard-success .dashboard-icon {
	background: var(--gradient-success);
	-webkit-background-clip: text;
}

.card-dashboard-warning .dashboard-icon {
	background: var(--gradient-warning);
	-webkit-background-clip: text;
}

.card-dashboard-info .dashboard-icon {
	background: var(--gradient-primary);
	-webkit-background-clip: text;
}

.dashboard-card-title {
	font-size: 1.4rem;
	font-weight: 600;
	margin-bottom: 10px;
	color: var(--dark);
}

.dashboard-card-desc {
	color: #6c757d;
	font-size: 0.95rem;
}

.dashboard-link {
	text-decoration: none;
	display: block;
	height: 100%;
}

.dashboard-link:hover {
	text-decoration: none;
}

.stats-badge {
	position: absolute;
	top: 15px;
	right: 15px;
	background: var(--primary);
	color: white;
	border-radius: 50%;
	width: 30px;
	height: 30px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 0.8rem;
	font-weight: 600;
}

/* Animation for cards */
@
keyframes fadeInUp {from { opacity:0;
	transform: translateY(30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.dashboard-card-animate {
	animation: fadeInUp 0.6s ease forwards;
	opacity: 0;
}

/* Responsive adjustments */
@media ( max-width : 768px) {
	.dashboard-title {
		font-size: 2.2rem;
	}
	.card-body-dashboard {
		padding: 20px 15px;
	}
	.dashboard-icon {
		font-size: 2.8rem;
	}
}
</style>
</head>
<body>
	<%@ include file="header1.jsp"%>
	<div class="dashboard-container">
		<div class="dashboard-header">
			<h1 class="dashboard-title">Admin Dashboard</h1>
			<p class="dashboard-subtitle">Manage your e-commerce platform
				efficiently</p>
		</div>

		<div class="row g-4">
			<!-- Add Product Card -->
			<div class="col-md-4 col-sm-6">
				<a href="/addpro" class="dashboard-link">
					<div
						class="card-dashboard card-dashboard-info dashboard-card-animate"
						style="animation-delay: 0.1s;">
						<div class="card-body-dashboard">
							<i class="fas fa-cube dashboard-icon"></i>
							<h3 class="dashboard-card-title">Add Product</h3>
							<p class="dashboard-card-desc">Add new products to your
								inventory</p>
						</div>
					</div>
				</a>
			</div>

			<!-- Add Category Card -->
			<div class="col-md-4 col-sm-6">
				<a href="/category" class="dashboard-link">
					<div
						class="card-dashboard card-dashboard-warning dashboard-card-animate"
						style="animation-delay: 0.2s;">
						<div class="card-body-dashboard">
							<i class="fas fa-tags dashboard-icon"></i>
							<h3 class="dashboard-card-title">Manage Categories</h3>
							<p class="dashboard-card-desc">Add and organize product
								categories</p>
						</div>
					</div>
				</a>
			</div>

			<!-- View Products Card -->
			<div class="col-md-4 col-sm-6">
				<a href="/productview" class="dashboard-link">
					<div
						class="card-dashboard card-dashboard-success dashboard-card-animate"
						style="animation-delay: 0.3s;">
						<div class="card-body-dashboard">
							<i class="fas fa-boxes dashboard-icon"></i>
							<h3 class="dashboard-card-title">View Products</h3>
							<p class="dashboard-card-desc">Browse and manage all products</p>
						</div>
					</div>
				</a>
			</div>

			<!-- Orders Card -->
			<div class="col-md-4 col-sm-6">
				<a href="/admindashbord" class="dashboard-link">
					<div
						class="card-dashboard card-dashboard-warning dashboard-card-animate"
						style="animation-delay: 0.4s;">
						<div class="card-body-dashboard">
							<i class="fas fa-shopping-bag dashboard-icon"></i>
							<h3 class="dashboard-card-title">Orders</h3>
							<p class="dashboard-card-desc">Manage customer orders and
								shipments</p>
						</div>
					</div>
				</a>
			</div>

			<!-- Users Card -->
			<!-- <div class="col-md-4 col-sm-6">
				<a href="/admin/users?type=1" class="dashboard-link">
					<div
						class="card-dashboard card-dashboard-info dashboard-card-animate"
						style="animation-delay: 0.5s;">
						<div class="card-body-dashboard">
							<i class="fas fa-users dashboard-icon"></i>
							<h3 class="dashboard-card-title">Users</h3>
							<p class="dashboard-card-desc">Manage customer accounts and
								profiles</p>
						</div>
					</div>
				</a>
			</div> -->

			<!-- Add Admin Card -->
			<!-- <div class="col-md-4 col-sm-6">
				<a href="/admin/add-admin" class="dashboard-link">
					<div
						class="card-dashboard card-dashboard-info dashboard-card-animate"
						style="animation-delay: 0.6s;">
						<div class="card-body-dashboard">
							<i class="fas fa-user-plus dashboard-icon"></i>
							<h3 class="dashboard-card-title">Add Admin</h3>
							<p class="dashboard-card-desc">Create new administrator
								accounts</p>
						</div>
					</div>
				</a>
			</div> -->

			<!-- Admin List Card -->
			<!-- <div class="col-md-4 col-sm-6">
				<a href="/admin/users?type=2" class="dashboard-link">
					<div
						class="card-dashboard card-dashboard-info dashboard-card-animate"
						style="animation-delay: 0.7s;">
						<div class="card-body-dashboard">
							<i class="fas fa-user-shield dashboard-icon"></i>
							<h3 class="dashboard-card-title">Admins</h3>
							<p class="dashboard-card-desc">View and manage administrator
								accounts</p>
						</div>
					</div>
				</a>
			</div> -->
		</div>
	</div>
	<%@ include file="Footar.jsp"%>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
        // Add interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            // Add hover effects to cards
            const cards = document.querySelectorAll('.card-dashboard');
            
            cards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-10px)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
            
            // Add click effect
            const links = document.querySelectorAll('.dashboard-link');
            
            links.forEach(link => {
                link.addEventListener('click', function(e) {
                    const card = this.querySelector('.card-dashboard');
                    card.style.transform = 'scale(0.95)';
                    
                    setTimeout(() => {
                        card.style.transform = '';
                    }, 300);
                });
            });
            
            // Animate cards on scroll
            const animateOnScroll = function() {
                const cards = document.querySelectorAll('.dashboard-card-animate');
                
                cards.forEach(card => {
                    const cardPosition = card.getBoundingClientRect().top;
                    const screenPosition = window.innerHeight / 1.2;
                    
                    if (cardPosition < screenPosition) {
                        card.style.opacity = '1';
                    }
                });
            };
            
            window.addEventListener('scroll', animateOnScroll);
            // Initial check in case cards are already in view
            animateOnScroll();
        });
    </script>
</body>
</html>