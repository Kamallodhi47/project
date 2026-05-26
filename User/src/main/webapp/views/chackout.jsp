<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Secure Payment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Stylesheets -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #2563eb;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            --dark-color: #1f2937;
            --light-bg: #f9fafb;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
        }
        
        .payment-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .payment-header {
            background: linear-gradient(135deg, var(--primary-color), #1e40af);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .payment-step {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-bottom: 2rem;
        }
        
        .step {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }
        
        .step.active {
            background: white;
            color: var(--primary-color);
        }
        
        .step-line {
            width: 50px;
            height: 2px;
            background: rgba(255,255,255,0.2);
        }
        
        .payment-method-card {
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .payment-method-card:hover {
            border-color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(37, 99, 235, 0.1);
        }
        
        .payment-method-card.selected {
            border-color: var(--primary-color);
            background: rgba(37, 99, 235, 0.05);
        }
        
        .payment-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        }
        
        .secure-badge {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .order-summary-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .address-card {
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .address-card:hover {
            border-color: var(--primary-color);
        }
        
        .address-card.selected {
            border-color: var(--primary-color);
            background: rgba(37, 99, 235, 0.05);
        }
        
        .btn-pay {
            background: linear-gradient(135deg, var(--primary-color), #1e40af);
            color: white;
            padding: 15px;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            width: 100%;
            border: none;
            transition: all 0.3s ease;
        }
        
        .btn-pay:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(37, 99, 235, 0.3);
        }
        
        .loading-spinner {
            display: none;
            width: 40px;
            height: 40px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .payment-success {
            display: none;
            text-align: center;
            padding: 3rem 1rem;
        }
        
        .success-animation {
            width: 100px;
            height: 100px;
            background: var(--success-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .payment-icon.bg-success {
            background: linear-gradient(135deg, var(--success-color), #059669) !important;
        }
        
        .payment-icon.bg-warning {
            background: linear-gradient(135deg, var(--warning-color), #d97706) !important;
        }
        
        .payment-icon.bg-info {
            background: linear-gradient(135deg, #0ea5e9, #0369a1) !important;
        }
        
        /* Google Maps Styles */
        .location-cache-indicator {
            font-size: 12px;
            color: #666;
            margin-left: 5px;
        }
        
        .map-placeholder {
            height: 300px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #4a5568;
        }
        
        .map-loading {
            text-align: center;
        }
        
        .map-loading-spinner {
            width: 40px;
            height: 40px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 10px;
        }
        
        .address-form-alert {
            display: none;
        }
        
        #map {
            height: 300px;
            width: 100%;
            border-radius: 10px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="payment-container">
                    <!-- Payment Header -->
                    <div class="payment-header">
                        <h1 class="mb-3"><i class="fas fa-lock me-2"></i>Secure Payment</h1>
                        <p class="mb-0">Complete your purchase with 100% secure payment</p>
                        <div class="payment-step">
                            <div class="step active">1</div>
                            <div class="step-line"></div>
                            <div class="step active">2</div>
                            <div class="step-line"></div>
                            <div class="step">3</div>
                        </div>
                    </div>
                    
                    <!-- Payment Content -->
                    <div class="row g-0">
                        <!-- Left Column - Payment Methods -->
                        <div class="col-lg-8 p-4">
                            <div class="mb-4">
                                <h4 class="mb-3">Select Payment Method</h4>
                                <div class="row">
                                    <!-- Credit/Debit Card -->
                                    <div class="col-md-6">
                                        <div class="payment-method-card selected" onclick="selectPaymentMethod('card', this)">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="payment-icon">
                                                    <i class="fas fa-credit-card"></i>
                                                </div>
                                                <div>
                                                    <h6 class="mb-1">Credit/Debit Card</h6>
                                                    <p class="text-muted mb-0 small">Visa, MasterCard, RuPay</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- UPI -->
                                    <div class="col-md-6">
                                        <div class="payment-method-card" onclick="selectPaymentMethod('upi', this)">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="payment-icon bg-success">
                                                    <i class="fas fa-mobile-alt"></i>
                                                </div>
                                                <div>
                                                    <h6 class="mb-1">UPI</h6>
                                                    <p class="text-muted mb-0 small">Google Pay, PhonePe, Paytm</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Net Banking -->
                                    <div class="col-md-6">
                                        <div class="payment-method-card" onclick="selectPaymentMethod('netbanking', this)">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="payment-icon bg-warning">
                                                    <i class="fas fa-university"></i>
                                                </div>
                                                <div>
                                                    <h6 class="mb-1">Net Banking</h6>
                                                    <p class="text-muted mb-0 small">All major banks</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Wallet -->
                                    <div class="col-md-6">
                                        <div class="payment-method-card" onclick="selectPaymentMethod('wallet', this)">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="payment-icon bg-info">
                                                    <i class="fas fa-wallet"></i>
                                                </div>
                                                <div>
                                                    <h6 class="mb-1">Wallet</h6>
                                                    <p class="text-muted mb-0 small">Paytm, Amazon Pay</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Address Selection -->
                            <div class="mb-4">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h4>Delivery Address</h4>
                                    <button class="btn btn-outline-primary btn-sm" onclick="showAddressModal()">
                                        <i class="fas fa-plus me-1"></i>Add New
                                    </button>
                                </div>
                                <div id="addressContainer">
                                    <!-- Default Address -->
                                    <div class="address-card selected" onclick="selectAddress('default', this)">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <h6 class="mb-1">${user.name}</h6>
                                                <p class="mb-1 text-muted">${user.mobileNumber}</p>
                                                <p class="mb-1">${user.address}, ${user.city}</p>
                                                <p class="mb-0">${user.state} - ${user.pincode}</p>
                                            </div>
                                            <span class="badge bg-primary">Default</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Card Details Form -->
                            <div id="cardDetailsForm" style="display: block;">
                                <h5 class="mb-3">Card Details</h5>
                                <div class="row">
                                    <div class="col-md-12 mb-3">
                                        <label class="form-label">Card Number</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="1234 5678 9012 3456" id="cardNumber" maxlength="19">
                                            <span class="input-group-text">
                                                <i class="fab fa-cc-visa text-primary me-2"></i>
                                                <i class="fab fa-cc-mastercard text-danger"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Expiry Date</label>
                                        <input type="text" class="form-control" placeholder="MM/YY" id="expiryDate" maxlength="5">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">CVV</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" placeholder="123" id="cvv" maxlength="3">
                                            <span class="input-group-text">
                                                <i class="fas fa-question-circle" title="3-digit code on back of card"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mb-3">
                                        <label class="form-label">Cardholder Name</label>
                                        <input type="text" class="form-control" placeholder="Enter name as on card" id="cardName" value="${user.name}">
                                    </div>
                                    <div class="col-12">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="saveCard">
                                            <label class="form-check-label" for="saveCard">
                                                Save this card for faster payments
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- UPI Form -->
                            <div id="upiForm" style="display: none;">
                                <h5 class="mb-3">UPI Details</h5>
                                <div class="mb-3">
                                    <label class="form-label">UPI ID</label>
                                    <input type="text" class="form-control" placeholder="username@upi" id="upiId">
                                </div>
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle me-2"></i>
                                    After clicking pay, you'll be redirected to your UPI app
                                </div>
                            </div>
                        </div>
                        
                        <!-- Right Column - Order Summary -->
                        <div class="col-lg-4 p-4" style="background: var(--light-bg);">
                            <div class="mb-4">
                                <h4 class="mb-3">Order Summary</h4>
                                <div class="order-summary-item">
                                    <span>Items Total</span>
                                    <span>₹ ${totalAmount}</span>
                                </div>
                                <div class="order-summary-item">
                                    <span>Delivery</span>
                                    <span class="text-success">FREE</span>
                                </div>
                                <div class="order-summary-item">
                                    <span>Tax (GST)</span>
                                    <% 
                                        double total = Double.parseDouble(request.getAttribute("totalAmount").toString());
                                        double tax = total * 0.18;
                                        double finalAmount = total + tax;
                                    %>
                                    <span>₹ <%= String.format("%.2f", tax) %></span>
                                </div>
                                <hr>
                                <div class="order-summary-item fw-bold fs-5">
                                    <span>Total Amount</span>
                                    <span>₹ <%= String.format("%.2f", finalAmount) %></span>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <span class="secure-badge mb-3">
                                    <i class="fas fa-shield-alt"></i> 100% Secure Payment
                                </span>
                                <p class="small text-muted">
                                    <i class="fas fa-lock me-1"></i> Your payment is secured with 256-bit SSL encryption
                                </p>
                                <p class="small text-muted">
                                    <i class="fas fa-sync-alt me-1"></i> Instant refund in case of payment failure
                                </p>
                            </div>
                            
                            <!-- Payment Button -->
                            <button class="btn-pay" onclick="processPayment()">
                                <i class="fas fa-lock me-2"></i>Pay ₹ <%= String.format("%.2f", finalAmount) %>
                            </button>
                            
                            <!-- Loading Spinner -->
                            <div id="loadingSpinner" class="loading-spinner mt-3"></div>
                            
                            <!-- Success Message -->
                            <div id="paymentSuccess" class="payment-success">
                                <div class="success-animation">
                                    <i class="fas fa-check fa-3x text-white"></i>
                                </div>
                                <h3 class="text-success mb-3">Payment Successful!</h3>
                                <p class="text-muted mb-4">
                                    Your order has been confirmed. Order ID: <strong>#${orderId}</strong>
                                </p>
                                <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary">
                                    <i class="fas fa-shopping-bag me-2"></i>View Orders
                                </a>
                            </div>
                            
                            <!-- Razorpay Payment Button -->
                            <form id="razorpay-form" method="POST" action="${pageContext.request.contextPath}/payment/verify">
                                <input type="hidden" name="razorpay_payment_id" id="razorpay_payment_id">
                                <input type="hidden" name="razorpay_order_id" id="razorpay_order_id">
                                <input type="hidden" name="razorpay_signature" id="razorpay_signature">
                                <input type="hidden" name="order_id" value="${orderId}">
                                <input type="hidden" name="address_id" id="razorpay_address_id" value="default">
                            </form>
                        </div>
                    </div>
                    
                    <!-- Footer -->
                    <div class="border-top p-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <img src="https://razorpay.com/assets/razorpay-logo.svg" height="20" class="me-3">
                                <img src="https://razorpay.com/assets/pci-dss-compliant.svg" height="20" class="me-3">
                                <img src="https://razorpay.com/assets/iso-certified.svg" height="20">
                            </div>
                            <a href="${pageContext.request.contextPath}/cart" class="text-decoration-none">
                                <i class="fas fa-arrow-left me-2"></i>Back to Cart
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Address Modal -->
    <div class="modal fade" id="addressModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Address</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Location Status -->
                    <div id="locationStatus" class="alert alert-info">
                        <i class="fas fa-spinner fa-spin me-2"></i>
                        <span id="statusText">Ready to get location</span>
                        <span id="cacheIndicator" class="location-cache-indicator" style="display: none;">
                            <i class="fas fa-bolt"></i> Using cached location
                        </span>
                    </div>
                    
                    <!-- Address Form Alert -->
                    <div id="addressFormAlert" class="alert address-form-alert" style="display: none;"></div>
                    
                    <!-- Address Form -->
                    <form id="addressForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">House / Flat No. <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="house" id="house" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Area / Street <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="area" id="area" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Landmark (Optional)</label>
                            <input type="text" class="form-control" name="landmark" id="landmark">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Mobile Number <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" name="mobile" id="mobile" value="${user.mobileNumber}" required pattern="[0-9]{10}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Pincode <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="text" class="form-control" name="pincode" id="pincode" maxlength="6" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="fetchAddressFromPincode()" id="pincodeBtn">
                                        <span id="pincodeBtnText">Fetch</span>
                                        <span id="pincodeBtnSpinner" class="spinner-border spinner-border-sm d-none"></span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">City <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="city" id="city" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">State <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="state" id="state" required>
                            </div>
                        </div>
                        
                        <!-- Hidden GPS Fields -->
                        <input type="hidden" name="latitude" id="latitude">
                        <input type="hidden" name="longitude" id="longitude">
                        <input type="hidden" name="userId" id="userId" value="${user.id}">
                        
                        <!-- Location Buttons -->
                        <div class="mb-3">
                            <button type="button" class="btn btn-outline-primary w-100 mb-2" onclick="getLiveLocation()" id="locationBtn">
                                <i class="fas fa-map-marker-alt me-2"></i>Use Current Location
                            </button>
                            <button type="button" class="btn btn-outline-secondary w-100" onclick="openMapSelector()" id="mapBtn">
                                <i class="fas fa-map me-2"></i>Select from Map
                            </button>
                        </div>
                        
                        <!-- Map Container -->
                        <div id="mapContainer" style="display: none;">
                            <div id="map"></div>
                            <div class="mt-2 text-center">
                                <small class="text-muted">Click on the map to set location</small>
                            </div>
                        </div>
                        
                        <!-- Map Placeholder -->
                        <div id="mapPlaceholder" class="map-placeholder">
                            <div class="map-loading">
                                <div class="map-loading-spinner"></div>
                                <p>Map will load when you click "Select from Map"</p>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="saveAddress()" id="saveAddressBtn">
                        <span id="saveBtnText">Save Address</span>
                        <span id="saveBtnSpinner" class="spinner-border spinner-border-sm d-none"></span>
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap and Razorpay Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    
    <!-- Google Maps API Key -->
    <script>
        const GOOGLE_MAPS_API_KEY = 'AIzaSyDlY0P9h3P8gD8Q6vL7J4K4mN3t7Yb8X2Z';
    </script>
    
    <!-- Main JavaScript -->
    <script>
        // Global Variables
        let selectedPaymentMethod = 'card';
        let selectedAddressId = 'default';
        let map = null;
        let marker = null;
        let geocoder = null;
        let isMapInitialized = false;
        let cachedUserLocation = null;
        let addressModal = null;
        
        // Initialize when page loads
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded, initializing...');
            
            // Initialize Bootstrap modal
            const modalElement = document.getElementById('addressModal');
            if (modalElement) {
                addressModal = new bootstrap.Modal(modalElement);
            }
            
            // Format card inputs
            formatCardInputs();
            
            // Load user addresses if needed
            loadUserAddresses();
            
            console.log('Initialization complete');
        });
        
        // Payment method selection
        function selectPaymentMethod(method, element) {
            selectedPaymentMethod = method;
            
            // Update UI
            document.querySelectorAll('.payment-method-card').forEach(card => {
                card.classList.remove('selected');
            });
            element.classList.add('selected');
            
            // Show relevant form
            document.getElementById('cardDetailsForm').style.display = method === 'card' ? 'block' : 'none';
            document.getElementById('upiForm').style.display = method === 'upi' ? 'block' : 'none';
        }
        
        // Format card inputs
        function formatCardInputs() {
            // Format card number
            const cardNumberInput = document.getElementById('cardNumber');
            if (cardNumberInput) {
                cardNumberInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
                    let formatted = value.replace(/(\d{4})(?=\d)/g, '$1 ');
                    e.target.value = formatted.substring(0, 19);
                });
            }
            
            // Format expiry date
            const expiryDateInput = document.getElementById('expiryDate');
            if (expiryDateInput) {
                expiryDateInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
                    if (value.length >= 2) {
                        value = value.substring(0, 2) + '/' + value.substring(2, 4);
                    }
                    e.target.value = value.substring(0, 5);
                });
            }
        }
        
        // Show address modal
        function showAddressModal() {
            if (addressModal) {
                addressModal.show();
                resetAddressForm();
            }
        }
        
        // Reset address form
        function resetAddressForm() {
            const form = document.getElementById('addressForm');
            if (form) {
                form.reset();
            }
            
            const alertDiv = document.getElementById('addressFormAlert');
            if (alertDiv) {
                alertDiv.style.display = 'none';
                alertDiv.innerHTML = '';
            }
            
            // Reset map
            hideMap();
            
            // Reset status
            updateStatus('Ready to get location', 'info');
            
            // Reset cache indicator
            document.getElementById('cacheIndicator').style.display = 'none';
        }
        
        // Hide map
        function hideMap() {
            const mapContainer = document.getElementById('mapContainer');
            const mapPlaceholder = document.getElementById('mapPlaceholder');
            
            if (mapContainer) mapContainer.style.display = 'none';
            if (mapPlaceholder) {
                mapPlaceholder.style.display = 'flex';
                mapPlaceholder.innerHTML = `
                    <div class="map-loading">
                        <div class="map-loading-spinner"></div>
                        <p>Map will load when you click "Select from Map"</p>
                    </div>
                `;
            }
            
            // Reset map variables
            if (marker) {
                marker.setMap(null);
                marker = null;
            }
            map = null;
            geocoder = null;
            isMapInitialized = false;
        }
        
        // Update status message
        function updateStatus(message, type = 'info') {
            const statusDiv = document.getElementById('locationStatus');
            const statusText = document.getElementById('statusText');
            
            if (statusDiv && statusText) {
                statusDiv.className = `alert alert-${type}`;
                statusText.textContent = message;
                statusDiv.style.display = 'block';
            }
        }
        
        // Show address alert
        function showAddressAlert(message, type) {
            const alertDiv = document.getElementById('addressFormAlert');
            if (alertDiv) {
                alertDiv.className = `alert alert-${type} address-form-alert`;
                alertDiv.innerHTML = message;
                alertDiv.style.display = 'block';
                
                // Auto hide success messages after 5 seconds
                if (type === 'success') {
                    setTimeout(() => {
                        alertDiv.style.display = 'none';
                    }, 5000);
                }
            }
        }
        
        // Load user addresses
		// Load user addresses
		async function loadUserAddresses() {
		    try {
		        const response = await fetch('${pageContext.request.contextPath}/address/list');
		        if (response.ok) {
		            const addresses = await response.json();
		            const container = document.getElementById('addressContainer');
		            
		            if (container && addresses.length > 0) {
		                // Clear default address
		                container.innerHTML = '';
		                
		                addresses.forEach(address => {
		                    const addressCard = document.createElement('div');
		                    addressCard.className = 'address-card';
		                    if (address.isDefault) {
		                        addressCard.classList.add('selected');
		                        selectedAddressId = address.id;
		                    }
		                    
		                    addressCard.innerHTML = `
		                        <div class="d-flex justify-content-between align-items-start">
		                            <div>
		                                <h6 class="mb-1">${address.name || '${user.name}'}</h6>
		                                <p class="mb-1 text-muted">${address.mobile || '${user.mobileNumber}'}</p>
		                                <p class="mb-1">${address.house || ''}, ${address.area || ''}</p>
		                                ${address.landmark ? '<p class="mb-1"><small>Near ' + address.landmark + '</small></p>' : ''}
		                                <p class="mb-0">${address.city || ''}, ${address.state || ''} - ${address.pincode || ''}</p>
		                            </div>
		                            ${address.isDefault ? '<span class="badge bg-primary">Default</span>' : ''}
		                        </div>
		                    `;
		                    
		                    addressCard.onclick = () => selectAddress(address.id, addressCard);
		                    container.appendChild(addressCard);
		                });
		            }
		        }
		    } catch (error) {
		        console.error('Error loading addresses:', error);
		    }
		}          
        // Select address
        function selectAddress(addressId, element) {
            selectedAddressId = addressId;
            document.getElementById('razorpay_address_id').value = addressId;
            
            // Update UI
            document.querySelectorAll('.address-card').forEach(card => {
                card.classList.remove('selected');
            });
            element.classList.add('selected');
        }
        
        // Get user location
        async function getUserLocation() {
            return new Promise((resolve) => {
                if (!navigator.geolocation) {
                    resolve(null);
                    return;
                }
                
                if (cachedUserLocation) {
                    resolve(cachedUserLocation);
                    return;
                }
                
                navigator.geolocation.getCurrentPosition(
                    (position) => {
                        cachedUserLocation = {
                            lat: position.coords.latitude,
                            lng: position.coords.longitude
                        };
                        resolve(cachedUserLocation);
                    },
                    (error) => {
                        console.warn('Geolocation error:', error.message);
                        resolve(null);
                    },
                    {
                        enableHighAccuracy: true,
                        timeout: 5000,
                        maximumAge: 300000
                    }
                );
            });
        }
        
        // Get live location
        async function getLiveLocation() {
            const locationBtn = document.getElementById('locationBtn');
            const originalText = locationBtn.innerHTML;
            locationBtn.disabled = true;
            locationBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Getting Location...';
            
            updateStatus('Getting your location...', 'info');
            
            try {
                const location = await getUserLocation();
                if (location) {
                    // Update form fields from coordinates
                    await updateFormFromCoordinates(location.lat, location.lng);
                    updateStatus('Location found!', 'success');
                    document.getElementById('cacheIndicator').style.display = 'inline';
                    
                    // Update map if available
                    if (map) {
                        const latLng = new google.maps.LatLng(location.lat, location.lng);
                        map.setCenter(latLng);
                        map.setZoom(15);
                        placeMarker(latLng);
                    }
                } else {
                    updateStatus('Could not get location. Please try manually.', 'warning');
                }
            } catch (error) {
                console.error('Error getting location:', error);
                updateStatus('Error getting location', 'danger');
            } finally {
                locationBtn.disabled = false;
                locationBtn.innerHTML = originalText;
            }
        }
        
        // Update form from coordinates
        async function updateFormFromCoordinates(lat, lng) {
            try {
                const response = await fetch(
                    `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}&zoom=18&addressdetails=1`
                );
                const data = await response.json();
                
                if (data.address) {
                    const addr = data.address;
                    
                    // Update form fields
                    document.getElementById('city').value = addr.city || addr.town || addr.village || '';
                    document.getElementById('state').value = addr.state || '';
                    document.getElementById('pincode').value = addr.postcode || '';
                    document.getElementById('area').value = addr.road || addr.neighbourhood || addr.suburb || '';
                    
                    // Update hidden fields
                    document.getElementById('latitude').value = lat;
                    document.getElementById('longitude').value = lng;
                    
                    // Try to get house number
                    if (addr.house_number && !document.getElementById('house').value) {
                        document.getElementById('house').value = addr.house_number;
                    }
                }
            } catch (error) {
                console.error('Error updating from coordinates:', error);
            }
        }
        
        // Fetch address from pincode
        async function fetchAddressFromPincode() {
            const pincode = document.getElementById('pincode').value.trim();
            const pincodeBtn = document.getElementById('pincodeBtn');
            const pincodeBtnText = document.getElementById('pincodeBtnText');
            const pincodeBtnSpinner = document.getElementById('pincodeBtnSpinner');
            
            if (pincode.length !== 6) {
                showAddressAlert('Please enter a 6-digit pincode', 'warning');
                return;
            }
            
            pincodeBtn.disabled = true;
            pincodeBtnText.textContent = 'Fetching...';
            pincodeBtnSpinner.classList.remove('d-none');
            
            try {
                const response = await fetch(`https://api.postalpincode.in/pincode/${pincode}`);
                const data = await response.json();
                
                if (data[0] && data[0].Status === 'Success') {
                    const postOffice = data[0].PostOffice[0];
                    document.getElementById('city').value = postOffice.District;
                    document.getElementById('state').value = postOffice.State;
                    showAddressAlert('Address fetched successfully', 'success');
                    
                    // Update map if available
                    if (map && postOffice.Latitude && postOffice.Longitude) {
                        const latLng = new google.maps.LatLng(
                            parseFloat(postOffice.Latitude),
                            parseFloat(postOffice.Longitude)
                        );
                        map.setCenter(latLng);
                        map.setZoom(12);
                        placeMarker(latLng);
                    }
                } else {
                    showAddressAlert('No address found for this pincode', 'warning');
                }
            } catch (error) {
                console.error('Pincode fetch error:', error);
                showAddressAlert('Error fetching address', 'danger');
            } finally {
                pincodeBtn.disabled = false;
                pincodeBtnText.textContent = 'Fetch';
                pincodeBtnSpinner.classList.add('d-none');
            }
        }
        
        // Load Google Maps API
        function loadGoogleMapsAPI() {
            return new Promise((resolve, reject) => {
                if (window.google && window.google.maps) {
                    resolve();
                    return;
                }
                
                const script = document.createElement('script');
                script.src = `https://maps.googleapis.com/maps/api/js?key=${GOOGLE_MAPS_API_KEY}&libraries=places`;
                script.async = true;
                script.defer = true;
                script.onload = resolve;
                script.onerror = reject;
                document.head.appendChild(script);
            });
        }
        
        // Open map selector - THIS IS THE FIXED FUNCTION
        async function openMapSelector() {
            const mapContainer = document.getElementById('mapContainer');
            const mapPlaceholder = document.getElementById('mapPlaceholder');
            const mapBtn = document.getElementById('mapBtn');
            
            mapBtn.disabled = true;
            const originalText = mapBtn.innerHTML;
            mapBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Loading Map...';
            
            try {
                // Load Google Maps API
                await loadGoogleMapsAPI();
                
                // Show map container
                mapContainer.style.display = 'block';
                mapPlaceholder.style.display = 'none';
                
                // Initialize map
                await initMap();
                updateStatus('Click on the map to set location', 'info');
            } catch (error) {
                console.error('Error loading map:', error);
                showAddressAlert('Failed to load Google Maps. Please check your connection.', 'danger');
                mapPlaceholder.innerHTML = '<div class="text-danger"><i class="fas fa-exclamation-triangle me-2"></i>Failed to load map</div>';
            } finally {
                mapBtn.disabled = false;
                mapBtn.innerHTML = originalText;
            }
        }
        
        // Initialize map - SIMPLIFIED AND WORKING
        async function initMap() {
            try {
                const mapElement = document.getElementById('map');
                if (!mapElement) {
                    throw new Error('Map element not found');
                }
                
                // Get center location
                let center = { lat: 28.6139, lng: 77.2090 }; // Default: Delhi
                const location = await getUserLocation();
                if (location) {
                    center = location;
                }
                
                // Create map
                map = new google.maps.Map(mapElement, {
                    center: center,
                    zoom: 12,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    mapTypeControl: false,
                    streetViewControl: false,
                    fullscreenControl: true,
                    zoomControl: true
                });
                
                // Initialize geocoder
                geocoder = new google.maps.Geocoder();
                
                // Add click listener
                map.addListener('click', function(event) {
                    placeMarker(event.latLng);
                    reverseGeocode(event.latLng);
                });
                
                // Place initial marker
                placeMarker(center);
                isMapInitialized = true;
                console.log('Map initialized successfully');
            } catch (error) {
                console.error('Error initializing map:', error);
                throw error;
            }
        }
        
        // Place marker on map
        function placeMarker(location) {
            if (!map) return;
            
            if (marker) {
                marker.setPosition(location);
            } else {
                marker = new google.maps.Marker({
                    position: location,
                    map: map,
                    draggable: true,
                    animation: google.maps.Animation.DROP
                });
                
                // Update location when marker is dragged
                google.maps.event.addListener(marker, 'dragend', function() {
                    reverseGeocode(marker.getPosition());
                });
            }
            
            // Update hidden fields
            document.getElementById('latitude').value = location.lat();
            document.getElementById('longitude').value = location.lng();
        }
        
        // Reverse geocode coordinates to address
        async function reverseGeocode(latlng) {
            if (!geocoder) return;
            
            try {
                const response = await geocoder.geocode({ 'location': latlng });
                if (response.results[0]) {
                    updateFormFromGoogleAddress(response.results[0]);
                }
            } catch (error) {
                console.error('Geocoding error:', error);
            }
        }
        
        // Update form from Google address
        function updateFormFromGoogleAddress(address) {
            let city = '';
            let state = '';
            let pincode = '';
            let area = '';
            let house = '';
            
            // Extract address components
            for (let component of address.address_components) {
                const types = component.types;
                if (types.includes('locality')) {
                    city = component.long_name;
                } else if (types.includes('administrative_area_level_1')) {
                    state = component.long_name;
                } else if (types.includes('postal_code')) {
                    pincode = component.long_name;
                } else if (types.includes('sublocality') || types.includes('neighborhood')) {
                    if (!area) area = component.long_name;
                } else if (types.includes('route')) {
                    area = component.long_name;
                } else if (types.includes('street_number')) {
                    house = component.long_name;
                }
            }
            
            // Update form fields
            if (city) document.getElementById('city').value = city;
            if (state) document.getElementById('state').value = state;
            if (pincode) document.getElementById('pincode').value = pincode;
            if (area) document.getElementById('area').value = area;
            if (house && !document.getElementById('house').value) {
                document.getElementById('house').value = house;
            }
        }
        
        // Save address
        async function saveAddress() {
            // Validate form
            const house = document.getElementById('house').value.trim();
            const area = document.getElementById('area').value.trim();
            const city = document.getElementById('city').value.trim();
            const state = document.getElementById('state').value.trim();
            const pincode = document.getElementById('pincode').value.trim();
            const mobile = document.getElementById('mobile').value.trim();
            
            if (!house || !area || !city || !state || !pincode || !mobile) {
                showAddressAlert('Please fill all required fields', 'danger');
                return;
            }
            
            if (pincode.length !== 6) {
                showAddressAlert('Please enter a valid 6-digit pincode', 'danger');
                return;
            }
            
            if (mobile.length !== 10) {
                showAddressAlert('Please enter a valid 10-digit mobile number', 'danger');
                return;
            }
            
            // Prepare address data
            const addressData = {
                house: house,
                area: area,
                landmark: document.getElementById('landmark').value.trim(),
                city: city,
                state: state,
                pincode: pincode,
                mobile: mobile,
                latitude: document.getElementById('latitude').value || null,
                longitude: document.getElementById('longitude').value || null,
                userId: document.getElementById('userId').value || '${user.id}',
                name: '${user.name}'
            };
            
            // Show loading
            const saveBtn = document.getElementById('saveAddressBtn');
            const saveBtnText = document.getElementById('saveBtnText');
            const saveBtnSpinner = document.getElementById('saveBtnSpinner');
            
            saveBtn.disabled = true;
            saveBtnText.textContent = 'Saving...';
            saveBtnSpinner.classList.remove('d-none');
            
            try {
                const response = await fetch('${pageContext.request.contextPath}/address/save', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(addressData)
                });
                
                if (response.ok) {
                    const result = await response.json();
                    if (result.success) {
                        showAddressAlert('Address saved successfully!', 'success');
                        
                        // Close modal after 2 seconds
                        setTimeout(() => {
                            if (addressModal) {
                                addressModal.hide();
                            }
                            // Reload addresses
                            loadUserAddresses();
                        }, 2000);
                    } else {
                        showAddressAlert(result.message || 'Failed to save address', 'danger');
                    }
                } else {
                    showAddressAlert('Error saving address', 'danger');
                }
            } catch (error) {
                console.error('Error saving address:', error);
                showAddressAlert('Network error. Please try again.', 'danger');
            } finally {
                saveBtn.disabled = false;
                saveBtnText.textContent = 'Save Address';
                saveBtnSpinner.classList.add('d-none');
            }
        }
        
        // Process payment
        async function processPayment() {
            if (!selectedAddressId) {
                alert('Please select a delivery address');
                return;
            }
            
            const finalAmount = <%= finalAmount %>;
            const amountInPaise = Math.round(finalAmount * 100);
            const orderId = '${orderId}';
            
            // Show loading
            document.getElementById('loadingSpinner').style.display = 'block';
            
            try {
                const response = await fetch('${pageContext.request.contextPath}/payment/create-order', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        amount: amountInPaise,
                        orderId: orderId,
                        addressId: selectedAddressId
                    })
                });
                
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                
                const orderData = await response.json();
                if (!orderData) {
                    throw new Error('No order data received from server');
                }
                
                // Razorpay options
                const options = {
                    key: orderData.key || 'YOUR_RAZORPAY_KEY_ID',
                    amount: orderData.amount || amountInPaise,
                    currency: 'INR',
                    name: 'Your Store',
                    description: 'Order Payment',
                    order_id: orderData.orderId,
                    handler: function(response) {
                        document.getElementById('razorpay_payment_id').value = response.razorpay_payment_id;
                        document.getElementById('razorpay_order_id').value = response.razorpay_order_id;
                        document.getElementById('razorpay_signature').value = response.razorpay_signature;
                        document.getElementById('razorpay-form').submit();
                    },
                    prefill: {
                        name: '${user.name}',
                        email: '${user.email}',
                        contact: '${user.mobileNumber}'
                    },
                    notes: {
                        address_id: selectedAddressId,
                        order_id: orderId
                    },
                    theme: {
                        color: '#2563eb'
                    },
                    modal: {
                        ondismiss: function() {
                            document.getElementById('loadingSpinner').style.display = 'none';
                        }
                    }
                };
                
                const rzp = new Razorpay(options);
                rzp.open();
                document.getElementById('loadingSpinner').style.display = 'none';
            } catch (error) {
                console.error('Payment error:', error);
                alert('Payment failed. Please try again.');
                document.getElementById('loadingSpinner').style.display = 'none';
            }
        }
        
        // Global function for Google Maps callback (if needed)
        window.initMap = initMap;
    </script>
</body>
</html>