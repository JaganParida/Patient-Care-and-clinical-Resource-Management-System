<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page isELIgnored="false" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Doctor Dashboard - Hospital Management System</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <style>
                    :root {
                        --primary: #2563eb;
                        --primary-light: #3b82f6;
                        --primary-dark: #1d4ed8;
                        --secondary: #64748b;
                        --success: #16a34a;
                        --warning: #f59e0b;
                        --danger: #dc2626;
                        --light: #f8fafc;
                        --white: #ffffff;
                        --dark: #1e293b;
                        --text: #334155;
                        --radius: 12px;
                        --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                        --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
                    }

                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    }

                    body {
                        background-color: #f1f5f9;
                        color: var(--text);
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

                    .sidebar-header h3 {
                        font-weight: 700;
                        margin-bottom: 5px;
                    }

                    .sidebar-header p {
                        opacity: 0.8;
                        font-size: 0.9rem;
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

                    .nav-link:hover,
                    .nav-link.active {
                        background: rgba(255, 255, 255, 0.1);
                        color: white;
                        transform: translateX(5px);
                    }

                    .nav-link i {
                        width: 20px;
                        text-align: center;
                    }

                    .main-content {
                        margin-left: 280px;
                        padding: 20px;
                        transition: all 0.3s ease;
                    }

                    .navbar-custom {
                        background: var(--white);
                        box-shadow: var(--shadow);
                        border-radius: var(--radius);
                        margin-bottom: 25px;
                    }

                    .welcome-card {
                        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
                        color: white;
                        border-radius: var(--radius);
                        padding: 30px;
                        margin-bottom: 30px;
                        box-shadow: var(--shadow-lg);
                    }

                    .stats-card {
                        background: var(--white);
                        border-radius: var(--radius);
                        padding: 25px;
                        box-shadow: var(--shadow);
                        transition: all 0.3s ease;
                        border-left: 4px solid var(--primary);
                    }

                    .stats-card:hover {
                        transform: translateY(-5px);
                        box-shadow: var(--shadow-lg);
                    }

                    .stats-card.appointments {
                        border-left-color: var(--success);
                    }

                    .stats-card.patients {
                        border-left-color: var(--warning);
                    }

                    .stats-card.earnings {
                        border-left-color: var(--danger);
                    }

                    .stats-icon {
                        width: 60px;
                        height: 60px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.5rem;
                        margin-bottom: 15px;
                    }

                    .stats-icon.primary {
                        background: rgba(37, 99, 235, 0.1);
                        color: var(--primary);
                    }

                    .stats-icon.success {
                        background: rgba(34, 197, 94, 0.1);
                        color: var(--success);
                    }

                    .stats-icon.warning {
                        background: rgba(245, 158, 11, 0.1);
                        color: var(--warning);
                    }

                    .stats-icon.danger {
                        background: rgba(239, 68, 68, 0.1);
                        color: var(--danger);
                    }

                    .recent-activity {
                        background: var(--white);
                        border-radius: var(--radius);
                        padding: 25px;
                        box-shadow: var(--shadow);
                    }

                    .activity-item {
                        padding: 15px 0;
                        border-bottom: 1px solid var(--light);
                        display: flex;
                        align-items: center;
                        gap: 15px;
                    }

                    .activity-item:last-child {
                        border-bottom: none;
                    }

                    .activity-icon {
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        background: var(--light);
                        color: var(--primary);
                    }

                    .user-avatar {
                        width: 45px;
                        height: 45px;
                        border-radius: 50%;
                        background: var(--primary);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-weight: 600;
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
                    <c:redirect url="doctor_login.jsp" />
                </c:if>

                <!-- Sidebar -->
                <div class="sidebar">
                    <div class="sidebar-header">
                        <h3><i class="fas fa-hospital me-2"></i>MedCare</h3>
                        <p>Doctor Portal</p>
                    </div>

                    <div class="sidebar-content">
                        <a href="index.jsp" class="nav-link active">
                            <i class="fas fa-tachometer-alt"></i>
                            Dashboard
                        </a>
                        <a href="appointments.jsp" class="nav-link">
                            <i class="fas fa-calendar-check"></i>
                            Appointments
                        </a>
                        <a href="patients.jsp" class="nav-link">
                            <i class="fas fa-user-injured"></i>
                            My Patients
                        </a>
                        <a href="schedule.jsp" class="nav-link">
                            <i class="fas fa-clock"></i>
                            Schedule
                        </a>
                        <a href="edit_profile.jsp" class="nav-link">
                            <i class="fas fa-user-edit"></i>
                            Edit Profile
                        </a>
                        <a href="change_password.jsp" class="nav-link">
                            <i class="fas fa-key"></i>
                            Change Password
                        </a>
                        <a href="../doctorLogout" class="nav-link">
                            <i class="fas fa-sign-out-alt"></i>
                            Logout
                        </a>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <!-- Navbar -->
                    <nav class="navbar navbar-custom">
                        <div class="container-fluid">
                            <div class="d-flex align-items-center">
                                <div class="user-avatar me-3">
                                    ${doctorObj.fullName.charAt(0)}
                                </div>
                                <div>
                                    <h5 class="mb-0">Dr. ${doctorObj.fullName}</h5>
                                    <small class="text-muted">${doctorObj.specialization}</small>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <span class="me-3"><i class="fas fa-bell text-primary"></i></span>
                                <span class="me-3"><i class="fas fa-envelope text-primary"></i></span>
                                <span>${doctorObj.department}</span>
                            </div>
                        </div>
                    </nav>

                    <!-- Welcome Card -->
                    <div class="welcome-card">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h2>Welcome back, Dr. ${doctorObj.fullName}!</h2>
                                <p class="mb-0">Here's what's happening with your practice today.</p>
                            </div>
                            <div class="col-md-4 text-end">
                                <i class="fas fa-user-md fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Stats Cards -->
                    <div class="row g-4 mb-4">
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="stats-icon primary">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <h3>12</h3>
                                <p class="text-muted">Today's Appointments</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card appointments">
                                <div class="stats-icon success">
                                    <i class="fas fa-users"></i>
                                </div>
                                <h3>156</h3>
                                <p class="text-muted">Total Patients</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card patients">
                                <div class="stats-icon warning">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <h3>3</h3>
                                <p class="text-muted">Pending Consultations</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card earnings">
                                <div class="stats-icon danger">
                                    <i class="fas fa-chart-line"></i>
                                </div>
                                <h3>89%</h3>
                                <p class="text-muted">Satisfaction Rate</p>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4">
                        <!-- Recent Activity -->
                        <div class="col-md-8">
                            <div class="recent-activity">
                                <h4 class="mb-4"><i class="fas fa-history me-2"></i>Recent Activity</h4>

                                <div class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas fa-user-plus"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">New Patient Registration</h6>
                                        <p class="mb-0 text-muted">John Doe registered for consultation</p>
                                    </div>
                                    <small class="text-muted">2 hours ago</small>
                                </div>

                                <div class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas fa-calendar-plus"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">Appointment Scheduled</h6>
                                        <p class="mb-0 text-muted">Sarah Wilson scheduled for tomorrow</p>
                                    </div>
                                    <small class="text-muted">4 hours ago</small>
                                </div>

                                <div class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas fa-file-medical"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">Medical Report Generated</h6>
                                        <p class="mb-0 text-muted">Report for patient #PT-1234 completed</p>
                                    </div>
                                    <small class="text-muted">1 day ago</small>
                                </div>

                                <div class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas fa-prescription"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">Prescription Updated</h6>
                                        <p class="mb-0 text-muted">Updated medication for Michael Brown</p>
                                    </div>
                                    <small class="text-muted">2 days ago</small>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="col-md-4">
                            <div class="recent-activity">
                                <h4 class="mb-4"><i class="fas fa-bolt me-2"></i>Quick Actions</h4>

                                <div class="d-grid gap-2">
                                    <button class="btn btn-primary btn-lg">
                                        <i class="fas fa-calendar-plus me-2"></i>New Appointment
                                    </button>
                                    <button class="btn btn-outline-primary btn-lg">
                                        <i class="fas fa-user-injured me-2"></i>View Patients
                                    </button>
                                    <button class="btn btn-outline-success btn-lg">
                                        <i class="fas fa-prescription me-2"></i>Write Prescription
                                    </button>
                                    <button class="btn btn-outline-warning btn-lg">
                                        <i class="fas fa-file-medical me-2"></i>Medical Reports
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Simple dashboard interactions
                    document.addEventListener('DOMContentLoaded', function () {
                        // Update current time
                        function updateTime() {
                            const now = new Date();
                            document.getElementById('currentTime').textContent =
                                now.toLocaleDateString() + ' ' + now.toLocaleTimeString();
                        }
                        setInterval(updateTime, 1000);
                        updateTime();
                    });
                </script>
            </body>

            </html>