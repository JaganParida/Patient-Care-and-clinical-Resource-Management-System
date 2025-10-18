<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - Doctor Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Reuse the same CSS variables and styles */
        :root {
            --primary: #2563eb;
            --primary-light: #3b82f6;
            --primary-dark: #1d4ed8;
            --secondary: #64748b;
            --light: #f8fafc;
            --white: #ffffff;
            --gray-light: #f1f5f9;
            --dark: #1e293b;
            --text: #334155;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --radius: 12px;
            --error: #dc2626;
            --success: #16a34a;
        }

        body {
            background-color: #f1f5f9;
            color: var(--text);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .sidebar {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            height: 100vh;
            position: fixed;
            width: 280px;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 25px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.8);
            padding: 15px 20px;
            margin: 5px 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            transform: translateX(5px);
        }

        .main-content {
            margin-left: 280px;
            padding: 20px;
            transition: all 0.3s ease;
        }

        .password-card {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            padding: 30px;
            max-width: 600px;
            margin: 0 auto;
        }

        .password-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .password-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin: 0 auto 20px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-label {
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 8px;
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
            transition: all 0.3s ease;
            z-index: 10;
        }

        .password-toggle:hover {
            color: var(--primary);
        }

        .btn-change {
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

        .btn-change:hover {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
        }

        .password-strength {
            margin-top: 8px;
            font-size: 0.875rem;
        }

        .strength-weak { color: var(--error); }
        .strength-medium { color: var(--warning); }
        .strength-strong { color: var(--success); }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <c:if test="${empty doctorObj}">
        <c:redirect url="../doctor_login.jsp"/>
    </c:if>

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h3><i class="fas fa-hospital me-2"></i>MedCare</h3>
            <p>Doctor Portal</p>
        </div>
        
        <div class="sidebar-content">
            <a href="index.jsp" class="nav-link">
                <i class="fas fa-tachometer-alt"></i>Dashboard
            </a>
            <a href="appointments.jsp" class="nav-link">
                <i class="fas fa-calendar-check"></i>Appointments
            </a>
            <a href="patients.jsp" class="nav-link">
                <i class="fas fa-user-injured"></i>My Patients
            </a>
            <a href="edit_profile.jsp" class="nav-link">
                <i class="fas fa-user-edit"></i>Edit Profile
            </a>
            <a href="change_password.jsp" class="nav-link active">
                <i class="fas fa-key"></i>Change Password
            </a>
            <a href="../doctorLogout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i>Logout
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-key me-2"></i>Change Password</h2>
            <a href="index.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty sucMsg}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${sucMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="sucMsg" scope="session"/>
        </c:if>

        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${errorMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="errorMsg" scope="session"/>
        </c:if>

        <div class="password-card">
            <div class="password-header">
                <div class="password-icon">
                    <i class="fas fa-lock"></i>
                </div>
                <h3>Update Your Password</h3>
                <p class="text-muted">Ensure your account security with a strong password</p>
            </div>

            <form action="../doctorChangePassword" method="post" id="passwordForm">
                <div class="form-group">
                    <label for="currentPassword" class="form-label">
                        <i class="fas fa-lock"></i>Current Password
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="currentPassword" 
                               name="currentPassword" placeholder="Enter current password" required>
                        <i class="input-icon fas fa-lock"></i>
                        <button type="button" class="password-toggle" data-target="currentPassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <div class="form-group">
                    <label for="newPassword" class="form-label">
                        <i class="fas fa-key"></i>New Password
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="newPassword" 
                               name="newPassword" placeholder="Enter new password" required>
                        <i class="input-icon fas fa-key"></i>
                        <button type="button" class="password-toggle" data-target="newPassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="password-strength" id="passwordStrength"></div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword" class="form-label">
                        <i class="fas fa-check-double"></i>Confirm New Password
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="confirmPassword" 
                               name="confirmPassword" placeholder="Confirm new password" required>
                        <i class="input-icon fas fa-check-double"></i>
                        <button type="button" class="password-toggle" data-target="confirmPassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="password-match" id="passwordMatch"></div>
                </div>

                <button type="submit" class="btn-change">
                    <i class="fas fa-sync-alt me-2"></i>Change Password
                </button>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Password visibility toggle
        document.querySelectorAll('.password-toggle').forEach(button => {
            button.addEventListener('click', function() {
                const targetId = this.getAttribute('data-target');
                const passwordInput = document.getElementById(targetId);
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
        });

        // Password strength indicator
        document.getElementById('newPassword').addEventListener('input', function() {
            const password = this.value;
            const strengthText = document.getElementById('passwordStrength');
            
            let strength = 0;
            let feedback = '';

            // Check password length
            if (password.length >= 8) strength++;
            // Check for lowercase letters
            if (/[a-z]/.test(password)) strength++;
            // Check for uppercase letters
            if (/[A-Z]/.test(password)) strength++;
            // Check for numbers
            if (/[0-9]/.test(password)) strength++;
            // Check for special characters
            if (/[^A-Za-z0-9]/.test(password)) strength++;

            switch(strength) {
                case 0:
                case 1:
                case 2:
                    feedback = '<span class="strength-weak"><i class="fas fa-times-circle me-1"></i>Weak password</span>';
                    break;
                case 3:
                case 4:
                    feedback = '<span class="strength-medium"><i class="fas fa-exclamation-circle me-1"></i>Medium strength</span>';
                    break;
                case 5:
                    feedback = '<span class="strength-strong"><i class="fas fa-check-circle me-1"></i>Strong password</span>';
                    break;
            }

            strengthText.innerHTML = feedback;
        });

        // Password match validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = this.value;
            const matchText = document.getElementById('passwordMatch');
            
            if (confirmPassword === '') {
                matchText.innerHTML = '';
            } else if (newPassword === confirmPassword) {
                matchText.innerHTML = '<span class="strength-strong"><i class="fas fa-check-circle me-1"></i>Passwords match</span>';
            } else {
                matchText.innerHTML = '<span class="strength-weak"><i class="fas fa-times-circle me-1"></i>Passwords do not match</span>';
            }
        });

        // Form validation
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (!currentPassword || !newPassword || !confirmPassword) {
                e.preventDefault();
                alert('Please fill in all password fields.');
                return;
            }
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                alert('New passwords do not match.');
                return;
            }
            
            if (newPassword.length < 8) {
                e.preventDefault();
                alert('New password must be at least 8 characters long.');
                return;
            }
        });
    </script>
</body>
</html>