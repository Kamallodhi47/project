<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Apna Shop - Premium Shopping Experience</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Font Awesome CDN -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

<style>
:root {
	--primary-color: #6c63ff;
	--primary-dark: #5a52d5;
	--secondary-color: #ff6584;
	--accent-color: #42b883;
	--gold-color: #ffd700;
	--dark-color: #2a2d3b;
	--light-color: #f8f9fa;
	--text-color: #333;
	--text-light: #6c757d;
	--gradient: linear-gradient(135deg, var(--primary-color),
		var(--secondary-color));
	--premium-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	--shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
	--glow: 0 0 20px rgba(108, 99, 255, 0.4);
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Poppins', sans-serif;
	padding-top: 80px;
	color: var(--text-color);
	background: #f8f9fa;
	overflow-x: hidden;
}

/* Premium Navbar Styling */
.navbar-premium {
	background: var(--premium-gradient);
	box-shadow: var(--shadow);
	padding: 0.8rem 0;
	transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	position: fixed;
	width: 100%;
	top: 0;
	z-index: 1000;
	border-bottom: 3px solid rgba(255, 255, 255, 0.1);
}

.navbar-premium.scrolled {
	padding: 0.6rem 0;
	background: rgba(102, 126, 234, 0.98);
	backdrop-filter: blur(15px);
	box-shadow: 0 5px 25px rgba(0, 0, 0, 0.2);
}

.navbar-premium::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	height: 3px;
	background: linear-gradient(90deg, var(--primary-color),
		var(--secondary-color), var(--accent-color));
	z-index: 1001;
}

.navbar-brand-premium {
	font-weight: 800;
	font-size: 1.8rem;
	display: flex;
	align-items: center;
	transition: all 0.3s ease;
	color: white !important;
	text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
	position: relative;
	margin-right: 20px;
}

.navbar-brand-premium:hover {
	transform: scale(1.05);
}

.navbar-brand-premium i {
	color: var(--gold-color);
	margin-right: 10px;
	font-size: 1.8rem;
	background: rgba(255, 255, 255, 0.15);
	padding: 8px;
	border-radius: 50%;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
	transition: all 0.3s ease;
}

.navbar-brand-premium:hover i {
	transform: rotate(15deg);
	background: rgba(255, 255, 255, 0.25);
}

.nav-link-premium {
	font-weight: 600;
	margin: 0 5px;
	border-radius: 8px;
	transition: all 0.3s ease;
	position: relative;
	display: flex;
	align-items: center;
	padding: 8px 12px !important;
	color: rgba(255, 255, 255, 0.9) !important;
	overflow: hidden;
	font-size: 0.9rem;
}

.nav-link-premium::before {
	content: '';
	position: absolute;
	top: 0;
	left: -100%;
	width: 100%;
	height: 100%;
	background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2),
		transparent);
	transition: left 0.5s;
}

.nav-link-premium:hover::before {
	left: 100%;
}

.nav-link-premium i {
	margin-right: 6px;
	font-size: 1rem;
	transition: transform 0.3s ease;
}

.nav-link-premium:hover i {
	transform: scale(1.1);
}

.nav-link-premium:hover, .nav-link-premium.active {
	background: rgba(255, 255, 255, 0.15);
	transform: translateY(-2px);
	box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
}

.nav-link-premium::after {
	content: '';
	position: absolute;
	width: 0;
	height: 2px;
	bottom: 0;
	left: 50%;
	background: var(--gold-color);
	transition: all 0.4s ease;
	border-radius: 10px;
	box-shadow: 0 0 8px var(--gold-color);
}

.nav-link-premium:hover::after, .nav-link-premium.active::after {
	width: 70%;
	left: 15%;
}

.navbar-toggler-premium {
	border: 2px solid rgba(255, 255, 255, 0.3);
	padding: 5px 8px;
	border-radius: 6px;
	transition: all 0.3s ease;
}

.navbar-toggler-premium:hover {
	border-color: rgba(255, 255, 255, 0.6);
	background: rgba(255, 255, 255, 0.1);
}

.navbar-toggler-premium:focus {
	box-shadow: 0 0 0 2px rgba(255, 255, 255, 0.3);
}

.navbar-toggler-icon-premium {
	background-image:
		url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 1%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2.5' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
	width: 20px;
	height: 20px;
}

/* Premium Badge */
.badge-premium {
	background: var(--gold-color);
	color: var(--dark-color);
	border-radius: 50%;
	font-size: 0.65rem;
	font-weight: 700;
	padding: 2px 6px;
	position: absolute;
	top: 3px;
	right: 3px;
	box-shadow: 0 1px 5px rgba(0, 0, 0, 0.2);
	animation: pulse 2s infinite;
}

@
keyframes pulse { 0% {
	transform: scale(1);
}

50










%
{
transform










:










scale








(










1








.05










)








;
}
100










%
{
transform










:










scale








(










1










)








;
}
}

/* Premium Dropdown */
.dropdown-menu-premium {
	border: none;
	border-radius: 12px;
	box-shadow: var(--shadow);
	padding: 10px 0;
	margin-top: 10px;
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(10px);
	overflow: hidden;
	border: 1px solid rgba(255, 255, 255, 0.2);
	min-width: 200px;
}

.dropdown-menu-premium::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	height: 2px;
	background: var(--premium-gradient);
}

.dropdown-item-premium {
	padding: 8px 20px;
	transition: all 0.3s ease;
	font-weight: 500;
	color: var(--dark-color);
	position: relative;
	overflow: hidden;
	font-size: 0.9rem;
}

.dropdown-item-premium i {
	margin-right: 8px;
	width: 16px;
	text-align: center;
	color: var(--primary-color);
	font-size: 0.9rem;
}

.dropdown-item-premium:hover {
	background: rgba(108, 99, 255, 0.1);
	padding-left: 25px;
	transform: translateX(3px);
}

.dropdown-item-premium:hover i {
	color: var(--secondary-color);
}

/* Premium Search Bar */
.search-container-premium {
	position: relative;
	margin: 0 15px;
	flex: 0 0 auto;
}

.search-input-premium {
	border: none;
	border-radius: 50px;
	padding: 8px 20px 8px 40px;
	width: 280px;
	font-size: 0.9rem;
	box-shadow: 0 3px 15px rgba(0, 0, 0, 0.1);
	transition: all 0.4s ease;
	background: rgba(255, 255, 255, 0.9);
	border: 1px solid transparent;
}

.search-input-premium:focus {
	width: 320px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
	background: white;
	border-color: var(--primary-color);
	outline: none;
}

.search-icon-premium {
	position: absolute;
	left: 15px;
	top: 50%;
	transform: translateY(-50%);
	color: var(--primary-color);
	font-size: 1rem;
	transition: all 0.3s ease;
}

.search-input-premium:focus+.search-icon-premium {
	color: var(--secondary-color);
	transform: translateY(-50%) scale(1.05);
}

/* Floating Cart & Wishlist */
.floating-icon {
	position: relative;
	transition: all 0.3s ease;
}

.floating-icon:hover {
	transform: translateY(-3px);
}

/* Navbar Container Adjustments */
.navbar-premium .container {
	padding: 0 15px;
	margin-left: 57px;
}

.navbar-nav {
	align-items: center;
}

/* Responsive Design */
@media ( max-width : 1199px) {
	.search-input-premium {
		width: 240px;
	}
	.search-input-premium:focus {
		width: 280px;
	}
	.nav-link-premium {
		margin: 0 3px;
		padding: 6px 10px !important;
	}
}

@media ( max-width : 991px) {
	.search-container-premium {
		margin: 10px 0;
		width: 100%;
	}
	.search-input-premium {
		width: 100%;
	}
	.search-input-premium:focus {
		width: 100%;
	}
	.nav-link-premium {
		margin: 3px 0;
		justify-content: flex-start;
		padding: 8px 15px !important;
	}
	.dropdown-menu-premium {
		margin-top: 5px;
		margin-bottom: 5px;
	}
	.navbar-brand-premium {
		font-size: 1.6rem;
	}
	.navbar-brand-premium i {
		font-size: 1.6rem;
		padding: 6px;
	}
}

@media ( max-width : 768px) {
	body {
		padding-top: 70px;
	}
	.navbar-premium {
		padding: 0.6rem 0;
	}
}

/* Demo Content */
.demo-content {
	padding: 40px 20px;
	text-align: center;
	background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	border-radius: 15px;
	margin: 20px;
	box-shadow: var(--shadow);
	margin-left: 57px;
}

.demo-content h1 {
	color: var(--primary-color);
	margin-bottom: 15px;
}
</style>
</head>
<body>

	<!-- Premium Navbar Start -->
	<nav class="navbar navbar-expand-lg navbar-premium">
		<div class="container">
			<a class="navbar-brand-premium" href="#"> <i
				class="fa-solid fa-crown"></i> Apna Shop
			</a>

			<button class="navbar-toggler-premium" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarPremiumContent"
				aria-controls="navbarPremiumContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon-premium"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarPremiumContent">
				<!-- Left Side Menu -->
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link-premium active"
						aria-current="page" href="/Index"> <i
							class="fa-solid fa-house"></i> Home
					</a></li>
					<li class="nav-item"><a class="nav-link-premium active"
						href="/products"> <i class="fa-solid fa-tags"></i> Product
					</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link-premium dropdown-toggle" href="/category"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							<i class="fa-solid fa-layer-group"></i> Categories
					</a>
						<ul class="dropdown-menu dropdown-menu-premium">
							<c:forEach var="c" items="${categories}">
								<li><a class="dropdown-item dropdown-item-premium"
									href="/products?categories=${(c.name)}"> <i
										class="fa-solid fa-tag"></i> ${c.name}
								</a></li>
							</c:forEach>
						</ul></li>
					<li class="nav-item"><a class="nav-link-premium" href="#">
							<i class="fa-solid fa-percent"></i> Offers <span
							class="badge-premium">3</span>
					</a></li>
				</ul>

				<!-- Search Bar -->
				<div class="search-container-premium">
					<i class="fa-solid fa-magnifying-glass search-icon-premium"></i> <input
						type="text" class="search-input-premium"
						placeholder="Search products...">
				</div>

				<!-- Right Side Menu -->
				<ul class="navbar-nav mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link-premium floating-icon"
						href="#"> <i class="fa-solid fa-heart"></i> Wishlist <span
							class="badge-premium">5</span>
					</a></li>
					<li class="nav-item"><a class="nav-link-premium floating-icon"
						href="#"> <i class="fa-solid fa-cart-shopping"></i> Cart <span
							class="badge-premium">2</span>
					</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link-premium dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> <i
							class="fa-solid fa-user"></i> Account
					</a>
						<ul class="dropdown-menu dropdown-menu-premium">
							<li><a class="dropdown-item dropdown-item-premium"
								href="/Login"><i class="fa-solid fa-right-to-bracket"></i>
									Login</a></li>
							<li><a class="dropdown-item dropdown-item-premium"
								href="/register"><i class="fa-solid fa-user-plus"></i>
									Register</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item dropdown-item-premium"
								href="/seller"><i class="fa-solid fa-user-shield"></i>
									Seller</a></li>
							<li><a class="dropdown-item dropdown-item-premium" href="#"><i
									class="fa-solid fa-gear"></i> Settings</a></li>
							<li><a class="dropdown-item dropdown-item-premium" href="#"><i
									class="fa-solid fa-question-circle"></i> Help</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Premium Navbar End -->

	<!-- Demo Content -->
	<!-- <div class="demo-content">
		<h1>Welcome to Apna Shop</h1>
		<p class="lead">Experience premium shopping with our modern
			e-commerce platform</p>
		<p>This header is now optimized for laptop screens and all
			elements should be visible properly.</p>
	</div> -->

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar-premium');
            if (window.scrollY > 30) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
        
        // Add active class to current page link
        document.addEventListener('DOMContentLoaded', function() {
            const currentLocation = location.pathname;
            const navLinks = document.querySelectorAll('.nav-link-premium');
            
            navLinks.forEach(link => {
                if(link.getAttribute('href') === currentLocation) {
                    link.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>