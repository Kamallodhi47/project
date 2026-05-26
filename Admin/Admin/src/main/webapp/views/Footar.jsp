	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Footer Page</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
    :root {
        --primary-color: #6c63ff;
        --primary-dark: #5a52d5;
        --secondary-color: #ff6584;
        --accent-color: #42b883;
        --dark-color: #2a2d3b;
        --light-color: #f8f9fa;
        --text-color: #333;
        --text-light: #6c757d;
        --gradient: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        --shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: var(--text-color);
        background-color: #f8fafc;
        margin: 0;
        padding: 0;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }
    
    .main-content {
        flex: 1;
    }
    
    /* Footer Styles */
    .footer {
        background: var(--dark-color);
        color: white;
        padding: 60px 0 30px;
        margin-top: auto;
    }
    
    .footer h5 {
        font-weight: 600;
        margin-bottom: 25px;
        position: relative;
        font-size: 1.2rem;
    }
    
    .footer h5::after {
        content: '';
        position: absolute;
        left: 0;
        bottom: -10px;
        width: 40px;
        height: 3px;
        background: var(--primary-color);
        border-radius: 10px;
    }
    
    .footer p {
        color: #b0b0b0;
        line-height: 1.6;
    }
    
    .footer ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .footer ul li {
        margin-bottom: 12px;
    }
    
    .footer ul li a {
        color: #b0b0b0;
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
    }
    
    .footer ul li a:hover {
        color: white;
        padding-left: 5px;
    }
    
    .footer ul li i {
        margin-right: 10px;
        width: 20px;
        text-align: center;
    }
    
    .social-icons {
        display: flex;
        margin-top: 20px;
    }
    
    .social-icons a {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        margin-right: 10px;
        transition: all 0.3s ease;
        color: white;
        text-decoration: none;
    }
    
    .social-icons a:hover {
        background: var(--primary-color);
        transform: translateY(-3px);
    }
    
    .copyright {
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        padding-top: 20px;
        margin-top: 40px;
        text-align: center;
        color: #b0b0b0;
        font-size: 0.9rem;
    }
    
    .newsletter-form {
        display: flex;
        margin-top: 15px;
    }
    
    .newsletter-input {
        flex: 1;
        padding: 10px 15px;
        border: none;
        border-radius: 5px 0 0 5px;
        background: rgba(255, 255, 255, 0.1);
        color: white;
    }
    
    .newsletter-input::placeholder {
        color: #b0b0b0;
    }
    
    .newsletter-btn {
        background: var(--primary-color);
        color: white;
        border: none;
        padding: 0 15px;
        border-radius: 0 5px 5px 0;
        cursor: pointer;
        transition: background 0.3s ease;
    }
    
    .newsletter-btn:hover {
        background: var(--primary-dark);
    }
    
    .payment-methods {
        margin-top: 20px;
    }
    
    .payment-methods img {
        height: 30px;
        margin-right: 10px;
        margin-bottom: 10px;
        border-radius: 4px;
    }
    
    /* Demo content styles */
    .demo-content {
        padding: 40px 20px;
        text-align: center;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        border-radius: 15px;
        margin: 20px;
        box-shadow: var(--shadow);
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .footer {
            padding: 40px 0 20px;
        }
        
        .footer .col-md-3 {
            margin-bottom: 30px;
        }
        
        .newsletter-form {
            flex-direction: column;
        }
        
        .newsletter-input {
            border-radius: 5px;
            margin-bottom: 10px;
        }
        
        .newsletter-btn {
            border-radius: 5px;
            padding: 10px;
        }
    }
</style>
</head>
<body>
    <div class="main-content">
        <!-- Demo content to show the footer in context -->
       <!--  <div class="demo-content">
            <h1>Footer Example Page</h1>
            <p class="lead">This page demonstrates the fixed footer</p>
            <p>Scroll down to see the footer at the bottom of the page.</p>
        </div> -->
        
       <!--  <div class="demo-content">
            <h2>More Content</h2>
            <p>Adding more content to show how the footer stays at the bottom.</p>
        </div> -->
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-3 mb-4">
                    <h5>Apna Shop</h5>
                    <p>Your one-stop destination for all your shopping needs. We offer quality products at affordable prices.</p>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <h5>Quick Links</h5>
                    <ul>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Home</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> About Us</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Products</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Categories</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-3 mb-4">
                    <h5>Customer Service</h5>
                    <ul>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Help Center</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Returns & Refunds</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Shipping Info</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Size Guide</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> FAQs</a></li>
                    </ul>
                </div>
                <div class="col-md-3 mb-4">
                    <h5>Contact Info</h5>
                    <ul>
                        <li><i class="fas fa-map-marker-alt"></i> 123 Street, City, Country</li>
                        <li><i class="fas fa-phone"></i> +1 234 567 8900</li>
                        <li><i class="fas fa-envelope"></i> info@apnashop.com</li>
                    </ul>
                    
                    <h5 class="mt-4">Newsletter</h5>
                    <p>Subscribe to our newsletter for the latest updates</p>
                    <div class="newsletter-form">
                        <input type="email" class="newsletter-input" placeholder="Your email">
                        <button class="newsletter-btn"><i class="fas fa-paper-plane"></i></button>
                    </div>
                    
                    <div class="payment-methods">
                        <h5 class="mt-4">We Accept</h5>
                        <div>
                            <img src="https://cdn-icons-png.flaticon.com/128/179/179457.png" alt="Visa">
                            <img src="https://cdn-icons-png.flaticon.com/128/196/196578.png" alt="Mastercard">
                            <img src="https://cdn-icons-png.flaticon.com/128/888/888871.png" alt="PayPal">
                            <img src="https://cdn-icons-png.flaticon.com/128/888/888870.png" alt="Apple Pay">
                        </div>
                    </div>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2023 Apna Shop. All rights reserved. | Designed with <i class="fas fa-heart" style="color: var(--secondary-color);"></i> for you</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Simple script to handle newsletter form submission
        document.addEventListener('DOMContentLoaded', function() {
            const newsletterForm = document.querySelector('.newsletter-form');
            const newsletterInput = document.querySelector('.newsletter-input');
            const newsletterBtn = document.querySelector('.newsletter-btn');
            
            if (newsletterBtn) {
                newsletterBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    if (newsletterInput.value) {
                        alert('Thank you for subscribing with: ' + newsletterInput.value);
                        newsletterInput.value = '';
                    } else {
                        alert('Please enter your email address');
                    }
                });
            }
            
            // Add animation to social icons on page load
            const socialIcons = document.querySelectorAll('.social-icons a');
            socialIcons.forEach((icon, index) => {
                icon.style.animationDelay = `${index * 0.1}s`;
                icon.classList.add('animate__animated', 'animate__fadeInUp');
            });
        });
    </script>
</body>
</html>