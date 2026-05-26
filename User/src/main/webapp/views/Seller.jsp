<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seller Registration - Apna Shop</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
:root {
    --primary-color: #6c63ff;
    --primary-dark: #5a52d5;
    --secondary-color: #ff6584;
    --accent-color: #42b883;
    --business-color: #4a6cf7;
    --business-dark: #3a5bd9;
    --dark-color: #2a2d3b;
    --light-color: #f8f9fa;
    --text-color: #333;
    --text-light: #6c757d;
    --gradient: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    --business-gradient: linear-gradient(135deg, var(--business-color), var(--primary-color));
    --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    --shadow-hover: 0 15px 40px rgba(0, 0, 0, 0.15);
}

body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    min-height: 100vh;
    padding-top: 80px;
    color: var(--text-color);
}

.seller-registration-container {
    min-height: calc(100vh - 80px);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px 0;
}

.seller-registration-card {
    background: white;
    border-radius: 20px;
    box-shadow: var(--shadow-hover);
    border: none;
    overflow: hidden;
    transition: all 0.3s ease;
    max-width: 1000px;
    width: 100%;
}

.seller-registration-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
}

.seller-registration-header {
    background: var(--business-gradient);
    color: white;
    padding: 30px;
    text-align: center;
    position: relative;
    overflow: hidden;
}

.seller-registration-header::before {
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

.seller-registration-header h2 {
    font-weight: 700;
    font-size: 2.5rem;
    margin-bottom: 10px;
    position: relative;
    z-index: 2;
}

.seller-registration-header p {
    font-size: 1.1rem;
    opacity: 0.9;
    position: relative;
    z-index: 2;
}

.seller-registration-image {
    background: linear-gradient(135deg, #4a6cf7 0%, #6c63ff 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px;
    height: 100%;
    position: relative;
    overflow: hidden;
}

.seller-registration-image::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,0 L100,0 L100,100 Z" fill="rgba(255,255,255,0.1)"/></svg>');
    background-size: cover;
}

.seller-registration-image img {
    max-width: 100%;
    height: auto;
    filter: drop-shadow(0 10px 20px rgba(0,0,0,0.3));
    transition: all 0.5s ease;
    position: relative;
    z-index: 2;
}

.seller-registration-image:hover img {
    transform: scale(1.05) rotate(2deg);
}

.seller-registration-body {
    padding: 40px;
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
    color: var(--business-color);
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
    border-color: var(--business-color);
    box-shadow: 0 0 0 0.2rem rgba(74, 108, 247, 0.25);
    background: white;
    transform: translateY(-2px);
}

.form-control:valid {
    border-color: var(--accent-color);
}

.form-control:invalid:not(:focus):not(:placeholder-shown) {
    border-color: var(--secondary-color);
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

.password-strength.weak::before { width: 33%; background: #ff4757; }
.password-strength.medium::before { width: 66%; background: #ffa502; }
.password-strength.strong::before { width: 100%; background: #2ed573; }

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

.btn-seller-register {
    background: var(--business-gradient);
    border: none;
    border-radius: 12px;
    padding: 15px 30px;
    font-size: 1.1rem;
    font-weight: 600;
    color: white;
    transition: all 0.3s ease;
    width: 100%;
    position: relative;
    overflow: hidden;
}

.btn-seller-register::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
    transition: left 0.5s ease;
}

.btn-seller-register:hover::before {
    left: 100%;
}

.btn-seller-register:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(74, 108, 247, 0.4);
}

.seller-registration-footer {
    text-align: center;
    padding: 20px;
    background: #f8f9fa;
    border-top: 1px solid #e9ecef;
}

.seller-registration-footer a {
    color: var(--business-color);
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s ease;
}

.seller-registration-footer a:hover {
    color: var(--primary-dark);
    text-decoration: underline;
}

/* File upload styling */
.file-upload {
    position: relative;
    overflow: hidden;
}

.file-upload input[type="file"] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

.file-upload-label {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px 15px;
    background: #f8f9fa;
    border: 2px dashed #dee2e6;
    border-radius: 12px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.file-upload-label:hover {
    border-color: var(--business-color);
    background: rgba(74, 108, 247, 0.05);
}

.file-upload-label i {
    margin-right: 10px;
    color: var(--business-color);
}

/* Business type selector */
.business-type-selector {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 10px;
}

.business-type-option {
    flex: 1;
    min-width: 120px;
}

.business-type-option input {
    display: none;
}

.business-type-option label {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 15px 10px;
    background: #f8f9fa;
    border: 2px solid #e9ecef;
    border-radius: 12px;
    cursor: pointer;
    transition: all 0.3s ease;
    text-align: center;
    font-weight: 500;
}

.business-type-option label i {
    font-size: 1.5rem;
    margin-bottom: 8px;
    color: var(--business-color);
}

.business-type-option input:checked + label {
    border-color: var(--business-color);
    background: rgba(74, 108, 247, 0.1);
    color: var(--business-color);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(74, 108, 247, 0.2);
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .seller-registration-image {
        display: none;
    }
    
    .seller-registration-body {
        padding: 30px 20px;
    }
    
    .seller-registration-header {
        padding: 20px;
    }
    
    .seller-registration-header h2 {
        font-size: 2rem;
    }
    
    .business-type-selector {
        flex-direction: column;
    }
}

/* Animation classes */
.animate-fade-in {
    animation: fadeIn 0.8s ease-in-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Success message */
.alert-success {
    border-radius: 12px;
    border: none;
    background: linear-gradient(135deg, #42b883, #2ed573);
    color: white;
    font-weight: 500;
}

/* Custom checkbox */
.form-check-input:checked {
    background-color: var(--business-color);
    border-color: var(--business-color);
}

.form-check-label {
    font-weight: 500;
}

.form-check-label a {
    color: var(--business-color);
    text-decoration: none;
}

.form-check-label a:hover {
    text-decoration: underline;
}

/* Seller benefits section */
.seller-benefits {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 25px;
}

.seller-benefits h5 {
    color: var(--business-color);
    margin-bottom: 15px;
    font-weight: 600;
}

.benefit-item {
    display: flex;
    align-items: flex-start;
    margin-bottom: 10px;
}

.benefit-item i {
    color: var(--accent-color);
    margin-right: 10px;
    margin-top: 3px;
    flex-shrink: 0;
}

.benefit-item span {
    font-size: 0.9rem;
}
</style>
</head>

<body>
<%@ include file="header1.jsp"%>

<section class="seller-registration-container">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="seller-registration-card animate-fade-in">
                    <div class="row g-0">
                        <!-- Registration Image Section -->
                        <div class="col-lg-5 d-none d-lg-block">
                            <div class="seller-registration-image">
                                <img alt="Seller Registration" src="../assets/img/seller-registration.png" class="img-fluid">
                            </div>
                        </div>
                        
                        <!-- Registration Form Section -->
                        <div class="col-lg-7">
                            <div class="seller-registration-header">
                                <h2><i class="fas fa-store"></i> Become a Seller</h2>
                                <p>Join Apna Shop marketplace and grow your business</p>
                            </div>
                            
                            <div class="seller-registration-body">
                                <!-- Seller Benefits -->
                                <div class="seller-benefits">
                                    <h5><i class="fas fa-rocket"></i> Seller Benefits</h5>
                                    <div class="benefit-item">
                                        <i class="fas fa-check-circle"></i>
                                        <span>Reach millions of customers on Apna Shop</span>
                                    </div>
                                    <div class="benefit-item">
                                        <i class="fas fa-check-circle"></i>
                                        <span>Easy product listing and inventory management</span>
                                    </div>
                                    <div class="benefit-item">
                                        <i class="fas fa-check-circle"></i>
                                        <span>Secure and timely payments</span>
                                    </div>
                                    <div class="benefit-item">
                                        <i class="fas fa-check-circle"></i>
                                        <span>Seller support and business insights</span>
                                    </div>
                                </div>
                                
                                <form action="/saveSeller" enctype="multipart/form-data" id="sellerRegister" novalidate method="post">
                                    <!-- Personal Information -->
                                    <div class="row mb-4">
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
                                    <div class="mb-4">
                                        <label class="form-label"><i class="fas fa-envelope"></i> Email Address</label>
                                        <input required class="form-control" name="email" type="email" placeholder="Enter your email address">
                                    </div>

                                    <!-- Business Information -->
                                    <div class="row mb-4">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-store"></i> Business Name</label>
                                            <input required class="form-control" name="businessName" type="text" placeholder="Enter your business name">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-id-card"></i> GST Number (Optional)</label>
                                            <input class="form-control" name="gstNumber" type="text" placeholder="Enter GST number">
                                        </div>
                                    </div>
                                    
                                    <!-- Business Type -->
                                   <!--  <div class="mb-4">
                                        <label class="form-label"><i class="fas fa-briefcase"></i> Business Type</label>
                                        <div class="business-type-selector">
                                            <div class="business-type-option">
                                                <input type="radio" id="individual" name="businessType" value="individual" checked>
                                                <label for="individual">
                                                    <i class="fas fa-user-tie"></i>
                                                    Individual
                                                </label>
                                            </div>
                                            <div class="business-type-option">
                                                <input type="radio" id="partnership" name="businessType" value="partnership">
                                                <label for="partnership">
                                                    <i class="fas fa-handshake"></i>
                                                    Partnership
                                                </label>
                                            </div>
                                            <div class="business-type-option">
                                                <input type="radio" id="privateLtd" name="businessType" value="privateLtd">
                                                <label for="privateLtd">
                                                    <i class="fas fa-building"></i>
                                                    Private Ltd.
                                                </label>
                                            </div>
                                        </div>
                                    </div> -->

                                    <!-- Address Information -->
                                    <div class="row mb-4">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-home"></i> Business Address</label>
                                            <input required class="form-control" name="address" type="text" placeholder="Enter your business address">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-city"></i> City</label>
                                            <input required class="form-control" name="city" type="text" placeholder="Enter your city">
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-map-marker-alt"></i> State</label>
                                            <input required class="form-control" name="state" type="text" placeholder="Enter your state">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-map-pin"></i> Pincode</label>
                                            <input required class="form-control" name="pincode" type="number" placeholder="Enter pincode">
                                        </div>
                                    </div>

                                    <!-- Bank Details -->
                                    <div class="row mb-4">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-university"></i> Bank Name</label>
                                            <input required class="form-control" name="bankName" type="text" placeholder="Enter bank name">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-credit-card"></i> Account Number</label>
                                            <input required class="form-control" name="accountNumber" type="text" placeholder="Enter account number">
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-user"></i> Account Holder Name</label>
                                            <input required class="form-control" name="accountHolderName" type="text" placeholder="Enter account holder name">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-code-branch"></i> IFSC Code</label>
                                            <input required class="form-control" name="ifscCode" type="text" placeholder="Enter IFSC code">
                                        </div>
                                    </div>

                                    <!-- Password Section -->
                                    <div class="row mb-4">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-lock"></i> Password</label>
                                            <input required class="form-control" name="password" type="password" id="pass" placeholder="Create a password">
                                            <div class="password-strength" id="passwordStrength"></div>
                                            <div class="password-requirements">
                                                <div class="requirement unmet" id="lengthReq"><i class="fas fa-circle"></i> At least 8 characters</div>
                                                <div class="requirement unmet" id="numberReq"><i class="fas fa-circle"></i> Contains a number</div>
                                                <div class="requirement unmet" id="specialReq"><i class="fas fa-circle"></i> Contains a special character</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label"><i class="fas fa-lock"></i> Confirm Password</label>
                                            <input required class="form-control" name="confirmpassword" type="password" placeholder="Confirm your password">
                                        </div>
                                    </div>

                                    <!-- Business Documents -->
                                    <!-- <div class="mb-4">
                                        <label class="form-label"><i class="fas fa-file-contract"></i> Business Documents</label>
                                        <div class="file-upload">
                                            <input class="form-control" name="businessDocuments" type="file" id="businessDocuments" accept=".pdf,.jpg,.jpeg,.png" multiple>
                                            <label for="businessDocuments" class="file-upload-label">
                                                <i class="fas fa-cloud-upload-alt"></i>
                                                <span id="documentsLabel">Upload business documents (GST, PAN, etc.)</span>
                                            </label>
                                        </div>
                                    </div> -->

                                    <!-- Profile Image -->
                                    <!-- <div class="mb-4">
                                        <label class="form-label"><i class="fas fa-camera"></i> Profile Image</label>
                                        <div class="file-upload">
                                          <input type="file" name="img" id="fileInput">
                                            <label for="profileImage" class="file-upload-label">
                                                <i class="fas fa-cloud-upload-alt"></i>
                                                <span id="fileLabel">Choose profile picture</span>
                                            </label>
                                        </div>
                                    </div> -->

                                    <!-- Terms and Conditions -->
                                    <div class="form-check mb-4">
                                        <input class="form-check-input" type="checkbox" id="termsCheck" required>
                                        <label class="form-check-label" for="termsCheck">
                                            I agree to the <a href="#">Seller Terms of Service</a> and <a href="#">Privacy Policy</a>
                                        </label>
                                    </div>

                                    <!-- Submit Button -->
                                    <button type="submit" class="btn btn-seller-register">
                                        <i class="fas fa-store me-2"></i> Register as Seller
                                    </button>
                                </form>
                            </div>

                            <div class="seller-registration-footer">
                                Already have a seller account? <a href="/sellerLogin" class="text-decoration-none">Login here</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

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

// File upload label update
document.getElementById('profileImage').addEventListener('change', function() {
    const fileLabel = document.getElementById('fileLabel');
    if (this.files.length > 0) {
        fileLabel.textContent = this.files[0].name;
    } else {
        fileLabel.textContent = 'Choose profile picture';
    }
});

// Business documents upload label update
document.getElementById('businessDocuments').addEventListener('change', function() {
    const documentsLabel = document.getElementById('documentsLabel');
    if (this.files.length > 0) {
        if (this.files.length === 1) {
            documentsLabel.textContent = this.files[0].name;
        } else {
            documentsLabel.textContent = this.files.length + ' files selected';
        }
    } else {
        documentsLabel.textContent = 'Upload business documents (GST, PAN, etc.)';
    }
});

// Form validation
document.getElementById('sellerRegister').addEventListener('submit', function(e) {
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
        alert('Please accept the Seller Terms of Service and Privacy Policy');
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

// Add animation to form elements
document.addEventListener('DOMContentLoaded', function() {
    const formElements = document.querySelectorAll('.form-control');
    formElements.forEach((element, index) => {
        element.style.animationDelay = `${index * 0.1}s`;
        element.classList.add('animate-fade-in');
    });
});
</script>
</body>
</html>