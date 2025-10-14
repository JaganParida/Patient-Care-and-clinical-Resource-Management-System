<%@page import="com.db.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Patient Care and Clinical Resource Management System</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/style.css">
<%@include file="component/allcss.jsp" %>

<style>
/* Base Dark Mode Styling */
body {
  font-family: 'Poppins', sans-serif;
  background-color: #121212;
  color: #e0e0e0;
  margin: 0;
  padding: 0;
  overflow-x: hidden;
}

/* Headings */
h1, h2, h3, h5 {
  font-weight: 600;
  color: #ffffff;
  margin: 0 0 15px 0;
}

/* Section Spacing */
section {
  padding: 80px 10%;
}

/* Carousel */
.carousel-item {
  height: 500px;
  width: 100%;
}
.carousel-item img {
  height: 100%;
  width: 100%;
  object-fit: cover;
  border-radius: 0;
}
.carousel-control-prev-icon,
.carousel-control-next-icon {
  background-color: rgba(255, 255, 255, 0.4);
  border-radius: 50%;
  width: 50px;
  height: 50px;
}

/* Services Section */
.services {
  background: #1e1e1e;
  text-align: center;
}
.services h2 {
  color: #00a8ff;
  font-size: 2.5rem;
  margin-bottom: 50px;
}
.service-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 30px;
}
.service-cards .card {
  background: #2a2a2a;
  border-radius: 15px;
  padding: 30px 20px;
  text-align: center;
  box-shadow: 0 8px 20px rgba(0,0,0,0.5);
  transition: all 0.3s ease;
}
.service-cards .card:hover {
  transform: translateY(-10px);
  box-shadow: 0 12px 25px rgba(0,0,0,0.7);
}
.service-cards .card h3 {
  color: #00a8ff;
  margin-bottom: 12px;
  font-size: 1.35rem;
}
.service-cards .card p {
  font-size: 1rem;
  line-height: 1.8;
  color: #ccc;
}

/* Our Team Section */
.serv {
  background-color: #1a1a1a;
  text-align: center;
}
.serv h1 {
  color: #00a8ff;
  font-size: 2.5rem;
  margin-bottom: 50px;
}
.serv-cards {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 30px;
}
.cards {
  background: #2a2a2a;
  border-radius: 15px;
  box-shadow: 0 6px 18px rgba(0,0,0,0.5);
  width: 280px;
  transition: all 0.3s ease;
  overflow: hidden;
}
.cards:hover {
  transform: translateY(-8px);
  box-shadow: 0 10px 25px rgba(0,0,0,0.7);
}
.cards img {
  width: 100%;
  height: 350px;
  object-fit: cover;
}
.cards h5 {
  padding: 20px 10px;
  color: #00a8ff;
  font-size: 1.1rem;
  margin: 0;
}

/* Hero Section */
.hero {
  background: linear-gradient(to right, rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
              url('img/hosp1.jpg') center/cover no-repeat;
  color: #ffffff;
  text-align: center;
  padding: 120px 10%;
}
.hero-content h1 {
  font-size: 3rem;
  font-weight: 700;
  margin-bottom: 20px;
}
.hero-content p {
  font-size: 1.2rem;
  margin-bottom: 40px;
}
.btn-primary {
  background: #00a8ff;
  color: #fff;
  border: none;
  padding: 15px 35px;
  border-radius: 10px;
  text-decoration: none;
  transition: all 0.3s ease;
  font-weight: 600;
  font-size: 1rem;
}
.btn-primary:hover {
  background: #0077cc;
  box-shadow: 0 5px 20px rgba(0, 119, 204, 0.5);
}

/* About Section */
.about {
  background: #1e1e1e;
  text-align: center;
}
.about h2 {
  color: #00a8ff;
  font-size: 2.3rem;
  margin-bottom: 35px;
}
.about p {
  text-align: justify;
  max-width: 900px;
  margin: 15px auto;
  font-size: 1rem;
  line-height: 1.8;
  color: #ccc;
}

/* Responsive Design */
@media (max-width: 992px) {
  .hero-content h1 { font-size: 2.5rem; }
  .hero-content p { font-size: 1.1rem; }
  .cards { width: 45%; }
}
@media (max-width: 768px) {
  section { padding: 60px 5%; }
  .cards { width: 100%; }
  .service-cards { grid-template-columns: 1fr; }
}
@media (max-width: 480px) {
  .hero-content h1 { font-size: 2rem; }
  .hero-content p { font-size: 1rem; }
  .btn-primary { padding: 12px 25px; font-size: 0.95rem; }
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
    <div class="carousel-item active"><img src="https://plus.unsplash.com/premium_photo-1681843126728-04eab730febe?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDV8fGhvc3BpdGFsfGVufDB8fDB8fHww&auto=format&fit=crop&q=60&w=600" alt="Hospital Image"></div>
    <div class="carousel-item"><img src="https://plus.unsplash.com/premium_photo-1681843111851-7dc6d4147e13?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTUzfHxob3NwaXRhbHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&q=60&w=600" alt="Hospital Image"></div>
    <div class="carousel-item"><img src="https://images.unsplash.com/photo-1599700403969-f77b3aa74837?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nzh8fGhvc3BpdGFsfGVufDB8fDB8fHww&auto=format&fit=crop&q=60&w=600" alt="Hospital Image"></div>
    <div class="carousel-item"><img src="img/po.jpg" alt="Hospital Image"></div>
  </div>

  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
  </button>
</div>

<!-- Services Section -->
<section class="services">
  <h2>Our Services</h2>
  <div class="service-cards">
    <div class="card"><h3>Inpatient Services</h3><p>Comfortable and modern inpatient care facilities.</p></div>
    <div class="card"><h3>Emergency Services</h3><p>24/7 emergency support with dedicated medical staff.</p></div>
    <div class="card"><h3>Medical Research</h3><p>Advanced research center for new medical solutions.</p></div>
    <div class="card"><h3>100% Safety</h3><p>Ensuring safety with top-quality healthcare standards.</p></div>
    <div class="card"><h3>Friendly Doctors</h3><p>Expert and compassionate doctors across all fields.</p></div>
    <div class="card"><h3>Clean Environment</h3><p>Maintaining hygiene and healthy meals for all patients.</p></div>
    <div class="card"><h3>Outpatient Services</h3><p>Wide range of outpatient treatments available.</p></div>
  </div>
</section>

<!-- Our Team Section -->
<section class="serv">
  <h1>Our Team</h1>
  <div class="serv-cards">
    <div class="cards"><img src="img/doc3.jpg" alt="CEO"><h5>CEO</h5></div>
    <div class="cards"><img src="img/doc2.png" alt="Chief Doctor"><h5>Chief Doctor</h5></div>
    <div class="cards"><img src="img/doc1.jpg" alt="Chief Doctor"><h5>Chief Doctor</h5></div>
    <div class="cards"><img src="img/doc5.png" alt="Chief Doctor"><h5>Chief Doctor</h5></div>
    <div class="cards"><img src="img/pos.jpeg" alt="Chief Doctor"><h5>Chief Doctor</h5></div>
    <div class="cards"><img src="img/w-1.png" alt="Chief Doctor"><h5>Chief Doctor</h5></div>
  </div>
</section>

<!-- Hero Section -->
<section class="hero">
  <div class="hero-content">
    <h1>Your Health, Our Priority</h1>
    <p>Delivering compassionate, quality healthcare for every patient.</p>
    <a href="user_appointment.jsp" class="btn-primary">Book an Appointment</a>
  </div>
</section>

<!-- About Section -->
<section class="about">
  <h2>About Our Hospital</h2>
  <p>Our hospital is committed to delivering exceptional healthcare with expert staff and modern facilities.</p>
  <p>We are a trusted provider across India and overseas, ensuring accessible and affordable medical services.</p>
  <p>Robust security protocols safeguard all patient information and maintain confidentiality.</p>
  <p>Our integrated system ensures smooth coordination between departments and effortless patient management.</p>
</section>

<%@include file="component/footer.jsp" %>
</body>
</html>
