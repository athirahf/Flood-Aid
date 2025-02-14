<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<%@ page import="com.floodaid.model.Need" %>
<%@ page import="java.util.List" %>
<jsp:include page="include/volunteer-extension.jsp" />

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Manage Need</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/FloodAidLogo.png" rel="icon">
  <link href="assets/img/FloodAidLogo.png" rel="apple-touch-icon">

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
      <h1>All Need</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="VolDashboardServlet">Home</a></li>
          <li class="breadcrumb-item active">Manage Need</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->
    
     <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">List of All Need</h5>

              <!-- Table with stripped rows -->
              <table class="table datatable">
                <thead>
                  <tr>
                    <th scope="col">No</th>
                    <th scope="col">Item</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Status</th>
                    <th scope="col">Date Requested</th>
                    <th scope="col">Date Approved</th>
                    <th scope="col">Action</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                    List<Need> needs = (List<Need>) request.getAttribute("needs");
                    if (needs != null && !needs.isEmpty()) {
                        int rowNumber = 1;
                        for (Need need : needs) {
                            String statusBadge = "";
                            String actionTime = (need.getActionTime() != null) ? need.getActionTime().toString() : "-";
                            
                            String status = need.getNeedStatus().toLowerCase();
                            if ("pending".equals(status)) {
                                statusBadge = "<span class='badge bg-warning text-dark'>Pending</span>";
                            } else if ("approved".equals(status)) {
                                statusBadge = "<span class='badge bg-success'>Approved</span>";
                            } else if ("rejected".equals(status)) {
                                statusBadge = "<span class='badge bg-danger'>Rejected</span>";
                            } else {
                                statusBadge = "<span class='badge bg-secondary'>Unknown</span>";
                            }
                  %>
                  <tr>
                    <th scope="row"><%= rowNumber++ %></th>
                    <td><%= need.getNeedItem() %></td>
                    <td><%= need.getNeedQuantity() %></td>
                    <td><%= statusBadge %></td>
                    <td><%= need.getTimeRequest() %></td>
                    <td><%= actionTime %></td>
                    <td>
                      <% if ("pending".equalsIgnoreCase(need.getNeedStatus())) { %>
                        <div class="filter">
                          <a href="#" data-bs-toggle="dropdown" class="btn btn-info rounded-pill btn-sm ri-edit-box-fill"></a>
                          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                            <li><a class="dropdown-item" href="volunteer-editneed.jsp?needID=<%= need.getNeedID() %>">Edit</a></li>
                            <li><a class="dropdown-item" href="CancelNeedServlet?needID=<%= need.getNeedID() %>" onclick="return confirm('Are you sure you want to cancel this request?');">Cancel</a></li>
                          </ul>
                        </div>
                      <% } else { %>
                        <span class="text-muted">No Actions</span>
                      <% } %>
                    </td>
                  </tr>
                  <% } 
                    } else { %>
                  <tr><td colspan="7" class="text-center">No need requests found for your shelter.</td></tr>
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