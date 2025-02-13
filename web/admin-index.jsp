<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/admin-extension.jsp" />

<%@ page import="com.floodaid.model.Signal" %>
<%@ page import="com.floodaid.model.SignalDAO" %>

<%
    Integer adminCount = (Integer) request.getAttribute("adminCount");
    Integer victimCount = (Integer) request.getAttribute("victimCount");
    Integer volunteerCount = (Integer) request.getAttribute("volunteerCount");
    Integer shelterCount = (Integer) request.getAttribute("shelterCount");
    Integer needCount = (Integer) request.getAttribute("needCount");
    Integer signalCount = (Integer) request.getAttribute("signalCount");

    // Ensure null safety (if attribute is missing, set to 0)
    adminCount = (adminCount != null) ? adminCount : 0;
    victimCount = (victimCount != null) ? victimCount : 0;
    volunteerCount = (volunteerCount != null) ? volunteerCount : 0;
    shelterCount = (shelterCount != null) ? shelterCount : 0;
    needCount = (needCount != null) ? needCount : 0;
    signalCount = (signalCount != null) ? signalCount : 0;
%>


 <!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Dashboard</title>
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
        <h1>Dashboard</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="admin-index.jsp">Home</a></li>
                <li class="breadcrumb-item active">Welcome, <%= session.getAttribute("name") %>!</li>
            </ol>
        </nav>
    </div>
    <!-- End Page Title -->

    <section class="section dashboard">
      <div class="row">
            <!-- Shelters Card -->
            <div class="col-xxl-4 col-md-6">
              <div class="card info-card sales-card">
                <div class="card-body">
                  <h5 class="card-title">Shelters</h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="bi bi-house"></i>
                    </div>
                    <div class="ps-3">
                      <h6><%= shelterCount %></h6>
                    </div>
                  </div>
                </div>

              </div>
            </div><!-- End Shelters Card -->

            <!-- Victims Card -->
            <div class="col-xxl-4 col-md-6">
              <div class="card info-card revenue-card">

                <div class="card-body">
                  <h5 class="card-title">Victims</h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="bi bi-people"></i>
                    </div>
                    <div class="ps-3">
                      <h6><%= victimCount %></h6>
                    </div>
                  </div>
                </div>

              </div>
            </div><!-- End Victims Card -->

            <!-- Volunteers Card -->
            <div class="col-xxl-4 col-xl-12">

              <div class="card info-card customers-card">
                <div class="card-body">
                  <h5 class="card-title">Volunteers</h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="bi bi-person-badge"></i>
                    </div>
                    <div class="ps-3">
                      <h6><%= volunteerCount %></h6>
                    </div>
                  </div>

                </div>
              </div>

            </div><!-- End Volunteers Card -->

        <!-- Left side columns -->
        <div class="col-lg-7">
          <div class="row">

            <!-- Reports -->
            <div class="col-12">
              <div class="card">


                <div class="card-body">
                  <h5 class="card-title">Reports </h5>

                <!-- Bar Chart -->
                    <canvas id="barChart" style="max-height: 400px;"></canvas>
                    <script>
                        document.addEventListener("DOMContentLoaded", () => {
                            new Chart(document.querySelector('#barChart'), {
                                type: 'bar',
                                data: {
                                    labels: ['Admin', 'Victim', 'Volunteer', 'Shelter', 'Need', 'Signal'],
                                    datasets: [{
                                        label: 'User Statistics',
                                        data: [
                                            <%= adminCount %>,
                                            <%= victimCount %>,
                                            <%= volunteerCount %>,
                                            <%= shelterCount %>,
                                            <%= needCount %>,
                                            <%= signalCount %>
                                        ],
                                        backgroundColor: [
                                            'rgba(255, 99, 132, 0.2)',
                                            'rgba(255, 159, 64, 0.2)',
                                            'rgba(255, 205, 86, 0.2)',
                                            'rgba(75, 192, 192, 0.2)',
                                            'rgba(54, 162, 235, 0.2)',
                                            'rgba(153, 102, 255, 0.2)'
                                        ],
                                        borderColor: [
                                            'rgb(255, 99, 132)',
                                            'rgb(255, 159, 64)',
                                            'rgb(255, 205, 86)',
                                            'rgb(75, 192, 192)',
                                            'rgb(54, 162, 235)',
                                            'rgb(153, 102, 255)'
                                        ],
                                        borderWidth: 1
                                    }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        });
                    </script>
                <!-- End Bar Chart -->


                </div>

              </div>
            </div><!-- End Reports -->

          </div>
        </div><!-- End Left side columns -->

        <!-- Right side columns -->
        <div class="col-lg-5">

          <!-- Recent Activity -->
          <div class="card" >

            <div class="card-body">
              <h5 class="card-title">Activity <span>| Banjir Rescue</span></h5>

              <div class="activity" style="max-height: 365px; overflow-y: auto; padding: 10px;">
                <%
                    SignalDAO signalDAO = new SignalDAO();
                    List<Signal> signals = signalDAO.getAllSignal();

                    if (signals != null && !signals.isEmpty()) {
                        for (Signal signal : signals) {
                            String badgeColor = "text-muted"; // Default color

                            // Assign colors based on SIGNAL_STATUS using if-else (compatible with older Java)
                            if ("Rejected".equals(signal.getSignalStatus())) {
                                badgeColor = "text-danger";
                            } else if ("Approved".equals(signal.getSignalStatus())) {
                                badgeColor = "text-success";
                            } else if ("Pending".equals(signal.getSignalStatus())) {
                                badgeColor = "text-warning";
                            }

                            // Format date & time (Optional: Use Java's SimpleDateFormat for better readability)
                %>
                            <div class="activity-item d-flex align-items-start p-3 mb-2 border rounded shadow-sm" style="background: #fff;">
                                <i class='bi bi-circle-fill activity-badge <%= badgeColor %> mx-2 align-self-center'></i>
                                <div class="activity-label fw-bold text-primary align-self-center" style="min-width: 80px;">
                                    <%= signal.getSignalTime() %> <!-- Show formatted signal time -->
                                </div>
                                <div class="activity-content">
                                    <strong class="text-dark">📍 Location:</strong> <%= signal.getSignalPlace() %>, <%= signal.getSignalArea() %> (<%= signal.getSignalPostcode() %>) <br>
                                    <strong class="text-dark">📝 Remark:</strong> <%= signal.getSignalRemark() %>
                                </div>
                            </div><!-- End activity item -->
                <%
                        }
                    } else {
                %>
                    <p class="text-center text-muted">No signals available.</p>
                <%
                    }
                %>
            </div>



            </div>
          </div><!-- End Recent Activity -->


        </div><!-- End Right side columns -->

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