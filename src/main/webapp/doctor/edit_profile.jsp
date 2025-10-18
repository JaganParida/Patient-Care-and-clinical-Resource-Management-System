<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Doctor Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Reuse the same CSS variables and styles from dashboard */
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

        .profile-card {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            padding: 30px;
            margin-bottom: 30px;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            margin: 0 auto 20px;
            border: 5px solid var(--light);
        }

        .form-section {
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--gray-light);
            display: flex;
            align-items: center;
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

        .form-control, .form-select {
            background: var(--light);
            border: 2px solid var(--gray-light);
            border-radius: 8px;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            background: var(--white);
        }

        .btn-update {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
            border: none;
            border-radius: 8px;
            color: white;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-update:hover {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            transform: translateY(-2px);
        }

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
            <a href="edit_profile.jsp" class="nav-link active">
                <i class="fas fa-user-edit"></i>Edit Profile
            </a>
            <a href="change_password.jsp" class="nav-link">
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
            <h2><i class="fas fa-user-edit me-2"></i>Edit Profile</h2>
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

        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">
                    <i class="fas fa-user-md"></i>
                </div>
                <h3>Dr. ${doctorObj.fullName}</h3>
                <p class="text-muted">${doctorObj.specialization} • ${doctorObj.department}</p>
            </div>

            <form action="../updateDoctorProfile" method="post">
                <!-- Personal Information -->
                <div class="form-section">
                    <h4 class="section-title">
                        <i class="fas fa-user"></i>Personal Information
                    </h4>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-user-circle"></i>Full Name
                                </label>
                                <input type="text" class="form-control" name="fullName" 
                                       value="${doctorObj.fullName}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-envelope"></i>Email Address
                                </label>
                                <input type="email" class="form-control" value="${doctorObj.email}" readonly>
                                <small class="text-muted">Email cannot be changed</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Professional Information -->
                <div class="form-section">
                    <h4 class="section-title">
                        <i class="fas fa-stethoscope"></i>Professional Information
                    </h4>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-heartbeat"></i>Specialization
                                </label>
                                <select class="form-select" name="specialization" required>
                                    <option value="cardiology" ${doctorObj.specialization == 'cardiology' ? 'selected' : ''}>Cardiology</option>
                                    <option value="neurology" ${doctorObj.specialization == 'neurology' ? 'selected' : ''}>Neurology</option>
                                    <option value="pediatrics" ${doctorObj.specialization == 'pediatrics' ? 'selected' : ''}>Pediatrics</option>
                                    <option value="orthopedics" ${doctorObj.specialization == 'orthopedics' ? 'selected' : ''}>Orthopedics</option>
                                    <option value="dermatology" ${doctorObj.specialization == 'dermatology' ? 'selected' : ''}>Dermatology</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-file-certificate"></i>License Number
                                </label>
                                <input type="text" class="form-control" name="licenseNumber" 
                                       value="${doctorObj.licenseNumber}" required>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-graduation-cap"></i>Years of Experience
                                </label>
                                <input type="number" class="form-control" name="yearsOfExperience" 
                                       value="${doctorObj.yearsOfExperience}" min="0" max="50" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-user-graduate"></i>Qualification
                                </label>
                                <select class="form-select" name="qualification" required>
                                    <option value="mbbs" ${doctorObj.qualification == 'mbbs' ? 'selected' : ''}>MBBS</option>
                                    <option value="md" ${doctorObj.qualification == 'md' ? 'selected' : ''}>MD</option>
                                    <option value="ms" ${doctorObj.qualification == 'ms' ? 'selected' : ''}>MS</option>
                                    <option value="dm" ${doctorObj.qualification == 'dm' ? 'selected' : ''}>DM</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contact Information -->
                <div class="form-section">
                    <h4 class="section-title">
                        <i class="fas fa-address-book"></i>Contact Information
                    </h4>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-phone"></i>Phone Number
                                </label>
                                <input type="tel" class="form-control" name="phone" 
                                       value="${doctorObj.phone}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-building"></i>Department
                                </label>
                                <select class="form-select" name="department" required>
                                    <option value="cardiology" ${doctorObj.department == 'cardiology' ? 'selected' : ''}>Cardiology</option>
                                    <option value="neurology" ${doctorObj.department == 'neurology' ? 'selected' : ''}>Neurology</option>
                                    <option value="pediatrics" ${doctorObj.department == 'pediatrics' ? 'selected' : ''}>Pediatrics</option>
                                    <option value="orthopedics" ${doctorObj.department == 'orthopedics' ? 'selected' : ''}>Orthopedics</option>
                                    <option value="emergency" ${doctorObj.department == 'emergency' ? 'selected' : ''}>Emergency</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-map-marker-alt"></i>Clinic Address
                        </label>
                        <textarea class="form-control" name="clinicAddress" rows="3" required>${doctorObj.clinicAddress}</textarea>
                    </div>
                </div>

                <!-- Availability -->
                <div class="form-section">
                    <h4 class="section-title">
                        <i class="fas fa-calendar-check"></i>Availability
                    </h4>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="availability" value="full_time" 
                                       ${doctorObj.availability.contains('full_time') ? 'checked' : ''}>
                                <label class="form-check-label">Full Time</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="availability" value="part_time"
                                       ${doctorObj.availability.contains('part_time') ? 'checked' : ''}>
                                <label class="form-check-label">Part Time</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="availability" value="consultation"
                                       ${doctorObj.availability.contains('consultation') ? 'checked' : ''}>
                                <label class="form-check-label">Consultation Only</label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-update btn-lg">
                        <i class="fas fa-save me-2"></i>Update Profile
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>