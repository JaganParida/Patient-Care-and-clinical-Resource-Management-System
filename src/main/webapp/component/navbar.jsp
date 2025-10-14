<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm sticky-top">
  <div class="container">

    <!-- Brand -->
    <a class="navbar-brand fw-bold d-flex align-items-center" href="index.jsp">
      <i class="fa-solid fa-hospital me-2"></i> Patient Care
    </a>

    <!-- Toggler for mobile -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
      aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Navbar Links -->
    <div class="collapse navbar-collapse" id="navbarContent">
      <ul class="navbar-nav ms-auto align-items-lg-center">

        <!-- Guest Links -->
        <c:if test="${empty userObj}">
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-light" href="admin.jsp">
              <i class="fa-solid fa-user-shield me-1"></i> Admin
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-light" href="doctor.jsp">
              <i class="fa-solid fa-user-doctor me-1"></i> Doctor
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-light" href="user_appointment.jsp">
              <i class="fa-solid fa-calendar-check me-1"></i> Appointment
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-light" href="user_Login.jsp">
              <i class="fa-solid fa-right-to-bracket me-1"></i> User Login
            </a>
          </li>
        </c:if>

        <!-- Logged-in User Links -->
        <c:if test="${not empty userObj}">
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-light" href="user_appointment.jsp">
              <i class="fa-solid fa-calendar-plus me-1"></i> Appointment
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link fw-medium text-light" href="view_appointment.jsp">
              <i class="fa-solid fa-eye me-1"></i> View Appointments
            </a>
          </li>

          <!-- Dropdown -->
          <li class="nav-item dropdown mx-2">
            <a class="nav-link dropdown-toggle fw-medium text-light d-flex align-items-center" href="#" id="userDropdown"
               role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <i class="fa-regular fa-user me-1"></i> ${userObj.fullName}
            </a>
            <ul class="dropdown-menu dropdown-menu-end shadow-lg bg-dark border-0 rounded-3" aria-labelledby="userDropdown">
              <li>
                <a class="dropdown-item text-light" href="change_password.jsp">
                  <i class="fa-solid fa-key me-2"></i> Change Password
                </a>
              </li>
              <li><hr class="dropdown-divider bg-secondary"></li>
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
/* Dark-Mode Modern Navbar */
.navbar {
  padding: 1rem 0;
  transition: all 0.3s ease;
  position:fixed;
  top:0;
  width:100%;
}

.navbar-brand {
  font-size: 1.4rem;
  color: #00a8ff !important;
}

.nav-link {
  font-size: 1rem;
  padding: 0.5rem 0.75rem;
  transition: all 0.2s ease-in-out;
  border-radius: 8px;
}

.nav-link:hover, .nav-link:focus {
  color: #00a8ff !important;
  background-color: rgba(0, 168, 255, 0.1);
  transform: translateY(-2px);
}

.dropdown-menu {
  background-color: #2a2a2a !important;
  color: #e0e0e0;
  border-radius: 10px;
  padding: 0.5rem 0;
  min-width: 200px;
}

.dropdown-item {
  transition: all 0.2s ease-in-out;
  border-radius: 5px;
}

.dropdown-item:hover, .dropdown-item:focus {
  background-color: #00a8ff !important;
  color: #fff !important;
}

.navbar-toggler {
  border-color: rgba(255,255,255,0.2);
}

.navbar-toggler-icon {
  filter: invert(1);
}

@media (max-width: 991px) {
  .navbar-nav {
    text-align: center;
    margin-top: 0.5rem;
  }
  .nav-item {
    margin: 0.5rem 0;
  }
}
</style>
