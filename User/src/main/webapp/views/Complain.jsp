<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>File Complaint</title>

<style>
body{
    font-family: Arial;
    background:#f4f6f9;
}

.container{
    width:500px;
    margin:50px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.1);
}

h2{
    text-align:center;
}

input, textarea{
    width:100%;
    padding:10px;
    margin-top:5px;
    margin-bottom:15px;
}

button{
    width:100%;
    padding:12px;
    background:#007bff;
    color:white;
    border:none;
    cursor:pointer;
}

button:hover{
    background:#0056b3;
}

.alert{
    padding:10px;
    margin-bottom:15px;
}

.error{
    background:#f8d7da;
    color:#721c24;
}

.success{
    background:#d4edda;
    color:#155724;
}

</style>

</head>

<body>

<div class="container">

<h2>File Complaint</h2>

<!-- Error Message -->
<c:if test="${not empty errorMsg}">
<div class="alert error">
${errorMsg}
</div>
</c:if>

<!-- Success Message -->
<c:if test="${not empty successMsg}">
<div class="alert success">
${successMsg}
</div>
</c:if>

<!-- Complaint Form -->
<form action="${pageContext.request.contextPath}/saveComplaint"
      method="post"
      enctype="multipart/form-data">

    <!-- CSRF Token -->
    <input type="hidden"
           name="${_csrf.parameterName}"
           value="${_csrf.token}" />

    <!-- Order ID (hidden, only if available) -->
    <c:if test="${not empty orderId}">
        <input type="hidden" name="orderId" value="${orderId}" />
    </c:if>

    <!-- Subject -->
    <label>Subject *</label>
    <input type="text"
           name="subject"
           required />

    <!-- Message -->
    <label>Message *</label>
    <textarea name="message"
              rows="5"
              required></textarea>

    <!-- File Upload -->
    <label>Attachment (Optional)</label>
    <input type="file"
           name="file" />

    <!-- Submit -->
    <button type="submit">
        Submit Complaint
    </button>

</form>

<!-- RESOLVED BUTTON FORM -->
<form action="${pageContext.request.contextPath}/resolveComplaint" method="post">
    <!-- Only include orderId if available -->
    <c:if test="${not empty orderId}">
		<input type="hidden" name="orderId" value="${orderId}" />
    </c:if>
    <button type="submit">Mark as Resolved</button>
</form>

<br>

<a href="${pageContext.request.contextPath}/todayOrder">
← Back to Orders
</a>

</div>

</body>
</html>
