<%@ page import="com.floodaid.model.User, com.floodaid.model.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/admin-extension.jsp" />

<%
    // Get userID from request
    String userIDStr = request.getParameter("userID");
    User user = null;

    if (userIDStr != null && !userIDStr.isEmpty()) {
        int userID = Integer.parseInt(userIDStr);
        UserDAO userDAO = new UserDAO();
        user = userDAO.getUserByID(userID);
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Edit User</title>
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
      <h1>Edit User</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="admin-index.jsp">Home</a></li>
          <li class="breadcrumb-item">Manage Users</li>
          <li class="breadcrumb-item active">Edit User</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-10 offset-lg-1"><!-- Centering the form -->
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Edit User Details</h5>

              <form action="EditUserServlet" method="POST">
                <input type="hidden" name="userID" value="<%= user.getUserID() %>">
                
                <!-- Full Name -->
                <div class="row mb-3">
                    <div class="col-md-12">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" id="name" name="name" value="<%= user.getName() %>" class="form-control">
                    </div>
                </div>

                <!-- NRIC and Age -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="nric" class="form-label">NRIC</label>
                        <input type="text" id="nric" name="nric" value="<%= user.getNric() %>" class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label for="age" class="form-label">Age</label>
                        <input type="number" id="age" name="age" value="<%= user.getAge() %>" class="form-control">
                    </div>
                </div>

                <!-- Email and Phone Number -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" name="email" value="<%= user.getEmail() %>" class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label for="phoneNum" class="form-label">Phone Number</label>
                        <input type="text" id="phoneNum" name="phoneNum" value="<%= user.getPhoneNum() %>" class="form-control">
                    </div>
                </div>

                <!-- Address -->
                <div class="row mb-3">
                    <div class="col-md-12">
                        <label for="address" class="form-label">Address</label>
                        <textarea id="address" name="address" class="form-control" rows="3"><%= user.getAddress() %></textarea>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="text-center">
                    <a href="AdminUsersServlet" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Update</button>
                    <a href="DeleteUserServlet?userID=<%= user.getUserID() %>" class="btn btn-danger" onclick="return confirmDelete();">Delete</a>
                </div>
            </form>

            </div>
          </div>
        </div>
      </div>
    </section>
  </main>

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