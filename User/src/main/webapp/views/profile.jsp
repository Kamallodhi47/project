<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - FreshpickKart</title>
    <!-- SAME STYLESHEETS AS HOMEPAGE -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <style>
        /* HOMEPAGE THEME VARIABLES */
        :root {
            --primary: #4a6cf7;
            --secondary: #6c63ff;
            --accent: #ff6b8b;
            --dark: #2a2d3b;
            --light: #f8fafc;
            --text: #64748b;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e4edf5 100%);
            color: var(--dark);
            padding-top: 80px;
            min-height: 100vh;
        }
        .profile-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 15px;
        }
        .profile-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.8);
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
        }
        .profile-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-header h1 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            color: var(--dark);
            font-size: 2.2rem;
            margin-bottom: 10px;
        }
        .profile-header p {
            color: var(--text);
            font-size: 1rem;
        }
        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid white;
            box-shadow: 0 10px 25px rgba(74, 108, 247, 0.2);
            margin-bottom: 20px;
        }
        .form-label {
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 8px;
            font-size: 0.95rem;
        }
        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 15px;
            font-size: 0.95rem;
            transition: all 0.3s;
            background: #fff;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(74, 108, 247, 0.1);
        }
        .form-control[readonly] {
            background-color: #f8fafc;
            color: #666;
        }
        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s;
            color: white !important;
            box-shadow: 0 6px 15px rgba(74, 108, 247, 0.3);
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(74, 108, 247, 0.4);
        }
        .alert-message {
            border-radius: 12px;
            padding: 15px 20px;
            font-weight: 500;
            border: none;
            margin-bottom: 25px;
        }
        .alert-success {
            background: rgba(40, 167, 69, 0.1);
            color: #155724;
            border-left: 4px solid #28a745;
        }
        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        .section-title {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            color: var(--dark);
            font-size: 1.5rem;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f1f5f9;
            position: relative;
        }
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 70px;
            height: 2px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        }
        .info-badge {
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            color: var(--dark);
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
            margin-top: 5px;
        }
        @media (max-width: 768px) {
            body { padding-top: 70px; }
            .profile-card { padding: 20px; }
            .profile-header h1 { font-size: 1.8rem; }
            .profile-image { width: 120px; height: 120px; }
        }
    </style>
</head>
<body>
    <%@ include file="header1.jsp" %>

    <div class="profile-container">
        <!-- SUCCESS/ERROR MESSAGES -->
        <c:if test="${not empty sessionScope.succMsg}">
            <div class="alert-message alert-success">
                <i class="fas fa-check-circle me-2"></i>${sessionScope.succMsg}
                <c:remove var="succMsg" scope="session"/>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.errorMsg}">
            <div class="alert-message alert-danger">
                <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.errorMsg}
                <c:remove var="errorMsg" scope="session"/>
            </div>
        </c:if>

        <!-- MAIN PROFILE CARD -->
        <div class="profile-card">
            <div class="profile-header">
                <img src="${pageContext.request.contextPath}/img/profile_img/${user.profileImage}" 
                     class="profile-image" 
                     alt="${user.name}'s profile">
                <h1>${user.name}'s Profile</h1>
                <p>Manage your personal information and security</p>
            </div>

            <h3 class="section-title">Personal Information</h3>
            
            <form action="${pageContext.request.contextPath}/user/update-profile" 
                  method="post" 
                  enctype="multipart/form-data">
                  
                <div class="row g-4">
                    <!-- LEFT COLUMN -->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name" class="form-control" 
                                   value="${user.name}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mobile Number</label>
                            <input type="tel" name="mobileNumber" class="form-control" 
                                   value="${user.mobileNumber}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" class="form-control" 
                                   value="${user.email}" readonly>
                            <small class="text-muted">Email cannot be changed</small>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Profile Image</label>
                            <input type="file" name="img" class="form-control" 
                                   accept="image/*">
                            <small class="text-muted">Max 2MB, JPG/PNG format</small>
                        </div>
                    </div>
                    
                    <!-- RIGHT COLUMN -->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <input type="text" name="address" class="form-control" 
                                   value="${user.address}">
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">City</label>
                                    <input type="text" name="city" class="form-control" 
                                           value="${user.city}">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">State</label>
                                    <input type="text" name="state" class="form-control" 
                                           value="${user.state}">
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Pincode</label>
                            <input type="text" name="pincode" class="form-control" 
                                   value="${user.pincode}">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Account Details</label>
                            <div class="d-flex gap-3">
                                <span class="info-badge">Role: ${user.role}</span>
                                <span class="info-badge">Status: ${user.isEnable}</span>
                            </div>
                            <input type="hidden" name="id" value="${user.id}">
                        </div>
                    </div>
                </div>
                
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary px-5">
                        <i class="fas fa-save me-2"></i>Update Profile
                    </button>
                </div>
            </form>
        </div>

        <!-- CHANGE PASSWORD CARD -->
        <div class="profile-card">
            <h3 class="section-title">Change Password</h3>
            
            <form action="${pageContext.request.contextPath}/user/change-password" 
                  method="post">
                <div class="row g-4">
                    <div class="col-md-8 offset-md-2">
                        <div class="mb-4">
                            <label class="form-label">Current Password</label>
                            <input type="password" name="currentPassword" 
                                   class="form-control" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label">New Password</label>
                            <input type="password" name="newPassword" 
                                   class="form-control" required>
                            <small class="text-muted">Minimum 8 characters with letters and numbers</small>
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Confirm New Password</label>
                            <input type="password" name="confirmPassword" 
                                   class="form-control" required>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary px-5">
                                <i class="fas fa-key me-2"></i>Update Password
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="Footar.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Profile image preview
        document.querySelector('input[name="img"]')?.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file && file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    document.querySelector('.profile-image').src = event.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
</body>
</html>