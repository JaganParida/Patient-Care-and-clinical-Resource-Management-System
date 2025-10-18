<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCare - Doctor Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background: linear-gradient(135deg, #1a73e8, #0d47a1);
            color: white;
            padding: 20px 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo i {
            font-size: 28px;
        }

        .logo h1 {
            font-size: 24px;
            font-weight: 600;
        }

        nav ul {
            display: flex;
            list-style: none;
            gap: 25px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        nav a:hover {
            color: #a7d1ff;
        }

        .user-actions {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-login {
            background-color: white;
            color: #1a73e8;
        }

        .btn-login:hover {
            background-color: #f0f0f0;
        }

        .btn-logout {
            background-color: transparent;
            color: white;
            border: 1px solid white;
        }

        .btn-logout:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .dashboard-title {
            text-align: center;
            margin: 30px 0;
            color: #1a73e8;
        }

        .dashboard-title h2 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .dashboard-title p {
            color: #666;
            font-size: 18px;
        }

        .filters {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 8px 20px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-btn:hover, .filter-btn.active {
            background-color: #1a73e8;
            color: white;
            border-color: #1a73e8;
        }

        .search-box {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .search-input {
            width: 100%;
            max-width: 500px;
            padding: 12px 20px;
            border: 1px solid #ddd;
            border-radius: 30px;
            font-size: 16px;
            outline: none;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
        }

        .doctors-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .doctor-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .doctor-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .doctor-header {
            display: flex;
            padding: 20px;
            background: linear-gradient(to right, #f8f9fa, #e9ecef);
        }

        .doctor-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid white;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }

        .doctor-basic-info {
            margin-left: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .doctor-name {
            font-size: 20px;
            font-weight: 600;
            color: #1a73e8;
            margin-bottom: 5px;
        }

        .doctor-department {
            color: #666;
            font-size: 16px;
            margin-bottom: 8px;
        }

        .doctor-rating {
            color: #ffc107;
            font-size: 14px;
        }

        .doctor-details {
            padding: 20px;
        }

        .detail-item {
            display: flex;
            margin-bottom: 12px;
            align-items: flex-start;
        }

        .detail-icon {
            color: #1a73e8;
            width: 20px;
            margin-right: 10px;
            margin-top: 3px;
        }

        .detail-label {
            font-weight: 600;
            margin-right: 5px;
            min-width: 120px;
        }

        .doctor-actions {
            display: flex;
            padding: 15px 20px;
            background-color: #f8f9fa;
            border-top: 1px solid #eee;
        }

        .btn-action {
            flex: 1;
            padding: 10px;
            text-align: center;
            border-radius: 5px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-info {
            background-color: #e3f2fd;
            color: #1a73e8;
            margin-right: 10px;
        }

        .btn-info:hover {
            background-color: #bbdefb;
        }

        .btn-book {
            background-color: #1a73e8;
            color: white;
        }

        .btn-book:hover {
            background-color: #0d47a1;
        }

        .btn-book:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: white;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        .close-modal {
            position: absolute;
            top: 15px;
            right: 15px;
            font-size: 24px;
            cursor: pointer;
            color: #666;
        }

        .modal-title {
            margin-bottom: 20px;
            color: #1a73e8;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #0d47a1;
        }

        .info-modal {
            max-width: 700px;
        }

        .info-content {
            max-height: 400px;
            overflow-y: auto;
            padding-right: 10px;
        }

        .info-section {
            margin-bottom: 25px;
        }

        .info-section h3 {
            color: #1a73e8;
            margin-bottom: 10px;
            padding-bottom: 5px;
            border-bottom: 1px solid #eee;
        }

        .login-prompt {
            text-align: center;
            padding: 20px;
            background-color: #fff8e1;
            border-radius: 5px;
            margin-top: 15px;
            color: #ff8f00;
            font-weight: 500;
        }

        footer {
            background-color: #1a73e8;
            color: white;
            padding: 30px 0;
            margin-top: 50px;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .footer-section {
            flex: 1;
            min-width: 250px;
            margin-bottom: 20px;
        }

        .footer-section h3 {
            margin-bottom: 15px;
            font-size: 18px;
        }

        .footer-section p, .footer-section a {
            color: #e3f2fd;
            margin-bottom: 8px;
            display: block;
            text-decoration: none;
        }

        .footer-section a:hover {
            text-decoration: underline;
        }

        .copyright {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #64b5f6;
            margin-top: 20px;
            color: #e3f2fd;
        }

        .loading {
            text-align: center;
            padding: 40px;
            font-size: 18px;
            color: #666;
        }

        .loading i {
            font-size: 24px;
            margin-bottom: 10px;
            color: #1a73e8;
        }

        .no-results {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 18px;
        }

        .no-results i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #ccc;
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
            }
            
            nav ul {
                gap: 15px;
            }
            
            .doctors-container {
                grid-template-columns: 1fr;
            }
            
            .doctor-header {
                flex-direction: column;
                text-align: center;
            }
            
            .doctor-basic-info {
                margin-left: 0;
                margin-top: 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-stethoscope"></i>
                    <h1>MediCare</h1>
                </div>
                <nav>
                    <ul>
                        <li><a href="#"><i class="fas fa-home"></i> Home</a></li>
                        <li><a href="#"><i class="fas fa-user-md"></i> Doctors</a></li>
                        <li><a href="#"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                        <li><a href="#"><i class="fas fa-info-circle"></i> About</a></li>
                        <li><a href="#"><i class="fas fa-phone"></i> Contact</a></li>
                    </ul>
                </nav>
                <div class="user-actions">
                    <button id="loginBtn" class="btn btn-login"><i class="fas fa-sign-in-alt"></i> Login</button>
                    <button id="logoutBtn" class="btn btn-logout" style="display: none;"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </div>
            </div>
        </div>
    </header>

    <!-- Dashboard Title -->
    <section class="dashboard-title">
        <div class="container">
            <h2>Find Your Specialist</h2>
            <p>Browse our team of experienced healthcare professionals</p>
        </div>
    </section>

    <!-- Search Box -->
    <section class="search-box container">
        <input type="text" id="searchInput" class="search-input" placeholder="Search doctors by name, department, or specialty...">
    </section>

    <!-- Filters -->
    <section class="filters container">
        <button class="filter-btn active">All Specialties</button>
        <button class="filter-btn">Cardiology</button>
        <button class="filter-btn">Neurology</button>
        <button class="filter-btn">Pediatrics</button>
        <button class="filter-btn">Dermatology</button>
        <button class="filter-btn">Orthopedics</button>
    </section>

    <!-- Doctors Container -->
    <section class="container">
        <div class="doctors-container" id="doctorsContainer">
            <!-- Doctor cards will be dynamically inserted here -->
        </div>
    </section>

    <!-- Login Modal -->
    <div id="loginModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2 class="modal-title">Patient Login</h2>
            <form id="loginForm">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" class="form-control" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" class="form-control" placeholder="Enter your password" required>
                </div>
                <button type="submit" class="btn-submit">Login</button>
            </form>
            <div class="login-prompt" id="loginMessage" style="display: none;">
                Please login to book an appointment
            </div>
        </div>
    </div>

    <!-- Appointment Modal -->
    <div id="appointmentModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2 class="modal-title">Book Appointment</h2>
            <form id="appointmentForm">
                <div class="form-group">
                    <label for="patientName">Full Name</label>
                    <input type="text" id="patientName" class="form-control" placeholder="Enter your full name" required>
                </div>
                <div class="form-group">
                    <label for="patientEmail">Email</label>
                    <input type="email" id="patientEmail" class="form-control" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <label for="patientPhone">Phone Number</label>
                    <input type="tel" id="patientPhone" class="form-control" placeholder="Enter your phone number" required>
                </div>
                <div class="form-group">
                    <label for="appointmentDate">Preferred Date</label>
                    <input type="date" id="appointmentDate" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="appointmentTime">Preferred Time</label>
                    <select id="appointmentTime" class="form-control" required>
                        <option value="">Select a time</option>
                        <option value="09:00">09:00 AM</option>
                        <option value="10:00">10:00 AM</option>
                        <option value="11:00">11:00 AM</option>
                        <option value="14:00">02:00 PM</option>
                        <option value="15:00">03:00 PM</option>
                        <option value="16:00">04:00 PM</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="symptoms">Symptoms / Reason for Visit</label>
                    <textarea id="symptoms" class="form-control" rows="3" placeholder="Briefly describe your symptoms or reason for appointment"></textarea>
                </div>
                <button type="submit" class="btn-submit">Book Appointment</button>
            </form>
        </div>
    </div>

    <!-- Doctor Info Modal -->
    <div id="infoModal" class="modal">
        <div class="modal-content info-modal">
            <span class="close-modal">&times;</span>
            <h2 class="modal-title">Doctor Information</h2>
            <div class="info-content" id="doctorInfoContent">
                <!-- Doctor info will be dynamically inserted here -->
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>About MediCare</h3>
                    <p>We are committed to providing the highest quality healthcare services with our team of experienced specialists.</p>
                </div>
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <a href="#">Home</a>
                    <a href="#">Doctors</a>
                    <a href="#">Services</a>
                    <a href="#">Appointments</a>
                </div>
                <div class="footer-section">
                    <h3>Contact Us</h3>
                    <p><i class="fas fa-map-marker-alt"></i> 123 Healthcare Ave, Medical City</p>
                    <p><i class="fas fa-phone"></i> +1 (555) 123-4567</p>
                    <p><i class="fas fa-envelope"></i> info@medicare.com</p>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2023 MediCare. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Database simulation using localStorage
        class Database {
            constructor() {
                this.doctorsKey = 'medicare_doctors';
                this.appointmentsKey = 'medicare_appointments';
                this.patientsKey = 'medicare_patients';
                this.init();
            }

            init() {
                // Initialize with sample data if not exists
                if (!localStorage.getItem(this.doctorsKey)) {
                    this.initializeDoctors();
                }
                
                if (!localStorage.getItem(this.patientsKey)) {
                    this.initializePatients();
                }
                
                if (!localStorage.getItem(this.appointmentsKey)) {
                    localStorage.setItem(this.appointmentsKey, JSON.stringify([]));
                }
            }

            initializeDoctors() {
                const doctors = [
                    {
                        id: 1,
                        name: "Dr. Sarah Johnson",
                        department: "Cardiology",
                        education: "MD from Harvard Medical School, Fellowship in Cardiology at Johns Hopkins",
                        experience: "15 years of experience in cardiology, specialized in interventional procedures",
                        visitingCharge: "$200",
                        location: "Main Hospital, Floor 3, Room 305",
                        timing: "Mon, Wed, Fri: 9:00 AM - 5:00 PM",
                        contact: "+1 (555) 123-4567",
                        email: "s.johnson@medicare.com",
                        img: "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80",
                        rating: "4.9"
                    },
                    {
                        id: 2,
                        name: "Dr. Michael Chen",
                        department: "Neurology",
                        education: "MD from Stanford University, Neurology Residency at Mayo Clinic",
                        experience: "12 years of experience, specialized in neurodegenerative disorders",
                        visitingCharge: "$180",
                        location: "Neuro Center, Building B, Room 102",
                        timing: "Tue, Thu, Sat: 10:00 AM - 6:00 PM",
                        contact: "+1 (555) 234-5678",
                        email: "m.chen@medicare.com",
                        img: "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80",
                        rating: "4.8"
                    },
                    {
                        id: 3,
                        name: "Dr. Emily Rodriguez",
                        department: "Pediatrics",
                        education: "MD from University of California, Pediatric Residency at Boston Children's Hospital",
                        experience: "10 years of experience in pediatric care and adolescent medicine",
                        visitingCharge: "$150",
                        location: "Children's Wing, Floor 1, Room 115",
                        timing: "Mon-Fri: 8:00 AM - 4:00 PM",
                        contact: "+1 (555) 345-6789",
                        email: "e.rodriguez@medicare.com",
                        img: "https://images.unsplash.com/photo-1591604021695-0c69b7c05981?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80",
                        rating: "4.9"
                    },
                    {
                        id: 4,
                        name: "Dr. James Wilson",
                        department: "Orthopedics",
                        education: "MD from Duke University, Orthopedic Surgery Residency at Hospital for Special Surgery",
                        experience: "18 years of experience, specialized in joint replacement and sports injuries",
                        visitingCharge: "$220",
                        location: "Ortho Center, Building C, Room 210",
                        timing: "Mon, Wed, Fri: 8:00 AM - 4:00 PM; Tue, Thu: 1:00 PM - 7:00 PM",
                        contact: "+1 (555) 456-7890",
                        email: "j.wilson@medicare.com",
                        img: "https://images.unsplash.com/photo-1622253692010-333f2da6031d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80",
                        rating: "4.7"
                    },
                    {
                        id: 5,
                        name: "Dr. Lisa Thompson",
                        department: "Dermatology",
                        education: "MD from Yale School of Medicine, Dermatology Residency at NYU Langone",
                        experience: "14 years of experience, specialized in cosmetic and medical dermatology",
                        visitingCharge: "$190",
                        location: "Skin Health Center, Floor 2, Room 205",
                        timing: "Tue, Thu, Sat: 9:00 AM - 5:00 PM",
                        contact: "+1 (555) 567-8901",
                        email: "l.thompson@medicare.com",
                        img: "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80",
                        rating: "4.8"
                    },
                    {
                        id: 6,
                        name: "Dr. Robert Kim",
                        department: "Cardiology",
                        education: "MD from Johns Hopkins University, Cardiology Fellowship at Cleveland Clinic",
                        experience: "16 years of experience, specialized in electrophysiology",
                        visitingCharge: "$210",
                        location: "Heart Center, Floor 4, Room 410",
                        timing: "Mon, Wed, Fri: 10:00 AM - 6:00 PM",
                        contact: "+1 (555) 678-9012",
                        email: "r.kim@medicare.com",
                        img: "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80",
                        rating: "4.9"
                    }
                ];
                localStorage.setItem(this.doctorsKey, JSON.stringify(doctors));
            }

            initializePatients() {
                const patients = [
                    {
                        id: 1,
                        name: "John Smith",
                        email: "john@example.com",
                        password: "password123",
                        phone: "+1 (555) 111-2222"
                    },
                    {
                        id: 2,
                        name: "Emma Wilson",
                        email: "emma@example.com",
                        password: "password123",
                        phone: "+1 (555) 333-4444"
                    }
                ];
                localStorage.setItem(this.patientsKey, JSON.stringify(patients));
            }

            // Doctor methods
            getDoctors() {
                return new Promise((resolve) => {
                    setTimeout(() => {
                        const doctors = JSON.parse(localStorage.getItem(this.doctorsKey) || '[]');
                        resolve(doctors);
                    }, 500); // Simulate database delay
                });
            }

            getDoctorById(id) {
                return new Promise((resolve) => {
                    setTimeout(() => {
                        const doctors = JSON.parse(localStorage.getItem(this.doctorsKey) || '[]');
                        const doctor = doctors.find(d => d.id === parseInt(id));
                        resolve(doctor);
                    }, 300);
                });
            }

            // Patient methods
            getPatients() {
                return new Promise((resolve) => {
                    const patients = JSON.parse(localStorage.getItem(this.patientsKey) || '[]');
                    resolve(patients);
                });
            }

            validatePatient(email, password) {
                return new Promise((resolve) => {
                    setTimeout(() => {
                        const patients = JSON.parse(localStorage.getItem(this.patientsKey) || '[]');
                        const patient = patients.find(p => p.email === email && p.password === password);
                        resolve(patient);
                    }, 500);
                });
            }

            // Appointment methods
            getAppointments() {
                return new Promise((resolve) => {
                    const appointments = JSON.parse(localStorage.getItem(this.appointmentsKey) || '[]');
                    resolve(appointments);
                });
            }

            saveAppointment(appointment) {
                return new Promise((resolve) => {
                    setTimeout(() => {
                        const appointments = JSON.parse(localStorage.getItem(this.appointmentsKey) || '[]');
                        appointment.id = appointments.length > 0 ? Math.max(...appointments.map(a => a.id)) + 1 : 1;
                        appointments.push(appointment);
                        localStorage.setItem(this.appointmentsKey, JSON.stringify(appointments));
                        resolve(appointment);
                    }, 500);
                });
            }
        }

        // Dashboard Application
        class DashboardApp {
            constructor() {
                this.db = new Database();
                this.doctors = [];
                this.isLoggedIn = false;
                this.currentPatient = null;
                this.currentDoctorId = null;
                
                // DOM Elements
                this.doctorsContainer = document.getElementById('doctorsContainer');
                this.loginBtn = document.getElementById('loginBtn');
                this.logoutBtn = document.getElementById('logoutBtn');
                this.loginModal = document.getElementById('loginModal');
                this.appointmentModal = document.getElementById('appointmentModal');
                this.infoModal = document.getElementById('infoModal');
                this.loginForm = document.getElementById('loginForm');
                this.appointmentForm = document.getElementById('appointmentForm');
                this.doctorInfoContent = document.getElementById('doctorInfoContent');
                this.closeModalButtons = document.querySelectorAll('.close-modal');
                this.filterButtons = document.querySelectorAll('.filter-btn');
                this.searchInput = document.getElementById('searchInput');
                
                this.init();
            }

            async init() {
                await this.loadDoctors();
                this.setupEventListeners();
                this.checkLoginStatus();
            }

            async loadDoctors() {
                this.showLoading();
                this.doctors = await this.db.getDoctors();
                this.renderDoctors(this.doctors);
            }

            showLoading() {
                this.doctorsContainer.innerHTML = `
                    <div class="loading">
                        <i class="fas fa-spinner fa-spin"></i>
                        <p>Loading doctors...</p>
                    </div>
                `;
            }

            showNoResults() {
                this.doctorsContainer.innerHTML = `
                    <div class="no-results">
                        <i class="fas fa-user-md"></i>
                        <p>No doctors found matching your criteria.</p>
                    </div>
                `;
            }

            renderDoctors(doctorsArray) {
                if (doctorsArray.length === 0) {
                    this.showNoResults();
                    return;
                }

                this.doctorsContainer.innerHTML = '';
                
                doctorsArray.forEach(doctor => {
                    const doctorCard = document.createElement('div');
                    doctorCard.className = 'doctor-card';
                    doctorCard.innerHTML = `
                        <div class="doctor-header">
                            <img src="${doctor.img}" alt="${doctor.name}" class="doctor-img">
                            <div class="doctor-basic-info">
                                <h3 class="doctor-name">${doctor.name}</h3>
                                <p class="doctor-department">${doctor.department}</p>
                                <div class="doctor-rating">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                    ${doctor.rating}
                                </div>
                            </div>
                        </div>
                        <div class="doctor-details">
                            <div class="detail-item">
                                <i class="fas fa-graduation-cap detail-icon"></i>
                                <span class="detail-label">Education:</span>
                                <span>${doctor.education.substring(0, 60)}...</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-briefcase detail-icon"></i>
                                <span class="detail-label">Experience:</span>
                                <span>${doctor.experience.substring(0, 60)}...</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-dollar-sign detail-icon"></i>
                                <span class="detail-label">Fee:</span>
                                <span>${doctor.visitingCharge}</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-map-marker-alt detail-icon"></i>
                                <span class="detail-label">Location:</span>
                                <span>${doctor.location}</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-clock detail-icon"></i>
                                <span class="detail-label">Availability:</span>
                                <span>${doctor.timing}</span>
                            </div>
                        </div>
                        <div class="doctor-actions">
                            <button class="btn-action btn-info" data-id="${doctor.id}">
                                <i class="fas fa-info-circle"></i> Show Info
                            </button>
                            <button class="btn-action btn-book" data-id="${doctor.id}">
                                <i class="fas fa-calendar-plus"></i> Book Appointment
                            </button>
                        </div>
                    `;
                    this.doctorsContainer.appendChild(doctorCard);
                });
                
                // Update button states based on login status
                this.updateBookButtons();
                
                // Add event listeners to the buttons
                document.querySelectorAll('.btn-info').forEach(button => {
                    button.addEventListener('click', (e) => this.handleShowInfo(e));
                });
                
                document.querySelectorAll('.btn-book').forEach(button => {
                    button.addEventListener('click', (e) => this.handleBookAppointment(e));
                });
            }

            // Update book buttons based on login status
            updateBookButtons() {
                document.querySelectorAll('.btn-book').forEach(button => {
                    button.disabled = !this.isLoggedIn;
                });
            }

            setupEventListeners() {
                // Login button
                this.loginBtn.addEventListener('click', () => {
                    this.loginModal.style.display = 'flex';
                });
                
                // Logout button
                this.logoutBtn.addEventListener('click', () => this.handleLogout());
                
                // Close modal buttons
                this.closeModalButtons.forEach(button => {
                    button.addEventListener('click', () => {
                        this.loginModal.style.display = 'none';
                        this.appointmentModal.style.display = 'none';
                        this.infoModal.style.display = 'none';
                    });
                });
                
                // Login form submission
                this.loginForm.addEventListener('submit', (e) => this.handleLogin(e));
                
                // Appointment form submission
                this.appointmentForm.addEventListener('submit', (e) => this.handleAppointmentSubmit(e));
                
                // Filter buttons
                this.filterButtons.forEach(button => {
                    button.addEventListener('click', (e) => this.handleFilter(e));
                });
                
                // Search input
                this.searchInput.addEventListener('input', (e) => this.handleSearch(e));
                
                // Close modal when clicking outside
                window.addEventListener('click', (e) => {
                    if (e.target === this.loginModal) {
                        this.loginModal.style.display = 'none';
                    }
                    if (e.target === this.appointmentModal) {
                        this.appointmentModal.style.display = 'none';
                    }
                    if (e.target === this.infoModal) {
                        this.infoModal.style.display = 'none';
                    }
                });
            }

            checkLoginStatus() {
                const patient = JSON.parse(localStorage.getItem('currentPatient'));
                if (patient) {
                    this.isLoggedIn = true;
                    this.currentPatient = patient;
                    this.loginBtn.style.display = 'none';
                    this.logoutBtn.style.display = 'block';
                    this.updateBookButtons();
                }
            }

            async handleLogin(e) {
                e.preventDefault();
                const email = document.getElementById('email').value;
                const password = document.getElementById('password').value;
                
                const patient = await this.db.validatePatient(email, password);
                
                if (patient) {
                    this.isLoggedIn = true;
                    this.currentPatient = patient;
                    this.loginBtn.style.display = 'none';
                    this.logoutBtn.style.display = 'block';
                    this.loginModal.style.display = 'none';
                    
                    // Update book buttons
                    this.updateBookButtons();
                    
                    // Save login state
                    localStorage.setItem('currentPatient', JSON.stringify(patient));
                    
                    // Show success message
                    alert('Login successful! You can now book appointments.');
                } else {
                    alert('Invalid email or password. Please try again.');
                }
            }

            handleLogout() {
                this.isLoggedIn = false;
                this.currentPatient = null;
                this.loginBtn.style.display = 'block';
                this.logoutBtn.style.display = 'none';
                
                // Update book buttons
                this.updateBookButtons();
                
                // Remove login state
                localStorage.removeItem('currentPatient');
                
                alert('You have been logged out.');
            }

            async handleShowInfo(e) {
                const doctorId = parseInt(e.target.closest('.btn-info').getAttribute('data-id'));
                const doctor = await this.db.getDoctorById(doctorId);
                
                if (doctor) {
                    this.doctorInfoContent.innerHTML = `
                        <div class="info-section">
                            <h3>About Dr. ${doctor.name.split(' ')[2]}</h3>
                            <p>${doctor.name} is a specialist in ${doctor.department} with ${doctor.experience}.</p>
                        </div>
                        <div class="info-section">
                            <h3>Education</h3>
                            <p>${doctor.education}</p>
                        </div>
                        <div class="info-section">
                            <h3>Experience</h3>
                            <p>${doctor.experience}</p>
                        </div>
                        <div class="info-section">
                            <h3>Contact Details</h3>
                            <p><strong>Phone:</strong> ${doctor.contact}</p>
                            <p><strong>Email:</strong> ${doctor.email}</p>
                            <p><strong>Location:</strong> ${doctor.location}</p>
                        </div>
                        <div class="info-section">
                            <h3>Availability</h3>
                            <p>${doctor.timing}</p>
                        </div>
                        <div class="info-section">
                            <h3>Consultation Fee</h3>
                            <p>${doctor.visitingCharge} per visit</p>
                        </div>
                    `;
                    
                    this.infoModal.style.display = 'flex';
                }
            }

            handleBookAppointment(e) {
                if (!this.isLoggedIn) {
                    this.loginModal.style.display = 'flex';
                    return;
                }
                
                this.currentDoctorId = parseInt(e.target.closest('.btn-book').getAttribute('data-id'));
                
                document.getElementById('patientName').value = this.currentPatient.name;
                document.getElementById('patientEmail').value = this.currentPatient.email;
                document.getElementById('patientPhone').value = this.currentPatient.phone;
                document.getElementById('appointmentDate').value = '';
                document.getElementById('appointmentTime').value = '';
                document.getElementById('symptoms').value = '';
                
                this.appointmentModal.style.display = 'flex';
            }

            async handleAppointmentSubmit(e) {
                e.preventDefault();
                
                const patientName = document.getElementById('patientName').value;
                const patientEmail = document.getElementById('patientEmail').value;
                const patientPhone = document.getElementById('patientPhone').value;
                const appointmentDate = document.getElementById('appointmentDate').value;
                const appointmentTime = document.getElementById('appointmentTime').value;
                const symptoms = document.getElementById('symptoms').value;
                
                if (patientName && patientEmail && patientPhone && appointmentDate && appointmentTime) {
                    const doctor = await this.db.getDoctorById(this.currentDoctorId);
                    
                    const appointment = {
                        patientName,
                        patientEmail,
                        patientPhone,
                        appointmentDate,
                        appointmentTime,
                        symptoms,
                        doctorId: this.currentDoctorId,
                        doctorName: doctor.name,
                        department: doctor.department,
                        status: 'Pending'
                    };
                    
                    const savedAppointment = await this.db.saveAppointment(appointment);
                    
                    alert(`Appointment booked successfully with ${doctor.name} on ${appointmentDate} at ${appointmentTime}. A confirmation has been sent to ${patientEmail}. Your appointment ID is ${savedAppointment.id}.`);
                    
                    this.appointmentModal.style.display = 'none';
                } else {
                    alert('Please fill in all required fields');
                }
            }

            handleFilter(e) {
                // Remove active class from all buttons
                this.filterButtons.forEach(button => {
                    button.classList.remove('active');
                });
                
                // Add active class to clicked button
                e.target.classList.add('active');
                
                const department = e.target.textContent;
                
                if (department === 'All Specialties') {
                    this.renderDoctors(this.doctors);
                } else {
                    const filteredDoctors = this.doctors.filter(doctor => 
                        doctor.department === department
                    );
                    this.renderDoctors(filteredDoctors);
                }
            }

            handleSearch(e) {
                const searchTerm = e.target.value.toLowerCase();
                
                if (searchTerm === '') {
                    this.renderDoctors(this.doctors);
                    return;
                }
                
                const filteredDoctors = this.doctors.filter(doctor => 
                    doctor.name.toLowerCase().includes(searchTerm) ||
                    doctor.department.toLowerCase().includes(searchTerm) ||
                    doctor.education.toLowerCase().includes(searchTerm) ||
                    doctor.experience.toLowerCase().includes(searchTerm)
                );
                
                this.renderDoctors(filteredDoctors);
            }
        }

        // Initialize the dashboard when the page loads
        document.addEventListener('DOMContentLoaded', () => {
            new DashboardApp();
        });
    </script>
</body>
</html>