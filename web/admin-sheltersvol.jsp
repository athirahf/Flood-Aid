<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/admin-extension.jsp" />
<%@ page import="java.util.List" %>
<%@ page import="com.floodaid.model.Shelter, com.floodaid.model.Volunteer" %>

<%
    Shelter shelter = (Shelter) request.getAttribute("shelter");
    List<Volunteer> volunteers = (List<Volunteer>) request.getAttribute("volunteers");
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>View Volunteer</title>
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
      <h1>View Volunteer</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="AdminDashboardServlet">Home</a></li>
          <li class="breadcrumb-item">Manage Shelters</li>
          <li class="breadcrumb-item active">View Volunteer</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
            <h5 class="card-title">Volunteers Assigned to Shelter: <%= shelter.getShelterName() %></h5>

              <!-- Table with stripped rows -->
              <table class="table datatable">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Name</th>
                <th scope="col">Age</th>
                <th scope="col">Phone No</th>
                <th scope="col">Email</th>
                <th scope="col">Employment</th>
                <th scope="col">Status</th>
                <th scope="col">Role</th>
                <th scope="col">Action</th>
            </tr>
        </thead>
        <tbody>
            <% if (volunteers != null && !volunteers.isEmpty()) {
                int index = 1;
                for (Volunteer vol : volunteers) { %>
            <tr>
                <td><%= index++ %></td>
                <td><%= vol.getName() %></td>
                <td><%= vol.getAge() %></td>
                <td><%= vol.getPhoneNum() %></td>
                <td><%= vol.getEmail() %></td>
                <td><%= vol.getVolEmployment() %></td>
                <td>
                    <span class="badge <%= vol.getAvailability().equals("Available") ? "bg-success" : "bg-secondary" %>">
                        <%= vol.getAvailability() %>
                    </span>
                </td>
                <td>
                    <span class="badge <%= vol.isLeader() == 1 ? "bg-primary" : "bg-light text-dark border" %>">
                        <%= vol.isLeader() == 1 ? "Team Leader" : "Member" %>
                    </span>
                </td>
                <td>
                    <div style="display: flex; gap: 10px;">
                        <form action="AppointLeaderServlet" method="POST" style="margin: 0;">
                            <input type="hidden" name="volunteer_id" value="<%= vol.getUserID() %>">
                            <input type="hidden" name="shelter_id" value="<%= vol.getShelterID() %>">
                            <button type="submit" class="btn btn-primary btn-sm">
                                Appoint as Leader
                            </button>
                        </form>

                        <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#reassignModal" 
                            onclick="openReassignModal('<%= vol.getUserID() %>')">
                            Reassign Shelter
                        </button>
                    </div>
                </td>
            </tr>
            <% } } else { %>
            <tr><td colspan="9" class="text-center">No volunteers found</td></tr>
             <% } %>
        </tbody>
    </table>
              <!-- End Table with stripped rows -->

            </div>
          </div>

        </div>
      </div>
    </section>
    <!-- Reassign Shelter Modal -->
    <div class="modal fade" id="reassignModal" tabindex="-1" aria-labelledby="reassignModalLabel" aria-hidden="true">
        <div class="modal-dialog"> <!-- Centered and larger modal -->
            <form action="ReassignShelterServlet" method="POST" id="reassignForm">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="reassignModalLabel">Reassign Volunteer to a Shelter</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <!-- Modal Body -->
                    <div class="modal-body">
                        <input type="hidden" name="volunteer_id" id="modalVolunteerId">

                        <div class="mb-3">
                            <label for="shelterSelect" class="form-label fw-bold">Select Shelter</label>
                            <select class="form-select form-control-lg" id="shelterSelect" name="shelter_id" required>
                                <option value="" selected disabled>-- Select Shelter --</option>
                                <% 
                                    List<Shelter> shelters = (List<Shelter>) request.getAttribute("shelters");
                                    if (shelters != null) {
                                        for (Shelter s : shelters) {
                                %>
                                    <option value="<%= s.getShelterID() %>"><%= s.getShelterName() %></option>
                                <% 
                                        }
                                    } 
                                %>
                            </select>
                        </div>
                    </div>

                    <!-- Modal Footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-warning">Reassign</button>
                    </div>
                </div>
            </form>
        </div>
    </div>


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
    function openReassignModal(volunteerId) {
        document.getElementById('modalVolunteerId').value = volunteerId;
    }

  </script>

</body>

</html>