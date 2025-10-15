<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login - Hospital Management System</title>
<%@include file="component/allcss.jsp" %>

<style>
:root {
    --primary: #7e22ce;
    --primary-light: #a855f7;
    --primary-dark: #6b21a8;
    --secondary: #64748b;
    --accent: #c084fc;
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

.admin-container {
    width: 100%;
    max-width: 480px;
    margin: 0 auto;
}

.admin-header {
    text-align: center;
    margin-bottom: 40px;
}

.admin-header h1 {
    color: var(--primary);
    font-weight: 700;
    margin-bottom: 10px;
    font-size: 2.5rem;
}

.admin-header p {
    color: var(--text-light);
    font-size: 1.1rem;
}

.admin-card {
    background: var(--white);
    border-radius: var(--radius);
    box-shadow: var(--shadow-lg);
    overflow: hidden;
    transition: all 0.3s ease;
    padding: 40px 35px;
    position: relative;
    border: 1px solid var(--gray-light);
}

.admin-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
}

.admin-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 20px 40px rgba(126, 34, 206, 0.15);
}

.admin-card .card-title {
    font-size: 1.8rem;
    font-weight: 600;
    color: var(--primary);
    margin-bottom: 30px;
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.admin-card .card-title i {
    color: var(--primary);
    font-size: 1.5rem;
}

.form-group {
    margin-bottom: 25px;
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
    padding: 14px 15px 14px 50px;
    transition: all 0.3s ease;
    font-size: 1rem;
    width: 100%;
}

.form-control::placeholder {
    color: var(--gray);
}

.form-control:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(126, 34, 206, 0.1);
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

.btn-admin-login {
    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
    border: none;
    border-radius: 8px;
    color: white;
    padding: 16px 30px;
    font-size: 1.1rem;
    font-weight: 600;
    transition: all 0.3s ease;
    width: 100%;
    margin-top: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    position: relative;
    overflow: hidden;
}

.btn-admin-login::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
    transition: 0.5s;
}

.btn-admin-login:hover::before {
    left: 100%;
}

.btn-admin-login:hover {
    background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(126, 34, 206, 0.3);
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

.security-features {
    margin-top: 25px;
    padding-top: 20px;
    border-top: 1px solid var(--gray-light);
}

.security-features h6 {
    color: var(--dark);
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.feature-list {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
}

.feature-item {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.85rem;
    color: var(--text-light);
}

.feature-item i {
    color: var(--primary);
    font-size: 0.8rem;
}

.admin-badge {
    position: absolute;
    top: -10px;
    right: 20px;
    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
    color: white;
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    box-shadow: 0 4px 10px rgba(126, 34, 206, 0.3);
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

.invalid-feedback {
    display: none;
    width: 100%;
    margin-top: 0.25rem;
    font-size: 0.875em;
    color: var(--danger);
}

.was-validated .form-control:invalid ~ .invalid-feedback {
    display: block;
}

@media (max-width: 480px) {
    .admin-card {
        padding: 30px 20px;
    }
    
    .admin-header h1 {
        font-size: 2rem;
    }
    
    .feature-list {
        grid-template-columns: 1fr;
    }
}
</style>
</head>
<body>

<div class="admin-container">
    <div class="admin-header">
        <h1><i class="fas fa-hospital-alt me-2"></i>Admin Portal</h1>
        <p>Secure access to hospital management system</p>
    </div>

    <div class="admin-card">
        <div class="admin-badge">
            <i class="fas fa-shield-alt me-1"></i>Admin Only
        </div>
        
        <div class="card-title">
            <i class="fas fa-lock"></i>Administrator Login
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

        <form action="adminLogin" method="post" id="adminLoginForm" class="needs-validation" novalidate>
            <div class="form-group">
                <label for="email" class="form-label">
                    <i class="fas fa-user-shield"></i>Admin Email
                </label>
                <div class="input-group">
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="Enter admin email address" required 
                           pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
                    <i class="input-icon fas fa-envelope"></i>
                    <div class="invalid-feedback">
                        Please provide a valid admin email address.
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="password" class="form-label">
                    <i class="fas fa-key"></i>Admin Password
                </label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Enter admin password" required minlength="6">
                    <i class="input-icon fas fa-lock"></i>
                    <button type="button" class="password-toggle" id="togglePassword">
                        <i class="fas fa-eye"></i>
                    </button>
                    <div class="invalid-feedback">
                        Password must be at least 6 characters long.
                    </div>
                </div>
            </div>
            
            <button type="submit" class="btn-admin-login">
                <i class="fas fa-sign-in-alt"></i>Access Admin Dashboard
            </button>
        </form>

        <div class="security-features">
            <h6><i class="fas fa-shield-alt"></i>Security Features</h6>
            <div class="feature-list">
                <div class="feature-item">
                    <i class="fas fa-check-circle"></i>
                    <span>Encrypted Connection</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-check-circle"></i>
                    <span>Activity Monitoring</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-check-circle"></i>
                    <span>Access Logging</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-check-circle"></i>
                    <span>Session Timeout</span>
                </div>
            </div>
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