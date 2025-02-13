<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/admin-extension.jsp" />
<%@ page import="java.util.List" %>
<%@ page import="com.floodaid.model.User" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Manage User</title>
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

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>All User</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="admin-index.jsp">Home</a></li>
          <li class="breadcrumb-item active">Manage Users</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">List of Users</h5>
              <!-- Table with stripped rows -->
              <table class="table datatable">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Name</th>
                    <th scope="col">Username</th>
                    <th scope="col">Email</th>
                    <th scope="col">Roles</th>
                    <th scope="col">Registration Time</th>
                    <th scope="col">Action</th>
                  </tr>
                </thead>
                <tbody>
                    <% 
                      List<User> users = (List<User>) request.getAttribute("users");
                      if (users != null) {
                          int rowNumber = 1;
                          for (User user : users) {
                              String roleBadge = "";

                              if ("Admin".equalsIgnoreCase(user.getRole())) {
                                  roleBadge = "<span class='badge text-dark' style='background-color:#aadeff; border-radius: 12px; padding: 8px 12px; font-weight: 500;'>Admin</span>";
                              } else if ("User".equalsIgnoreCase(user.getRole())) {
                                  roleBadge = "<span class='badge text-dark' style='background-color:#c5ffaa; border-radius: 12px; padding: 8px 12px; font-weight: 500;'>Victim</span>";
                              } else if ("Volunteer".equalsIgnoreCase(user.getRole())) {
                                  roleBadge = "<span class='badge text-dark' style='background-color:#ffd1aa; border-radius: 12px; padding: 8px 12px; font-weight: 500;'>Volunteer</span>";
                              }
                    %>
                    <tr>
                      <th scope="row"><%= rowNumber++ %></th>
                      <td><%= user.getName() %></td>
                      <td><%= user.getUsername() %></td>
                      <td><%= user.getEmail() %></td>
                      <td class="text-center"><%= roleBadge %></td>
                      <td><%= user.getRegistrationTime().substring(0, 16) %></td>
                      <td>
                        <div style="display: flex; flex-direction: column; align-items: center; gap: 5px;">
                            <div class="filter">
                                <a href="#" data-bs-toggle="dropdown" class="btn btn-info rounded-pill btn-md bi-pencil-square"></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li><a class="dropdown-item" href="admin-viewuser.jsp?userID=<%= user.getUserID() %>">View</a></li>
                                    <li><a class="dropdown-item" href="admin-edituser.jsp?userID=<%= user.getUserID() %>">Edit</a></li>
                                    <li><a class="dropdown-item" href="DeleteUsersServlet?userID=<%= user.getUserID() %>" onclick="return confirmDelete();">Delete</a></li>
                                </ul>
                            </div>
                        </div>
                      </td>
                    </tr>
                    <% 
                          }
                      } else { 
                    %>
                    <tr><td colspan="7" class="text-center">No users found.</td></tr>
                    <% } %>
                </tbody>
              </table>
              <!-- End Table with stripped rows -->

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
    function confirmDelete() {
        return confirm('Are you sure you want to delete this user? This action cannot be undone.');
    }
  </script>

</body>

</html>