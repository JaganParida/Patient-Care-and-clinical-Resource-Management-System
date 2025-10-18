<%@page import="com.db.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Patient Care and Clinical Resource Management System</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/style.css">
<%@include file="component/allcss.jsp" %>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* Modern Light Theme Styling */
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
  --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  --radius: 12px;
}

* {
  box-sizing: border-box;
}

body {
  font-family: 'Inter', sans-serif;
  background-color: var(--white);
  color: var(--text);
  margin: 0;
  padding: 0;
  line-height: 1.6;
  overflow-x: hidden;
}

/* Headings */
h1, h2, h3, h5 {
  font-weight: 600;
  color: var(--dark);
  margin: 0 0 15px 0;
  line-height: 1.3;
}

h1 {
  font-size: 2.5rem;
}

h2 {
  font-size: 2rem;
  position: relative;
  display: inline-block;
  margin-bottom: 3rem;
}

h2:after {
  content: '';
  position: absolute;
  bottom: -10px;
  left: 0;
  width: 60px;
  height: 4px;
  background: var(--primary);
  border-radius: 2px;
}

h3 {
  font-size: 1.35rem;
}

/* Section Spacing */
section {
  padding: 80px 10%;
}

#section-header {
  text-align: center;
  margin-bottom: 60px;
}

#section-header h2:after {
  left: 50%;
  transform: translateX(-50%);
}

.section-subtitle {
  font-size: 1.1rem;
  color: var(--text-light);
  max-width: 600px;
  margin: 0 auto;
  line-height: 1.6;
}

/* Carousel */
.carousel {
  border-radius: var(--radius);
  overflow: hidden;
  box-shadow: var(--shadow-lg);
  margin-top: 76px; /* Account for fixed navbar */
}

.carousel-item {
  height: 600px;
  width: 100%;
}

.carousel-item img {
  height: 100%;
  width: 100%;
  object-fit: cover;
  border-radius: 0;
}

.carousel-control-prev,
.carousel-control-next {
  width: 50px;
  height: 50px;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 50%;
  top: 50%;
  transform: translateY(-50%);
  opacity: 0.8;
  transition: all 0.3s ease;
}

.carousel-control-prev {
  left: 20px;
}

.carousel-control-next {
  right: 20px;
}

.carousel-control-prev:hover,
.carousel-control-next:hover {
  opacity: 1;
  background: var(--white);
  box-shadow: var(--shadow);
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
  background-color: var(--primary);
  border-radius: 50%;
  width: 30px;
  height: 30px;
  background-size: 60%;
}


.carousel-indicators button {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background-color: var(--gray);
  margin: 0 5px;
}

.carousel-indicators button.active {
  background-color: var(--primary);
}

/* Updated Hero Section */
.hero {
  background: linear-gradient(135deg, 
    rgba(37, 99, 235, 0.93) 0%, 
    rgba(14, 165, 233, 0.90) 50%, 
    rgba(37, 99, 235, 0.85) 100%),
    url('https://images.unsplash.com/photo-1516549655669-dfbf54c5f2db?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGhvc3BpdGFsfGVufDB8fDB8fHww&auto=format&fit=crop&w=1200&q=60') center/cover no-repeat;
  color: var(--white);
  padding: 120px 10%;
  border-radius: var(--radius);
  margin: 60px 10% 40px;
  box-shadow: var(--shadow-lg);
  position: relative;
  overflow: hidden;
  min-height: 70vh;
  display: flex;
  align-items: center;
}

.hero::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: 
    radial-gradient(circle at 20% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
    radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
    radial-gradient(circle at 40% 40%, rgba(255, 255, 255, 0.05) 0%, transparent 50%);
  animation: pulse 8s ease-in-out infinite;
}

.hero-content {
  position: relative;
  z-index: 2;
  max-width: 1200px;
  margin: 0 auto;
  width: 100%;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: white;
  padding: 8px 20px;
  border-radius: 50px;
  font-size: 0.9rem;
  font-weight: 500;
  margin-bottom: 25px;
  animation: fadeInUp 0.8s ease-out 0.2s both;
}

.hero-badge i {
  margin-right: 8px;
  font-size: 1rem;
}

.hero-content h1 {
  font-size: 3.8rem;
  font-weight: 800;
  margin-bottom: 25px;
  color: var(--white);
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  line-height: 1.1;
  animation: fadeInUp 0.8s ease-out 0.4s both;
}

.hero-highlight {
  color: #fef08a;
  position: relative;
  display: inline-block;
}

.hero-highlight::after {
  content: '';
  position: absolute;
  bottom: 5px;
  left: 0;
  width: 100%;
  height: 8px;
  background: rgba(254, 240, 138, 0.3);
  z-index: -1;
  border-radius: 4px;
}

.hero-content p {
  font-size: 1.4rem;
  margin-bottom: 40px;
  max-width: 700px;
  opacity: 0.95;
  line-height: 1.6;
  font-weight: 400;
  animation: fadeInUp 0.8s ease-out 0.6s both;
}

.hero-actions {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  animation: fadeInUp 0.8s ease-out 0.8s both;
}

.btn-primary {
  background: var(--white);
  color: white;
  border: none;
  padding: 16px 40px;
  border-radius: 50px;
  text-decoration: none;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  font-weight: 600;
  font-size: 1.1rem;
  display: inline-flex;
  align-items: center;
  gap: 12px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  position: relative;
  overflow: hidden;
}

.btn-primary::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
  transition: left 0.7s ease;
}

.btn-primary:hover::before {
  left: 100%;
}

.btn-primary:hover {
  background: var(--gray-light);
  color: white;
  transform: translateY(-3px) scale(1.02);
  box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
}

.btn-secondary {
  background: transparent;
  color: var(--white);
  border: 2px solid rgba(255, 255, 255, 0.3);
  padding: 16px 40px;
  border-radius: 50px;
  text-decoration: none;
  transition: all 0.4s ease;
  font-weight: 600;
  font-size: 1.1rem;
  display: inline-flex;
  align-items: center;
  gap: 12px;
  backdrop-filter: blur(10px);
}

.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-3px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.hero-features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 30px;
  margin-top: 60px;
  animation: fadeInUp 0.8s ease-out 1s both;
}

.hero-feature {
  display: flex;
  align-items: center;
  gap: 15px;
  padding: 15px;
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.15);
  transition: all 0.3s ease;
}

.hero-feature:hover {
  background: rgba(255, 255, 255, 0.15);
  transform: translateY(-5px);
}

.feature-icon {
  width: 50px;
  height: 50px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.3rem;
}

.feature-text {
  flex: 1;
}

.feature-text h4 {
  margin: 0 0 5px 0;
  font-size: 1rem;
  font-weight: 600;
  color: white;
}

.feature-text p {
  margin: 0;
  font-size: 0.85rem;
  opacity: 0.9;
  line-height: 1.4;
}

/* Animations */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.8;
  }
}

/* Updated Services Section */
.services {
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
  text-align: center;
  position: relative;
  overflow: hidden;
}

.services::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" fill="none"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="%23e2e8f0" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
  opacity: 0.3;
}

.service-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  position: relative;
  z-index: 2;
}

.service-card {
  background: var(--white);
  border-radius: 16px;
  padding: 40px 30px;
  text-align: center;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  border: 1px solid transparent;
  position: relative;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.service-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
  opacity: 0;
  transition: opacity 0.4s ease;
  z-index: 1;
}

.service-card::after {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.7s ease;
  z-index: 2;
}

.service-card:hover::after {
  left: 100%;
}

.service-card:hover {
  transform: translateY(-12px);
  box-shadow: 0 20px 40px rgba(37, 99, 235, 0.15);
  border-color: var(--primary-light);
}

.service-card:hover::before {
  opacity: 0.03;
}

.service-icon {
  width: 80px;
  height: 80px;
  margin: 0 auto 25px;
  background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  z-index: 3;
  transition: all 0.4s ease;
}

.service-card:hover .service-icon {
  transform: scale(1.1) rotate(5deg);
  box-shadow: 0 10px 20px rgba(37, 99, 235, 0.2);
}

.service-icon i {
  font-size: 2rem;
  color: white;
}

.service-card h3 {
  color: var(--dark);
  margin-bottom: 18px;
  font-size: 1.4rem;
  font-weight: 600;
  position: relative;
  z-index: 3;
  transition: color 0.3s ease;
}

.service-card:hover h3 {
  color: var(--primary-dark);
}

.service-card p {
  font-size: 1rem;
  line-height: 1.7;
  color: var(--text-light);
  margin-bottom: 25px;
  flex-grow: 1;
  position: relative;
  z-index: 3;
  transition: color 0.3s ease;
}

.service-link {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  color: var(--primary);
  font-weight: 600;
  text-decoration: none;
  position: relative;
  z-index: 3;
  transition: all 0.3s ease;
  margin-top: auto;
}

.service-link i {
  transition: transform 0.3s ease;
}

.service-link:hover {
  color: var(--primary-dark);
  gap: 12px;
}

.service-link:hover i {
  transform: translateX(4px);
}

/* Stats Section */
.stats {
  background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
  color: var(--white);
  padding: 80px 10%;
  text-align: center;
  position: relative;
  overflow: hidden;
}

.stats::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" fill="none"><circle cx="50" cy="50" r="2" fill="%23ffffff" opacity="0.1"/></svg>');
  background-size: 50px 50px;
}

.stats-container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 40px;
  position: relative;
  z-index: 2;
}

.stat-item {
  padding: 20px;
}

.stat-item h3 {
  font-size: 3rem;
  margin-bottom: 10px;
  color: var(--white);
  font-weight: 700;
}

.stat-item p {
  font-size: 1.1rem;
  opacity: 0.9;
  font-weight: 500;
}

/* Our Team Section */
.team {
  background-color: var(--white);
  text-align: center;
}

.team-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 30px;
}

.team-card {
  background: var(--white);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  transition: all 0.3s ease;
  overflow: hidden;
  border: 1px solid var(--gray-light);
  position: relative;
}

.team-card:hover {
  transform: translateY(-10px);
  box-shadow: var(--shadow-lg);
}

.team-card img {
  width: 100%;
  height: 320px;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.team-card:hover img {
  transform: scale(1.05);
}

.team-card-content {
  padding: 25px 20px;
  background: var(--white);
}

.team-card h5 {
  color: var(--dark);
  font-size: 1.2rem;
  margin: 0 0 5px 0;
}

.team-card p {
  color: var(--primary);
  font-size: 0.9rem;
  margin: 0;
  font-weight: 500;
}

/* About Section */
.about {
  background: var(--light);
  text-align: center;
}

.about p {
  text-align: justify;
  max-width: 900px;
  margin: 15px auto;
  font-size: 1rem;
  line-height: 1.8;
  color: var(--text);
}

.about-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 50px;
  align-items: center;
}

.about-text {
  text-align: left;
}

.about-image {
  border-radius: var(--radius);
  overflow: hidden;
  box-shadow: var(--shadow-lg);
  transition: transform 0.3s ease;
}

.about-image:hover {
  transform: scale(1.02);
}

.about-image img {
  width: 100%;
  height: auto;
  display: block;
}

/* Responsive Design */
@media (max-width: 1200px) {
  section {
    padding: 80px 5%;
  }
  
  .hero {
    margin: 60px 5% 40px;
  }
  
  .service-cards {
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  }
  
  .hero-content h1 {
    font-size: 3.2rem;
  }
}

@media (max-width: 992px) {
  .hero-content h1 { 
    font-size: 2.8rem; 
  }
  
  .hero-content p { 
    font-size: 1.2rem; 
  }
  
  .about-content {
    grid-template-columns: 1fr;
    gap: 40px;
  }
  
  .about-text {
    text-align: center;
  }
  
  h1 {
    font-size: 2.2rem;
  }
  
  h2 {
    font-size: 1.8rem;
  }
  
  .carousel-item {
    height: 500px;
  }
  
  .hero-features {
    grid-template-columns: 1fr 1fr;
  }
}

@media (max-width: 768px) {
  section { 
    padding: 60px 5%; 
  }
  
  .team-cards, .service-cards { 
    grid-template-columns: 1fr; 
  }
  
  .carousel-item {
    height: 400px;
  }
  
  .hero {
    padding: 80px 5%;
    margin: 40px 5% 20px;
    min-height: 60vh;
  }
  
  .hero-content h1 {
    font-size: 2.5rem;
  }
  
  .service-card {
    padding: 30px 20px;
  }
  
  .service-icon {
    width: 70px;
    height: 70px;
    margin-bottom: 20px;
  }
  
  .service-icon i {
    font-size: 1.8rem;
  }
  
  .hero-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .btn-primary, .btn-secondary {
    width: 100%;
    justify-content: center;
  }
  
  .hero-features {
    grid-template-columns: 1fr;
    margin-top: 40px;
  }
}

@media (max-width: 480px) {
  .hero-content h1 { 
    font-size: 2.2rem; 
  }
  
  .hero-content p { 
    font-size: 1.1rem; 
  }
  
  .btn-primary, .btn-secondary { 
    padding: 14px 30px; 
    font-size: 1rem; 
  }
  
  .carousel-item {
    height: 300px;
  }
  
  h1 {
    font-size: 2rem;
  }
  
  h2 {
    font-size: 1.6rem;
  }
  
  .service-card {
    padding: 25px 20px;
  }
  
  .service-icon {
    width: 60px;
    height: 60px;
    margin-bottom: 15px;
  }
  
  .service-icon i {
    font-size: 1.5rem;
  }
  
  .service-card h3 {
    font-size: 1.2rem;
  }
  
  .stats-container {
    grid-template-columns: 1fr 1fr;
    gap: 20px;
  }
  
  .stat-item h3 {
    font-size: 2.2rem;
  }
}
</style>
</head>
<body>

<%@include file="component/navbar.jsp" %>

<!-- Carousel -->
<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3"></button>
  </div>

  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="https://plus.unsplash.com/premium_photo-1681843126728-04eab730febe?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1600" alt="Modern Hospital Facility">
    </div>
    <div class="carousel-item">
      <img src="https://plus.unsplash.com/premium_photo-1661627136784-ff7e699dbf3f?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTA0fHxob3NwaXRhbHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&q=60&w=1600" alt="Emergency Department">
    </div>
    <div class="carousel-item">
      <img src="https://plus.unsplash.com/premium_photo-1675686363507-22a8d0e11b4c?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1600" alt="Medical Technology">
    </div>
    <div class="carousel-item">
      <img src="https://images.unsplash.com/photo-1629909613654-28e377c37b09?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjd8fGhvc3BpdGFsfGVufDB8fDB8fHww&auto=format&fit=crop&q=60&w=1600" alt="Patient Care">
    </div>
  </div>

  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
  </button>
</div>

<!-- Stats Section -->
<section class="stats">
  <div class="stats-container">
    <div class="stat-item">
      <h3>10,000+</h3>
      <p>Patients Treated</p>
    </div>
    <div class="stat-item">
      <h3>200+</h3>
      <p>Medical Professionals</p>
    </div>
    <div class="stat-item">
      <h3>50+</h3>
      <p>Specialties</p>
    </div>
    <div class="stat-item">
      <h3>24/7</h3>
      <p>Emergency Services</p>
    </div>
  </div>
</section>

<!-- Services Section -->
<section class="services">
  <div id="section-header">
    <h2>Our Premium Services</h2>
    <p class="section-subtitle">Comprehensive healthcare solutions with cutting-edge technology and compassionate care</p>
  </div>
  <div class="service-cards">
    <div class="service-card">
      <div class="service-icon">
        <i class="fa-solid fa-bed-pulse"></i>
      </div>
      <h3>Inpatient Services</h3>
      <p>Comfortable and modern inpatient care facilities with personalized attention and 24/7 monitoring.</p>
      <a href="#" class="service-link">Learn More <i class="fa-solid fa-arrow-right"></i></a>
    </div>
    
    <div class="service-card">
      <div class="service-icon">
        <i class="fa-solid fa-truck-medical"></i>
      </div>
      <h3>Emergency Care</h3>
      <p>24/7 emergency support with dedicated medical staff, advanced equipment and rapid response teams.</p>
      <a href="#" class="service-link">Learn More <i class="fa-solid fa-arrow-right"></i></a>
    </div>
    
    <div class="service-card">
      <div class="service-icon">
        <i class="fa-solid fa-microscope"></i>
      </div>
      <h3>Medical Research</h3>
      <p>Advanced research center for developing innovative medical solutions and breakthrough treatments.</p>
      <a href="#" class="service-link">Learn More <i class="fa-solid fa-arrow-right"></i></a>
    </div>
    
    <div class="service-card">
      <div class="service-icon">
        <i class="fa-solid fa-shield-heart"></i>
      </div>
      <h3>Patient Safety</h3>
      <p>Ensuring safety with top-quality healthcare standards, protocols and infection control measures.</p>
      <a href="#" class="service-link">Learn More <i class="fa-solid fa-arrow-right"></i></a>
    </div>
    
    <div class="service-card">
      <div class="service-icon">
        <i class="fa-solid fa-user-doctor"></i>
      </div>
      <h3>Expert Doctors</h3>
      <p>Compassionate and experienced doctors across all medical specialties with proven track records.</p>
      <a href="#" class="service-link">Learn More <i class="fa-solid fa-arrow-right"></i></a>
    </div>
    
    <div class="service-card">
      <div class="service-icon">
        <i class="fa-solid fa-broom"></i>
      </div>
      <h3>Clean Environment</h3>
      <p>Maintaining highest hygiene standards and providing healthy, nutritious meals for all patients.</p>
      <a href="#" class="service-link">Learn More <i class="fa-solid fa-arrow-right"></i></a>
    </div>
    
    <div class="service-card">
      <div class="service-icon">
        <i class="fa-solid fa-stethoscope"></i>
      </div>
      <h3>Outpatient Care</h3>
      <p>Comprehensive range of outpatient treatments, consultations and follow-up care services.</p>
      <a href="#" class="service-link">Learn More <i class="fa-solid fa-arrow-right"></i></a>
    </div>
    
    <div class="service-card">
      <div class="service-icon">
        <i class="fa-solid fa-pills"></i>
      </div>
      <h3>Pharmacy Services</h3>
      <p>Fully-stocked pharmacy with licensed pharmacists providing medication guidance and support.</p>
      <a href="#" class="service-link">Learn More <i class="fa-solid fa-arrow-right"></i></a>
    </div>
  </div>
</section>

<!-- Updated Hero Section -->
<section class="hero">
  <div class="hero-content">
    <div class="hero-badge">
      <i class="fa-solid fa-star"></i>
      Trusted Healthcare Provider Since 2005
    </div>
    
    <h1>
      Your Health, <span class="hero-highlight">Our Priority</span>
    </h1>
    
    <p>
      Delivering compassionate, quality healthcare for every patient with state-of-the-art facilities and expert medical professionals dedicated to your well-being.
    </p>
    
    <div class="hero-actions">
      <a href="user_appointment.jsp" class="btn-primary">
        <i class="fa-solid fa-calendar-check"></i>
        Book an Appointment
      </a>
      <a href="#" class="btn-secondary">
        <i class="fa-solid fa-circle-info"></i>
        Learn More
      </a>
    </div>
    
    <div class="hero-features">
      <div class="hero-feature">
        <div class="feature-icon">
          <i class="fa-solid fa-clock"></i>
        </div>
        <div class="feature-text">
          <h4>24/7 Emergency</h4>
          <p>Round the clock care</p>
        </div>
      </div>
      
      <div class="hero-feature">
        <div class="feature-icon">
          <i class="fa-solid fa-user-md"></i>
        </div>
        <div class="feature-text">
          <h4>Expert Doctors</h4>
          <p>Specialized professionals</p>
        </div>
      </div>
      
      <div class="hero-feature">
        <div class="feature-icon">
          <i class="fa-solid fa-shield-alt"></i>
        </div>
        <div class="feature-text">
          <h4>Safe & Secure</h4>
          <p>Patient safety first</p>
        </div>
      </div>
      
      <div class="hero-feature">
        <div class="feature-icon">
          <i class="fa-solid fa-award"></i>
        </div>
        <div class="feature-text">
          <h4>Quality Care</h4>
          <p>Certified excellence</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Our Team Section -->
<section class="team">
  <div class="section-header">
    <h2>Our Medical Team</h2>
    <p class="section-subtitle">Meet our dedicated healthcare professionals committed to your well-being</p>
  </div>
  <div class="team-cards">
    <div class="team-card">
      <img src="https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZG9jdG9yfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60" alt="CEO">
      <div class="team-card-content">
        <h5>Dr. Sarah Johnson</h5>
        <p>Chief Executive Officer</p>
      </div>
    </div>
    <div class="team-card">
      <img src="https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZG9jdG9yfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60" alt="Chief Doctor">
      <div class="team-card-content">
        <h5>Dr. Michael Chen</h5>
        <p>Chief Medical Officer</p>
      </div>
    </div>
    <div class="team-card">
      <img src="https://images.unsplash.com/photo-1591604021695-0c69b7c05981?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8ZG9jdG9yfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60" alt="Chief Doctor">
      <div class="team-card-content">
        <h5>Dr. Emily Rodriguez</h5>
        <p>Head of Cardiology</p>
      </div>
    </div>
    <div class="team-card">
      <img src="https://images.unsplash.com/photo-1582750433449-648ed127bb54?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGRvY3RvcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=600&q=60" alt="Chief Doctor">
      <div class="team-card-content">
        <h5>Dr. James Wilson</h5>
        <p>Head of Neurology</p>
      </div>
    </div>
  </div>
</section>

<!-- About Section -->
<section class="about">
  <div class="section-header">
    <h2>About Our Hospital</h2>
  </div>
  <div class="about-content">
    <div class="about-text">
      <p>Our hospital is committed to delivering exceptional healthcare with expert staff and modern facilities. We prioritize patient care and continuously strive to improve medical outcomes through innovation and compassion.</p>
      <p>We are a trusted healthcare provider across India and overseas, ensuring accessible and affordable medical services for all. Our team of specialists works collaboratively to provide comprehensive care tailored to individual needs.</p>
      <p>Robust security protocols safeguard all patient information and maintain confidentiality. We utilize advanced technology to ensure data protection while delivering seamless healthcare experiences.</p>
      <p>Our integrated system ensures smooth coordination between departments and effortless patient management, resulting in efficient and effective healthcare delivery.</p>
    </div>
    <div class="about-image">
      <img src="https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGhvc3BpdGFsJTIwaW50ZXJpb3J8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60" alt="Hospital Interior">
    </div>
  </div>
</section>

<%@include file="component/footer.jsp" %>
</body>
</html>