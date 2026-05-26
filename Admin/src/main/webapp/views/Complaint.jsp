<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel - Complaint Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            padding: 20px;
        }

        /* Main Container */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Header Section */
        .header {
            background: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            color: #1e3c72;
            font-size: 28px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .admin-name {
            color: #555;
            font-weight: 600;
        }

        .logout-btn {
            background: #dc3545;
            color: white;
            padding: 8px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background: #c82333;
        }

        /* Statistics Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card.pending {
            border-bottom: 4px solid #dc3545;
        }

        .stat-card.in-progress {
            border-bottom: 4px solid #fd7e14;
        }

        .stat-card.resolved {
            border-bottom: 4px solid #28a745;
        }

        .stat-card.total {
            border-bottom: 4px solid #007bff;
        }

        .stat-number {
            font-size: 36px;
            font-weight: bold;
            margin: 10px 0;
        }

        .stat-label {
            color: #666;
            font-size: 16px;
            font-weight: 600;
        }

        .stat-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }

        /* Filter Section */
        .filter-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .filter-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .filter-item {
            display: flex;
            flex-direction: column;
        }

        .filter-item label {
            font-size: 14px;
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
        }

        .filter-item input,
        .filter-item select {
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: 0.3s;
        }

        .filter-item input:focus,
        .filter-item select:focus {
            outline: none;
            border-color: #667eea;
        }

        .filter-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
            font-size: 14px;
        }

        .btn-primary {
            background: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background: #0056b3;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #545b62;
        }

        /* Complaints Table */
        .complaints-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .complaint-count {
            background: #e9ecef;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            color: #495057;
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #495057;
            border-bottom: 2px solid #dee2e6;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
            vertical-align: middle;
        }

        tr:hover {
            background: #f8f9fa;
        }

        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
            text-align: center;
        }

        .status-pending {
            background: #ffebee;
            color: #c62828;
            border: 1px solid #ef9a9a;
        }

        .status-in-progress {
            background: #fff3e0;
            color: #ef6c00;
            border: 1px solid #ffb74d;
        }

        .status-resolved {
            background: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-view {
            background: #17a2b8;
            color: white;
        }

        .btn-view:hover {
            background: #138496;
        }

        .btn-pending {
            background: #dc3545;
            color: white;
        }

        .btn-pending:hover {
            background: #c82333;
        }

        .btn-progress {
            background: #fd7e14;
            color: white;
        }

        .btn-progress:hover {
            background: #e96b02;
        }

        .btn-resolved {
            background: #28a745;
            color: white;
            opacity: 0.7;
            cursor: default;
        }

        .btn-download {
            background: #6c757d;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .btn-download:hover {
            background: #545b62;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            margin: 50px auto;
            padding: 30px;
            border-radius: 15px;
            width: 80%;
            max-width: 800px;
            max-height: 80vh;
            overflow-y: auto;
            position: relative;
        }

        .close {
            position: absolute;
            right: 20px;
            top: 15px;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            color: #666;
        }

        .close:hover {
            color: #333;
        }

        .modal-header {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .modal-body {
            line-height: 1.6;
        }

        .detail-row {
            margin-bottom: 15px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .detail-label {
            font-weight: 600;
            color: #495057;
            width: 120px;
            display: inline-block;
        }

        .detail-value {
            color: #212529;
        }

        .attachment-preview {
            max-width: 100%;
            max-height: 300px;
            margin: 10px 0;
            border-radius: 8px;
        }

        .response-textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            margin: 10px 0;
            resize: vertical;
        }

        /* Alert Messages */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .close-alert {
            cursor: pointer;
            font-size: 20px;
            font-weight: bold;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 5px;
            margin-top: 30px;
        }

        .page-link {
            padding: 8px 15px;
            border: 1px solid #dee2e6;
            background: white;
            color: #007bff;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }

        .page-link.active {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }

        .page-link:hover:not(.active) {
            background: #e9ecef;
        }

        /* Complaint Modal */
        .complaint-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .complaint-modal-content {
            background: white;
            padding: 25px;
            width: 450px;
            border-radius: 15px;
            position: relative;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .complaint-modal-content h3 {
            color: #1e3c72;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .complaint-modal-content p {
            margin: 15px 0;
            line-height: 1.6;
            color: #333;
        }

        .close-modal-btn {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: 0.3s;
        }

        .close-modal-btn:hover {
            background: #545b62;
        }
    </style>
</head>
<body>
    <div class="main-container">
        
        <!-- Header -->
        <div class="header">
            <h1>
                <span>📋 Complaint Management System</span>
                <span style="font-size: 14px; color: #666;">Admin Panel</span>
            </h1>
            <div class="admin-info">
                <span class="admin-name">Welcome, Admin</span>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>

        <!-- Alert Messages -->
        <c:if test="${not empty successMsg}">
            <div class="alert alert-success" id="successAlert">
                <span>✅ ${successMsg}</span>
                <span class="close-alert" onclick="this.parentElement.remove()">&times;</span>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-error" id="errorAlert">
                <span>❌ ${errorMsg}</span>
                <span class="close-alert" onclick="this.parentElement.remove()">&times;</span>
            </div>
        </c:if>

        <!-- Statistics Cards -->
        <div class="stats-container">
            <div class="stat-card pending">
                <div class="stat-icon">⏳</div>
                <div class="stat-number">${pendingCount}</div>
                <div class="stat-label">Pending Complaints</div>
            </div>
            <div class="stat-card in-progress">
                <div class="stat-icon">⚙️</div>
                <div class="stat-number">${inProgressCount}</div>
                <div class="stat-label">In Progress</div>
            </div>
            <div class="stat-card resolved">
                <div class="stat-icon">✅</div>
                <div class="stat-number">${resolvedCount}</div>
                <div class="stat-label">Resolved</div>
            </div>
            <div class="stat-card total">
                <div class="stat-icon">📊</div>
                <div class="stat-number">${totalComplaints}</div>
                <div class="stat-label">Total Complaints</div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-title">🔍 Filter Complaints</div>
            <form action="${pageContext.request.contextPath}/complaints/filter" method="get">
                <div class="filter-grid">
                    <div class="filter-item">
                        <label>Status</label>
                        <select name="status">
                            <option value="">All Status</option>
                            <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                            <option value="IN_PROGRESS" ${param.status == 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
                            <option value="RESOLVED" ${param.status == 'RESOLVED' ? 'selected' : ''}>Resolved</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <label>Search</label>
                        <input type="text" name="search" placeholder="ID, Subject, Message..." value="${param.search}">
                    </div>
                    <div class="filter-item">
                        <label>From Date</label>
                        <input type="date" name="fromDate" value="${param.fromDate}">
                    </div>
                    <div class="filter-item">
                        <label>To Date</label>
                        <input type="date" name="toDate" value="${param.toDate}">
                    </div>
                </div>
                <div class="filter-actions">
                    <button type="submit" class="btn btn-primary">Apply Filters</button>
                    <a href="${pageContext.request.contextPath}/complaints" class="btn btn-secondary">Reset</a>
                </div>
            </form>
        </div>

        <!-- Complaints Table -->
        <div class="complaints-section">
            <div class="section-title">
                <span>📋 All Complaints</span>
                <span class="complaint-count">Total: ${totalComplaints}</span>
            </div>

            <c:choose>
                <c:when test="${empty complaints}">
                    <div style="text-align: center; padding: 60px; color: #666;">
                        <h2>📭 No Complaints Found</h2>
                        <p>There are no complaints matching your criteria.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Customer</th>
                                    <th>Order ID</th>
                                    <th>Subject</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Attachment</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="complaint" items="${complaints}">
                                    <tr>
                                        <td>#${complaint.id}</td>
                                        <td>
                                            ${complaint.user.name}<br>
                                            <small style="color: #666;">${complaint.user.email}</small>
                                        </td>
                                        <td>#${complaint.orderId}</td>
                                        <td>
                                            <strong>${complaint.subject}</strong><br>
                                            <small style="color: #666;">${fn:substring(complaint.message, 0, 50)}...</small>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${complaint.complaintDate}" pattern="dd-MM-yyyy"/><br>
                                            <small><fmt:formatDate value="${complaint.complaintDate}" pattern="HH:mm"/></small>
                                        </td>
                                        <td>
                                            <span class="status-badge status-${fn:toLowerCase(fn:replace(complaint.status, '_', '-'))}">
                                                ${complaint.status}
                                            </span>
                                        </td>
                                        <td>
											<a href="${pageContext.request.contextPath}/complaint/download/${complaint.id}" 
											   class="btn-sm btn-download" 
											   title="${complaint.attachmentName}">
											   📎 Download
											</a>
                                            <c:if test="${empty complaint.attachmentName}">
                                                <span style="color: #999;">No file</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <!-- View Button -->
                                                <button class="btn-sm btn-view" onclick="showComplaintModal('${complaint.subject}', '${fn:escapeXml(complaint.message)}')">View</button>
                                                
                                                <!-- Status Update Forms -->
                                                <c:choose>
                                                    <c:when test="${complaint.status == 'PENDING'}">
                                                        <form action="${pageContext.request.contextPath}/complaint/update-status" method="post" style="display:inline;">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                            <input type="hidden" name="complaintId" value="${complaint.id}" />
                                                            <input type="hidden" name="status" value="IN_PROGRESS" />
                                                            <button type="submit" class="btn-sm btn-pending" onclick="return confirm('Mark as In Progress?')">Start</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${complaint.status == 'IN_PROGRESS'}">
                                                        <form action="${pageContext.request.contextPath}/complaint/update-status" method="post" style="display:inline;">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                            <input type="hidden" name="complaintId" value="${complaint.id}" />
                                                            <input type="hidden" name="status" value="RESOLVED" />
                                                            <button type="submit" class="btn-sm btn-progress" onclick="return confirm('Mark as Resolved?')">Resolve</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${complaint.status == 'RESOLVED'}">
                                                        <span class="btn-sm btn-resolved">Resolved</span>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="?page=${i}&status=${param.status}&search=${param.search}&fromDate=${param.fromDate}&toDate=${param.toDate}" 
                                   class="page-link ${currentPage == i ? 'active' : ''}">${i}</a>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Simple Complaint Modal -->
    <div id="complaintModal" class="complaint-modal">
        <div class="complaint-modal-content">
            <h3 id="modalSubject"></h3>
            <p id="modalMessage"></p>
            <button onclick="closeModal()" class="close-modal-btn">Close</button>
        </div>
    </div>

    <!-- Original Complaint Details Modal (kept for full details) -->
    <div id="fullComplaintModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeFullModal()">&times;</span>
            <div class="modal-header">
                <h2>Complete Complaint Details</h2>
            </div>
            <div class="modal-body" id="modalBody">
                <!-- Content will be loaded dynamically -->
            </div>
        </div>
    </div>

    <script>
        // Simple modal functions
        function showComplaintModal(subject, message) {
            document.getElementById('modalSubject').innerText = subject;
            document.getElementById('modalMessage').innerText = message;
            document.getElementById('complaintModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('complaintModal').style.display = 'none';
        }

        // Full details modal functions
        function viewComplaint(complaintId) {
            // Show loading
            document.getElementById('modalBody').innerHTML = '<div style="text-align: center; padding: 20px;">Loading...</div>';
            document.getElementById('fullComplaintModal').style.display = 'block';
            
            fetch('${pageContext.request.contextPath}/complaint/' + complaintId)
                .then(response => response.json())
                .then(data => {
                    let html = `
                        <div class="detail-row">
                            <span class="detail-label">Complaint ID:</span>
                            <span class="detail-value">#` + data.id + `</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Customer:</span>
                            <span class="detail-value">` + data.user.name + ` (` + data.user.email + `)</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Order ID:</span>
                            <span class="detail-value">#` + data.orderId + `</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Date:</span>
                            <span class="detail-value">` + new Date(data.complaintDate).toLocaleString() + `</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Status:</span>
                            <span class="detail-value"><span class="status-badge status-` + data.status.toLowerCase().replace('_', '-') + `">` + data.status + `</span></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Subject:</span>
                            <span class="detail-value"><strong>` + data.subject + `</strong></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Message:</span>
                            <div class="detail-value" style="background:#f8f9fa; padding:15px; border-radius:8px; margin-top:5px;">` + data.message + `</div>
                        </div>`;
                    
                    if (data.attachmentName) {
                        let fileExt = data.attachmentName.split('.').pop().toLowerCase();
                        if (['jpg', 'jpeg', 'png', 'gif'].includes(fileExt)) {
                            html += `
                                <div class="detail-row">
                                    <span class="detail-label">Attachment:</span>
                                    <div>
                                        <img src="${pageContext.request.contextPath}/complaint/download/` + data.id + `" class="attachment-preview" alt="Attachment">
                                        <br>
                                        <a href="${pageContext.request.contextPath}/complaint/download/` + data.id + `" class="btn-sm btn-download" style="margin-top:10px;">Download ` + data.attachmentName + `</a>
                                    </div>
                                </div>`;
                        } else {
                            html += `
                                <div class="detail-row">
                                    <span class="detail-label">Attachment:</span>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/complaint/download/` + data.id + `" class="btn-sm btn-download">Download ` + data.attachmentName + `</a>
                                    </div>
                                </div>`;
                        }
                    }

                    document.getElementById('modalBody').innerHTML = html;
                })
                .catch(error => {
                    document.getElementById('modalBody').innerHTML = '<div style="color: red; text-align: center;">Error loading complaint details</div>';
                });
        }

        function closeFullModal() {
            document.getElementById('fullComplaintModal').style.display = 'none';
        }

        // Close modals when clicking outside
        window.onclick = function(event) {
            const simpleModal = document.getElementById('complaintModal');
            const fullModal = document.getElementById('fullComplaintModal');
            
            if (event.target == simpleModal) {
                simpleModal.style.display = 'none';
            }
            if (event.target == fullModal) {
                fullModal.style.display = 'none';
            }
        }

        // Auto-hide alerts
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 5000);
    </script>
</body>
</html>