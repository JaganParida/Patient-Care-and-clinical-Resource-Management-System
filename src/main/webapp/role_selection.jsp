<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Choose Your Role - Hospital Management System</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
                --dark: #1e293b;
                --text: #334155;
                --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
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

            .role-container {
                width: 100%;
                max-width: 1000px;
                margin: 0 auto;
            }

            .role-header {
                text-align: center;
                margin-bottom: 50px;
            }

            .role-header h1 {
                color: var(--primary);
                font-weight: 700;
                margin-bottom: 15px;
                font-size: 2.8rem;
            }

            .role-header p {
                color: var(--secondary);
                font-size: 1.2rem;
                max-width: 600px;
                margin: 0 auto;
                line-height: 1.6;
            }

            .role-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 30px;
                margin-bottom: 40px;
            }

            .role-card {
                background: var(--white);
                border-radius: var(--radius);
                padding: 40px 30px;
                text-align: center;
                box-shadow: var(--shadow);
                transition: all 0.3s ease;
                border: 2px solid transparent;
                position: relative;
                overflow: hidden;
            }

            .role-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: var(--primary);
                transform: scaleX(0);
                transition: transform 0.3s ease;
            }

            .role-card:hover {
                transform: translateY(-10px);
                box-shadow: var(--shadow-lg);
                border-color: var(--primary-light);
            }

            .role-card:hover::before {
                transform: scaleX(1);
            }

            .role-icon {
                width: 80px;
                height: 80px;
                margin: 0 auto 25px;
                background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 2rem;
                transition: all 0.3s ease;
            }

            .role-card:hover .role-icon {
                transform: scale(1.1) rotate(5deg);
            }

            .role-card h3 {
                color: var(--dark);
                margin-bottom: 15px;
                font-size: 1.5rem;
                font-weight: 600;
            }

            .role-card p {
                color: var(--secondary);
                margin-bottom: 25px;
                line-height: 1.6;
                font-size: 0.95rem;
            }

            .role-features {
                list-style: none;
                margin-bottom: 30px;
                text-align: left;
            }

            .role-features li {
                padding: 8px 0;
                color: var(--text);
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 0.9rem;
            }

            .role-features li i {
                color: var(--primary);
                font-size: 0.8rem;
            }

            .btn-role {
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
                border: none;
                border-radius: 8px;
                color: white;
                padding: 12px 30px;
                font-size: 1rem;
                font-weight: 600;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
                width: 100%;
            }

            .btn-role:hover {
                background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
                color: white;
            }

            .login-link {
                text-align: center;
                margin-top: 40px;
                color: var(--secondary);
            }

            .login-link a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .login-link a:hover {
                color: var(--primary-dark);
                text-decoration: underline;
            }

            @media (max-width: 768px) {
                .role-cards {
                    grid-template-columns: 1fr;
                }

                .role-header h1 {
                    font-size: 2.2rem;
                }
            }
        </style>
    </head>

    <body>
        <div class="role-container">
            <div class="role-header">
                <h1><i class="fas fa-hospital-user me-2"></i>Join Our Healthcare System</h1>
                <p>Select your role to create an account and access our healthcare services</p>
            </div>

            <div class="role-cards">
                <!-- Patient Card -->
                <div class="role-card">
                    <div class="role-icon">
                        <i class="fas fa-user-injured"></i>
                    </div>
                    <h3>Patient</h3>
                    <p>Create your personal account to book appointments, view medical records, and manage your
                        healthcare journey.</p>

                    <ul class="role-features">
                        <li><i class="fas fa-check"></i> Book appointments online</li>
                        <li><i class="fas fa-check"></i> Access medical records</li>
                        <li><i class="fas fa-check"></i> View prescription history</li>
                        <li><i class="fas fa-check"></i> Secure messaging with doctors</li>
                    </ul>

                    <a href="./patient/patient_signup.jsp" class="btn-role">
                        <i class="fas fa-user-plus me-2"></i>Register as Patient
                    </a>
                </div>

                <!-- Doctor Card -->
                <div class="role-card">
                    <div class="role-icon">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h3>Medical Professional</h3>
                    <p>Join our network of healthcare providers to manage patients, schedules, and provide quality care.
                    </p>

                    <ul class="role-features">
                        <li><i class="fas fa-check"></i> Manage patient appointments</li>
                        <li><i class="fas fa-check"></i> Access medical records</li>
                        <li><i class="fas fa-check"></i> Electronic prescription system</li>
                        <li><i class="fas fa-check"></i> Professional collaboration tools</li>
                    </ul>

                    <a href="./doctor/doctor_register.jsp" class="btn-role">
                        <i class="fas fa-stethoscope me-2"></i>Register as Doctor
                    </a>
                </div>

                <!-- Admin Card -->
                <div class="role-card">
                    <div class="role-icon">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <h3>Administrator</h3>
                    <p>Manage hospital operations, user accounts, and system configurations with administrative
                        privileges.</p>

                    <ul class="role-features">
                        <li><i class="fas fa-check"></i> Manage user accounts</li>
                        <li><i class="fas fa-check"></i> System configuration</li>
                        <li><i class="fas fa-check"></i> Reports and analytics</li>
                        <li><i class="fas fa-check"></i> Hospital operations management</li>
                    </ul>

                    <a href="./admin/admin_signup.jsp" class="btn-role">
                        <i class="fas fa-cogs me-2"></i>Register as Admin
                    </a>
                </div>
            </div>

            <div class="login-link">
                Already have an account? <a href="./index.jsp">Sign in here</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>