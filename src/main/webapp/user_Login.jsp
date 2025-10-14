<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Login</title>
<%@include file="component/allcss.jsp" %>

<style>
/* Base Body Styling */
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #1f1f1f, #121212);
    color: #e0e0e0;
    min-height: 100vh;
    margin: 0;
    padding: 0;
}

/* Navbar Fixed Top */
nav {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;
}

/* Container for Login Card */
.login-container {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 100%;
    padding-top: 80px; /* Space for navbar */
}

/* Login Card */
.login-card {
    background: #1e1e1e;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.6);
    padding: 40px 30px;
    width: 100%;
    max-width: 400px;
    transition: all 0.3s ease;
}
.login-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 30px rgba(0,0,0,0.7);
}

/* Card Title */
.login-card p.fs-4 {
    font-size: 1.75rem;
    font-weight: 600;
    margin-bottom: 30px;
    color: #00a8ff;
    text-align: center;
}

/* Input Fields */
.login-card .form-control {
    background: #2a2a2a;
    border: 1px solid #444;
    border-radius: 8px;
    color: #fff;
    padding: 12px 15px;
    transition: all 0.3s ease;
}
.login-card .form-control:focus {
    border-color: #00a8ff;
    box-shadow: 0 0 8px #00a8ff;
    outline: none;
}

/* Labels */
.login-card .form-label {
    font-weight: 500;
    margin-bottom: 5px;
    color: #ccc;
}

/* Login Button */
.login-card .btn-login {
    background: #00a8ff;
    border: none;
    border-radius: 8px;
    padding: 12px;
    font-size: 1.1rem;
    font-weight: 500;
    transition: all 0.3s ease;
    width: 100%;
    margin-top: 10px;
}
.login-card .btn-login:hover {
    background: #0077cc;
    box-shadow: 0 5px 15px rgba(0, 119, 204, 0.5);
}

/* Messages */
.text-success, .text-danger {
    font-size: 1rem;
    margin-bottom: 15px;
    text-align: center;
}

/* Signup Link */
.login-card .signup-link {
    display: block;
    text-align: center;
    margin-top: 20px;
    color: #00a8ff;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.3s ease;
}
.login-card .signup-link:hover {
    text-decoration: underline;
    color: #0077cc;
}

/* Responsive */
@media (max-width: 480px) {
    .login-card {
        padding: 30px 20px;
    }
    .login-card p.fs-4 {
        font-size: 1.5rem;
    }
}
</style>
</head>
<body>

<%@include file ="component/navbar.jsp" %>

<div class="login-container">
    <div class="login-card">

        <p class="fs-4">User Login</p>

        <!-- Success Message -->
        <c:if test="${not empty sucMsg }">
            <p class="text-success">${sucMsg }</p>
            <c:remove var="sucMsg" scope="session"/>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty errorMsg }">
            <p class="text-danger">${errorMsg }</p>
            <c:remove var="errorMsg" scope="session"/>
        </c:if>

        <form action="userLogin" method="post">
            <div class="mb-3">
                <label class="form-label">Email address</label>
                <input required name="email" type="email" class="form-control" placeholder="Enter your email">
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input required name="password" type="password" class="form-control" placeholder="Enter your password">
            </div>
            <button type="submit" class="btn btn-login">Login</button>
        </form>

        <a href="signup.jsp" class="signup-link">Don't have an account? Create one</a>
    </div>
</div>

</body>
</html>
