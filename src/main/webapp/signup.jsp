<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Signup - Patient Care System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1f1f1f, #121212);
            color: #e0e0e0;
            min-height: 100vh ;
            display:flex;
            align-items:center;
            justify-content:center;
            flex-wrap:wrap;
            width:100%;
            margin: 0;
            padding: 0;
        }

        .signup-container {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100%;
            width:50%;
        }

        .signup-card {
            background: #1e1e1e;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.6);
            padding: 40px 30px;
            width: 100%;
            max-width: 400px;
            transition: all 0.3s ease;
        }
        .signup-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.7);
        }

        .signup-card p.fs-4 {
            font-size: 1.75rem;
            font-weight: 600;
            margin-bottom: 30px;
            color: #00a8ff;
            text-align: center;
        }

        .signup-card .form-control {
            background: #2a2a2a;
            border: 1px solid #444;
            border-radius: 8px;
            color: #fff;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
         .signup-card .form-control::placeholder{
             color:#777676;
          }
        .signup-card .form-control:focus {
            border-color: #00a8ff;
            box-shadow: 0 0 8px #00a8ff;
            outline: none;
        }

        .signup-card .form-label {
            font-weight: 500;
            margin-bottom: 5px;
            color: #ccc;
        }

        .signup-card .btn-signup {
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
        .signup-card .btn-signup:hover {
            background: #0077cc;
            box-shadow: 0 5px 15px rgba(0, 119, 204, 0.5);
        }

        .text-success, .text-danger {
            font-size: 1rem;
            margin-bottom: 15px;
            text-align: center;
        }

        .signup-card .login-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #00a8ff;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .signup-card .login-link:hover {
            text-decoration: underline;
            color: #0077cc;
        }

        @media (max-width: 480px) {
            .signup-card {
                padding: 30px 20px;
            }
            .signup-card p.fs-4 {
                font-size: 1.5rem;
            }
        }

    </style>
</head>
<body>
<%@include file ="component/navbar.jsp" %>
<div class="signup-container">
    <div class="signup-card">

        <p class="fs-4">Create Account</p>

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

        <form action="<%=request.getContextPath()%>/register" method="post">
            <div class="mb-3">
                <label for="fullname" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Enter full name" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
            </div>
            <button type="submit" class="btn btn-signup">Register</button>
        </form>

        <a href="user_Login.jsp" class="login-link">Already have an account? Login</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
