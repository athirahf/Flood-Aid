<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Register New Account</title>
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

  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="homepage.html" class="logo d-flex align-items-center w-auto">
                  <img src="assets/img/FloodAidLogo.png" alt="">
                  <!-- <span class="d-none d-lg-block">Flood Aid</span> -->
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Create an Account</h5>
                    <p class="text-center small">Enter your personal details to create account</p>
                  </div>
                    
                    <!-- Capture Form Parameters -->
                    <c:set var="name" value="${param.name}" />
                    <c:set var="email" value="${param.email}" />
                    <c:set var="role" value="${param.role}" />
                    <c:set var="username" value="${param.username}" />
                    <c:set var="password" value="${param.password}" />

                  <form class="row g-3 needs-validation" novalidate>
                    <div class="col-12">
                      <label for="name" class="form-label">Name</label>
                      <input type="text" name="name" class="form-control" id="name" required>
                      <div class="invalid-feedback">Please, enter your name!</div>
                    </div>

                    <!-- Birthday -->
                    <!-- <div class="col-12">
                      <label for="birthday" class="form-label">Birthday</label>
                      <input type="date" name="birthday" class="form-control" id="birthday" required>
                      <div class="invalid-feedback">Please select your birthday!</div>
                    </div> -->

                    <div class="col-12">
                      <label for="email" class="form-label">Email</label>
                      <input type="email" name="email" class="form-control" id="email" required>
                      <div class="invalid-feedback">Please enter a valid Email adddress!</div>
                    </div>

                    <div class="col-12">
                      <label for="userRole" class="form-label">Select Your Role</label>
                      <select class="form-select" name="role" id="userRole" required>
                        <option value="" disabled selected>Choose your role</option>
                        <option value="Admin">Admin</option>
                        <option value="Volunteer">Volunteer</option>
                        <option value="User">User</option>
                      </select>
                      <div class="invalid-feedback">Please select a role!</div>
                    </div>
                    
<!--                    <div class="col-12" id="typeForm" style="display: none;">
                      <label for="volunteerStatus" class="form-label">Current Employment Status</label>
                      <select class="form-select" name="type" id="volunteerStatus" required>
                        <option value="" disabled selected>Choose Employment Status</option>
                        <option value="Unemployed">Unemployed</option>
                        <option value="Working">Working</option>
                        <option value="Student">Student</option>
                      </select>
                      <div class="invalid-feedback">Please select your Employment Status!</div>
                    </div>-->
                    

                    <div class="col-12">
                      <label for="yourUsername" class="form-label">Username</label>
                      <div class="input-group has-validation">
                        <span class="input-group-text" id="inputGroupPrepend">@</span>
                        <input type="text" name="username" class="form-control" id="yourUsername" required>
                        <div class="invalid-feedback">Please choose a username.</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">Password</label>
                      <div class="input-group">
                        <input type="password" name="password" class="form-control" id="yourPassword" required>
                        <button type="button" class="btn btn-outline-secondary" id="togglePassword">
                          <i class="bi bi-eye"></i>
                        </button>
                        <div class="invalid-feedback">Please enter your password!</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">Create Account</button>
                    </div>
                    <div class="col-12">
                      <p class="small mb-0">Already have an account? <a href="pages-login.html">Log in</a></p>
                    </div>
                  </form>
                    
                    <!-- Database Connection -->
                    <sql:setDataSource var="FloodAidDatasource"
                        driver="org.apache.derby.jdbc.ClientDriver"
                        url="jdbc:oracle:thin:@localhost:1521:XE"
                        user="FloodAid" password="FloodAid" />

                </div>
              </div>

              <div class="credits">
                <!-- All the links in the footer should remain intact. -->
                <!-- You can delete the links only if you purchased the pro version. -->
                <!-- Licensing information: https://bootstrapmade.com/license/ -->
                <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
                <!-- Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a> -->
              </div>

            </div>
          </div>
        </div>

      </section>

    </div>
  </main><!-- End #main -->

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
    document.addEventListener('DOMContentLoaded', () => {
      const roleField = document.getElementById('userRole');
      const typeForm = document.getElementById('typeForm');
  
      // Show or hide the "Type" form based on role selection
      roleField.addEventListener('change', function () {
        if (this.value === 'Volunteer') {
          typeForm.style.display = 'block';
        } else {
          typeForm.style.display = 'none';
        }
      });
    });

    document.addEventListener('DOMContentLoaded', () => {
      const togglePassword = document.getElementById('togglePassword');
      const passwordField = document.getElementById('yourPassword');
  
      togglePassword.addEventListener('click', function () {
        // Toggle password visibility
        const isPassword = passwordField.type === 'password';
        passwordField.type = isPassword ? 'text' : 'password';
  
        // Toggle the icon
        this.innerHTML = isPassword 
          ? '<i class="bi bi-eye-slash"></i>' 
          : '<i class="bi bi-eye"></i>';
      });
    });
  </script>
  

</body>

</html>