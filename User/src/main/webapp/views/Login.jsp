<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Apna Shop</title>
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #4a90e2;
            --secondary-color: #7ed6df;
            --premium-gradient: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
            --light-gradient: linear-gradient(135deg, #a29bfe 0%, #6c5ce7 100%);
            --dark-color: #2d3436;
            --light-bg: #f7f9fc;
        }
        
        body {
            background: linear-gradient(-45deg, #dfe6e9, #b2bec3, #74b9ff, #0984e3);
            background-size: 400% 400%;
            animation: gradient 20s ease infinite;
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        @keyframes gradient {
            0% { background-position:0% 50%; }
            50% { background-position:100% 50%; }
            100% { background-position:0% 50%; }
        }
        
        .login-container {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
            animation: fadeInUp 0.8s ease;
            border: 1px solid rgba(255,255,255,0.3);
        }
        
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .login-header {
            background: var(--premium-gradient);
            padding: 35px 20px;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .login-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: rgba(255,255,255,0.1);
            transform: rotate(30deg);
        }
        
        .logo {
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 5px;
            position: relative;
            z-index: 2;
        }
        
        .logo i {
            color: #ffeaa7;
            margin-right: 10px;
        }
        
        .login-header p {
            opacity: 0.9;
            margin-bottom: 0;
            position: relative;
            z-index: 2;
            font-size: 16px;
        }
        
        .login-body {
            padding: 35px 30px;
        }
        
        .form-control {
            border-radius: 12px;
            padding: 14px 18px;
            border: 1px solid #e1e8ed;
            transition: all 0.3s;
            font-size: 15px;
            background: #f8f9fa;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(74, 144, 226, 0.2);
            background: white;
        }
        
        .input-group-text {
            background: #f8f9fa;
            border-radius: 12px;
            border: 1px solid #e1e8ed;
            color: #74b9ff;
        }
        
        .login-btn {
            background: var(--premium-gradient);
            border: none;
            color: white;
            padding: 14px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s;
            width: 100%;
            font-size: 16px;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(116, 185, 255, 0.4);
        }
        
        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(116, 185, 255, 0.6);
        }
        
        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
        }
        
        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #e1e8ed;
        }
        
        .divider-text {
            padding: 0 15px;
            color: #6c757d;
            font-size: 14px;
            font-weight: 500;
        }
        
        .social-login {
            display: flex;
            gap: 12px;
            margin-bottom: 25px;
        }
        
        .social-btn {
            flex: 1;
            padding: 12px;
            border-radius: 12px;
            border: 1px solid #e1e8ed;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
            font-weight: 500;
            font-size: 14px;
        }
        
        .social-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        
        .social-btn.google {
            color: #DB4437;
            border-color: #DB4437;
        }
        
        .social-btn.google:hover {
            background: rgba(219, 68, 55, 0.05);
        }
        
        .social-btn.facebook {
            color: #4267B2;
            border-color: #4267B2;
        }
        
        .social-btn.facebook:hover {
            background: rgba(66, 103, 178, 0.05);
        }
        
        .login-footer {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #e1e8ed;
        }
        
        .login-footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .login-footer a:hover {
            color: #0984e3;
            text-decoration: underline;
        }
        
        .password-toggle {
            cursor: pointer;
            color: #74b9ff;
            background: #f8f9fa;
            transition: all 0.3s;
        }
        
        .password-toggle:hover {
            background: #e9ecef;
        }
        
        .form-label {
            font-weight: 600;
            color: #2d3436;
            margin-bottom: 8px;
        }
        
        .feature-highlight {
            display: flex;
            align-items: center;
            margin-top: 20px;
            padding: 12px 15px;
            background: rgba(116, 185, 255, 0.1);
            border-radius: 10px;
            border-left: 4px solid var(--primary-color);
        }
        
        .feature-highlight i {
            color: var(--primary-color);
            margin-right: 10px;
            font-size: 18px;
        }
        
        .feature-highlight span {
            font-size: 14px;
            color: #2d3436;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h2 class="logo"><i class="fas fa-shopping-bag"></i>Fresh Mart</h2>
            <p>Grocery</p>
        </div>
        
        <div class="login-body">
        <form action="/loginUser" enctype="multipart/form-data" id="userloging" novalidate method="post">
           
                <div class="mb-4">
                    <label for="email" class="form-label">Email or Mobile Number</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="email" name="email" placeholder="Enter email or mobile number" required>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                        <span class="input-group-text password-toggle" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </span>
                    </div>
                </div>
                
                <div class="mb-4 form-check d-flex justify-content-between align-items-center">
                    <div>
                        <input type="checkbox" class="form-check-input" id="remember">
                        <label class="form-check-label" for="remember">Remember me</label>
                    </div>
                    <a href="#" class="text-decoration-none">Forgot password?</a>
                </div>
                
                <button type="submit" class="login-btn mb-4">
                    <i class="fas fa-sign-in-alt me-2"></i> Sign In
                </button>
                
                <div class="divider">
                    <span class="divider-text">Or continue with</span>
                </div>
                
                <div class="social-login">
                    <button type="button" class="social-btn google">
                        <i class="fab fa-google me-2"></i> Google
                    </button>
                    <button type="button" class="social-btn facebook">
                        <i class="fab fa-facebook-f me-2"></i> Facebook
                    </button>
                </div>
                
                <div class="feature-highlight">
                    <i class="fas fa-shield-alt"></i>
                    <span>Your data is securely encrypted</span>
                </div>
                
                <div class="login-footer">
                    <p>New to Apna Shop? <a href="register">Create an account</a></p>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
        
        // Add focus effects to form inputs
        const formInputs = document.querySelectorAll('.form-control');
        formInputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.classList.remove('focused');
            });
        });
    </script>
</body>
</html>