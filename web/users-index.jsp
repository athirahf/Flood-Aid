<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/users-extension.jsp" />

<%
    Integer victimCount = (Integer) request.getAttribute("victimCount");
    Integer volunteerCount = (Integer) request.getAttribute("volunteerCount");
    Integer needCount = (Integer) request.getAttribute("needCount");

    // Ensure null if attribute is missing, set to 0
    victimCount = (victimCount != null) ? victimCount : 0;
    volunteerCount = (volunteerCount != null) ? volunteerCount : 0;
    needCount = (needCount != null) ? needCount : 0;
    
    String successMessage = request.getParameter("success");
    boolean showSuccessAlert = (successMessage != null && successMessage.equals("signal_sent"));
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
    <div id="successAlert" class="alert alert-success alert-dismissible fade show" role="alert" style="display: none; margin-top: 20px;">
      Signal has been successfully sent! Please wait for admin response.
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

    <div class="d-flex align-items-center justify-content-between">
      <div class="pagetitle">
          <h1>Dashboard</h1>
          <nav>
              <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="users-index.jsp">Home</a></li>
                  <li class="breadcrumb-item active">Welcome, <%= session.getAttribute("name") %>!</li>
              </ol>
          </nav>
      </div>
      <!-- Send Signal Button -->
      <button data-bs-toggle="modal" data-bs-target="#sendSignal"
              style="background: none; border: none; padding: 0; width: auto; height: 50px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
        <img src="assets/img/sos-button.png" alt="SOS Icon" style="height: 100%; width: auto;">
      </button>
      <div class="modal fade" id="sendSignal" tabindex="-1">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Send Signal</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form action="SendSignalServlet" method="post">
                <input type="hidden" name="redirectPage" value="UserDashboardServlet">
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
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" id="sendSignalBtn">Send Signal</button>
                  </div>
              </form>
            </div>
            
          </div>
        </div>
      </div>
    </div>

    <section class="section dashboard">
      <div class="row">

        <!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">

            <!-- Victim Rescued Card -->
            <div class="col-xxl-4 col-md-6">
              <div class="card info-card sales-card">

                <div class="card-body">
                  <h5 class="card-title">Victims Rescued <span>| As Now</span></h5>
                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="bi bi-person-heart"></i>
                    </div>
                    <div class="ps-3">
                      <h6><%= request.getAttribute("victimCount") %></h6>
                    </div>
                  </div>
                </div>
              </div>
            </div><!-- End Victim Rescued Card -->

            <!-- Aid Kits Delivered Card -->
            <div class="col-xxl-4 col-md-6">
              <div class="card info-card revenue-card">

                <div class="card-body">
                  <h5 class="card-title">Needs Distributed <span>| As Now</span></h5>
                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="bi bi-box2-heart"></i>
                    </div>
                    <div class="ps-3">
                      <h6><%= request.getAttribute("needCount") %></h6>
                    </div>
                  </div>
                </div>
              </div>
            </div><!-- End Aid Kits Delivered Card -->

            <!-- Volunteers Engaged Card -->
            <div class="col-xxl-4 col-xl-12">
              <div class="card info-card customers-card">

                <div class="card-body">
                  <h5 class="card-title">Active Volunteers <span>| As Now</h5>
                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="bi bi-people"></i>
                    </div>
                    <div class="ps-3">
                      <h6><%= request.getAttribute("volunteerCount") %></h6>
                    </div>
                  </div>
                </div>
              </div>
            </div><!-- End Volunteers Engaged Card -->
          </div>

          <div class="row">

            <!-- Statistic Rain -->
            <div class="col-lg-8">
              <div class="card">
                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>
                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">Statistic Rain in Malaysia </h5>

                  <!-- Line Chart -->
                  <div id="reportsChart"></div>
                  <script>
                    document.addEventListener("DOMContentLoaded", () => {
                      new ApexCharts(document.querySelector("#reportsChart"), {
                        series: [{
                          name: '2022',
                          data: [31, 40, 28, 51, 42, 82, 56],
                        }, {
                          name: '2023',
                          data: [11, 32, 45, 32, 34, 52, 41]
                        }, {
                          name: '2024',
                          data: [15, 11, 32, 18, 9, 24, 11]
                        }],
                        chart: {
                          height: 350,
                          type: 'area',
                          toolbar: {
                            show: false
                          },
                        },
                        markers: {
                          size: 4
                        },
                        colors: ['#4154f1', '#2eca6a', '#ff771d'],
                        fill: {
                          type: "gradient",
                          gradient: {
                            shadeIntensity: 1,
                            opacityFrom: 0.3,
                            opacityTo: 0.4,
                            stops: [0, 90, 100]
                          }
                        },
                        dataLabels: {
                          enabled: false
                        },
                        stroke: {
                          curve: 'smooth',
                          width: 2
                        },
                        xaxis: {
                          type: 'datetime',
                          categories: ["2018-09-19T00:00:00.000Z", "2018-09-19T01:30:00.000Z", "2018-09-19T02:30:00.000Z", "2018-09-19T03:30:00.000Z", "2018-09-19T04:30:00.000Z", "2018-09-19T05:30:00.000Z", "2018-09-19T06:30:00.000Z"]
                        },
                        tooltip: {
                          x: {
                            format: 'dd/MM/yy HH:mm'
                          },
                        }
                      }).render();
                    });
                  </script>
                  <!-- End Line Chart -->

                </div>
              </div>
            <!-- </div> --><!-- End Statistic Rain -->

            <!-- Projects -->
            <!-- <div class="col-lg-8"> -->
              <div class="card recent-sales overflow-auto">
                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">Projects</h5>

                  <table class="table table-borderless datatable">
                    <thead>
                      <tr>
                        <th scope="col">No.</th>
                        <th scope="col">Volunteer involved </th>
                        <th scope="col">Project </th>
                        <th scope="col">Budget</th>
                        <th scope="col">Status</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <th scope="row"><a href="#"> 1 </a></th>
                        <td>43 </td>
                        <td><a href="#" class="text-primary">December 2021: The "Christmas Floods"</a></td>
                        <td>RM 23,450 </td>
                        <td><span class="badge bg-success">SUCCESSFUL</span></td>
                      </tr>
                      <tr>
                        <th scope="row"><a href="#">2</a></th>
                        <td>67</td>
                        <td><a href="#" class="text-primary">July 2022: Flooding in Johor</a></td>
                        <td>RM 47,500 </td>
                        <td><span class="badge bg-success">SUCCESSFUL</span></td>
                      </tr>
                      <tr>
                        <th scope="row"><a href="#">3</a></th>
                        <td>103</td>
                        <td><a href="#" class="text-primary">March 2023: Flooding in Terengganu and Kelantan</a></td>
                        <td>RM80,000</td>
                        <td><span class="badge bg-success">SUCCESSFUL</span></td>
                      </tr>
                      <tr>
                        <th scope="row"><a href="#">4</a></th>
                        <td>73</td>
                        <td><a href="#" class="text-primar">August 2023: Sabah Floods</a></td>
                        <td>RM 30,765</td>
                        <td><span class="badge bg-success">SUCCESSFUL</span></td>
                      </tr>
                      <tr>
                        <th scope="row"><a href="#">5</a></th>
                        <td>45</td>
                        <td><a href="#" class="text-primary">December 2023: Year-End Floods in East Coast</a></td>
                        <td>RM 79,000</td>
                        <td><span class="badge bg-success">SUCCESSFUL</span></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div><!-- End Recent Sales -->
            </div>
        <!-- End Left side columns -->

        <!-- Right side columns -->
        <div class="col-lg-4">

          <!-- Overview of Major Floods in 2024 -->
          <div class="card">
            <div class="filter">
              <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
              <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                <li class="dropdown-header text-start">
                  <h6>Filter</h6>
                </li>

                <li><a class="dropdown-item" href="#">Today</a></li>
                <li><a class="dropdown-item" href="#">This Month</a></li>
                <li><a class="dropdown-item" href="#">This Year</a></li>
              </ul>
            </div>

            <div class="card-body">
              <h5 class="card-title">Overview of Major Floods in 2024:</h5>

              <div class="activity">

                <div class="activity-item d-flex">
                  <div class="activite-label">JAN</div>
                  <i class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
                  <div class="activity-content">
                    Flooding in Johor, affecting more than 5,000 people and leading to evacuations. Roads and agricultural areas were submerged, disrupting daily life and economic activities

                  </div>
                </div><!-- End activity item-->

                <div class="activity-item d-flex">
                  <div class="activite-label">MAR</div>
                  <i class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>
                  <div class="activity-content">
                  The east coast states, including Kelantan and Terengganu, experienced severe flooding due to the monsoon season. Over 20,000 residents were evacuated, with riverbanks overflowing and infrastructure damaged. 
                  </div>
                </div><!-- End activity item-->

                <div class="activity-item d-flex">
                  <div class="activite-label">MAY</div>
                  <i class='bi bi-circle-fill activity-badge text-primary align-self-start'></i>
                  <div class="activity-content">
                  Flash floods hit urban areas in Selangor after heavy rainfall, disrupting traffic and causing property damage in towns like Shah Alam and Klang
                  </div>
                </div><!-- End activity item-->

                <div class="activity-item d-flex">
                  <div class="activite-label">AUG</div>
                  <i class='bi bi-circle-fill activity-badge text-info align-self-start'></i>
                  <div class="activity-content">
                  Penampang and surrounding regions in Sabah faced major flooding after continuous downpours. Villages were cut off, and power outages compounded the crisis, prompting emergency responses
                  </div>
                </div><!-- End activity item-->

                <div class="activity-item d-flex">
                  <div class="activite-label">OCT</div>
                  <i class='bi bi-circle-fill activity-badge text-warning align-self-start'></i>
                  <div class="activity-content">
                  Northern states like Kedah and Perlis encountered flooding due to prolonged rains, which affected farmlands and residential areas
                  </div>
                </div><!-- End activity item-->

                <div class="activity-item d-flex">
                  <div class="activite-label">DEC</div>
                  <i class='bi bi-circle-fill activity-badge text-muted align-self-start'></i>
                  <div class="activity-content">
                  As part of the ongoing monsoon season, the east coast was again severely affected, with six states declaring disaster zones. Nearly 27,000 people sought refuge in relief centers
                  </div>
                </div><!-- End activity item-->

              </div>

            </div>
          </div><!-- End Recent Activity -->

        </div><!-- End Right side columns -->

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
  
   <!-- JavaScript to handle button click -->
  <script>

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