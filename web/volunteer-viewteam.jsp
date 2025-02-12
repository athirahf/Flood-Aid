<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<%@ page import="com.floodaid.model.Volunteer" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>View Team</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
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
        <a class="nav-link collapsed" href="volunteer-index.jsp">
          <i class="bi bi-grid"></i>
          <span>Dashboard</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <!-- View Team Nav -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="volunteer-viewteam.jsp">
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
        <a class="nav-link collapsed" href="volunteer-need.jsp">
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

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>View Team</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="volunteer-index.jsp">Home</a></li>
          <li class="breadcrumb-item active">View Team</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Welcome to Seri Muda Team Page!</h5>

            
                <div class="accordion" id="accordionExample">
                <div class="accordion-item">
                  <h2 class="accordion-header" id="headingOne">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                      About Team
                    </button>
                  </h2>
                  <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                      <strong>Who Are We?</strong><br>
                      Seri Muda Volunteers Team is a dedicated team focused on supporting and assisting the community of Seri Muda, especially during times of disaster like floods. With a strong commitment to community cooperation, we provide immediate relief, coordinate shelters, and mobilize resources to help our fellow Malaysians in this vulnerable area. We stand by the people of Seri Muda, ensuring their safety and recovery when they need it the most.
                      <p></p>
                      <strong>Stay Connected!</strong><br>
                      Our team communicates and stays updated through our Telegram Group. It's a great platform for sharing important updates, coordinating efforts, and supporting each other. If you haven't joined us yet, make sure to click the link below to become a part of our communication network and help us coordinate relief efforts for the community of Seri Muda.
                      <br><br>
                      <a href="https://t.me/SeriMudaTeam" button type="button" class="btn btn-outline-dark" target="_blank">Our Telegram Channel</a>
                    
                    </div>
                  </div>
                </div>
                <div class="accordion-item">
                  <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                      Our Mission & Vision
                    </button>
                  </h2>
                  <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                      <strong>Mission</strong><br>
                      Our mission is to bring timely, effective, and compassionate assistance to the people of Seri Muda, helping them recover from the devastating impacts of floods. We aim to strengthen the bonds within the community by uniting volunteers and residents to overcome challenges together, keeping the spirit of semangat kekitaan (togetherness) alive in every action we take.
                      <br><p></p>
                      <strong>Vision</strong><br> 
                      Our vision is to establish a resilient and well-prepared community in Seri Muda, where no one is left behind during times of crisis. We aspire to create a future where the people of Seri Muda are equipped to face any disaster with confidence, supported by a strong network of volunteers and resources.
                    </div>
                  </div>
                </div>

                <div class="accordion-item">
                  <h2 class="accordion-header" id="headingThree">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                      Volunteer List
                    </button>
                  </h2>
                  <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                      <strong>List of Active Members of Seri Muda Team</strong>
                      <p></p>

                      <!-- Table with stripped rows -->
                      <table class="table datatable">
                        <thead>
                          <tr>
                            <th scope="col">No</th>
                            <th scope="col">Name</th>
                            <th scope="col">Age</th>
                            <th scope="col">Phone No</th>
                            <th scope="col">Email</th>
                            <th scope="col">Employment</th>
                            <th scope="col">Status</th>
                            <th scope="col">Role</th>
                          </tr>
                        </thead>                
                        <tbody>
                            <% 
                                List<Volunteer> volunteers = (List<Volunteer>) request.getAttribute("volunteers");
                                if (volunteers != null) {
                                    int rowNumber = 1; // ✅ Start row number from 1
                                    for (Volunteer volunteer : volunteers) {
                                        String availabilityBadge = "";

                                        if ("Available".equalsIgnoreCase(volunteer.getAvailability())) {
                                            availabilityBadge = "<span class='badge bg-success'>Available</span>";
                                        } else {
                                            availabilityBadge = "<span class='badge bg-secondary'>Unavailable</span>";
                                        }
                                        
                                        String leaderBadge = "";

                                        if (volunteer.isLeader() == 1) {
                                            leaderBadge = "<span class='badge bg-primary'>Leader</span>";
                                        } else {
                                            leaderBadge = "<span class='badge bg-light text-dark'>Member</span>";
                                        }
                            %>
                                <tr>
                                    <th scope="row"><%= rowNumber++ %></th>
                                    <td><%= volunteer.getName() %></td>
                                    <td><%= volunteer.getAge() %></td>
                                    <td><%= volunteer.getPhoneNum() %></td>
                                    <td><%= volunteer.getEmail() %></td>
                                    <td><%= volunteer.getVolEmployment() %></td>
                                    <td><%= availabilityBadge %></td>
                                    <td><%= leaderBadge %></td>
                                </tr>
                            <% 
                                    }
                                } else { 
                            %>
                                <tr><td colspan="8">No volunteers found.</td></tr>
                            <% } %>
                        </tbody>
                      </table>
                      <!-- End Table with stripped rows -->
                    </div>
                  </div>
                </div>
              </div>
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

</body>

</html>