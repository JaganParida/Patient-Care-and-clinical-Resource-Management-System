<%@page import="com.dao.DoctorDao"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.SpecialistDao"%>
<%@page import="com.entity.*" %>
<%@page import="java.util.List"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page import="com.entity.Doctor"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Appointment - Hospital Management System</title>
<%@include file="../component/allcss.jsp"%>

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
}

.appointment-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
}

.appointment-header {
    text-align: center;
    margin-bottom: 40px;
}

.appointment-header h1 {
    color: var(--primary);
    font-weight: 700;
    margin-bottom: 10px;
    font-size: 2.5rem;
}

.appointment-header p {
    color: var(--text-light);
    font-size: 1.1rem;
}
.form-control:focus{
color:black !important;
}

.appointment-card {
    background: var(--white);
    border-radius: var(--radius);
    box-shadow: var(--shadow-lg);
    overflow: hidden;
    transition: all 0.3s ease;
    padding: 40px;
}
.appointment-container{
padding-top:108px}

.appointment-card:hover {
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

.appointment-title {
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

.appointment-title i {
    font-size: 1.5rem;
}

.appointment-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 40px;
}

.appointment-image {
    border-radius: var(--radius);
    overflow: hidden;
    box-shadow: var(--shadow);
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, var(--primary-light) 0%, var(--accent) 100%);
}

.appointment-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.appointment-form-container {
    display: flex;
    flex-direction: column;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-bottom: 20px;
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
    padding: 12px 15px;
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

.form-select {
    background: var(--light);
    border: 2px solid var(--gray-light);
    border-radius: 8px;
    color: var(--text);
    padding: 12px 15px;
    transition: all 0.3s ease;
    font-size: 1rem;
    width: 100%;
}

.form-select:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    outline: none;
}

textarea.form-control {
    resize: vertical;
    min-height: 100px;
}

.btn-appointment {
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

.btn-appointment:hover {
    background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
}

.btn-login-redirect {
    background: linear-gradient(135deg, var(--success) 0%, #34d399 100%);
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
    text-decoration: none;
}

.btn-login-redirect:hover {
    background: linear-gradient(135deg, #059669 0%, var(--success) 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(16, 185, 129, 0.3);
    color: white;
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

.doctor-info {
    background: rgba(37, 99, 235, 0.05);
    border-radius: 8px;
    padding: 15px;
    margin-top: 10px;
    border-left: 4px solid var(--primary);
}

.doctor-info p {
    margin: 0;
    font-size: 0.9rem;
    color: var(--text-light);
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

.was-validated .form-control:invalid ~ .invalid-feedback,
.was-validated .form-select:invalid ~ .invalid-feedback {
    display: block;
}

@media (max-width: 992px) {
    .appointment-grid {
        grid-template-columns: 1fr;
        gap: 30px;
    }
    
    .appointment-image {
        height: 300px;
    }
}

@media (max-width: 768px) {
    .form-row {
        grid-template-columns: 1fr;
        gap: 0;
    }
    
    .appointment-card {
        padding: 30px 20px;
    }
    
    .appointment-header h1 {
        font-size: 2rem;
    }
}
</style>
</head>
<body>
	<%@include file="../component/navbar.jsp"%>

	<div class="appointment-container">
        <div class="appointment-header">
            <h1><i class="fas fa-calendar-check me-2"></i>Book Your Appointment</h1>
            <p>Schedule your visit with our healthcare specialists</p>
        </div>

        <div class="appointment-card">
            <div class="appointment-title">
                <i class="fas fa-file-medical"></i>Appointment Form
            </div>

            <div class="appointment-grid">
                <div class="appointment-image">
                    <img src="https://images.unsplash.com/photo-1638202993928-7267aad84c31?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=687" alt="Medical Appointment">
                </div>

                <div class="appointment-form-container">
                    <!-- Success Message -->
                    <c:if test="${not empty succMsg}">
                        <div class="text-success">
                            <i class="fas fa-check-circle me-2"></i>${succMsg}
                        </div>
                        <c:remove var="succMsg" scope="session" />
                    </c:if>

                    <!-- Error Message -->
                    <c:if test="${not empty errorMsg}">
                        <div class="text-danger">
                            <i class="fas fa-exclamation-circle me-2"></i>${errorMsg}
                        </div>
                        <c:remove var="errorMsg" scope="session" />
                    </c:if>

                    <form class="needs-validation" action="appAppointment" method="post" novalidate>
                        <input type="hidden" name="userid" value="${userObj.id }">

                        <div class="form-row">
                            <div class="form-group">
                                <label for="fullname" class="form-label">
                                    <i class="fas fa-user"></i>Full Name
                                </label>
                                <input type="text" class="form-control" id="fullname" name="fullname" 
                                       placeholder="Enter your full name" required>
                                <div class="invalid-feedback">
                                    Please provide your full name.
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="gender" class="form-label">
                                    <i class="fas fa-venus-mars"></i>Gender
                                </label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="" disabled selected>Select gender</option>
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                    <option value="other">Other</option>
                                </select>
                                <div class="invalid-feedback">
                                    Please select your gender.
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="age" class="form-label">
                                    <i class="fas fa-birthday-cake"></i>Age
                                </label>
                                <input type="number" class="form-control" id="age" name="age" 
                                       placeholder="Enter your age" min="1" max="120" required>
                                <div class="invalid-feedback">
                                    Please provide a valid age.
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="appoint_date" class="form-label">
                                    <i class="fas fa-calendar-day"></i>Appointment Date
                                </label>
                                <input type="date" class="form-control" id="appoint_date" 
                                       name="appoint_date" required>
                                <div class="invalid-feedback">
                                    Please select an appointment date.
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope"></i>Email
                                </label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="Enter your email" required>
                                <div class="invalid-feedback">
                                    Please provide a valid email address.
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="phno" class="form-label">
                                    <i class="fas fa-phone"></i>Phone Number
                                </label>
                                <input type="tel" class="form-control" id="phno" name="phno" 
                                       placeholder="Enter your phone number" pattern="[0-9]{10}" required>
                                <div class="invalid-feedback">
                                    Please provide a valid 10-digit phone number.
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="diseases" class="form-label">
                                    <i class="fas fa-disease"></i>Medical Condition
                                </label>
                                <input type="text" class="form-control" id="diseases" name="diseases" 
                                       placeholder="Describe your condition" required>
                                <div class="invalid-feedback">
                                    Please describe your medical condition.
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="doct" class="form-label">
                                    <i class="fas fa-user-md"></i>Select Doctor
                                </label>
                                <select class="form-select" id="doct" name="doct" required>
                                    <option value="" disabled selected>Select a doctor</option>
                                    <% 
                                        DoctorDao dao = new DoctorDao(DBConnect.getConn());
                                        List<Doctor> list = dao.getAllDoctor();
                                        
                                        for(Doctor s : list) {
                                    %>
                                        <option value="<%=s.getId()%>">
                                            <%=s.getFullName()%> (<%=s.getSpecialist()%>)
                                        </option>
                                    <% } %>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a doctor.
                                </div>
                                <div class="doctor-info">
                                    <p><i class="fas fa-info-circle me-1"></i> Our specialists are available from 9 AM to 6 PM</p>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address" class="form-label">
                                <i class="fas fa-home"></i>Full Address
                            </label>
                            <textarea class="form-control" id="address" name="address" 
                                      rows="3" placeholder="Enter your complete address" required></textarea>
                            <div class="invalid-feedback">
                                Please provide your complete address.
                            </div>
                        </div>

                        <c:if test="${empty userObj}">
                            <a href="user_Login.jsp" class="btn-login-redirect">
                                <i class="fas fa-sign-in-alt"></i>Login to Book Appointment
                            </a>
                        </c:if>

                        <c:if test="${not empty userObj}">
                            <button type="submit" class="btn-appointment">
                                <i class="fas fa-calendar-plus"></i>Book Appointment
                            </button>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>
	
	<%@include file="../component/footer.jsp"%>

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

        // Set minimum date for appointment (today)
        window.onload = function() {
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            
            // Format date as YYYY-MM-DD
            const minDate = tomorrow.toISOString().split('T')[0];
            document.getElementById('appoint_date').min = minDate;
            
            // Set maximum date (3 months from now)
            const maxDate = new Date(today);
            maxDate.setMonth(maxDate.getMonth() + 3);
            document.getElementById('appoint_date').max = maxDate.toISOString().split('T')[0];
        };
    </script>
</body>
</html>