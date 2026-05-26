<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Fresh Mart</title>
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #4a90e2;
            --primary-dark: #3a7bc8;
            --secondary-color: #7ed6df;
            --accent-color: #42b883;
            --dark-color: #2a2d3b;
            --light-color: #f8f9fa;
            --text-color: #333;
            --text-light: #6c757d;
            --gradient: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
            --light-gradient: linear-gradient(135deg, #a29bfe 0%, #6c5ce7 100%);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 15px 40px rgba(0, 0, 0, 0.15);
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
        
        .registration-container {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            box-shadow: var(--shadow-hover);
            overflow: hidden;
            width: 100%;
            max-width: 900px;
            animation: fadeInUp 0.8s ease;
            display: flex;
            flex-direction: row;
            border: 1px solid rgba(255,255,255,0.3);
        }
        
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .registration-image {
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            width: 45%;
            position: relative;
            overflow: hidden;
        }
        
        .registration-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,0 L100,0 L100,100 Z" fill="rgba(255,255,255,0.1)"/></svg>');
            background-size: cover;
        }
        
        .registration-image img {
            max-width: 100%;
            height: auto;
            filter: drop-shadow(0 10px 20px rgba(0, 0, 0, 0.3));
            transition: all 0.5s ease;
            position: relative;
            z-index: 2;
        }
        
        .registration-image:hover img {
            transform: scale(1.05) rotate(2deg);
        }
        
        .registration-content {
            width: 55%;
            padding: 40px;
            max-height: 80vh;
            overflow-y: auto;
        }
        
        .registration-header {
            background: var(--gradient);
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
            border-radius: 15px;
        }
        
        .registration-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: rgba(255, 255, 255, 0.1);
            transform: rotate(45deg);
            animation: shine 3s infinite;
        }
        
        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
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
        
        .registration-header p {
            opacity: 0.9;
            margin-bottom: 0;
            position: relative;
            z-index: 2;
            font-size: 16px;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }
        
        .form-label i {
            margin-right: 10px;
            color: var(--primary-color);
            width: 20px;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 15px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(74, 144, 226, 0.25);
            background: white;
            transform: translateY(-2px);
        }
        
        .input-group-text {
            background: #f8f9fa;
            border-radius: 12px;
            border: 2px solid #e9ecef;
            color: var(--primary-color);
        }
        
        .register-btn {
            background: var(--gradient);
            border: none;
            color: white;
            padding: 15px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s;
            width: 100%;
            font-size: 16px;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(116, 185, 255, 0.4);
            position: relative;
            overflow: hidden;
        }
        
        .register-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }
        
        .register-btn:hover::before {
            left: 100%;
        }
        
        .register-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(116, 185, 255, 0.6);
        }
        
        .registration-footer {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #e1e8ed;
        }
        
        .registration-footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .registration-footer a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        
        .password-toggle {
            cursor: pointer;
            color: var(--primary-color);
            background: #f8f9fa;
            transition: all 0.3s;
        }
        
        .password-toggle:hover {
            background: #e9ecef;
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
            color: var(--dark-color);
        }
        
        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .password-strength {
            height: 4px;
            background: #e9ecef;
            border-radius: 2px;
            margin-top: 5px;
            overflow: hidden;
            position: relative;
        }
        
        .password-strength::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            width: 0%;
            background: var(--secondary-color);
            transition: all 0.3s ease;
        }
        
        .password-strength.weak::before {
            width: 33%;
            background: #ff4757;
        }
        
        .password-strength.medium::before {
            width: 66%;
            background: #ffa502;
        }
        
        .password-strength.strong::before {
            width: 100%;
            background: #2ed573;
        }
        
        .password-requirements {
            font-size: 0.8rem;
            color: var(--text-light);
            margin-top: 5px;
        }
        
        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 2px;
        }
        
        .requirement i {
            margin-right: 5px;
            font-size: 0.7rem;
        }
        
        .requirement.met {
            color: var(--accent-color);
        }
        
        .requirement.unmet {
            color: var(--text-light);
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .registration-container {
                flex-direction: column;
            }
            
            .registration-image {
                width: 100%;
                display: none;
            }
            
            .registration-content {
                width: 100%;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <div class="registration-image d-none d-lg-flex">
            <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjMwMCIgdmlld0JveD0iMCAwIDQwMCAzMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSI0MDAiIGhlaWdodD0iMzAwIiBmaWxsPSJ1cmwoI3BhaW50MF9saW5lYXJfMTY3XzM0MikiLz4KPGRlZnM+CjxsaW5lYXJHcmFkaWVudCBpZD0icGFpbnQwX2xpbmVhcl8xNjdfMzQyIiB4MT0iMjAwIiB5MT0iMCIgeDI9IjIwMCIgeTI9IjMwMCIgZ3JhZGllbnRVbml0cz0idXNlclNwYWNlT25Vc2UiPgo8c3RvcCBzdG9wLWNvbG9yPSIjNzRCOUZGIi8+CjxzdG9wIG9mZnNldD0iMSIgc3RvcC1jb2xvcj0iIzA5ODRFMyIvPgo8L2xpbmVhckdyYWRpZW50Pgo8L2RlZnM+CjxwYXRoIGQ9Ik0xMDAgMTUwQzEwMCAxMzQuNTMzIDExMi41MzMgMTIyIDEyOCAxMjJIMjcyQzI4Ny40NjcgMTIyIDMwMCAxMzQuNTMzIDMwMCAxNTBWMjUwQzMwMCAyNjUuNDY3IDI4Ny40NjcgMjc4IDI3MiAyNzhIMTI4QzExMi41MzMgMjc4IDEwMCAyNjUuNDY3IDEwMCAyNTBWMTUwWiIgZmlsbD0id2hpdGUiIGZpbGwtb3BhY2l0eT0iMC4xIi8+CjxwYXRoIGQ9Ik0xMjUgMTUwQzEyNSAxMzcuMTkyIDEzNS4xOTIgMTI3IDE0OCAxMjdIMjUyQzI2NC44MDggMTI3IDI3NSAxMzcuMTkyIDI3NSAxNTBWMjUwQzI3NSAyNjIuODA4IDI2NC44MDggMjczIDI1MiAyNzNIMTQ4QzEzNS4xOTIgMjczIDEyNSAyNjIuODA4IDEyNSAyNTBWMTUwWiIgZmlsbD0id2hpdGUiIGZpbGwtb3BhY2l0eT0iMC4xIi8+CjxjaXJjbGUgY3g9IjIwMCIgY3k9IjE1MCIgcj0iNDAiIGZpbGw9IndoaXRlIiBmaWxsLW9wYWNpdHk9IjAuMiIvPgo8Y2lyY2xlIGN4PSIyMDAiIGN5PSIxNTAiIHI9IjMwIiBmaWxsPSJ3aGl0ZSIgZmlsbC1vcGFjaXR5PSIwLjMiLz4KPHBhdGggZD0iTTE2MCAyMDBDMTYwIDE4Ny4xOTIgMTcwLjE5MiAxNzcgMTgzIDE3N0gyMTdDMjI5LjgwOCAxNzcgMjQwIDE4Ny4xOTIgMjQwIDIwMEMyNDAgMjEyLjgwOCAyMjkuODA4IDIyMyAyMTcgMjIzSDE4M0MxNzAuMTkyIDIyMyAxNjAgMjEyLjgwOCAxNjAgMjAwWiIgZmlsbD0id2hpdGUiIGZpbGwtb3BhY2l0eT0iMC4yIi8+Cjwvc3ZnPgo=" alt="Registration Illustration">
        </div>
        
        <div class="registration-content">
            <div class="registration-header">
                <h2 class="logo"><i class="fas fa-user-plus"></i>Fresh Mart</h2>
                <p>Create your account and start shopping</p>
            </div>
            
            <form action="/saveUser" id="userRegister" novalidate method="post">
                <!-- Personal Information -->
                <div class="row mb-3">
                    <div class="col-md-6 mb-3">
                        <label class="form-label"><i class="fas fa-user"></i> Full Name</label>
                        <input required class="form-control" name="name" type="text" placeholder="Enter your full name">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label"><i class="fas fa-phone"></i> Mobile Number</label>
                        <input required class="form-control" name="mobileNumber" type="tel" placeholder="Enter your mobile number">
                    </div>
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-envelope"></i> Email Address</label>
                    <input required class="form-control" name="email" type="email" placeholder="Enter your email address">
                </div>

                <!-- Address Information -->
                <div class="row mb-3">
                    <div class="col-md-6 mb-3">
                        <label class="form-label"><i class="fas fa-home"></i> Address</label>
                        <input required class="form-control" name="address" type="text" placeholder="Enter your address">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label"><i class="fas fa-city"></i> City</label>
                        <input required class="form-control" name="city" type="text" placeholder="Enter your city">
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6 mb-3">
                        <label class="form-label"><i class="fas fa-map-marker-alt"></i> State</label>
                        <input required class="form-control" name="state" type="text" placeholder="Enter your state">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label"><i class="fas fa-map-pin"></i> Pincode</label>
                        <input required class="form-control" name="pincode" type="number" placeholder="Enter pincode">
                    </div>
                </div>

                <!-- Password Section -->
                <div class="row mb-3">
                    <div class="col-md-6 mb-3">
                        <label class="form-label"><i class="fas fa-lock"></i> Password</label>
                        <div class="input-group">
                            <input required class="form-control" name="password" type="password" id="pass" placeholder="Create a password">
                            <span class="input-group-text password-toggle" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                        <div class="password-strength" id="passwordStrength"></div>
                        <div class="password-requirements">
                            <div class="requirement unmet" id="lengthReq">
                                <i class="fas fa-circle"></i> At least 8 characters
                            </div>
                            <div class="requirement unmet" id="numberReq">
                                <i class="fas fa-circle"></i> Contains a number
                            </div>
                            <div class="requirement unmet" id="specialReq">
                                <i class="fas fa-circle"></i> Contains a special character
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label"><i class="fas fa-lock"></i> Confirm Password</label>
                        <div class="input-group">
                            <input required class="form-control" name="confirmpassword" type="password" id="confirmPassword" placeholder="Confirm your password">
                            <span class="input-group-text password-toggle" id="toggleConfirmPassword">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Role is fixed as USER only -->
                <input type="hidden" name="role" value="USER">
                
                <!-- Terms and Conditions -->
                <div class="form-check mb-4">
                    <input class="form-check-input" type="checkbox" id="termsCheck" required>
                    <label class="form-check-label" for="termsCheck">
                        I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
                    </label>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="register-btn mb-4">
                    <i class="fas fa-user-plus me-2"></i> Create Account
                </button>
                
                <div class="feature-highlight">
                    <i class="fas fa-shield-alt"></i>
                    <span>Your personal information is securely protected</span>
                </div>
                
                <div class="registration-footer">
                    <p>Already have an account? <a href="/Login">Login here</a></p>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Password strength checker
        document.getElementById('pass').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('passwordStrength');
            const lengthReq = document.getElementById('lengthReq');
            const numberReq = document.getElementById('numberReq');
            const specialReq = document.getElementById('specialReq');
            
            // Reset classes
            strengthBar.className = 'password-strength';
            lengthReq.className = 'requirement unmet';
            numberReq.className = 'requirement unmet';
            specialReq.className = 'requirement unmet';
            
            let strength = 0;
            
            // Check length
            if (password.length >= 8) {
                strength += 1;
                lengthReq.className = 'requirement met';
            }
            
            // Check for numbers
            if (/\d/.test(password)) {
                strength += 1;
                numberReq.className = 'requirement met';
            }
            
            // Check for special characters
            if (/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                strength += 1;
                specialReq.className = 'requirement met';
            }
            
            // Update strength bar
            if (strength === 1) {
                strengthBar.classList.add('weak');
            } else if (strength === 2) {
                strengthBar.classList.add('medium');
            } else if (strength === 3) {
                strengthBar.classList.add('strong');
            }
        });

        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('pass');
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

        // Toggle confirm password visibility
        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('confirmPassword');
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

        // Form validation
        document.getElementById('userRegister').addEventListener('submit', function(e) {
            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = document.querySelector('input[name="confirmpassword"]').value;
            const termsCheck = document.getElementById('termsCheck');
            
            // Check if passwords match
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }
            
            // Check if terms are accepted
            if (!termsCheck.checked) {
                e.preventDefault();
                alert('Please accept the Terms of Service and Privacy Policy');
                return false;
            }
            
            // Check password strength
            if (password.length < 8) {
                e.preventDefault();
                alert('Password must be at least 8 characters long');
                return false;
            }
            
            return true;
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