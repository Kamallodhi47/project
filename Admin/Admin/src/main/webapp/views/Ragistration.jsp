<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Registration</title>

<style>
body{
    font-family: Arial;
    background:#f4f4f4;
}
.container{
    width:400px;
    margin:50px auto;
    padding:20px;
    background:white;
    border-radius:10px;
    box-shadow:0px 0px 10px gray;
}
input, textarea{
    width:100%;
    padding:10px;
    margin:5px 0;
}
button{
    width:100%;
    padding:10px;
    background:green;
    color:white;
    border:none;
}
</style>

</head>
<body>

<div class="container">
<h2 align="center">User Registration</h2>

<form action="/register" method="post" enctype="multipart/form-data">

    Name:
    <input type="text" name="name" required>

    Mobile Number:
    <input type="text" name="mobileNumber" required>

    Email:
    <input type="email" name="email" required>

    Address:
    <textarea name="address"></textarea>

    City:
    <input type="text" name="city">

    State:
    <input type="text" name="state">

    Pincode:
    <input type="text" name="pincode">

    Password:
    <input type="password" name="password" required>
     
	
	Profile Image:
	<input type="file" name="img">

    <button type="submit">Register</button>

</form>

<p align="center">
    Already have account? <a href="login.jsp">Login</a>
</p>

</div>

</body>
</html>