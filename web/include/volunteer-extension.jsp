<%-- 
    Document   : volunteer-extension
    Created on : Feb 14, 2025, 9:15:32 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <!-- ======= Header ======= -->
        <header id="header" class="header fixed-top d-flex align-items-center">

          <div class="d-flex align-items-center justify-content-between">
            <a href="homepage.html" class="logo d-flex align-items-center">
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
                    <span>Volunteer</span>
                  </li>
                  <li>
                    <hr class="dropdown-divider">
                  </li>

                  <li>
                    <a class="dropdown-item d-flex align-items-center" href="VolunteerProfileServlet">
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

        </header><!-- End Header -->

        <!-- ======= Sidebar ======= -->
        <aside id="sidebar" class="sidebar">

          <ul class="sidebar-nav" id="sidebar-nav">

            <li class="nav-item">
              <a class="nav-link collapsed" href="VolDashboardServlet">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
              </a>
            </li><!-- End Dashboard Nav -->

            <!-- View Team Nav -->
            <li class="nav-item">
              <a class="nav-link collapsed" href="VolViewTeamServlet">
                <i class="bi bi-people-fill"></i>
                <span>View Team</span>
              </a>
            </li><!-- End View Team Nav -->

            <li class="nav-item">
              <a class="nav-link collapsed" href="volunteer-reqneed.jsp">
                <i class="bi bi-bag-plus"></i>
                <span>Request Need</span>
              </a>
            </li>

            <li class="nav-item">
              <a class="nav-link collapsed" href="ManageNeedServlet">
                <i class="bi bi-bag-plus-fill"></i>
                <span>Manage Need</span>
              </a>
            </li>

            <!-- Profile Page Nav -->
            <li class="nav-item">
              <a class="nav-link collapsed" href="VolunteerProfileServlet">
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
