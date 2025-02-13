<%-- 
    Document   : admin-extension
    Created on : Feb 11, 2025, 5:04:16 PM
    Author     : rosha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
          <!-- ======= Header ======= -->
            <header id="header" class="header fixed-top d-flex align-items-center">

              <div class="d-flex align-items-center justify-content-between">
                <a href="AdminDashboardServlet" class="logo d-flex align-items-center">
                  <img src="assets/img/FloodAidLogo.png" alt="">
                  <span class="d-none d-lg-block">Banjir Rescue </span>
                </a>
                <i class="bi bi-list toggle-sidebar-btn"></i>
              </div><!-- End Logo -->

              <nav class="header-nav ms-auto">
                <ul class="d-flex align-items-center">

                  <li class="nav-item dropdown pe-3">

                    <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                      <img src="assets/img/default-profile.png" alt="Profile" class="rounded-circle">
                      <!-- <span class="d-none d-md-block dropdown-toggle ps-2">K. Anderson</span> -->
                    </a><!-- End Profile Iamge Icon -->

                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                      <li class="dropdown-header">
                        <h6><%= session.getAttribute("username") %></h6>
                        <span>Admin</span>
                      </li>
                      <li>
                        <hr class="dropdown-divider">
                      </li>

                      <li>
                        <a class="dropdown-item d-flex align-items-center" href="AdminProfileServlet">
                          <i class="bi bi-person"></i>
                          <span>My Profile</span>
                        </a>
                      </li>
                      <li>
                        <hr class="dropdown-divider">
                      </li>

                      <li>
                        <a class="dropdown-item d-flex align-items-center" href="LogoutServlet">
                          <i class="bi bi-box-arrow-right"></i>
                          <span>Log Out</span>
                        </a>
                      </li>

                    </ul><!-- End Profile Dropdown Items -->
                  </li><!-- End Profile Nav -->

                </ul>
              </nav><!-- End Icons Navigation -->

            </header>
        <!-- End Header -->

          <!-- ======= Sidebar ======= -->
          <aside id="sidebar" class="sidebar">

            <ul class="sidebar-nav" id="sidebar-nav">

              <li class="nav-item">
                <a class="nav-link collapsed" href="AdminDashboardServlet">
                  <i class="bi bi-grid"></i>
                  <span>Dashboard</span>
                </a>
              </li><!-- End Dashboard Nav -->

              <!-- Manage Signal Nav -->
              <li class="nav-item">
                <a class="nav-link collapsed" href="AdminSignalServlet">
                  <i class="bi bi-broadcast"></i>
                  <span>Manage Signal</span>
                </a>
              </li><!-- End Manage Signal Nav -->

              <!-- Manage Need Nav -->
              <li class="nav-item">
                <a class="nav-link collapsed" href="AdminNeedServlet">
                  <i class="bi bi-box-seam"></i>
                  <span>Manage Need</span>
                </a>
              </li><!-- End Manage Need Nav -->


              <!-- Manage Users Nav -->
              <li class="nav-item">
                <a class="nav-link collapsed" href="AdminUsersServlet">
                  <i class="bi bi-person-lines-fill"></i>
                  <span>Manage Users</span>
                </a>
              </li><!-- End Manage Users Nav -->

              <!-- <li class="nav-heading">Pages</li> -->

              <!-- Manage Shelter Nav -->
              <li class="nav-item">
                <a class="nav-link collapsed" href="AdminSheltersServlet">
                  <i class="bi bi-shield-plus"></i>
                  <span>Manage Shelter</span>
                </a>
              </li><!-- End Manage Shelter Nav -->

              <!-- Profile Page Nav -->
              <li class="nav-item">
                <a class="nav-link collapsed" href="AdminProfileServlet">
                  <i class="bi bi-person"></i>
                  <span>Profile</span>
                </a>
              </li><!-- End Profile Page Nav -->

              <li class="nav-item">
                <a class="nav-link collapsed" href="LogoutServlet">
                  <i class="bi bi-box-arrow-right"></i>
                  <span>Log Out</span>
                </a>
              </li><!-- End Logout Page Nav -->

            </ul>

          </aside><!-- End Sidebar-->
    </body>
</html>
