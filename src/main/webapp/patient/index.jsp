<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<%-- 
    Session Check: 
    If the 'patient' object is not in the session (user not logged in), 
    redirect to the login page to prevent errors.
--%>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Patient Dashboard - Hospital Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary: #2563eb;
            --primary-light: #3b82f6;
            --primary-dark: #1d4ed8;
            --secondary: #64748b;
            --accent: #0ea5e9;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --light: #f8fafc;
            --white: #ffffff;
            --gray-light: #f1f5f9;
            --gray: #94a3b8;
            --dark: #1e293b;
            --text: #334155;
            --text-light: #64748b;
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
            background-color: #f5f7fb;
            color: var(--text);
        }

        /* Sidebar Styles */
        .sidebar {
            background: linear-gradient(180deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            height: 100vh;
            position: fixed;
            width: 260px;
            transition: all 0.3s;
            z-index: 1000;
            box-shadow: var(--shadow-lg);
        }

        .sidebar-header {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header h3 {
            font-weight: 700;
            margin-bottom: 0;
            font-size: 1.5rem;
        }

        .sidebar-header p {
            opacity: 0.8;
            font-size: 0.9rem;
            margin-bottom: 0;
        }

        .sidebar-menu {
            padding: 15px 0;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.8);
            padding: 12px 20px;
            margin: 5px 10px;
            border-radius: 8px;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
        }

        .nav-link:hover, .nav-link.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .nav-link i {
            width: 20px;
            text-align: center;
        }

        /* Main Content Styles */
        .main-content {
            margin-left: 260px;
            padding: 20px;
            transition: all 0.3s;
        }

        .header {
            background: white;
            border-radius: var(--radius);
            padding: 15px 25px;
            margin-bottom: 25px;
            box-shadow: var(--shadow);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-title h1 {
            color: var(--primary);
            font-weight: 700;
            margin-bottom: 5px;
            font-size: 1.8rem;
        }

        .header-title p {
            color: var(--text-light);
            margin-bottom: 0;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
        }

        /* Dashboard Cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .dashboard-card {
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            box-shadow: var(--shadow);
            transition: all 0.3s;
            border-left: 4px solid var(--primary);
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .dashboard-card.appointments {
            border-left-color: var(--primary);
        }

        .dashboard-card.prescriptions {
            border-left-color: var(--success);
        }

        .dashboard-card.bills {
            border-left-color: var(--warning);
        }

        .dashboard-card.doctors {
            border-left-color: var(--accent);
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            font-size: 1.5rem;
        }

        .card-icon.appointments {
            background: rgba(37, 99, 235, 0.1);
            color: var(--primary);
        }

        .card-icon.prescriptions {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .card-icon.bills {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        .card-icon.doctors {
            background: rgba(14, 165, 233, 0.1);
            color: var(--accent);
        }

        .card-value {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .card-label {
            color: var(--text-light);
            font-size: 0.9rem;
        }

        /* Content Sections */
        .content-section {
            background: white;
            border-radius: var(--radius);
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: var(--shadow);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--gray-light);
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            font-size: 1.1rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.3);
        }

        /* Table Styles */
        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .table th {
            background-color: var(--light);
            color: var(--dark);
            font-weight: 600;
            padding: 12px 15px;
            border-bottom: 2px solid var(--gray-light);
        }

        .table td {
            padding: 12px 15px;
            border-bottom: 1px solid var(--gray-light);
            vertical-align: middle;
        }

        .table tr:last-child td {
            border-bottom: none;
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-scheduled {
            background: rgba(37, 99, 235, 0.1);
            color: var(--primary);
        }

        .status-completed {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .status-cancelled {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }

        .status-pending {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        /* Modal Styles */
        .modal-content {
            border-radius: var(--radius);
            border: none;
            box-shadow: var(--shadow-lg);
        }

        .modal-header {
            background: var(--light);
            border-bottom: 1px solid var(--gray-light);
            border-radius: var(--radius) var(--radius) 0 0;
            padding: 15px 20px;
        }

        .modal-title {
            font-weight: 600;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Form Styles */
        .form-label {
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--dark);
        }

        .form-control, .form-select {
            border: 2px solid var(--gray-light);
            border-radius: 8px;
            padding: 10px 15px;
            transition: all 0.3s;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        /* Calendar Styles */
        #calendar {
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            box-shadow: var(--shadow);
        }

        .fc .fc-toolbar {
            padding: 10px;
        }

        .fc .fc-button {
            background-color: var(--primary);
            border: none;
        }

        .fc .fc-button:hover {
            background-color: var(--primary-dark);
        }

        /* Footer Styles */
        .footer {
            background: white;
            padding: 20px;
            margin-top: 30px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            text-align: center;
            color: var(--text-light);
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 15px;
        }

        .footer-links a {
            color: var(--text-light);
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: var(--primary);
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .sidebar {
                width: 70px;
                overflow: hidden;
            }
            
            .sidebar .menu-text {
                display: none;
            }
            
            .main-content {
                margin-left: 70px;
            }
            
            .sidebar-header h3, .sidebar-header p {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .dashboard-cards {
                grid-template-columns: 1fr;
            }
            
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .user-info {
                align-self: flex-end;
            }
        }

        /* Real-time notification */
        .notification-badge {
            position: absolute;
            top: 5px;
            right: 5px;
            background: var(--danger);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .nav-item {
            position: relative;
        }
    </style>
</head>

<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h3><i class="fas fa-hospital-alt me-2"></i>MediCare</h3>
            <p>Patient Portal</p>
        </div>
        
        <div class="sidebar-menu">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="#" data-section="dashboard">
                        <i class="fas fa-tachometer-alt"></i>
                        <span class="menu-text">Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="profile">
                        <i class="fas fa-user"></i>
                        <span class="menu-text">My Profile</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="appointments">
                        <i class="fas fa-calendar-check"></i>
                        <span class="menu-text">Appointments</span>
                        <span class="notification-badge" id="appointment-notification" style="display: none;">3</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="prescriptions">
                        <i class="fas fa-file-prescription"></i>
                        <span class="menu-text">Prescriptions</span>
                        <span class="notification-badge" id="prescription-notification" style="display: none;">2</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="doctors">
                        <i class="fas fa-user-md"></i>
                        <span class="menu-text">Doctors</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="bills">
                        <i class="fas fa-file-invoice-dollar"></i>
                        <span class="menu-text">Bills & Payments</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="feedback">
                        <i class="fas fa-comment-medical"></i>
                        <span class="menu-text">Feedback</span>
                    </a>
                </li>
                <li class="nav-item mt-4">
                    <a class="nav-link" href="user_logout">
                        <i class="fas fa-sign-out-alt"></i>
                        <span class="menu-text">Logout</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <div class="main-content">
        <div class="header">
            <div class="header-title">
                <h1 id="page-title">Patient Dashboard</h1>
                <p id="page-subtitle">Welcome back, ${patient.fullName}</p>
            </div>
            <div class="user-info">
                <div class="user-avatar">
                    ${patient.fullName.substring(0, 1)}
                </div>
                <div>
                    <div class="fw-bold">${patient.fullName}</div>
                    <div class="small text-muted">Patient ID: ${patient.id}</div>
                </div>
            </div>
        </div>

        <div id="dashboard-content">
            <div class="dashboard-cards">
                <div class="dashboard-card appointments">
                    <div class="card-icon appointments">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="card-value" id="upcoming-appointments">0</div>
                    <div class="card-label">Upcoming Appointments</div>
                </div>
                
                <div class="dashboard-card prescriptions">
                    <div class="card-icon prescriptions">
                        <i class="fas fa-file-prescription"></i>
                    </div>
                    <div class="card-value" id="recent-prescriptions">0</div>
                    <div class="card-label">Recent Prescriptions</div>
                </div>
                
                <div class="dashboard-card bills">
                    <div class="card-icon bills">
                        <i class="fas fa-file-invoice-dollar"></i>
                    </div>
                    <div class="card-value" id="pending-bills">0</div>
                    <div class="card-label">Pending Bills</div>
                </div>
                
                <div class="dashboard-card doctors">
                    <div class="card-icon doctors">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <div class="card-value" id="available-doctors">0</div>
                    <div class="card-label">Available Doctors</div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-8">
                    <div class="content-section">
                        <div class="section-header">
                            <h3 class="section-title"><i class="fas fa-calendar-alt"></i>Upcoming Appointments</h3>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#bookAppointmentModal">
                                <i class="fas fa-plus me-2"></i>Book Appointment
                            </button>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Doctor</th>
                                        <th>Date & Time</th>
                                        <th>Department</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="appointments-table-body">
                                    </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="content-section">
                        <div class="section-header">
                            <h3 class="section-title"><i class="fas fa-calendar-day"></i>Appointment Calendar</h3>
                        </div>
                        <div id="calendar"></div>
                    </div>
                </div>
            </div>

            <div class="content-section">
                <div class="section-header">
                    <h3 class="section-title"><i class="fas fa-file-prescription"></i>Recent Prescriptions</h3>
                    <a href="#" class="btn btn-outline-primary">View All</a>
                </div>
                
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Doctor</th>
                                <th>Medication</th>
                                <th>Dosage</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="prescriptions-table-body">
                            </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="profile-content" class="d-none">
            <div class="content-section">
                <div class="section-header">
                    <h3 class="section-title"><i class="fas fa-user-edit"></i>Edit Profile</h3>
                </div>
                
                <form id="profile-form">
                    <input type="hidden" id="patientId" name="patientId" value="${patient.id}">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" value="${patient.fullName}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" value="${patient.email}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phone" name="phone" value="${patient.phone}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="dob" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="dob" name="dob" value="${patient.dob}">
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <select class="form-select" id="gender" name="gender">
                                    <option value="male" ${patient.gender == 'male' ? 'selected' : ''}>Male</option>
                                    <option value="female" ${patient.gender == 'female' ? 'selected' : ''}>Female</option>
                                    <option value="other" ${patient.gender == 'other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="bloodGroup" class="form-label">Blood Group</label>
                                <select class="form-select" id="bloodGroup" name="bloodGroup">
                                    <option value="">Select blood group</option>
                                    <option value="A+" ${patient.bloodGroup == 'A+' ? 'selected' : ''}>A+</option>
                                    <option value="A-" ${patient.bloodGroup == 'A-' ? 'selected' : ''}>A-</option>
                                    <option value="B+" ${patient.bloodGroup == 'B+' ? 'selected' : ''}>B+</option>
                                    <option value="B-" ${patient.bloodGroup == 'B-' ? 'selected' : ''}>B-</option>
                                    <option value="AB+" ${patient.bloodGroup == 'AB+' ? 'selected' : ''}>AB+</option>
                                    <option value="AB-" ${patient.bloodGroup == 'AB-' ? 'selected' : ''}>AB-</option>
                                    <option value="O+" ${patient.bloodGroup == 'O+' ? 'selected' : ''}>O+</option>
                                    <option value="O-" ${patient.bloodGroup == 'O-' ? 'selected' : ''}>O-</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <textarea class="form-control" id="address" name="address" rows="3">${patient.address}</textarea>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end gap-2">
                        <button type="button" class="btn btn-outline-secondary" id="cancel-profile">Cancel</button>
                        <button type="submit" class="btn btn-primary">Update Profile</button>
                    </div>
                </form>
            </div>
            
            <div class="content-section">
                <div class="section-header">
                    <h3 class="section-title"><i class="fas fa-lock"></i>Change Password</h3>
                </div>
                
                <form id="password-form">
                    <input type="hidden" id="patientIdPassword" name="patientId" value="${patient.id}">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" required minlength="8">
                                <div class="form-text">Password must be at least 8 characters with uppercase, lowercase, number, and special character.</div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">Change Password</button>
                    </div>
                </form>
            </div>
        </div>

        <div id="appointments-content" class="d-none">
            <div class="content-section">
                <div class="section-header">
                    <h3 class="section-title"><i class="fas fa-calendar-check"></i>My Appointments</h3>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#bookAppointmentModal">
                        <i class="fas fa-plus me-2"></i>Book New Appointment
                    </button>
                </div>
                
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Appointment ID</th>
                                <th>Doctor</th>
                                <th>Department</th>
                                <th>Date & Time</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="all-appointments-table-body">
                            </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="footer">
            <div class="footer-links">
                <a href="#">About Us</a>
                <a href="#">Contact</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
                <a href="#">Help Center</a>
            </div>
            <div class="copyright">
                &copy; 2023 MediCare Hospital Management System. All rights reserved.
            </div>
        </div>
    </div>

    <div class="modal fade" id="bookAppointmentModal" tabindex="-1" aria-labelledby="bookAppointmentModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bookAppointmentModalLabel"><i class="fas fa-calendar-plus me-2"></i>Book New Appointment</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="appointment-form">
                        <input type="hidden" id="patientIdAppointment" name="patientId" value="${patient.id}">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="appointmentDoctor" class="form-label">Select Doctor</label>
                                    <select class="form-select" id="appointmentDoctor" name="doctorId" required>
                                        <option value="">Choose a doctor</option>
                                        </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="appointmentDate" class="form-label">Appointment Date</label>
                                    <input type="date" class="form-control" id="appointmentDate" name="appointmentDate" required>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="appointmentTime" class="form-label">Preferred Time</label>
                                    <select class="form-select" id="appointmentTime" name="appointmentTime" required>
                                        <option value="">Select time slot</option>
                                        <option value="09:00">09:00 AM</option>
                                        <option value="10:00">10:00 AM</option>
                                        <option value="11:00">11:00 AM</option>
                                        <option value="14:00">02:00 PM</option>
                                        <option value="15:00">03:00 PM</option>
                                        <option value="16:00">04:00 PM</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="appointmentReason" class="form-label">Reason for Visit</label>
                                    <textarea class="form-control" id="appointmentReason" name="reason" rows="3" placeholder="Briefly describe your symptoms or reason for appointment"></textarea>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="submit-appointment">Book Appointment</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="cancelAppointmentModal" tabindex="-1" aria-labelledby="cancelAppointmentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="cancelAppointmentModalLabel"><i class="fas fa-calendar-times me-2"></i>Cancel Appointment</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to cancel this appointment?</p>
                    <div id="cancel-appointment-details"></div>
                    <div class="mb-3 mt-3">
                        <label for="cancelReason" class="form-label">Reason for cancellation (optional)</label>
                        <textarea class="form-control" id="cancelReason" rows="2" placeholder="Please provide a reason for cancellation"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Keep Appointment</button>
                    <button type="button" class="btn btn-danger" id="confirm-cancel">Cancel Appointment</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <script>
        // Global variables
        let currentAppointmentId = null;
        let appointments = [];
        let doctors = [];
        
        // Initialize dashboard when page loads
        document.addEventListener('DOMContentLoaded', function() {
            initializeDashboard();
            loadAppointments();
            loadDoctors();
            initializeCalendar();
            setupEventListeners();
            
            // Simulate real-time updates
            setInterval(updateDashboardData, 30000); // Update every 30 seconds
        });
        
        // Initialize dashboard components
        function initializeDashboard() {
            // Set initial active section
            showSection('dashboard');
            
            // Update dashboard stats
            updateDashboardStats();
        }
        
        // Setup event listeners
        function setupEventListeners() {
            // Sidebar navigation
            document.querySelectorAll('.nav-link').forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    
                    // Update active state
                    document.querySelectorAll('.nav-link').forEach(item => {
                        item.classList.remove('active');
                    });
                    this.classList.add('active');
                    
                    // Show selected section
                    const section = this.getAttribute('data-section');
                    showSection(section);
                });
            });
            
            // Profile form submission
            document.getElementById('profile-form').addEventListener('submit', function(e) {
                e.preventDefault();
                updateProfile();
            });
            
            // Password form submission
            document.getElementById('password-form').addEventListener('submit', function(e) {
                e.preventDefault();
                changePassword();
            });
            
            // Cancel profile edit
            document.getElementById('cancel-profile').addEventListener('click', function() {
                showSection('dashboard');
            });
            
            // Book appointment submission
            document.getElementById('submit-appointment').addEventListener('click', function() {
                bookAppointment();
            });
            
            // Confirm cancel appointment
            document.getElementById('confirm-cancel').addEventListener('click', function() {
                cancelAppointment();
            });
        }
        
        // Show/hide sections based on navigation
        function showSection(section) {
            // Hide all content sections
            document.querySelectorAll('[id$="-content"]').forEach(el => {
                el.classList.add('d-none');
            });
            
            // Show selected section
            document.getElementById(section + '-content').classList.remove('d-none');
            
            // Update page title
            const titles = {
                'dashboard': 'Patient Dashboard',
                'profile': 'My Profile',
                'appointments': 'My Appointments',
                'prescriptions': 'My Prescriptions',
                'doctors': 'Available Doctors',
                'bills': 'Bills & Payments',
                'feedback': 'Feedback & Reviews'
            };
            
            // This is valid JSP EL. It gets processed on the server.
            const subtitles = {
                'dashboard': 'Welcome back, ${patient.fullName}',
                'profile': 'Manage your personal information',
                'appointments': 'Schedule and manage your appointments',
                'prescriptions': 'View your medical prescriptions',
                'doctors': 'Find and book appointments with doctors',
                'bills': 'View and pay your medical bills',
                'feedback': 'Share your experience with us'
            };
            
            document.getElementById('page-title').textContent = titles[section];
            document.getElementById('page-subtitle').textContent = subtitles[section];
        }
        
        // Load appointments from server
        function loadAppointments() {
            // This is valid JSP EL. It gets processed on the server.
            fetch('PatientAppointmentServlet?action=getAppointments&patientId=' + ${patient.id})
                .then(response => response.json())
                .then(data => {
                    appointments = data;
                    renderAppointments();
                })
                .catch(error => {
                    console.error('Error loading appointments:', error);
                    // Fallback to sample data if API fails
                    loadSampleAppointments();
                });
        }
        
        // Load sample appointments if API fails
        function loadSampleAppointments() {
            appointments = [
                {
                    id: 'APT001',
                    doctorName: 'Dr. Sarah Johnson',
                    department: 'Cardiology',
                    date: '2023-12-15',
                    time: '10:00',
                    status: 'scheduled',
                    reason: 'Regular checkup'
                },
                {
                    id: 'APT002',
                    doctorName: 'Dr. Michael Chen',
                    department: 'Dermatology',
                    date: '2023-12-18',
                    time: '14:00',
                    status: 'scheduled',
                    reason: 'Skin allergy consultation'
                },
                {
                    id: 'APT003',
                    doctorName: 'Dr. Emily Rodriguez',
                    department: 'Pediatrics',
                    date: '2023-12-10',
                    time: '11:00',
                    status: 'completed',
                    reason: 'Vaccination'
                },
                {
                    id: 'APT004',
                    doctorName: 'Dr. James Wilson',
                    department: 'Orthopedics',
                    date: '2023-12-05',
                    time: '15:00',
                    status: 'cancelled',
                    reason: 'Knee pain evaluation'
                }
            ];
            
            renderAppointments();
        }
        
        // Load doctors from server
        function loadDoctors() {
            fetch('PatientAppointmentServlet?action=getDoctors')
                .then(response => response.json())
                .then(data => {
                    doctors = data;
                    populateDoctorDropdown();
                })
                .catch(error => {
                    console.error('Error loading doctors:', error);
                    // Fallback to sample data if API fails
                    loadSampleDoctors();
                });
        }
        
        // Load sample doctors if API fails
        function loadSampleDoctors() {
            doctors = [
                { id: 1, name: 'Dr. Sarah Johnson', department: 'Cardiology', availability: 'Mon, Wed, Fri', rating: 4.8 },
                { id: 2, name: 'Dr. Michael Chen', department: 'Dermatology', availability: 'Tue, Thu, Sat', rating: 4.7 },
                { id: 3, name: 'Dr. Emily Rodriguez', department: 'Pediatrics', availability: 'Mon-Fri', rating: 4.9 },
                { id: 4, name: 'Dr. James Wilson', department: 'Orthopedics', availability: 'Mon, Wed, Thu', rating: 4.6 },
                { id: 5, name: 'Dr. Lisa Thompson', department: 'Gynecology', availability: 'Tue, Thu, Fri', rating: 4.8 }
            ];
            
            populateDoctorDropdown();
        }
        
        // Populate doctor dropdown
        function populateDoctorDropdown() {
            const doctorSelect = document.getElementById('appointmentDoctor');
            doctorSelect.innerHTML = '<option value="">Choose a doctor</option>';
            
            doctors.forEach(doctor => {
                const option = document.createElement('option');
                option.value = doctor.id;
                option.textContent = doctor.name + ' - ' + doctor.department;
                doctorSelect.appendChild(option);
            });
        }
        
        // Render appointments in tables
        function renderAppointments() {
            // Upcoming appointments table (dashboard)
            const appointmentsTableBody = document.getElementById('appointments-table-body');
            appointmentsTableBody.innerHTML = '';
            
            // All appointments table (appointments section)
            const allAppointmentsTableBody = document.getElementById('all-appointments-table-body');
            allAppointmentsTableBody.innerHTML = '';
            
            const upcomingAppointments = appointments.filter(apt => 
                apt.status === 'scheduled' && new Date(apt.date) >= new Date()
            );
            
            // Update dashboard card
            document.getElementById('upcoming-appointments').textContent = upcomingAppointments.length;
            
            // Render upcoming appointments (dashboard)
            upcomingAppointments.forEach(appointment => {
                const row = createAppointmentRow(appointment);
                appointmentsTableBody.appendChild(row);
            });
            
            // Render all appointments (appointments section)
            appointments.forEach(appointment => {
                const row = createAppointmentRow(appointment, true);
                allAppointmentsTableBody.appendChild(row);
            });
            
            // Update calendar events
            updateCalendarEvents();
        }
        
        // Create appointment table row
        function createAppointmentRow(appointment, showAll = false) {
            const row = document.createElement('tr');
            
            // Format date and time
            const appointmentDate = new Date(appointment.date);
            const formattedDate = appointmentDate.toLocaleDateString('en-US', { 
                weekday: 'short', 
                year: 'numeric', 
                month: 'short', 
                day: 'numeric' 
            });
            const formattedTime = appointment.time;
            
            // Status badge
            let statusClass = '';
            let statusText = '';
            
            switch(appointment.status) {
                case 'scheduled':
                    statusClass = 'status-scheduled';
                    statusText = 'Scheduled';
                    break;
                case 'completed':
                    statusClass = 'status-completed';
                    statusText = 'Completed';
                    break;
                case 'cancelled':
                    statusClass = 'status-cancelled';
                    statusText = 'Cancelled';
                    break;
                case 'pending':
                    statusClass = 'status-pending';
                    statusText = 'Pending';
                    break;
            }
            
            // FIXED: Replaced JavaScript template literals with standard string concatenation
            if (showAll) {
                // For all appointments table
                row.innerHTML = '<td>' + appointment.id + '</td>' +
                                '<td>' + appointment.doctorName + '</td>' +
                                '<td>' + appointment.department + '</td>' +
                                '<td>' + formattedDate + ' at ' + formattedTime + '</td>' +
                                '<td><span class="status-badge ' + statusClass + '">' + statusText + '</span></td>' +
                                '<td>' +
                                    (appointment.status === 'scheduled' ? 
                                        '<button class="btn btn-sm btn-outline-danger cancel-appointment" data-id="' + appointment.id + '">Cancel</button>' : 
                                        '') +
                                    ' <button class="btn btn-sm btn-outline-primary view-appointment" data-id="' + appointment.id + '">Details</button>' +
                                '</td>';
            } else {
                // For dashboard table (upcoming appointments only)
                row.innerHTML = '<td>' + appointment.doctorName + '</td>' +
                                '<td>' + formattedDate + ' at ' + formattedTime + '</td>' +
                                '<td>' + appointment.department + '</td>' +
                                '<td><span class="status-badge ' + statusClass + '">' + statusText + '</span></td>' +
                                '<td>' +
                                    (appointment.status === 'scheduled' ? 
                                        '<button class="btn btn-sm btn-outline-danger cancel-appointment" data-id="' + appointment.id + '">Cancel</button>' : 
                                        '') +
                                    ' <button class="btn btn-sm btn-outline-primary view-appointment" data-id="' + appointment.id + '">Details</button>' +
                                '</td>';
            }
            
            // Add event listeners to buttons
            row.querySelector('.cancel-appointment')?.addEventListener('click', function() {
                openCancelModal(this.getAttribute('data-id'));
            });
            
            row.querySelector('.view-appointment')?.addEventListener('click', function() {
                viewAppointmentDetails(this.getAttribute('data-id'));
            });
            
            return row;
        }
        
        // Initialize calendar
        function initializeCalendar() {
            const calendarEl = document.getElementById('calendar');
            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                events: [],
                eventClick: function(info) {
                    viewAppointmentDetails(info.event.id);
                }
            });
            
            calendar.render();
            window.calendar = calendar;
        }
        
        // Update calendar with appointment events
        function updateCalendarEvents() {
            if (!window.calendar) return;
            
            const events = appointments.map(appointment => {
                let color = '';
                
                switch(appointment.status) {
                    case 'scheduled':
                        color = '#2563eb';
                        break;
                    case 'completed':
                        color = '#10b981';
                        break;
                    case 'cancelled':
                        color = '#ef4444';
                        break;
                    case 'pending':
                        color = '#f59e0b';
                        break;
                }
                
                return {
                    id: appointment.id,
                    title: 'Appointment with ' + appointment.doctorName,
                    // FIXED: Replaced template literal
                    start: appointment.date + 'T' + appointment.time + ':00',
                    backgroundColor: color,
                    borderColor: color
                };
            });
            
            window.calendar.removeAllEvents();
            window.calendar.addEventSource(events);
        }
        
        // Open cancel appointment modal
        function openCancelModal(appointmentId) {
            currentAppointmentId = appointmentId;
            const appointment = appointments.find(apt => apt.id === appointmentId);
            
            if (appointment) {
                const modal = new bootstrap.Modal(document.getElementById('cancelAppointmentModal'));
                const detailsEl = document.getElementById('cancel-appointment-details');
                
                const appointmentDate = new Date(appointment.date);
                const formattedDate = appointmentDate.toLocaleDateString('en-US', { 
                    weekday: 'long', 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric' 
                });
                
                // FIXED: Replaced template literal
                detailsEl.innerHTML = '<div class="alert alert-info">' +
                                        '<strong>' + appointment.doctorName + '</strong><br>' +
                                        formattedDate + ' at ' + appointment.time + '<br>' +
                                        'Department: ' + appointment.department +
                                    '</div>';
                
                modal.show();
            }
        }
        
        // Cancel appointment
        function cancelAppointment() {
            if (!currentAppointmentId) return;
            
            const reason = document.getElementById('cancelReason').value;
            
            // API call to cancel appointment
            fetch('PatientAppointmentServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=cancelAppointment&appointmentId=' + currentAppointmentId + '&reason=' + encodeURIComponent(reason)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Update appointment status in local data
                    const appointmentIndex = appointments.findIndex(apt => apt.id === currentAppointmentId);
                    if (appointmentIndex !== -1) {
                        appointments[appointmentIndex].status = 'cancelled';
                        appointments[appointmentIndex].cancellationReason = reason;
                        
                        // Update UI
                        renderAppointments();
                        updateDashboardStats();
                        
                        // Show success message
                        Swal.fire({
                            icon: 'success',
                            title: 'Appointment Cancelled',
                            text: 'Your appointment has been successfully cancelled.',
                            timer: 3000,
                            showConfirmButton: false
                        });
                    }
                } else {
                    throw new Error(data.message);
                }
            })
            .catch(error => {
                console.error('Error cancelling appointment:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Cancellation Failed',
                    text: 'Failed to cancel appointment. Please try again.'
                });
            })
            .finally(() => {
                // Close modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('cancelAppointmentModal'));
                modal.hide();
                
                // Reset form
                document.getElementById('cancelReason').value = '';
                currentAppointmentId = null;
            });
        }
        
        // View appointment details
        function viewAppointmentDetails(appointmentId) {
            const appointment = appointments.find(apt => apt.id === appointmentId);
            
            if (appointment) {
                const appointmentDate = new Date(appointment.date);
                const formattedDate = appointmentDate.toLocaleDateString('en-US', { 
                    weekday: 'long', 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric' 
                });
                
                let statusText = '';
                switch(appointment.status) {
                    case 'scheduled':
                        statusText = 'Scheduled';
                        break;
                    case 'completed':
                        statusText = 'Completed';
                        break;
                    case 'cancelled':
                        statusText = 'Cancelled';
                        break;
                    case 'pending':
                        statusText = 'Pending';
                        break;
                }
                
                // FIXED: Replaced template literal
                Swal.fire({
                    title: 'Appointment Details',
                    html: '<div class="text-start">' +
                            '<p><strong>Appointment ID:</strong> ' + appointment.id + '</p>' +
                            '<p><strong>Doctor:</strong> ' + appointment.doctorName + '</p>' +
                            '<p><strong>Department:</strong> ' + appointment.department + '</p>' +
                            '<p><strong>Date & Time:</strong> ' + formattedDate + ' at ' + appointment.time + '</p>' +
                            '<p><strong>Status:</strong> ' + statusText + '</p>' +
                            '<p><strong>Reason:</strong> ' + appointment.reason + '</p>' +
                            (appointment.cancellationReason ? 
                                '<p><strong>Cancellation Reason:</strong> ' + appointment.cancellationReason + '</p>' : 
                                '') +
                        '</div>',
                    icon: 'info',
                    confirmButtonText: 'Close'
                });
            }
        }
        
        // Book new appointment
        function bookAppointment() {
            const form = document.getElementById('appointment-form');
            const formData = new FormData(form);
            
            // Validate form
            if (!formData.get('doctorId') || !formData.get('appointmentDate') || !formData.get('appointmentTime')) {
                Swal.fire({
                    icon: 'error',
                    title: 'Missing Information',
                    text: 'Please fill in all required fields.',
                    timer: 3000,
                    showConfirmButton: false
                });
                return;
            }
            
            // Get selected doctor details
            const selectedDoctorId = parseInt(formData.get('doctorId'));
            const doctor = doctors.find(doc => doc.id === selectedDoctorId);
            
            if (!doctor) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Selection',
                    text: 'Please select a valid doctor.',
                    timer: 3000,
                    showConfirmButton: false
                });
                return;
            }
            
            // Prepare data for API call
            const appointmentData = {
                patientId: formData.get('patientId'),
                doctorId: formData.get('doctorId'),
                appointmentDate: formData.get('appointmentDate'),
                appointmentTime: formData.get('appointmentTime'),
                reason: formData.get('reason') || 'Not specified'
            };
            
            // API call to book appointment
            fetch('PatientAppointmentServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=bookAppointment&' + new URLSearchParams(appointmentData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Add to local data
                    const newAppointment = {
                        id: data.appointmentId,
                        doctorName: doctor.name,
                        department: doctor.department,
                        date: appointmentData.appointmentDate,
                        time: appointmentData.appointmentTime,
                        status: 'scheduled',
                        reason: appointmentData.reason
                    };
                    
                    appointments.push(newAppointment);
                    
                    // Update UI
                    renderAppointments();
                    updateDashboardStats();
                    
                    // Show success message
                    Swal.fire({
                        icon: 'success',
                        title: 'Appointment Booked',
                        text: 'Your appointment has been successfully scheduled.',
                        timer: 3000,
                        showConfirmButton: false
                    });
                    
                    // Close modal
                    const modal = bootstrap.Modal.getInstance(document.getElementById('bookAppointmentModal'));
                    modal.hide();
                    
                    // Reset form
                    form.reset();
                } else {
                    throw new Error(data.message);
                }
            })
            .catch(error => {
                console.error('Error booking appointment:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Booking Failed',
                    text: 'Failed to book appointment. Please try again.'
                });
            });
        }
        
        // Update profile
        function updateProfile() {
            const form = document.getElementById('profile-form');
            const formData = new FormData(form);
            
            // API call to update profile
            fetch('PatientProfileServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=updateProfile&' + new URLSearchParams(formData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Profile Updated',
                        text: 'Your profile information has been successfully updated.',
                        timer: 3000,
                        showConfirmButton: false
                    });
                } else {
                    throw new Error(data.message);
                }
            })
            .catch(error => {
                console.error('Error updating profile:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Update Failed',
                    text: 'Failed to update profile. Please try again.'
                });
            });
        }
        
        // Change password
        function changePassword() {
            const form = document.getElementById('password-form');
            const formData = new FormData(form);
            
            const currentPassword = formData.get('currentPassword');
            const newPassword = formData.get('newPassword');
            const confirmPassword = formData.get('confirmPassword');
            
            // Validate passwords
            if (newPassword !== confirmPassword) {
                Swal.fire({
                    icon: 'error',
                    title: 'Password Mismatch',
                    text: 'New password and confirmation do not match.',
                    timer: 3000,
                    showConfirmButton: false
                });
                return;
            }
            
            // API call to change password
            fetch('PatientProfileServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=changePassword&' + new URLSearchParams(formData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Password Changed',
                        text: 'Your password has been successfully updated.',
                        timer: 3000,
                        showConfirmButton: false
                    });
                    
                    // Reset form
                    form.reset();
                } else {
                    throw new Error(data.message);
                }
            })
            .catch(error => {
                console.error('Error changing password:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Password Change Failed',
                    text: 'Failed to change password. Please check your current password and try again.'
                });
            });
        }
        
        // Update dashboard statistics
        function updateDashboardStats() {
            // In a real application, these would come from the server
            const upcomingCount = appointments.filter(apt => 
                apt.status === 'scheduled' && new Date(apt.date) >= new Date()
            ).length;
            
            const prescriptionCount = 5; // This would come from server
            const pendingBillsCount = 2; // This would come from server
            const availableDoctorsCount = doctors.length;
            
            document.getElementById('upcoming-appointments').textContent = upcomingCount;
            document.getElementById('recent-prescriptions').textContent = prescriptionCount;
            document.getElementById('pending-bills').textContent = pendingBillsCount;
            document.getElementById('available-doctors').textContent = availableDoctorsCount;
            
            // Update notification badges
            const appointmentNotification = document.getElementById('appointment-notification');
            const prescriptionNotification = document.getElementById('prescription-notification');
            
            if (upcomingCount > 0) {
                appointmentNotification.textContent = upcomingCount;
                appointmentNotification.style.display = 'flex';
            } else {
                appointmentNotification.style.display = 'none';
            }
            
            if (prescriptionCount > 0) {
                prescriptionNotification.textContent = prescriptionCount;
                prescriptionNotification.style.display = 'flex';
            } else {
                prescriptionNotification.style.display = 'none';
            }
        }
        
        // Simulate real-time data updates
        function updateDashboardData() {
            // In a real application, this would make API calls to check for updates
            console.log('Checking for real-time updates...');
            
            // Update dashboard stats
            updateDashboardStats();
        }
    </script>
</body>
</html>