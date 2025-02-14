<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.floodaid.model.User" %>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/users-extension.jsp" />

<%
    // Retrieve user object from session
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("pages-login.html?error=session_expired");
        return;
    }
    
    String successMessage = request.getParameter("success");
    boolean showSuccessAlert = (successMessage != null && successMessage.equals("signal_sent"));
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Send Signal</title>
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
      
    <div id="successAlert" class="alert alert-success alert-dismissible fade show" 
        role="alert" style="<%= showSuccessAlert ? "" : "display: none;" %> ; margin-top: 20px;">
       Signal has been successfully sent! Please wait for admin response.
       <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>


    <div class="pagetitle">
      <h1>Send Signal Information</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="users-index.jsp">Home</a></li>
          <li class="breadcrumb-item active">Send Signal</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-10 offset-lg-1">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">User Signal form </h5>

              <!-- General Form Elements -->
              <form action="SendSignalServlet" method="post">
                <input type="hidden" name="redirectPage" value="users-signal.jsp">
                <div class="row mb-3">
                    <div class="col-sm-12">
                        <label for="inputPlace" class="col-sm-2 col-form-label">Current Place</label>
                        <input 
                           type="text" 
                           class="form-control"
                           name="inputPlace"
                           id="inputPlace" 
                           placeholder="Enter Place" 
                           data-bs-toggle="tooltip" 
                           data-bs-placement="top" 
                           title="E.g. Inside the house, on the rooftop, etc.">
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-sm-6">
                        <label for="inputArea" class="col-sm-2 col-form-label">Area</label> <!--area is not state!-->
                        <input type="text" class="form-control" id="inputArea" name="inputArea" placeholder="Enter your area">
                    </div>
                    <div class="col-sm-6">
                        <label for="inputPostcode" class="col-sm-2 col-form-label">Postcode</label>
                        <input type="text" class="form-control" name="inputPostcode" id="inputPostcode" placeholder="Enter postcode">
                    </div>
                </div>
                  
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Save</button>
                    <button type="reset" class="btn btn-secondary">Clear</button>
                </div>
                
              </form>

              <!-- End General Form Elements -->
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
    // Initialize Bootstrap tooltips
    document.addEventListener('DOMContentLoaded', function () {
      var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
      tooltipTriggerList.forEach(function (tooltipTriggerEl) {
        new bootstrap.Tooltip(tooltipTriggerEl);
      });
    });
    
    document.addEventListener("DOMContentLoaded", function () {
        // Check if success parameter exists in the URL
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has("success") && urlParams.get("success") === "signal_sent") {
            document.getElementById("successAlert").style.display = "block";
        }
    });
  </script>

</body>

</html>