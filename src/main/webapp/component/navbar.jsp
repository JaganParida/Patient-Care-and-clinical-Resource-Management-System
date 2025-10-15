<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
  <div class="container">

    <!-- Brand -->
    <a class="navbar-brand fw-bold d-flex align-items-center" href="index.jsp">
      <i class="fa-solid fa-hospital me-2 text-primary"></i> 
      <span class="text-dark">Patient Care</span>
    </a>

    <!-- Toggler for mobile -->
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
      aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Navbar Links -->
    <div class="collapse navbar-collapse" id="navbarContent">
      <ul class="navbar-nav ms-auto align-items-lg-center">

        <!-- Guest Links -->
        <c:if test="${empty userObj}">
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-dark position-relative" href="admin.jsp">
              <i class="fa-solid fa-user-shield me-1"></i> Admin
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-dark position-relative" href="doctor.jsp">
              <i class="fa-solid fa-user-doctor me-1"></i> Doctor
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-dark position-relative" href="user_appointment.jsp">
              <i class="fa-solid fa-calendar-check me-1"></i> Appointment
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-primary position-relative" href="user_Login.jsp">
              <i class="fa-solid fa-right-to-bracket me-1"></i> User Login
            </a>
          </li>
        </c:if>

        <!-- Logged-in User Links -->
        <c:if test="${not empty userObj}">
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-dark position-relative" href="user_appointment.jsp">
              <i class="fa-solid fa-calendar-plus me-1"></i> Appointment
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-dark position-relative" href="view_appointment.jsp">
              <i class="fa-solid fa-eye me-1"></i> View Appointments
            </a>
          </li>

          <!-- Dropdown -->
          <li class="nav-item dropdown mx-2">
            <a class="nav-link dropdown-toggle fw-medium text-dark d-flex align-items-center position-relative" 
               href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <i class="fa-regular fa-user me-1"></i> ${userObj.fullName}
            </a>
            <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3" aria-labelledby="userDropdown">
              <li>
                <a class="dropdown-item text-dark" href="change_password.jsp">
                  <i class="fa-solid fa-key me-2"></i> Change Password
                </a>
              </li>
              <li><hr class="dropdown-divider"></li>
              <li>
                <a class="dropdown-item text-danger" href="userLogout">
                  <i class="fa-solid fa-right-from-bracket me-2"></i> Logout
                </a>
              </li>
            </ul>
          </li>
        </c:if>

      </ul>
    </div>
  </div>
</nav>

<style>
/* Modern Light Theme Navbar */
.navbar {
  padding: 1rem 0;
  transition: all 0.3s ease;
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1030;
  backdrop-filter: blur(10px);
  background: rgba(255, 255, 255, 0.95) !important;
}

.navbar-brand {
  font-size: 1.5rem;
}

.navbar-brand i {
  font-size: 1.8rem;
}

.nav-link {
  font-size: 1rem;
  padding: 0.5rem 0.75rem;
  transition: all 0.3s ease;
  border-radius: 8px;
  position: relative;
  font-weight: 500;
}

.nav-link:not(.dropdown-toggle):after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  width: 0;
  height: 2px;
  background: #2563eb;
  transition: all 0.3s ease;
  transform: translateX(-50%);
}

.nav-link:hover:not(.dropdown-toggle):after,
.nav-link.active:after {
  width: 80%;
}

.nav-link:hover, .nav-link:focus {
  color: #2563eb !important;
  transform: translateY(-1px);
}

.nav-link.text-primary {
  background: linear-gradient(135deg, #2563eb, #3b82f6);
  color: white !important;
  border-radius: 8px;
  padding: 0.5rem 1.25rem;
  margin-left: 0.5rem;
  box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.2);
}

.nav-link.text-primary:hover {
  background: linear-gradient(135deg, #1d4ed8, #2563eb);
  transform: translateY(-2px);
  box-shadow: 0 6px 10px -1px rgba(37, 99, 235, 0.3);
}

.dropdown-menu {
  background: white !important;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  padding: 0.5rem 0;
  min-width: 200px;
  box-shadow: 0 10px 25px -3px rgba(0, 0, 0, 0.1);
  margin-top: 0.5rem;
}

.dropdown-item {
  transition: all 0.2s ease;
  border-radius: 6px;
  margin: 0.25rem 0.5rem;
  padding: 0.5rem 1rem;
  font-weight: 500;
}

.dropdown-item:hover, .dropdown-item:focus {
  background: #2563eb !important;
  color: white !important;
  transform: translateX(5px);
}

.navbar-toggler {
  border: none;
  padding: 0.25rem 0.5rem;
}

.navbar-toggler:focus {
  box-shadow: none;
}

.navbar-toggler-icon {
  background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%2837, 99, 235, 1%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
}

@media (max-width: 991px) {
  .navbar-nav {
    text-align: center;
    margin-top: 1rem;
    padding: 1rem 0;
  }
  
  .nav-item {
    margin: 0.5rem 0;
  }
  
  .nav-link.text-primary {
    margin: 0.5rem 0;
    display: inline-block;
    width: auto;
  }
  
  .dropdown-menu {
    text-align: center;
    border: none;
    box-shadow: none;
    background: #f8fafc !important;
  }
}
</style>