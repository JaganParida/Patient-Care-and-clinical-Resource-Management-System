<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@page isELIgnored="false" %>

    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
      <div class="container-fluid px-4">
        <!-- Brand -->
        <a class="navbar-brand fw-bold d-flex align-items-center" href="index.jsp">
          <i class="fa-solid fa-house-medical me-2 text-primary"></i>
          <span class="text-dark">MedCare Admin</span>
        </a>

        <!-- Toggler for mobile -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
          aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mx-auto align-items-lg-center">
            <!-- Main Navigation Links -->
            <li class="nav-item px-2">
              <a class="nav-link fw-medium text-dark position-relative" href="../index.jsp">
                <i class="fa-solid fa-house me-1"></i> Home
              </a>
            </li>
            <li class="nav-item px-2">
              <a class="nav-link fw-medium text-dark position-relative" href="doctor.jsp">
                <i class="fa-solid fa-user-doctor me-1"></i> Doctor
              </a>
            </li>
            <li class="nav-item px-2">
              <a class="nav-link fw-medium text-dark position-relative" href="view_doctor.jsp">
                <i class="fa-solid fa-list me-1"></i> View Doctor
              </a>
            </li>
            <li class="nav-item px-2">
              <a class="nav-link fw-medium text-dark position-relative" href="patient.jsp">
                <i class="fa-solid fa-user-injured me-1"></i> Patient
              </a>
            </li>
          </ul>

          <ul class="navbar-nav ms-auto align-items-lg-center">
            <!-- Admin Dropdown -->
            <li class="nav-item dropdown px-2 position-relative">
              <a class="nav-link dropdown-toggle fw-medium text-dark d-flex align-items-center position-relative admin-dropdown"
                href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <div class="user-avatar bg-warning rounded-circle d-flex align-items-center justify-content-center me-2"
                  style="width: 32px; height: 32px;">
                  <i class="fa-solid fa-user-shield text-white small fa-fw"></i>
                </div>
                <span class="user-name">Admin</span>
              </a>
              <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3 p-2"
                aria-labelledby="adminDropdown" style="min-width: 200px;">
                <li class="dropdown-header p-3">
                  <div class="d-flex align-items-center">
                    <div
                      class="user-avatar bg-warning rounded-circle d-flex align-items-center justify-content-center me-3"
                      style="width: 40px; height: 40px;">
                      <i class="fa-solid fa-user-shield text-white fa-fw"></i>
                    </div>
                    <div>
                      <div class="fw-bold">Administrator</div>
                      <small class="text-muted">System Admin</small>
                    </div>
                  </div>
                </li>
                <li>
                  <hr class="dropdown-divider my-2">
                </li>
                <li>
                  <a class="dropdown-item d-flex align-items-center text-dark p-2" href="#">
                    <i class="fa-solid fa-user me-2 fa-fw"></i> Admin Profile
                  </a>
                </li>
                <li>
                  <a class="dropdown-item d-flex align-items-center text-dark p-2" href="#">
                    <i class="fa-solid fa-cog me-2 fa-fw"></i> Settings
                  </a>
                </li>
                <li>
                  <hr class="dropdown-divider my-2">
                </li>
                <li>
                  <a class="dropdown-item d-flex align-items-center text-danger p-2" href="../adminLogout">
                    <i class="fa-solid fa-right-from-bracket me-2 fa-fw"></i> Logout
                  </a>
                </li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <style>
      /* Modern Light Theme Navbar */
      .navbar {
        padding: 0.6rem 0;
        transition: all 0.3s ease;
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1030;
        backdrop-filter: blur(10px);
        background: rgba(255, 255, 255, 0.98) !important;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
      }

      .navbar-brand {
        font-size: 1.6rem;
        font-weight: 700;
        padding: 0.5rem 0;
      }

      .navbar-brand i {
        font-size: 1.8rem;
      }

      .nav-link {
        font-size: 0.95rem;
        padding: 0.5rem 0.9rem !important;
        transition: all 0.3s ease;
        border-radius: 8px;
        position: relative;
        font-weight: 500;
        margin: 0 0.2rem;
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
        width: 70%;
      }

      .nav-link:hover,
      .nav-link:focus {
        color: #2563eb !important;
        transform: translateY(-1px);
      }

      /* Admin Dropdown */
      .admin-dropdown {
        padding: 0.5rem 0.8rem !important;
        border-radius: 8px;
        transition: all 0.3s ease;
        cursor: pointer;
        background: #f8fafc;
        border: 1px solid #e2e8f0;
      }

      .admin-dropdown:hover {
        background: #f1f5f9;
        border-color: #cbd5e1;
      }

      .user-avatar {
        font-size: 0.8rem;
      }

      .user-name {
        max-width: 150px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }

      /* Dropdown Menu Styling */
      .dropdown-menu {
        background: white !important;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        padding: 0.8rem 0;
        min-width: 200px;
        box-shadow: 0 10px 25px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        margin-top: 0.5rem !important;
        position: absolute !important;
        z-index: 1060;
      }

      .dropdown-menu.show {
        display: block;
      }

      .dropdown-header {
        font-size: 0.9rem;
        padding: 0.5rem 1.5rem;
      }

      .dropdown-item {
        transition: all 0.2s ease;
        border-radius: 8px;
        margin: 0.2rem 0.5rem;
        padding: 0.75rem 1rem;
        font-weight: 500;
        border: 1px solid transparent;
        display: flex;
        align-items: center;
        cursor: pointer;
      }

      .dropdown-item:hover,
      .dropdown-item:focus {
        background: #f8fafc !important;
        color: #1e293b !important;
        border-color: #e2e8f0;
        transform: translateX(5px);
      }

      /* Ensure all icons have proper spacing and fixed width */
      .navbar .fa-fw {
        width: 1.25em;
        text-align: center;
      }

      /* Navbar Toggler */
      .navbar-toggler {
        border: none;
        padding: 0.25rem 0.5rem;
        transition: all 0.3s ease;
      }

      .navbar-toggler:focus {
        box-shadow: none;
        background: #f1f5f9;
        border-radius: 6px;
      }

      .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%2837, 99, 235, 1%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        transition: all 0.3s ease;
      }

      /* Responsive Design */
      @media (max-width: 991px) {
        .navbar-nav {
          text-align: center;
          margin-top: 1rem;
          padding: 1rem 0;
        }

        .nav-item {
          margin: 0.4rem 0;
        }

        .admin-dropdown {
          margin: 0.5rem 0;
          display: inline-flex;
          width: auto;
          justify-content: center;
        }

        .dropdown-menu {
          text-align: left;
          border: 1px solid #e2e8f0;
          box-shadow: 0 10px 25px -3px rgba(0, 0, 0, 0.1);
          background: white !important;
          position: static !important;
          margin: 0.5rem auto;
          width: 90%;
        }

        .user-name {
          max-width: 150px;
        }

        .navbar-collapse {
          border-top: 1px solid #e2e8f0;
          margin-top: 0.5rem;
        }
      }

      @media (min-width: 992px) {
        .dropdown-menu {
          right: 0 !important;
          left: auto !important;
        }
      }

      @media (max-width: 576px) {
        .navbar-brand {
          font-size: 1.4rem;
        }

        .navbar-brand i {
          font-size: 1.6rem;
        }

        .nav-link {
          padding: 0.5rem 0.7rem !important;
          font-size: 0.9rem;
        }

        .container-fluid {
          padding-left: 1rem;
          padding-right: 1rem;
        }

        .dropdown-menu {
          width: 95%;
          margin: 0.5rem auto;
        }
      }

      /* Animation for dropdown */
      @keyframes fadeInUp {
        from {
          opacity: 0;
          transform: translate3d(0, 10px, 0);
        }

        to {
          opacity: 1;
          transform: translate3d(0, 0, 0);
        }
      }

      .dropdown-menu {
        animation: fadeInUp 0.3s ease;
      }

      /* Fix dropdown positioning for desktop */
      .navbar-nav .dropdown-menu {
        position: absolute;
      }

      .navbar-nav .dropdown {
        position: static;
      }

      /* Ensure dropdowns work properly with Bootstrap */
      .dropdown-toggle::after {
        display: inline-block;
        margin-left: 0.5em;
        vertical-align: middle;
      }

      /* Improved dropdown visibility */
      .dropdown-menu {
        z-index: 1060 !important;
      }

      .navbar-nav .nav-item.dropdown:hover .dropdown-menu {
        display: none;
      }

      .navbar-nav .nav-item.dropdown.show .dropdown-menu {
        display: block;
      }
    </style>

    <script>
      // Add smooth interactions - Click-based dropdown functionality
      document.addEventListener('DOMContentLoaded', function () {
        // Add active class to current page
        const currentPage = window.location.pathname.split('/').pop();
        const navLinks = document.querySelectorAll('.nav-link');

        navLinks.forEach(link => {
          if (link.getAttribute('href') === currentPage) {
            link.classList.add('active');
          }
        });

        // Close dropdowns when clicking outside
        document.addEventListener('click', function (e) {
          if (!e.target.closest('.dropdown')) {
            const openDropdowns = document.querySelectorAll('.dropdown-menu.show');
            openDropdowns.forEach(dropdown => {
              dropdown.classList.remove('show');
            });

            const dropdownToggles = document.querySelectorAll('.dropdown-toggle[aria-expanded="true"]');
            dropdownToggles.forEach(toggle => {
              toggle.setAttribute('aria-expanded', 'false');
            });
          }
        });

        // Handle dropdown toggle clicks
        const dropdownToggles = document.querySelectorAll('.dropdown-toggle');
        dropdownToggles.forEach(toggle => {
          toggle.addEventListener('click', function (e) {
            e.preventDefault();
            e.stopPropagation();

            const dropdownMenu = this.nextElementSibling;
            const isExpanded = this.getAttribute('aria-expanded') === 'true';

            // Close all other dropdowns
            document.querySelectorAll('.dropdown-menu.show').forEach(menu => {
              if (menu !== dropdownMenu) {
                menu.classList.remove('show');
              }
            });

            document.querySelectorAll('.dropdown-toggle[aria-expanded="true"]').forEach(toggle => {
              if (toggle !== this) {
                toggle.setAttribute('aria-expanded', 'false');
              }
            });

            // Toggle current dropdown
            if (dropdownMenu) {
              dropdownMenu.classList.toggle('show');
              this.setAttribute('aria-expanded', !isExpanded);
            }
          });
        });

        // Close dropdown when clicking on dropdown items (optional)
        const dropdownItems = document.querySelectorAll('.dropdown-item');
        dropdownItems.forEach(item => {
          item.addEventListener('click', function () {
            const dropdownMenu = this.closest('.dropdown-menu');
            if (dropdownMenu) {
              dropdownMenu.classList.remove('show');
            }

            const dropdownToggle = document.querySelector('.dropdown-toggle[aria-expanded="true"]');
            if (dropdownToggle) {
              dropdownToggle.setAttribute('aria-expanded', 'false');
            }
          });
        });
      });
    </script>