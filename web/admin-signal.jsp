<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/admin-extension.jsp" />
<%@ page import="java.util.List" %>
<%@ page import="com.floodaid.model.Signal" %>


<!DOCTYPE html>
<html lang="en">
    <!-- HEAD -->
    <head>
      <meta charset="utf-8">
      <meta content="width=device-width, initial-scale=1.0" name="viewport">

      <title>Manage Signal</title>
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
    <!-- End HEAD -->

    <!-- BODY -->
        <body>
            <!-- #main -->
            <main id="main" class="main">
                <!-- Page Title -->
                    <div class="pagetitle">
                    <h1>All Signal</h1>
                        <nav>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="admin-index.jsp">Home</a></li>
                                <li class="breadcrumb-item active">Manage Signal</li>
                            </ol>
                        </nav>
                    </div>
                <!-- End Page Title -->

                <!-- Page Content -->
                <section class="section">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">List of All Signal</h5>
                                    <!-- Table with stripped rows -->
                                    <table class="table datatable">
                                        <thead>
                                            <tr>
                                                <th scope="col">No</th>
                                                <th scope="col">Time Requested</th>
                                                <th scope="col">Place</th>
                                                <th scope="col">Area</th>
                                                <th scope="col">Postcode</th>
                                                <th scope="col">Status</th>
                                                <th scope="col">Remark</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% 
                                                List<Signal> signals = (List<Signal>) request.getAttribute("signals");
                                                if (signals != null) {
                                                    int rowNumber = 1; // ✅ Start row number from 1
                                                    for (Signal signal : signals) {
                                            %>
                                                <tr>
                                                    <th scope="row"><%= rowNumber++ %></th> <!-- ✅ Uses row number instead of Shelter ID -->
                                                    <td><%= signal.getSignalTime() %></td>
                                                    <td><%= signal.getSignalPlace() %></td>
                                                    <td><%= signal.getSignalArea() %></td>
                                                    <td><%= signal.getSignalPostcode() %></td>
                                                    <td>
                                                        <%
                                                            String status = signal.getSignalStatus();
                                                            String badgeClass = "bg-secondary text-white"; // Default (for unknown status)

                                                            if ("Pending".equalsIgnoreCase(status)) {
                                                                badgeClass = "bg-warning text-dark";
                                                            } else if ("Approved".equalsIgnoreCase(status)) {
                                                                badgeClass = "bg-success text-white";
                                                            } else if ("Rejected".equalsIgnoreCase(status)) {
                                                                badgeClass = "bg-danger text-white";
                                                            }
                                                        %>

                                                        <span class="badge <%= badgeClass %>"><%= status %></span>
                                                    </td>
                                                    <td><%= signal.getSignalRemark() %></td>
                                                    <td>
                                                        <div style="display: flex; flex-direction: column; align-items: center; gap: 5px;">
                                                            <div class="filter">
                                                                <a href="#" data-bs-toggle="dropdown" class="btn btn-danger rounded-pill btn-sm ri-base-station-line"></a>
                                                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                                                    <li><a class="dropdown-item" href="admin-signalApprove.jsp?SignalID=<%= signal.getSignalID() %>&ShelterID=0">Approve</a></li>
                                                                    <li><a class="dropdown-item" href="admin-signalReject.jsp?SignalID=<%= signal.getSignalID() %>&ShelterID=0">Reject</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            <% 
                                                    }
                                                } else { 
                                            %>
                                                <tr><td colspan="12" style="text-align: center;">No signals request.</td></tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                    <!-- End Table with stripped rows -->
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- End Page Content -->


            </main>
            <!-- End #main -->

            <!-- JS FILE -->
            <div name="JSFILE">
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
            </div>
            <!-- END OF JS FILE -->
        </body>
    <!-- End BODY -->
</html>