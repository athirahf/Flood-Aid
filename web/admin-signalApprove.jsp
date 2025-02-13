<%-- 
    Document   : AdminSignal_Action
    Author     : rosha
--%>

<%@page import="com.floodaid.model.Signal"%>
<%@page import="com.floodaid.model.SignalDAO"%>
<%@page import="com.floodaid.model.Shelter"%>
<%@page import="com.floodaid.model.ShelterDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/admin-extension.jsp" />

<%
    String error = request.getParameter("error");
    if ("shelter_not_selected".equals(error)) {
%>
    <script>
        alert("Please select a shelter before approving the signal.");
    </script>
<%
    }
%>

<%
    String SignalID = request.getParameter("SignalID");
    String ShelterID = request.getParameter("ShelterID");

    // ✅ Debugging
    System.out.println("Received Signal ID " + SignalID);

    if (SignalID == null || SignalID.isEmpty()) {
%>
        <h3 style="color: red;">Error: Signal ID is missing!</h3>
        <a href="AdminSignalServlet">Back to Signal List</a>
<%
        return;
    }

    int signalID = Integer.parseInt(SignalID);
    int shelterID = Integer.parseInt(ShelterID);
    SignalDAO signalDAO = new SignalDAO();
    Signal signal = signalDAO.getSignalByID(signalID);
%>

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
        <body class="modal-open">
            <!-- #main -->
            <main id="main" class="main">
                <!-- Page Title -->
                    <div class="pagetitle">
                    <h1>Signal Action</h1>
                        <nav>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="admin-index.jsp">Home</a></li>
                                <li class="breadcrumb-item"><a href="AdminSignalServlet">Manage Signal</a></li>
                                <li class="breadcrumb-item active">Signal Action</li>
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
                                    <form action="AdminSignalApproveServlet" method="POST">
                                        <h5 class="card-title">Signal Requested</h5>
                                        Signal ID: <input value="<%=signalID%>" disabled><br><br>
                                        <input name="SignalID" value="<%=signalID%>" hidden>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="input-group mb-3">
                                                    <span class="input-group-text" id="basic-addon1">VICTIM ID</span>
                                                    <input type="text" class="form-control" value="<%= signal.getUserID() %>" aria-label="VictimID" aria-describedby="basic-addon1" style="background-color: white;" readonly disabled>
                                                    <input type="text" class="form-control" value="<%= signal.getUserID() %>" name="userID" aria-label="VictimID" aria-describedby="basic-addon1" style="background-color: white;" hidden>
                                                </div>
                                                <div class="input-group mb-3">
                                                    <span class="input-group-text" id="basic-addon1">PLACE</span>
                                                    <input type="text" class="form-control" value="<%= signal.getSignalPlace() %>" aria-label="place" aria-describedby="basic-addon1" style="background-color: white;" readonly disabled>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="input-group mb-3">
                                                    <span class="input-group-text" id="basic-addon1">TIME REQUESTED</span>
                                                    <input type="text" class="form-control" value="<%= signal.getSignalTime() %>" aria-label="timeRequested" aria-describedby="basic-addon1" style="background-color: white;" readonly disabled>
                                                </div>
                                                <div class="input-group mb-3">
                                                    <span class="input-group-text" id="basic-addon1">POSTCODE</span>
                                                    <input type="text" class="form-control" value="<%= signal.getSignalPostcode() %>" aria-label="postcode" aria-describedby="basic-addon1" style="background-color: white;" readonly disabled>
                                                </div>
                                            </div>
                                            <div class="input-group mb-3">
                                                <span class="input-group-text" id="basic-addon1">ADDRESS</span>
                                                <textarea class="form-control" style="height: 0px; background-color: white;" value="<%= signal.getSignalArea() %>" readonly disabled></textarea>
                                            </div>
                                            <% 
                                                ShelterDAO shelterDAO = new ShelterDAO();
                                                Shelter shelterr = shelterDAO.getShelterByID(shelterID);
                                                if(shelterr==null){
                                                    shelterr = new Shelter(0, "Not Found", 0, "N/A"); // Default shelter
                                                }
                                            %>
                                            <div class="input-group mb-3">
                                                <div class="col-lg-2"><span class="input-group-text">SHELTER ID</span></div>
                                                <div class="col-lg-8"><input class="form-control" value="<%= shelterr.getShelterID() %>" style="background-color: white;" readonly disabled></input></div>
                                                <input class="form-control" value="<%= shelterr.getShelterID() %>" name="shelterID" style="background-color: white;" hidden></input>
                                                <div class="col-lg-2"><center><button type="button" class="btn btn-secondary"data-bs-toggle="modal" data-bs-target="#modalDialogScrollable">Select Shelter</button></center></div>
                                                <div class="modal fade" id="modalDialogScrollable" tabindex="-1" aria-modal="true" role="dialog">
                                                    <div class="modal-dialog modal-dialog-scrollable modal-xl">
                                                      <div class="modal-content">
                                                        <div class="modal-header">
                                                          <h5 class="modal-title">Select Shelter</h5>
                                                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <label>Find shelter to be send</label><br>
                                                            <label style="font-size: 12px;">You can search shelter address with details given.</label>
                                                            <center>
                                                                <!-- Table with stripped rows -->
                                                                <table class="table datatable">
                                                                  <thead>
                                                                    <tr>
                                                                      <th scope="col">#</th>
                                                                      <th scope="col">Name</th>
                                                                      <th scope="col">Capacity</th>
                                                                      <th scope="col">Current Occupant</th>
                                                                      <th scope="col">Address</th>
                                                                      <th scope="col">Select This Shelter</th>
                                                                    </tr>
                                                                  </thead>
                                                                  <tbody>
                                                                      <% 
                                                                          shelterDAO = new ShelterDAO();
                                                                          List<Shelter> shelters = shelterDAO.getAllShelters();
                                                                          if (shelters != null) {
                                                                              int rowNumber = 1; // ✅ Start row number from 1
                                                                              for (Shelter shelter : shelters) {
                                                                      %>
                                                                          <tr>
                                                                              <th scope="row"><%= rowNumber++ %></th> <!-- ✅ Uses row number instead of Shelter ID -->
                                                                              <td><%= shelter.getShelterName() %></td>
                                                                              <td><%= shelter.getShelterCapacity() %></td>
                                                                              <td><%= shelter.getCurrentOccupant() %></td> <!-- Assuming current occupants will be added later -->
                                                                              <td><%= shelter.getShelterAddress() %></td>
                                                                              <td>
                                                                                  <div style="display: flex; flex-direction: column; align-items: center; gap: 5px;">
                                                                                      <div class="filter">
                                                                                              <button type="button" onclick="window.location.href='admin-signalApprove.jsp?SignalID=<%= signal.getSignalID() %>&ShelterID=<%= shelter.getShelterID() %>'" class="btn btn-warning rounded-pill btn-sm ri-bookmark-fill"></button>
                                                                                      </div>
                                                                                  </div>
                                                                              </td>
                                                                          </tr>
                                                                      <% 
                                                                              }
                                                                          } else { 
                                                                      %>
                                                                          <tr><td colspan="6">No shelters found.</td></tr>
                                                                      <% } %>
                                                                  </tbody>
                                                                </table>
                                                                <!-- End Table with stripped rows -->
                                                            </center>
                                                            <br><br><br>
                                                        </div>
                                                        <div class="modal-footer">
                                                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                      </div>
                                                    </div>
                                                  </div>
                                            </div>
                                            <center> 
                                                <div class="btn-group col-lg-6" role="group" aria-label="Basic mixed styles example">
                                                    <a type="button" class="btn btn-secondary" href="AdminSignalServlet">Back</a>
                                                    <button type="submit" class="btn btn-success">Approve</button>
                                                </div>
                                            </center>
                                        </div>
                                    </form>
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
                <script defer="" src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon="{&quot;rayId&quot;:&quot;910d0621bc769cab&quot;,&quot;serverTiming&quot;:{&quot;name&quot;:{&quot;cfExtPri&quot;:true,&quot;cfL4&quot;:true,&quot;cfSpeedBrain&quot;:true,&quot;cfCacheStatus&quot;:true}},&quot;version&quot;:&quot;2025.1.0&quot;,&quot;token&quot;:&quot;68c5ca450bae485a842ff76066d69420&quot;}" crossorigin="anonymous"></script>
                <svg id="SvgjsSvg1001" width="2" height="0" xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.dev" style="overflow: hidden; top: -100%; left: -100%; position: absolute; opacity: 0;"><defs id="SvgjsDefs1002"></defs><polyline id="SvgjsPolyline1003" points="0,0"></polyline><path id="SvgjsPath1004" d="M0 0 "></path></svg>
                
                <script src="https://bootstrapmade.com/assets/js/demo.js?v=42"></script>
                <script async="" src="https://www.googletagmanager.com/gtag/js?id=G-P7JSYB1CSP"></script>
                <script>window.dataLayer = window.dataLayer || []; function gtag(){dataLayer.push(arguments);} gtag('js', new Date()); gtag('config', 'G-P7JSYB1CSP');</script>
                <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        var modal = new bootstrap.Modal(document.getElementById('modalDialogScrollable'));
                    });
                </script>
            </div>
            <!-- END OF JS FILE -->
        </body>
    <!-- End BODY -->
</html>


