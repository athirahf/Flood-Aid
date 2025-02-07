<%@ page import="com.floodaid.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />

<%
    // Retrieve user object set in AdminProfileServlet
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("pages-login.html?error=session_expired");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Profile</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts meohhw -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Mar 09 2023 with Bootstrap v5.2.3
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

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

  </header><!-- End Header -->

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link collapsed" href="admin-index.jsp">
          <i class="bi bi-grid"></i>
          <span>Dashboard</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <!-- Manage Signal Nav -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="admin-signal.jsp">
          <i class="bi bi-broadcast"></i>
          <span>Manage Signal</span>
        </a>
      </li><!-- End Manage Signal Nav -->

      <!-- Manage Need Nav -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="admin-need.jsp">
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

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Profile</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="admin-index.jsp">Home</a></li>
          <li class="breadcrumb-item active">Profile</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section profile">
      <div class="row">
        <div class="col-xl-4">

          <div class="card">
            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

              <img src="assets/img/default-profile.png" alt="Profile" class="rounded-circle">
              <h2><%= user.getName() %></h2>
              <h3>Admin</h3>
            </div>
          </div>

        </div>

        <div class="col-xl-8">

          <div class="card">
            <div class="card-body pt-3">
              <!-- Bordered Tabs -->
              <ul class="nav nav-tabs nav-tabs-bordered">

                <li class="nav-item">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                </li>

              </ul>
              <div class="tab-content pt-2">

                <div class="tab-pane fade show active profile-overview" id="profile-overview">

                  <h5 class="card-title">Profile Details</h5>

                    <div class="row">
                        <div class="col-lg-3 col-md-4 label">Full Name</div>
                        <div class="col-lg-9 col-md-8"><%= user.getName() %></div>
                      </div>

                      <div class="row">
                        <div class="col-lg-3 col-md-4 label">NRIC</div>
                        <div class="col-lg-9 col-md-8"><%= user.getNric() %></div>
                      </div>

                      <div class="row">
                        <div class="col-lg-3 col-md-4 label">Age</div>
                        <div class="col-lg-9 col-md-8"><%= user.getAge() %></div>
                      </div>

                      <div class="row">
                        <div class="col-lg-3 col-md-4 label">Address</div>
                        <div class="col-lg-9 col-md-8"><%= user.getAddress() %></div>
                      </div>

                      <div class="row">
                        <div class="col-lg-3 col-md-4 label">Phone</div>
                        <div class="col-lg-9 col-md-8"><%= user.getPhoneNum() %></div>
                      </div>

                      <div class="row">
                        <div class="col-lg-3 col-md-4 label">Email</div>
                        <div class="col-lg-9 col-md-8"><%= user.getEmail() %></div>
                      </div>
                </div>

                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                  <!-- Profile Edit Form -->
                  
                  <form action="UpdateProfileServlet" method="POST">
                    <input type="hidden" name="userID" value="<%= session.getAttribute("userID") %>">

                    <div class="row mb-3">
                        <label for="name" class="col-md-4 col-lg-3 col-form-label">Full Name</label>
                        <div class="col-md-8 col-lg-9">
                            <input type="text" id="name" name="name" value="<%= user.getName() %>" class="form-control">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="nric" class="col-md-4 col-lg-3 col-form-label">NRIC</label>
                        <div class="col-md-8 col-lg-9">
                            <input type="text" id="nric" name="nric" value="<%= user.getNric() %>" class="form-control">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="age" class="col-md-4 col-lg-3 col-form-label">Age</label>
                        <div class="col-md-8 col-lg-9">
                            <input type="number" id="age" name="age" value="<%= user.getAge() %>" class="form-control">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="address" class="col-md-4 col-lg-3 col-form-label">Address</label>
                        <div class="col-md-8 col-lg-9">
                            <textarea id="address" name="address" class="form-control"><%= user.getAddress() %></textarea>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="phone" class="col-md-4 col-lg-3 col-form-label">Phone Number</label>
                        <div class="col-md-8 col-lg-9">
                            <input type="text" id="phone" name="phone" value="<%= user.getPhoneNum() %>" class="form-control">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                        <div class="col-md-8 col-lg-9">
                            <input type="text" id="email" name="email" value="<%= user.getEmail() %>" class="form-control">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </form><!-- End Profile Edit Form -->

                </div>

                <div class="tab-pane fade pt-3" id="profile-change-password">
                    <!-- Change Password Form -->
                    <form action="ChangePasswordServlet" method="POST" onsubmit="return validatePasswordChange()">
                        <input type="hidden" name="userID" value="<%= session.getAttribute("userID") %>">
                        <input type="hidden" name="username" value="<%= session.getAttribute("username") %>">
                        
                        <div class="row mb-3">
                            <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="currentPassword" type="password" class="form-control" id="currentPassword" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="newPassword" type="password" class="form-control" id="newPassword" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="renewPassword" type="password" class="form-control" id="renewPassword" required>
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Change Password</button>
                        </div>
                    </form>
                </div>
              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="copyright">
      <!-- &copy; Copyright <strong><span>NiceAdmin</span></strong>. All Rights Reserved -->
    </div>
    <div class="credits">
      <!-- All the links in the footer should remain intact. -->
      <!-- You can delete the links only if you purchased the pro version. -->
      <!-- Licensing information: https://bootstrapmade.com/license/ -->
      <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
      <!-- Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a> -->
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/chart.js/chart.umd.js"></script>
  <script src="assets/vendor/echarts/echarts.min.js"></script>
  <script src="assets/vendor/quill/quill.min.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>
  
  <script>
    function validatePasswordChange() {
        let newPassword = document.getElementById("newPassword").value;
        let renewPassword = document.getElementById("renewPassword").value;

        if (newPassword !== renewPassword) {
            alert("New Password and Re-entered Password do not match.");
            return false;
        }

        if (newPassword.length < 6) {
            alert("New password must be at least 6 characters long.");
            return false;
        }

        return true;
    }
  </script>



</body>

</html>