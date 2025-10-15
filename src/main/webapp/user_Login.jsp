<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Patient Login - Hospital Management System</title>
<%@include file="component/allcss.jsp" %>

<style>
:root {
    --primary: #2563eb;
    --primary-light: #3b82f6;
    --primary-dark: #1d4ed8;
    --secondary: #64748b;
    --accent: #0ea5e9;
    --light: #f8fafc;
    --white: #ffffff;
    --gray-light: #f1f5f9;
    --gray: #94a3b8;
    --dark: #1e293b;
    --text: #334155;
    --text-light: #64748b;
    --success: #10b981;
    --danger: #ef4444;
    --warning: #f59e0b;
    --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    --radius: 12px;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
    background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
    color: var(--text);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.login-container {
    width: 100%;
    max-width: 440px;
    margin: 0 auto;
    padding-top:100px;
}

.login-header {
    text-align: center;
    margin-bottom: 30px;
}

.login-header h1 {
    color: var(--primary);
    font-weight: 700;
    margin-bottom: 10px;
    font-size: 2.2rem;
}

.login-header p {
    color: var(--text-light);
    font-size: 1rem;
}

.login-card {
    background: var(--white);
    border-radius: var(--radius);
    box-shadow: var(--shadow-lg);
    overflow: hidden;
    transition: all 0.3s ease;
    padding: 40px 35px;
}

.login-card:hover {
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

.login-card .card-title {
    font-size: 1.5rem;
    font-weight: 600;
    color: var(--primary);
    margin-bottom: 30px;
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.form-group {
    margin-bottom: 20px;
}

.form-label {
    font-weight: 600;
    margin-bottom: 8px;
    color: var(--dark);
    display: flex;
    align-items: center;
    gap: 8px;
}

.form-label i {
    color: var(--primary);
    font-size: 1rem;
}

.input-group {
    position: relative;
    display: flex;
    align-items: center;
}

.form-control {
    background: var(--light);
    border: 2px solid var(--gray-light);
    border-radius: 8px;
    color: var(--text);
    padding: 12px 15px 12px 45px;
    transition: all 0.3s ease;
    font-size: 1rem;
    width: 100%;
    position: relative;
}

.form-control:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    outline: none;
    background: var(--white);
}

.input-icon {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--secondary);
    font-size: 1.1rem;
    transition: all 0.3s ease;
    z-index: 5;
    pointer-events: none;
    background: transparent;
}

.form-control:focus + .input-icon,
.input-group:focus-within .input-icon,
.input-group.focused .input-icon {
    color: var(--primary) !important;
}

.password-toggle {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    color: var(--secondary);
    cursor: pointer;
    font-size: 1.1rem;
    z-index: 5;
}

.input-group:focus-within .password-toggle,
.input-group.focused .password-toggle {
    color: var(--primary);
}

.btn-login {
    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
    border: none;
    border-radius: 8px;
    color: white;
    padding: 15px 30px;
    font-size: 1.1rem;
    font-weight: 600;
    transition: all 0.3s ease;
    width: 100%;
    margin-top: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.btn-login:hover {
    background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
}

.signup-link {
    display: block;
    text-align: center;
    margin-top: 25px;
    color: var(--primary);
    font-weight: 500;
    text-decoration: none;
    transition: all 0.3s ease;
}

.signup-link:hover {
    text-decoration: underline;
    color: var(--primary-dark);
}

.text-success, .text-danger {
    font-size: 1rem;
    margin-bottom: 20px;
    text-align: center;
    padding: 12px;
    border-radius: 8px;
}

.text-success {
    background: rgba(16, 185, 129, 0.1);
    color: var(--success);
    border: 1px solid rgba(16, 185, 129, 0.2);
}

.text-danger {
    background: rgba(239, 68, 68, 0.1);
    color: var(--danger);
    border: 1px solid rgba(239, 68, 68, 0.2);
}

.remember-forgot {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.remember-me {
    display: flex;
    align-items: center;
    gap: 8px;
}

.remember-me input {
    margin: 0;
}

.forgot-password {
    color: var(--primary);
    text-decoration: none;
    font-size: 0.9rem;
    transition: all 0.3s ease;
}

.forgot-password:hover {
    text-decoration: underline;
    color: var(--primary-dark);
}

.security-notice {
    background: rgba(245, 158, 11, 0.1);
    border: 1px solid rgba(245, 158, 11, 0.2);
    border-radius: 8px;
    padding: 12px;
    margin-top: 20px;
    font-size: 0.85rem;
    color: var(--warning);
    display: flex;
    align-items: center;
    gap: 10px;
}

.security-notice i {
    font-size: 1rem;
}

/* Validation feedback styling */
.was-validated .form-control:valid,
.was-validated .form-select:valid {
    border-color: var(--success);
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3e%3cpath fill='%2310b981' d='M2.3 6.73.6 4.53c-.4-1.04.46-1.4 1.1-.8l1.1 1.4 3.4-3.8c.6-.63 1.6-.27 1.2.7l-4 4.6c-.43.5-.8.4-1.1.1z'/%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right calc(.375em + .1875rem) center;
    background-size: calc(.75em + .375rem) calc(.75em + .375rem);
}

.was-validated .form-control:invalid,
.was-validated .form-select:invalid {
    border-color: var(--danger);
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23ef4444'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath d='m5.8 3.6.4.4.4-.4'/%3e%3cpath d='M6 7v1'/%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right calc(.375em + .1875rem) center;
    background-size: calc(.75em + .375rem) calc(.75em + .375rem);
}

.was-validated .form-check-input:valid {
    border-color: var(--success);
}

.was-validated .form-check-input:invalid {
    border-color: var(--danger);
}

.form-control:valid:focus,
.form-select:valid:focus {
    border-color: var(--success);
    box-shadow: 0 0 0 0.25rem rgba(16, 185, 129, 0.25);
}

.form-control:invalid:focus,
.form-select:invalid:focus {
    border-color: var(--danger);
    box-shadow: 0 0 0 0.25rem rgba(239, 68, 68, 0.25);
}

.invalid-feedback {
    display: none;
    width: 100%;
    margin-top: 0.25rem;
    font-size: 0.875em;
    color: var(--danger);
}

.was-validated .form-control:invalid ~ .invalid-feedback,
.was-validated .form-select:invalid ~ .invalid-feedback,
.was-validated .form-check-input:invalid ~ .invalid-feedback {
    display: block;
}

@media (max-width: 480px) {
    .login-card {
        padding: 30px 20px;
    }
    
    .login-header h1 {
        font-size: 1.8rem;
    }
    
    .remember-forgot {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
    }
}
</style>
</head>
<body>
	<%@include file="component/navbar.jsp"%>
<div class="login-container">
    <div class="login-header">
        <h1><i class="fas fa-hospital-user me-2"></i>Patient Login</h1>
        <p>Access your healthcare account securely</p>
    </div>

    <div class="login-card">
        <div class="card-title">
            <i class="fas fa-sign-in-alt"></i>Sign In
        </div>

        <!-- Success Message -->
        <c:if test="${not empty sucMsg}">
            <div class="text-success">
                <i class="fas fa-check-circle me-2"></i>${sucMsg}
            </div>
            <c:remove var="sucMsg" scope="session"/>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty errorMsg}">
            <div class="text-danger">
                <i class="fas fa-exclamation-circle me-2"></i>${errorMsg}
            </div>
            <c:remove var="errorMsg" scope="session"/>
        </c:if>

        <form action="userLogin" method="post" id="loginForm" class="needs-validation" novalidate>
            <div class="form-group">
                <label for="email" class="form-label">
                    <i class="fas fa-envelope"></i>Email Address
                </label>
                <div class="input-group">
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="Enter your registered email" required 
                           pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
                    <i class="input-icon fas fa-envelope"></i>
                    <div class="invalid-feedback">
                        Please provide a valid email address.
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="password" class="form-label">
                    <i class="fas fa-lock"></i>Password
                </label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Enter your password" required minlength="8">
                    <i class="input-icon fas fa-lock"></i>
                    <button type="button" class="password-toggle" id="togglePassword">
                        <i class="fas fa-eye"></i>
                    </button>
                    <div class="invalid-feedback">
                        Password must be at least 8 characters long.
                    </div>
                </div>
            </div>
            
            <div class="remember-forgot">
                <div class="remember-me">
                    <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember me</label>
                </div>
                <a href="change_password.jsp" class="forgot-password">Forgot Password?</a>
            </div>
            
            <button type="submit" class="btn-login">
                <i class="fas fa-sign-in-alt"></i>Login to Account
            </button>
        </form>

        <a href="signup.jsp" class="signup-link">
            <i class="fas fa-user-plus me-2"></i>Don't have an account? Register as Patient
        </a>
        
        <div class="security-notice">
            <i class="fas fa-shield-alt"></i>
            <span>Your medical information is protected with industry-standard security measures.</span>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Bootstrap Form Validation
    (function() {
        'use strict';
        
        // Fetch all the forms we want to apply custom Bootstrap validation styles to
        const forms = document.querySelectorAll('.needs-validation');
        
        // Loop over them and prevent submission
        Array.from(forms).forEach(function(form) {
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                
                form.classList.add('was-validated');
            }, false);
        });
    })();

    // Password visibility toggle
    document.getElementById('togglePassword').addEventListener('click', function() {
        const passwordInput = document.getElementById('password');
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

    // Add focus event listeners to all inputs for icon color change
    window.onload = function() {
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.classList.remove('focused');
            });
        });
        
        // Auto-focus on email field for better UX
        document.getElementById('email').focus();
    };
</script>
</body>
</html>