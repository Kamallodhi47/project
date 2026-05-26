<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<style>
body{
    font-family: Arial;
    background:#f4f4f4;
}
.container{
    width:350px;
    margin:80px auto;
    padding:20px;
    background:white;
    border-radius:10px;
    box-shadow:0px 0px 10px gray;
}
input{
    width:100%;
    padding:10px;
    margin:10px 0;
}
button{
    width:100%;
    padding:10px;
    background:blue;
    color:white;
    border:none;
}
</style>

</head>
<body>

<div class="container">
<h2 align="center">Login</h2>

<form action="/login" method="post">

    Email:
    <input type="email" name="email" required>

    Password:
    <input type="password" name="password" required>

    <button type="submit">Login</button>

</form>

<p align="center">
    New User? <a href="register.jsp">Register Here</a>
</p>

</div>

</body>
</html>