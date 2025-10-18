<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page isELIgnored="false" %>

<%
// Sample data - in real application, this would come from your database
java.util.List<java.util.Map<String, Object>> patients = new java.util.ArrayList<>();
java.util.Map<String, Object> patient1 = new java.util.HashMap<>();
patient1.put("id", 1);
patient1.put("name", "John Doe");
patient1.put("email", "john.doe@example.com");
patient1.put("phone", "+1 234 567 8901");
patient1.put("status", "Active");
patient1.put("lastVisit", "2023-11-15");
patients.add(patient1);

java.util.Map<String, Object> patient2 = new java.util.HashMap<>();
patient2.put("id", 2);
patient2.put("name", "Maria Smith");
patient2.put("email", "maria.smith@example.com");
patient2.put("phone", "+1 234 567 8903");
patient2.put("status", "Active");
patient2.put("lastVisit", "2023-11-10");
patients.add(patient2);

java.util.Map<String, Object> patient3 = new java.util.HashMap<>();
patient3.put("id", 3);
patient3.put("name", "Robert Johnson");
patient3.put("email", "robert.j@example.com");
patient3.put("phone", "+1 234 567 8905");
patient3.put("status", "Pending");
patient3.put("lastVisit", "2023-11-05");
patients.add(patient3);

request.setAttribute("patients", patients);

// Doctors data
java.util.List<java.util.Map<String, Object>> doctors = new java.util.ArrayList<>();
java.util.Map<String, Object> doctor1 = new java.util.HashMap<>();
doctor1.put("id", 1);
doctor1.put("name", "Dr. Sarah Wilson");
doctor1.put("email", "s.wilson@hospital.com");
doctor1.put("specialization", "Cardiology");
doctor1.put("department", "Cardiology");
doctor1.put("status", "Active");
doctors.add(doctor1);

java.util.Map<String, Object> doctor2 = new java.util.HashMap<>();
doctor2.put("id", 2);
doctor2.put("name", "Dr. James Brown");
doctor2.put("email", "j.brown@hospital.com");
doctor2.put("specialization", "Neurology");
doctor2.put("department", "Neurology");
doctor2.put("status", "Active");
doctors.add(doctor2);

request.setAttribute("doctors", doctors);

// Appointments data
java.util.List<java.util.Map<String, Object>> appointments = new java.util.ArrayList<>();
java.util.Map<String, Object> appointment1 = new java.util.HashMap<>();
appointment1.put("id", 1);
appointment1.put("patientName", "John Doe");
appointment1.put("doctorName", "Dr. Sarah Wilson");
appointment1.put("date", "2023-11-20");
appointment1.put("time", "10:30 AM");
appointment1.put("status", "Approved");
appointments.add(appointment1);

java.util.Map<String, Object> appointment2 = new java.util.HashMap<>();
appointment2.put("id", 2);
appointment2.put("patientName", "Maria Smith");
appointment2.put("doctorName", "Dr. James Brown");
appointment2.put("date", "2023-11-20");
appointment2.put("time", "2:15 PM");
appointment2.put("status", "Pending");
appointments.add(appointment2);

request.setAttribute("appointments", appointments);

// Calculate stats
int totalPatients = patients.size();
int totalDoctors = doctors.size();
int todayAppointments = 42; // Hardcoded for demo
int pendingApprovals = (int) appointments.stream().filter(a -> "Pending".equals(a.get("status"))).count();

request.setAttribute("totalPatients", totalPatients);
request.setAttribute("totalDoctors", totalDoctors);
request.setAttribute("todayAppointments", todayAppointments);
request.setAttribute("pendingApprovals", pendingApprovals);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Hospital Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            --warning: #f59e0b;
            --danger: #ef4444;
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
            background-color: #f8fafc;
            color: var(--text);
        }

        /* Sidebar Styles */
        .sidebar {
            background: var(--white);
            height: 100vh;
            position: fixed;
            width: 260px;
            box-shadow: var(--shadow);
            z-index: 1000;
            transition: all 0.3s ease;
            overflow-y: auto;
        }

        .sidebar-brand {
            padding: 20px 25px;
            border-bottom: 1px solid var(--gray-light);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .sidebar-brand h3 {
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0;
        }

        .sidebar-menu {
            padding: 15px 0;
        }

        .sidebar-item {
            margin-bottom: 5px;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 12px 25px;
            color: var(--text);
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
            cursor: pointer;
        }

        .sidebar-link:hover, .sidebar-link.active {
            background-color: rgba(37, 99, 235, 0.05);
            color: var(--primary);
            border-left-color: var(--primary);
        }

        .sidebar-link i {
            margin-right: 12px;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        .sidebar-link .badge {
            margin-left: auto;
        }

        /* Main Content Styles */
        .main-content {
            margin-left: 260px;
            transition: all 0.3s ease;
        }

        /* Topbar Styles */
        .topbar {
            background: var(--white);
            padding: 15px 30px;
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 999;
        }

        .search-box {
            position: relative;
            max-width: 400px;
        }

        .search-box input {
            padding-left: 40px;
            border-radius: 8px;
            border: 1px solid var(--gray-light);
            background-color: var(--light);
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary);
        }

        .user-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
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

        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }

        /* Content Area */
        .content-area {
            padding: 30px;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .page-header p {
            color: var(--text-light);
            margin-bottom: 0;
        }

        /* Dashboard Cards */
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

        .stats-card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--primary);
        }

        .stats-card h3 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stats-card p {
            color: var(--text-light);
            margin-bottom: 0;
        }

        .card-1 { border-left-color: var(--primary); }
        .card-2 { border-left-color: var(--success); }
        .card-3 { border-left-color: var(--warning); }
        .card-4 { border-left-color: var(--danger); }

        .card-1 i { color: var(--primary); }
        .card-2 i { color: var(--success); }
        .card-3 i { color: var(--warning); }
        .card-4 i { color: var(--danger); }

        /* Tables */
        .data-table {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .table-header {
            padding: 20px 25px;
            border-bottom: 1px solid var(--gray-light);
            display: flex;
            justify-content: between;
            align-items: center;
        }

        .table-header h5 {
            margin-bottom: 0;
            font-weight: 600;
        }

        .table-actions {
            display: flex;
            gap: 10px;
        }

        .table-container {
            padding: 0;
        }

        .table th {
            background-color: var(--light);
            font-weight: 600;
            border-top: none;
            padding: 15px 20px;
        }

        .table td {
            padding: 15px 20px;
            vertical-align: middle;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-active {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .status-pending {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        .status-inactive {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }

        .status-approved {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .status-rejected {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }

        /* Buttons */
        .btn-primary {
            background: var(--primary);
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.3);
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 0.875rem;
        }

        .btn-success {
            background: var(--success);
            border: none;
        }

        .btn-warning {
            background: var(--warning);
            border: none;
        }

        .btn-danger {
            background: var(--danger);
            border: none;
        }

        /* Modal */
        .modal-content {
            border-radius: var(--radius);
            border: none;
            box-shadow: var(--shadow-lg);
        }

        .modal-header {
            border-bottom: 1px solid var(--gray-light);
            padding: 20px 25px;
        }

        .modal-body {
            padding: 25px;
        }

        .modal-footer {
            border-top: 1px solid var(--gray-light);
            padding: 20px 25px;
        }

        /* Form Controls */
        .form-control, .form-select {
            border: 1px solid var(--gray-light);
            border-radius: 8px;
            padding: 10px 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        /* Charts */
        .chart-container {
            background: var(--white);
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            height: 100%;
        }

        /* Tabs */
        .nav-tabs .nav-link {
            border: none;
            color: var(--text-light);
            font-weight: 500;
            padding: 12px 20px;
        }

        .nav-tabs .nav-link.active {
            color: var(--primary);
            border-bottom: 3px solid var(--primary);
            background: transparent;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                width: 280px;
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .menu-toggle {
                display: block !important;
            }
        }

        .menu-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 1.5rem;
            color: var(--dark);
        }

        /* Footer */
        footer {
            margin-left: 260px;
            transition: all 0.3s ease;
        }

        @media (max-width: 992px) {
            footer {
                margin-left: 0;
            }
        }

        /* Toast Notifications */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1055;
        }

        .toast {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            border-left: 4px solid var(--primary);
        }

        .toast-success {
            border-left-color: var(--success);
        }

        .toast-error {
            border-left-color: var(--danger);
        }
    </style>
</head>
<body>
    <!-- Toast Container -->
    <div class="toast-container"></div>

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-brand">
            <i class="fas fa-hospital-alt fa-2x text-primary"></i>
            <h3>MedTech HMS</h3>
        </div>
        <div class="sidebar-menu">
            <div class="sidebar-item">
                <a href="#" class="sidebar-link active" data-section="dashboard">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </div>
            <div class="sidebar-item">
                <a href="#" class="sidebar-link" data-section="patients">
                    <i class="fas fa-user-injured"></i>
                    <span>Patient Management</span>
                </a>
            </div>
            <div class="sidebar-item">
                <a href="#" class="sidebar-link" data-section="doctors">
                    <i class="fas fa-user-md"></i>
                    <span>Doctor & Staff</span>
                </a>
            </div>
            <div class="sidebar-item">
                <a href="#" class="sidebar-link" data-section="appointments">
                    <i class="fas fa-calendar-check"></i>
                    <span>Appointments</span>
                    <span class="badge bg-danger">${pendingApprovals}</span>
                </a>
            </div>
            <div class="sidebar-item">
                <a href="#" class="sidebar-link" data-section="reports">
                    <i class="fas fa-chart-bar"></i>
                    <span>Reports & Analytics</span>
                </a>
            </div>
            <div class="sidebar-item">
                <a href="#" class="sidebar-link" data-section="system">
                    <i class="fas fa-cog"></i>
                    <span>System & Security</span>
                </a>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Topbar -->
        <div class="topbar d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <button class="menu-toggle me-3">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" class="form-control" placeholder="Search...">
                </div>
            </div>
            <div class="user-actions">
                <div class="position-relative">
                    <i class="fas fa-bell fa-lg text-secondary"></i>
                    <span class="notification-badge">3</span>
                </div>
                <div class="user-profile">
                    <div class="user-avatar">AD</div>
                    <div>
                        <div class="fw-bold">Admin User</div>
                        <div class="small text-muted">Administrator</div>
                    </div>
                    <i class="fas fa-chevron-down text-secondary ms-2"></i>
                </div>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <!-- Dashboard Section -->
            <div id="dashboard-section" class="section-content">
                <!-- Page Header -->
                <div class="page-header">
                    <h1>Admin Dashboard</h1>
                    <p>Welcome back, Admin! Here's what's happening with your hospital today.</p>
                </div>

                <!-- Stats Cards -->
                <div class="row mb-5">
                    <div class="col-md-3 mb-4">
                        <div class="stats-card card-1">
                            <i class="fas fa-user-injured"></i>
                            <h3 id="total-patients">${totalPatients}</h3>
                            <p>Total Patients</p>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="stats-card card-2">
                            <i class="fas fa-user-md"></i>
                            <h3 id="total-doctors">${totalDoctors}</h3>
                            <p>Doctors & Staff</p>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="stats-card card-3">
                            <i class="fas fa-calendar-check"></i>
                            <h3 id="today-appointments">${todayAppointments}</h3>
                            <p>Today's Appointments</p>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="stats-card card-4">
                            <i class="fas fa-exclamation-circle"></i>
                            <h3 id="pending-approvals">${pendingApprovals}</h3>
                            <p>Pending Approvals</p>
                        </div>
                    </div>
                </div>

                <!-- Recent Patients Table -->
                <div class="row mb-5">
                    <div class="col-12">
                        <div class="data-table">
                            <div class="table-header">
                                <h5>Recent Patients</h5>
                                <div class="table-actions">
                                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addPatientModal">
                                        <i class="fas fa-plus me-1"></i> Add Patient
                                    </button>
                                    <button class="btn btn-outline-secondary btn-sm">
                                        <i class="fas fa-filter me-1"></i> Filter
                                    </button>
                                </div>
                            </div>
                            <div class="table-container">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Patient Name</th>
                                                <th>Contact</th>
                                                <th>Last Visit</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="patient" items="${patients}" varStatus="status">
                                                <c:if test="${status.index < 5}">
                                                    <tr>
                                                        <td>#PT-${patient.id}</td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <%
                                                                    // Get patient name and create initials
                                                                    java.util.Map<String, Object> p = (java.util.Map<String, Object>) pageContext.getAttribute("patient");
                                                                    String name = (String) p.get("name");
                                                                    String[] nameParts = name.split(" ");
                                                                    StringBuilder initials = new StringBuilder();
                                                                    for (String part : nameParts) {
                                                                        if (!part.isEmpty()) {
                                                                            initials.append(part.charAt(0));
                                                                        }
                                                                    }
                                                                %>
                                                                <div class="user-avatar me-2" style="width: 35px; height: 35px; font-size: 0.8rem;">
                                                                    <%= initials.toString() %>
                                                                </div>
                                                                <span>${patient.name}</span>
                                                            </div>
                                                        </td>
                                                        <td>${patient.email}</td>
                                                        <td>${patient.lastVisit}</td>
                                                        <td><span class="status-badge status-${fn:toLowerCase(patient.status)}">${patient.status}</span></td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-primary me-1" onclick="editPatient(${patient.id})">
                                                                <i class="fas fa-edit"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger" onclick="deletePatient(${patient.id})">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Upcoming Appointments -->
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="data-table">
                            <div class="table-header">
                                <h5>Upcoming Appointments</h5>
                                <div class="table-actions">
                                    <button class="btn btn-outline-secondary btn-sm" onclick="showSection('appointments')">
                                        <i class="fas fa-calendar me-1"></i> View All
                                    </button>
                                </div>
                            </div>
                            <div class="table-container">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>Patient</th>
                                                <th>Doctor</th>
                                                <th>Date & Time</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="appointment" items="${appointments}" varStatus="status">
                                                <c:if test="${status.index < 3}">
                                                    <tr>
                                                        <td>${appointment.patientName}</td>
                                                        <td>${appointment.doctorName}</td>
                                                        <td>${appointment.date}, ${appointment.time}</td>
                                                        <td><span class="status-badge status-${fn:toLowerCase(appointment.status)}">${appointment.status}</span></td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- System Alerts -->
                    <div class="col-md-6 mb-4">
                        <div class="data-table">
                            <div class="table-header">
                                <h5>System Alerts</h5>
                                <div class="table-actions">
                                    <button class="btn btn-outline-secondary btn-sm">
                                        <i class="fas fa-cog me-1"></i> Settings
                                    </button>
                                </div>
                            </div>
                            <div class="table-container">
                                <div class="p-3">
                                    <div class="alert alert-warning d-flex align-items-center mb-3">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        <div>
                                            <strong>Low Inventory</strong>
                                            <p class="mb-0">Medical supplies running low. Reorder soon.</p>
                                        </div>
                                    </div>
                                    <div class="alert alert-info d-flex align-items-center mb-3">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <div>
                                            <strong>System Update</strong>
                                            <p class="mb-0">New update available. Schedule maintenance.</p>
                                        </div>
                                    </div>
                                    <div class="alert alert-success d-flex align-items-center">
                                        <i class="fas fa-check-circle me-2"></i>
                                        <div>
                                            <strong>Backup Complete</strong>
                                            <p class="mb-0">System backup completed successfully.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Patient Management Section -->
            <div id="patients-section" class="section-content d-none">
                <div class="page-header">
                    <h1>Patient Management</h1>
                    <p>Manage all patient records, add new patients, and update information.</p>
                </div>

                <div class="data-table">
                    <div class="table-header">
                        <h5>All Patients</h5>
                        <div class="table-actions">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPatientModal">
                                <i class="fas fa-plus me-1"></i> Add New Patient
                            </button>
                            <button class="btn btn-outline-secondary">
                                <i class="fas fa-download me-1"></i> Export
                            </button>
                        </div>
                    </div>
                    <div class="table-container">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Patient Name</th>
                                        <th>Contact</th>
                                        <th>Last Visit</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="patient" items="${patients}">
                                        <tr>
                                            <td>#PT-${patient.id}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <%
                                                        // Get patient name and create initials
                                                        java.util.Map<String, Object> p = (java.util.Map<String, Object>) pageContext.getAttribute("patient");
                                                        String name = (String) p.get("name");
                                                        String[] nameParts = name.split(" ");
                                                        StringBuilder initials = new StringBuilder();
                                                        for (String part : nameParts) {
                                                            if (!part.isEmpty()) {
                                                                initials.append(part.charAt(0));
                                                            }
                                                        }
                                                    %>
                                                    <div class="user-avatar me-2" style="width: 35px; height: 35px; font-size: 0.8rem;">
                                                        <%= initials.toString() %>
                                                    </div>
                                                    <span>${patient.name}</span>
                                                </div>
                                            </td>
                                            <td>${patient.email}</td>
                                            <td>${patient.lastVisit}</td>
                                            <td><span class="status-badge status-${fn:toLowerCase(patient.status)}">${patient.status}</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary me-1" onclick="editPatient(${patient.id})">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-danger" onclick="deletePatient(${patient.id})">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Doctor Management Section -->
            <div id="doctors-section" class="section-content d-none">
                <div class="page-header">
                    <h1>Doctor & Staff Management</h1>
                    <p>Manage doctors, staff members, roles, and shifts.</p>
                </div>

                <div class="data-table">
                    <div class="table-header">
                        <h5>Doctors & Staff</h5>
                        <div class="table-actions">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDoctorModal">
                                <i class="fas fa-plus me-1"></i> Add New Doctor
                            </button>
                            <button class="btn btn-outline-secondary">
                                <i class="fas fa-user-plus me-1"></i> Add Staff
                            </button>
                        </div>
                    </div>
                    <div class="table-container">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Specialization</th>
                                        <th>Contact</th>
                                        <th>Department</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="doctor" items="${doctors}">
                                        <tr>
                                            <td>#DR-${doctor.id}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <%
                                                        // Get doctor name and create initials
                                                        java.util.Map<String, Object> d = (java.util.Map<String, Object>) pageContext.getAttribute("doctor");
                                                        String docName = (String) d.get("name");
                                                        String[] docNameParts = docName.split(" ");
                                                        StringBuilder docInitials = new StringBuilder();
                                                        for (String part : docNameParts) {
                                                            if (!part.isEmpty()) {
                                                                docInitials.append(part.charAt(0));
                                                            }
                                                        }
                                                    %>
                                                    <div class="user-avatar me-2" style="width: 35px; height: 35px; font-size: 0.8rem;">
                                                        <%= docInitials.toString() %>
                                                    </div>
                                                    <span>${doctor.name}</span>
                                                </div>
                                            </td>
                                            <td>${doctor.specialization}</td>
                                            <td>${doctor.email}</td>
                                            <td>${doctor.department}</td>
                                            <td><span class="status-badge status-${fn:toLowerCase(doctor.status)}">${doctor.status}</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary me-1" onclick="editDoctor(${doctor.id})">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-danger" onclick="deleteDoctor(${doctor.id})">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Appointment Management Section -->
            <div id="appointments-section" class="section-content d-none">
                <div class="page-header">
                    <h1>Appointment Management</h1>
                    <p>View, approve, reject, and manage all appointments.</p>
                </div>

                <ul class="nav nav-tabs mb-4" id="appointmentTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button" role="tab">Pending</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="approved-tab" data-bs-toggle="tab" data-bs-target="#approved" type="button" role="tab">Approved</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="rejected-tab" data-bs-toggle="tab" data-bs-target="#rejected" type="button" role="tab">Rejected</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab">All Appointments</button>
                    </li>
                </ul>

                <div class="tab-content" id="appointmentTabsContent">
                    <div class="tab-pane fade show active" id="pending" role="tabpanel">
                        <div class="data-table">
                            <div class="table-header">
                                <h5>Pending Appointments</h5>
                                <div class="table-actions">
                                    <button class="btn btn-outline-secondary">
                                        <i class="fas fa-filter me-1"></i> Filter
                                    </button>
                                </div>
                            </div>
                            <div class="table-container">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Patient</th>
                                                <th>Requested Doctor</th>
                                                <th>Date & Time</th>
                                                <th>Reason</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="appointment" items="${appointments}">
                                                <c:if test="${appointment.status == 'Pending'}">
                                                    <tr>
                                                        <td>#APT-${appointment.id}</td>
                                                        <td>${appointment.patientName}</td>
                                                        <td>${appointment.doctorName}</td>
                                                        <td>${appointment.date}, ${appointment.time}</td>
                                                        <td>Regular checkup</td>
                                                        <td>
                                                            <button class="btn btn-sm btn-success me-1" onclick="updateAppointmentStatus(${appointment.id}, 'Approved')">
                                                                <i class="fas fa-check"></i> Approve
                                                            </button>
                                                            <button class="btn btn-sm btn-danger" onclick="updateAppointmentStatus(${appointment.id}, 'Rejected')">
                                                                <i class="fas fa-times"></i> Reject
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="approved" role="tabpanel">
                        <div class="data-table">
                            <div class="table-header">
                                <h5>Approved Appointments</h5>
                            </div>
                            <div class="table-container">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Patient</th>
                                                <th>Doctor</th>
                                                <th>Date & Time</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="appointment" items="${appointments}">
                                                <c:if test="${appointment.status == 'Approved'}">
                                                    <tr>
                                                        <td>#APT-${appointment.id}</td>
                                                        <td>${appointment.patientName}</td>
                                                        <td>${appointment.doctorName}</td>
                                                        <td>${appointment.date}, ${appointment.time}</td>
                                                        <td><span class="status-badge status-approved">Approved</span></td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-danger" onclick="updateAppointmentStatus(${appointment.id}, 'Cancelled')">
                                                                <i class="fas fa-times"></i> Cancel
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="rejected" role="tabpanel">
                        <div class="data-table">
                            <div class="table-header">
                                <h5>Rejected Appointments</h5>
                            </div>
                            <div class="table-container">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Patient</th>
                                                <th>Requested Doctor</th>
                                                <th>Date & Time</th>
                                                <th>Reason</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="appointment" items="${appointments}">
                                                <c:if test="${appointment.status == 'Rejected'}">
                                                    <tr>
                                                        <td>#APT-${appointment.id}</td>
                                                        <td>${appointment.patientName}</td>
                                                        <td>${appointment.doctorName}</td>
                                                        <td>${appointment.date}, ${appointment.time}</td>
                                                        <td>Schedule conflict</td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-primary" onclick="updateAppointmentStatus(${appointment.id}, 'Pending')">
                                                                <i class="fas fa-redo"></i> Restore
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="all" role="tabpanel">
                        <div class="data-table">
                            <div class="table-header">
                                <h5>All Appointments</h5>
                            </div>
                            <div class="table-container">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Patient</th>
                                                <th>Doctor</th>
                                                <th>Date & Time</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="appointment" items="${appointments}">
                                                <tr>
                                                    <td>#APT-${appointment.id}</td>
                                                    <td>${appointment.patientName}</td>
                                                    <td>${appointment.doctorName}</td>
                                                    <td>${appointment.date}, ${appointment.time}</td>
                                                    <td><span class="status-badge status-${fn:toLowerCase(appointment.status)}">${appointment.status}</span></td>
                                                    <td>
                                                        <c:if test="${appointment.status == 'Pending'}">
                                                            <button class="btn btn-sm btn-success me-1" onclick="updateAppointmentStatus(${appointment.id}, 'Approved')">
                                                                <i class="fas fa-check"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-danger me-1" onclick="updateAppointmentStatus(${appointment.id}, 'Rejected')">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                        </c:if>
                                                        <button class="btn btn-sm btn-outline-danger" onclick="deleteAppointment(${appointment.id})">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Reports & Analytics Section -->
            <div id="reports-section" class="section-content d-none">
                <div class="page-header">
                    <h1>Reports & Analytics</h1>
                    <p>View detailed reports and analytics for your hospital.</p>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="chart-container">
                            <h5 class="mb-3">Patient Admissions (Last 6 Months)</h5>
                            <canvas id="patientAdmissionsChart"></canvas>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="chart-container">
                            <h5 class="mb-3">Appointment Statistics</h5>
                            <canvas id="appointmentStatsChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="chart-container">
                            <h5 class="mb-3">Department-wise Patient Distribution</h5>
                            <canvas id="departmentDistributionChart"></canvas>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="chart-container">
                            <h5 class="mb-3">Revenue Overview (Last 12 Months)</h5>
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- System & Security Section -->
            <div id="system-section" class="section-content d-none">
                <div class="page-header">
                    <h1>System & Security</h1>
                    <p>Manage system settings, user accounts, and security configurations.</p>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="data-table">
                            <div class="table-header">
                                <h5>User Accounts</h5>
                                <div class="table-actions">
                                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                        <i class="fas fa-plus me-1"></i> Add User
                                    </button>
                                </div>
                            </div>
                            <div class="table-container">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>Username</th>
                                                <th>Role</th>
                                                <th>Last Login</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Admin User</td>
                                                <td><span class="badge bg-primary">Admin</span></td>
                                                <td>2023-11-15 09:42:23</td>
                                                <td><span class="status-badge status-active">Active</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary me-1">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-danger">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Dr. Sarah Wilson</td>
                                                <td><span class="badge bg-success">Doctor</span></td>
                                                <td>2023-11-16 14:20:15</td>
                                                <td><span class="status-badge status-active">Active</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary me-1">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-danger">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 mb-4">
                        <div class="data-table">
                            <div class="table-header">
                                <h5>System Settings</h5>
                            </div>
                            <div class="table-container">
                                <div class="p-3">
                                    <div class="mb-3">
                                        <label class="form-label">Hospital Name</label>
                                        <input type="text" class="form-control" value="MedTech Hospital">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Contact Email</label>
                                        <input type="email" class="form-control" value="info@medtech.com">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Emergency Contact</label>
                                        <input type="text" class="form-control" value="+1 234 567 890">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Automatic Backup</label>
                                        <select class="form-select">
                                            <option>Daily</option>
                                            <option selected>Weekly</option>
                                            <option>Monthly</option>
                                        </select>
                                    </div>
                                    <button class="btn btn-primary">Save Settings</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light pt-5 pb-4">
        <div class="container">
            <div class="row">
                
                <!-- About Section -->
                <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                    <div class="footer-section">
                        <div class="d-flex align-items-center mb-3">
                            <i class="fas fa-hospital-alt fa-2x text-primary me-3"></i>
                            <h4 class="fw-bold mb-0 text-white">MedTech HMS</h4>
                        </div>
                        <p class="text-light opacity-75 mb-4">
                            MedTech Solutions (HMS) is dedicated to providing the best healthcare services 
                            with a patient-first approach. We ensure that our patients receive the utmost 
                            care with our state-of-the-art facilities and expert medical professionals.
                        </p>
                        <div class="d-flex align-items-center">
                            <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 50px; height: 50px;">
                                <i class="fa-solid fa-phone text-white"></i>
                            </div>
                            <div>
                                <h6 class="mb-0 text-white">Emergency Hotline</h6>
                                <p class="mb-0 text-primary fw-bold fs-5">+1 234 567 890</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Links -->
                <div class="col-xl-2 col-lg-3 col-md-6 col-sm-6 mb-4">
                    <div class="footer-section">
                        <h4 class="fw-bold mb-3 text-primary position-relative pb-2">Quick Links</h4>
                        <ul class="list-unstyled footer-links">
                            <li class="mb-2">
                                <a href="index.jsp" class="text-light opacity-75 text-decoration-none footer-link">
                                    <i class="fa-solid fa-chevron-right me-2 text-primary small"></i> Home
                                </a>
                            </li>
                            <li class="mb-2">
                                <a href="#" class="text-light opacity-75 text-decoration-none footer-link">
                                    <i class="fa-solid fa-chevron-right me-2 text-primary small"></i> About Us
                                </a>
                            </li>
                            <li class="mb-2">
                                <a href="#" class="text-light opacity-75 text-decoration-none footer-link">
                                    <i class="fa-solid fa-chevron-right me-2 text-primary small"></i> Services
                                </a>
                            </li>
                            <li class="mb-2">
                                <a href="#" class="text-light opacity-75 text-decoration-none footer-link">
                                    <i class="fa-solid fa-chevron-right me-2 text-primary small"></i> Doctors
                                </a>
                            </li>
                            <li class="mb-2">
                                <a href="#" class="text-light opacity-75 text-decoration-none footer-link">
                                    <i class="fa-solid fa-chevron-right me-2 text-primary small"></i> Contact
                                </a>
                            </li>
                            <li class="mb-2">
                                <a href="#" class="text-light opacity-75 text-decoration-none footer-link">
                                    <i class="fa-solid fa-chevron-right me-2 text-primary small"></i> FAQs
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <!-- Contact Info -->
                <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 mb-4">
                    <div class="footer-section">
                        <h4 class="fw-bold mb-3 text-primary position-relative pb-2">Contact Us</h4>
                        <div class="d-flex align-items-start mb-3">
                            <div class="contact-icon">
                                <i class="fa-solid fa-location-dot text-primary"></i>
                            </div>
                            <p class="text-light opacity-75 mb-0 ms-3">
                                123 Hospital Street, Medical District,<br>City, State, 12345
                            </p>
                        </div>
                        <div class="d-flex align-items-center mb-3">
                            <div class="contact-icon">
                                <i class="fa-solid fa-envelope text-primary"></i>
                            </div>
                            <p class="text-light opacity-75 mb-0 ms-3">info@hospital.com</p>
                        </div>
                        <div class="d-flex align-items-center mb-3">
                            <div class="contact-icon">
                                <i class="fa-solid fa-phone text-primary"></i>
                            </div>
                            <p class="text-light opacity-75 mb-0 ms-3">+1 234 567 890</p>
                        </div>
                        <div class="d-flex align-items-center">
                            <div class="contact-icon">
                                <i class="fa-solid fa-clock text-primary"></i>
                            </div>
                            <p class="text-light opacity-75 mb-0 ms-3">24/7 Emergency Services</p>
                        </div>
                    </div>
                </div>
                
                <!-- Social Media & Newsletter -->
                <div class="col-xl-4 col-lg-5 col-md-6 mb-4">
                    <div class="footer-section">
                        <h4 class="fw-bold mb-3 text-primary position-relative pb-2">Stay Connected</h4>
                        <p class="text-light opacity-75 mb-3">
                            Subscribe to our newsletter for the latest updates and health tips.
                        </p>
                        
                        <!-- Newsletter Form -->
                        <div class="input-group mb-4 newsletter-form">
                            <input type="email" class="form-control bg-transparent border-secondary text-light" 
                                   placeholder="Enter your email" aria-label="Your email">
                            <button class="btn btn-primary px-3" type="button">
                                <i class="fa-solid fa-paper-plane"></i>
                            </button>
                        </div>
                        
                        <!-- Social Icons -->
                        <h6 class="fw-bold mb-3 text-white">Follow Us On Social Media</h6>
                        <div class="social-icons d-flex flex-wrap">
                            <a href="#" class="social-link me-3 mb-2">
                                <i class="fa-brands fa-facebook-f"></i>
                            </a>
                            <a href="#" class="social-link me-3 mb-2">
                                <i class="fa-brands fa-twitter"></i>
                            </a>
                            <a href="#" class="social-link me-3 mb-2">
                                <i class="fa-brands fa-instagram"></i>
                            </a>
                            <a href="#" class="social-link me-3 mb-2">
                                <i class="fa-brands fa-linkedin-in"></i>
                            </a>
                            <a href="#" class="social-link me-3 mb-2">
                                <i class="fa-brands fa-youtube"></i>
                            </a>
                            <a href="#" class="social-link mb-2">
                                <i class="fa-brands fa-whatsapp"></i>
                            </a>
                        </div>
                    </div>
                </div>
                
            </div>
            
            <!-- Footer Bottom -->
            <div class="footer-bottom border-top border-secondary pt-4 mt-3">
                <div class="row align-items-center">
                    <div class="col-lg-6 text-center text-lg-start mb-2 mb-lg-0">
                        <p class="mb-0 text-light opacity-75">
                            &copy; 2024 MedTech Hospital Management System. All rights reserved.
                        </p>
                    </div>
                    <div class="col-lg-6 text-center text-lg-end">
                        <div class="d-flex justify-content-lg-end justify-content-center flex-wrap">
                            <a href="#" class="text-light opacity-75 text-decoration-none me-3 mb-1 mb-lg-0 small footer-link">Privacy Policy</a>
                            <a href="#" class="text-light opacity-75 text-decoration-none me-3 mb-1 mb-lg-0 small footer-link">Terms of Service</a>
                            <a href="#" class="text-light opacity-75 text-decoration-none mb-1 mb-lg-0 small footer-link">Sitemap</a>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </footer>

    <!-- Modals -->
    <!-- Add Patient Modal -->
    <div class="modal fade" id="addPatientModal" tabindex="-1" aria-labelledby="addPatientModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addPatientModalLabel">Add New Patient</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addPatientForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="patientName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="patientName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="patientEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="patientEmail" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="patientPhone" class="form-label">Phone</label>
                                <input type="tel" class="form-control" id="patientPhone" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="patientDob" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="patientDob" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="patientGender" class="form-label">Gender</label>
                                <select class="form-select" id="patientGender" required>
                                    <option value="">Select Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="patientBloodGroup" class="form-label">Blood Group</label>
                                <select class="form-select" id="patientBloodGroup">
                                    <option value="">Select Blood Group</option>
                                    <option value="A+">A+</option>
                                    <option value="A-">A-</option>
                                    <option value="B+">B+</option>
                                    <option value="B-">B-</option>
                                    <option value="AB+">AB+</option>
                                    <option value="AB-">AB-</option>
                                    <option value="O+">O+</option>
                                    <option value="O-">O-</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="patientAddress" class="form-label">Address</label>
                            <textarea class="form-control" id="patientAddress" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="patientEmergencyContact" class="form-label">Emergency Contact</label>
                            <input type="text" class="form-control" id="patientEmergencyContact">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="addPatient()">Add Patient</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Doctor Modal -->
    <div class="modal fade" id="addDoctorModal" tabindex="-1" aria-labelledby="addDoctorModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addDoctorModalLabel">Add New Doctor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addDoctorForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="doctorName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="doctorName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="doctorEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="doctorEmail" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="doctorPhone" class="form-label">Phone</label>
                                <input type="tel" class="form-control" id="doctorPhone" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="doctorSpecialization" class="form-label">Specialization</label>
                                <select class="form-select" id="doctorSpecialization" required>
                                    <option value="">Select Specialization</option>
                                    <option value="Cardiology">Cardiology</option>
                                    <option value="Dermatology">Dermatology</option>
                                    <option value="Neurology">Neurology</option>
                                    <option value="Orthopedics">Orthopedics</option>
                                    <option value="Pediatrics">Pediatrics</option>
                                    <option value="Surgery">Surgery</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="doctorDepartment" class="form-label">Department</label>
                                <select class="form-select" id="doctorDepartment" required>
                                    <option value="">Select Department</option>
                                    <option value="Cardiology">Cardiology</option>
                                    <option value="Dermatology">Dermatology</option>
                                    <option value="Neurology">Neurology</option>
                                    <option value="Orthopedics">Orthopedics</option>
                                    <option value="Pediatrics">Pediatrics</option>
                                    <option value="Surgery">Surgery</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="doctorLicense" class="form-label">License Number</label>
                                <input type="text" class="form-control" id="doctorLicense" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="doctorExperience" class="form-label">Years of Experience</label>
                                <input type="number" class="form-control" id="doctorExperience" min="0" max="50" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="doctorStatus" class="form-label">Status</label>
                                <select class="form-select" id="doctorStatus" required>
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                    <option value="On Leave">On Leave</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="addDoctor()">Add Doctor</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addUserForm">
                        <div class="mb-3">
                            <label for="userName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="userName" required>
                        </div>
                        <div class="mb-3">
                            <label for="userEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="userEmail" required>
                        </div>
                        <div class="mb-3">
                            <label for="userRole" class="form-label">Role</label>
                            <select class="form-select" id="userRole" required>
                                <option value="">Select Role</option>
                                <option value="Admin">Admin</option>
                                <option value="Doctor">Doctor</option>
                                <option value="Nurse">Nurse</option>
                                <option value="Receptionist">Receptionist</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="userPassword" class="form-label">Password</label>
                            <input type="password" class="form-control" id="userPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="userStatus" class="form-label">Status</label>
                            <select class="form-select" id="userStatus" required>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="addUser()">Add User</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialize charts
        function initCharts() {
            // Patient Admissions Chart
            const patientAdmissionsCtx = document.getElementById('patientAdmissionsChart').getContext('2d');
            new Chart(patientAdmissionsCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Patient Admissions',
                        data: [65, 59, 80, 81, 56, 72],
                        borderColor: '#2563eb',
                        backgroundColor: 'rgba(37, 99, 235, 0.1)',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });

            // Appointment Stats Chart
            const appointmentStatsCtx = document.getElementById('appointmentStatsChart').getContext('2d');
            new Chart(appointmentStatsCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Approved', 'Pending', 'Rejected'],
                    datasets: [{
                        data: [70, 20, 10],
                        backgroundColor: [
                            '#10b981',
                            '#f59e0b',
                            '#ef4444'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });

            // Department Distribution Chart
            const departmentDistributionCtx = document.getElementById('departmentDistributionChart').getContext('2d');
            new Chart(departmentDistributionCtx, {
                type: 'bar',
                data: {
                    labels: ['Cardiology', 'Neurology', 'Orthopedics', 'Pediatrics', 'Surgery'],
                    datasets: [{
                        label: 'Patients',
                        data: [65, 59, 80, 81, 56],
                        backgroundColor: '#2563eb'
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });

            // Revenue Chart
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            new Chart(revenueCtx, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Revenue ($)',
                        data: [12000, 19000, 15000, 25000, 22000, 30000, 28000, 26000, 31000, 35000, 33000, 40000],
                        backgroundColor: '#10b981'
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        }

        // UI Functions
        function showSection(sectionName) {
            // Hide all sections
            document.querySelectorAll('.section-content').forEach(section => {
                section.classList.add('d-none');
            });

            // Show the selected section
            document.getElementById(sectionName + '-section').classList.remove('d-none');

            // Update active menu item
            document.querySelectorAll('.sidebar-link').forEach(link => {
                link.classList.remove('active');
            });
            document.querySelector(`[data-section="${sectionName}"]`).classList.add('active');

            // Load section-specific data
            if (sectionName === 'reports') {
                initCharts();
            }
        }

        // CRUD Operations
        function addPatient() {
            // In a real application, this would submit to a servlet
            alert('Patient added successfully! This would connect to your backend in a real application.');
            
            // Close modal
            const modal = bootstrap.Modal.getInstance(document.getElementById('addPatientModal'));
            modal.hide();
            
            // Reset form
            document.getElementById('addPatientForm').reset();
        }

        function addDoctor() {
            // In a real application, this would submit to a servlet
            alert('Doctor added successfully! This would connect to your backend in a real application.');
            
            // Close modal
            const modal = bootstrap.Modal.getInstance(document.getElementById('addDoctorModal'));
            modal.hide();
            
            // Reset form
            document.getElementById('addDoctorForm').reset();
        }

        function addUser() {
            // In a real application, this would submit to a servlet
            alert('User added successfully! This would connect to your backend in a real application.');
            
            // Close modal
            const modal = bootstrap.Modal.getInstance(document.getElementById('addUserModal'));
            modal.hide();
            
            // Reset form
            document.getElementById('addUserForm').reset();
        }

        function updateAppointmentStatus(appointmentId, status) {
            // In a real application, this would submit to a servlet
            alert(`Appointment ${status.toLowerCase()} successfully! This would connect to your backend in a real application.`);
            
            // Refresh page to show updated status (in real app, use AJAX)
            location.reload();
        }

        function deletePatient(patientId) {
            if (confirm('Are you sure you want to delete this patient?')) {
                // In a real application, this would submit to a servlet
                alert('Patient deleted successfully! This would connect to your backend in a real application.');
                
                // Refresh page (in real app, use AJAX)
                location.reload();
            }
        }

        function deleteDoctor(doctorId) {
            if (confirm('Are you sure you want to delete this doctor?')) {
                // In a real application, this would submit to a servlet
                alert('Doctor deleted successfully! This would connect to your backend in a real application.');
                
                // Refresh page (in real app, use AJAX)
                location.reload();
            }
        }

        function deleteAppointment(appointmentId) {
            if (confirm('Are you sure you want to delete this appointment?')) {
                // In a real application, this would submit to a servlet
                alert('Appointment deleted successfully! This would connect to your backend in a real application.');
                
                // Refresh page (in real app, use AJAX)
                location.reload();
            }
        }

        // Placeholder functions for edit operations
        function editPatient(patientId) {
            alert('Edit patient functionality would open here. Patient ID: ' + patientId);
        }

        function editDoctor(doctorId) {
            alert('Edit doctor functionality would open here. Doctor ID: ' + doctorId);
        }

        // Initialize the dashboard
        document.addEventListener('DOMContentLoaded', function() {
            // Set up sidebar navigation
            document.querySelectorAll('.sidebar-link').forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const section = this.getAttribute('data-section');
                    showSection(section);
                });
            });
            
            // Toggle sidebar on mobile
            document.querySelector('.menu-toggle').addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('active');
            });
            
            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(event) {
                const sidebar = document.querySelector('.sidebar');
                const menuToggle = document.querySelector('.menu-toggle');
                
                if (window.innerWidth < 992 && 
                    !sidebar.contains(event.target) && 
                    !menuToggle.contains(event.target) && 
                    sidebar.classList.contains('active')) {
                    sidebar.classList.remove('active');
                }
            });
        });
    </script>
</body>
</html>