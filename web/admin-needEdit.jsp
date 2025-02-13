<%@page import="com.floodaid.model.Need"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/admin-extension.jsp" />
<%@ page import="java.util.List" %>

<%@ page import="com.floodaid.model.Need" %>
<%@ page import="com.floodaid.model.NeedDAO" %>
<%@ page import="com.floodaid.model.Shelter" %>
<%@ page import="com.floodaid.model.ShelterDAO" %>

<%
    Integer userID = (Integer) session.getAttribute("userID");
    String needID = request.getParameter("NeedID");
    NeedDAO needDAO = new NeedDAO();
    Need need = needDAO.getNeedByID(Integer.parseInt(needID));
    String ShelterID = request.getParameter("ShelterID");
    int shelterID = Integer.parseInt(ShelterID);
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Request Need</title>
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

    <!-- Page Title -->
    <div class="pagetitle">
      <h1>Edit Need</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="admin-editneed.html">Home</a></li>
          <li class="breadcrumb-item"><a href="AdminNeedServlet">Manage Need</a></li>
          <li class="breadcrumb-item active">Edit Request Need</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Edit Request Need</h5>
              <form class="row g-3" method="POST" action="AdminNeedEditServlet?NeedID=<%= need.getNeedID() %>">
                <div class="col-md-12">
                <% 
                      ShelterDAO shelterDAO = new ShelterDAO();
                      Shelter shelterr = shelterDAO.getShelterByID(shelterID);
                      if(shelterr==null){
                          shelterr = new Shelter(0, "Not Found", 0, "N/A"); // Default shelter
                      }
                  %>
                  <div class="input-group mb-3">
                      <div class="col-lg-2"><span class="input-group-text">SHELTER ID</span></div>
                      <div class="col-lg-8"><input class="form-control" value="<%= shelterID %>" style="background-color: white;" readonly disabled></input></div>
                      <input class="form-control" value="<%= shelterID %>" name="shelterID" style="background-color: white;" hidden></input>
                      <div class="col-lg-2"><center><button type="button" class="btn btn-info"data-bs-toggle="modal" data-bs-target="#modalDialogScrollable">Select Shelter</button></center></div>
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
                                                                    <button type="button" onclick="window.location.href='admin-needEdit.jsp?NeedID=<%= need.getNeedID() %>&ShelterID=<%= shelter.getShelterID() %>'" class="btn btn-warning rounded-pill btn-sm ri-add-circle-line"></button>
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
                </div>
                <div class="col-md-12">
                  <div class="form-floating">
                      <input type="text" class="form-control" id="item" name="NEED_ITEM" value="<%= need.getNeedItem() %>" required>
                    <label for="item">Item</label>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="number" class="form-control" id="quantity" name="NEED_QUANTITY" value="<%= need.getNeedQuantity() %>" required>
                    <label for="quantity">Quantity</label>
                  </div>
                </div>


                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" id="user" name="USER_ID" value="<%= userID %>">
                    <label for="user">Enter your user ID</label>
                  </div>
                </div>
                    
                <div class="col-md-12">
                    <div class="form-floating">
                        <select class="form-control" id="Status" name="NEED_STATUS">
                            <option value="<%= need.getNeedStatus() %>"><%= need.getNeedStatus() %></option>
                            <option value="Pending">Pending</option>
                            <option value="Approved">Approved</option>
                            <option value="Rejected">Rejected</option>
                        </select>
                        <label for="Status">Select Status</label>
                    </div>
                </div>

                <div class="text-center">
                  <button type="submit" class="btn btn-primary">Confirm Edit</button>
                  <button type="reset" class="btn btn-secondary">Clear</button>
                </div>
              </form>


            </div>
          </div>
        </div>
      </div>
    </section>

    <a type="reset" class="btn btn-warning" href="AdminNeedServlet">Back to Need List</a>

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
  </footer>
  <!-- End Footer -->

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