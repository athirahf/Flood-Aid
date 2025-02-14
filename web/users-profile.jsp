<%@page import="com.floodaid.model.EmergencyContact"%>
<%@page import="java.util.List"%>
<%@ page import="com.floodaid.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/users-extension.jsp" />

<%
    // Retrieve user object set in UsersProfileServlet
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("pages-login.html?error=session_expired");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Profile</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts meohhw -->
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
        <h1>Profile</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="users-index.jsp">Home</a></li>
                <li class="breadcrumb-item active">Profile</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section profile">
        <div class="row">
            <div class="col-xl-4">

              <div class="card">
                <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

                    <img src="assets/img/default-profile.png" alt="Profile" class="rounded-circle">
                    <h2><%= user.getName() %></h2>
                    <h3>User</h3>
                </div>
              </div>
            </div>

            <div class="col-xl-8">

                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <ul class="nav nav-tabs nav-tabs-bordered">
                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#emergency-contact">Emergency Contact</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                            </li>
                        </ul>

                        <div class="tab-content pt-2">
                            <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                <h5 class="card-title">Profile Details</h5>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Full Name</div>
                                    <div class="col-lg-9 col-md-8"><%= user.getName() %></div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">NRIC</div>
                                    <div class="col-lg-9 col-md-8"><%= user.getNric() %></div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Age</div>
                                    <div class="col-lg-9 col-md-8"><%= user.getAge() %></div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Address</div>
                                    <div class="col-lg-9 col-md-8"><%= user.getAddress() %></div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Phone</div>
                                    <div class="col-lg-9 col-md-8"><%= user.getPhoneNum() %></div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Email</div>
                                    <div class="col-lg-9 col-md-8"><%= user.getEmail() %></div>
                                </div>
                            </div>

                            <div class="tab-pane fade profile-edit pt-3" id="profile-edit">
                                <form action="UpdateProfileServlet" method="POST">
                                    <input type="hidden" name="userID" value="<%= session.getAttribute("userID") %>">
                                    <div class="row mb-3">
                                        <label for="name" class="col-md-4 col-lg-3 col-form-label">Full Name</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="text" id="name" name="name" value="<%= user.getName() %>" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="nric" class="col-md-4 col-lg-3 col-form-label">NRIC</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="text" id="nric" name="nric" value="<%= user.getNric() %>" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="age" class="col-md-4 col-lg-3 col-form-label">Age</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="number" id="age" name="age" value="<%= user.getAge() %>" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="address" class="col-md-4 col-lg-3 col-form-label">Address</label>
                                        <div class="col-md-8 col-lg-9">
                                            <textarea id="address" name="address" class="form-control"><%= user.getAddress() %></textarea>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="phone" class="col-md-4 col-lg-3 col-form-label">Phone Number</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="text" id="phone" name="phone" value="<%= user.getPhoneNum() %>" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="text" id="email" name="email" value="<%= user.getEmail() %>" class="form-control">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </form>
                            </div>

                            <!-- Emergency Contact Form -->
                            <div class="tab-pane fade profile-edit pt-3" id="emergency-contact">
                                <h5 class="card-title">Emergency Contacts</h5>

                                <%
                                    List<EmergencyContact> contacts = (List<EmergencyContact>) request.getAttribute("emergencyContacts");
                                    if (contacts == null || contacts.isEmpty()) { 
                                %>
                                    <p>You have no emergency contacts.</p>
                                <% } else { %>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Relation</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Default</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (EmergencyContact contact : contacts) { %>
                                                <tr>
                                                    <td><%= contact.getName() %></td>
                                                    <td><%= contact.getRelation() %></td>
                                                    <td><%= contact.getEmail() %></td>
                                                    <td><%= contact.getPhoneNum() %></td>
                                                    <td><%= contact.isDefault() ? "✅" : "" %></td>
                                                    <td>
                                                        <div style="display: flex; flex-direction: column; align-items: center; gap: 5px;">
                                                            <div class="filter">
                                                                <a href="#" data-bs-toggle="dropdown" class="btn btn-info rounded-pill btn-md bi-pencil-square"></a>
                                                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#editEmergencyContactModal" 
                                                                           onclick="openEditModal('<%= contact.getId() %>', '<%= contact.getName() %>', '<%= contact.getRelation() %>', '<%= contact.getEmail() %>', '<%= contact.getPhoneNum() %>', '<%= contact.isDefault() ? "1" : "0" %>')">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="SetDefaultEmergencyContactServlet?emerCtc_ID=<%= contact.getId() %>">Set as Default</a></li>
                                                                    <li><a class="dropdown-item text-danger" href="DeleteEmergencyContactServlet?emerCtc_ID=<%= contact.getId() %>" onclick="return confirmDelete();">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                <% } %>

                                <!-- Add Emergency Contact Button -->
                                <button type="button" class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#addEmergencyContactModal">+ Add Emergency Contact</button>

                                <!-- Add Emergency Contact Modal -->
                                <div class="modal fade" id="addEmergencyContactModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Add Emergency Contact</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="ManageEmergencyContactServlet" method="POST">
                                                    <input type="hidden" name="user_ID" value="<%= user.getUserID() %>">
                                                    <div class="mb-3">
                                                        <label for="emerCtc_name" class="form-label">Full Name</label>
                                                        <input type="text" class="form-control" id="emerCtc_name" name="emerCtc_name" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="emerCtc_relation" class="form-label">Relationship</label>
                                                        <input type="text" class="form-control" id="emerCtc_relation" name="emerCtc_relation" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="emerCtc_email" class="form-label">Email</label>
                                                        <input type="email" class="form-control" id="emerCtc_email" name="emerCtc_email">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="emerCtc_phoneNum" class="form-label">Phone Number</label>
                                                        <input type="text" class="form-control" id="emerCtc_phoneNum" name="emerCtc_phoneNum" required>
                                                    </div>
                                                    <div class="mb-3 form-check">
                                                        <input type="checkbox" class="form-check-input" id="emerCtc_default" name="emerCtc_default" value="1">
                                                        <label class="form-check-label" for="emerCtc_default">Set as default</label>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">Save Contact</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                                    
                            <!-- Edit Emergency Contact Modal -->
                            <div class="modal fade" id="editEmergencyContactModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Edit Emergency Contact</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="UpdateEmergencyContactServlet" method="POST">
                                                <input type="hidden" id="editEmerCtc_ID" name="emerCtc_ID">
                                                <div class="mb-3">
                                                    <label for="editEmerCtc_name" class="form-label">Full Name</label>
                                                    <input type="text" class="form-control" id="editEmerCtc_name" name="emerCtc_name" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="editEmerCtc_relation" class="form-label">Relationship</label>
                                                    <input type="text" class="form-control" id="editEmerCtc_relation" name="emerCtc_relation" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="editEmerCtc_email" class="form-label">Email</label>
                                                    <input type="email" class="form-control" id="editEmerCtc_email" name="emerCtc_email">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="editEmerCtc_phoneNum" class="form-label">Phone Number</label>
                                                    <input type="text" class="form-control" id="editEmerCtc_phoneNum" name="emerCtc_phoneNum" required>
                                                </div>
                                                <div class="mb-3 form-check">
                                                    <input type="checkbox" class="form-check-input" id="editEmerCtc_default" name="emerCtc_default" value="1">
                                                    <label class="form-check-label" for="editEmerCtc_default">Set as default</label>
                                                </div>
                                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>                        
                        
                            <div class="tab-pane fade pt-3" id="profile-change-password">
                                <form action="ChangePasswordServlet" method="POST" onsubmit="return validatePasswordChange()">
                                    <input type="hidden" name="userID" value="<%= session.getAttribute("userID") %>">
                                    <input type="hidden" name="username" value="<%= session.getAttribute("username") %>">
                                    <div class="row mb-3">
                                        <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="currentPassword" type="password" class="form-control" id="currentPassword" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="newPassword" type="password" class="form-control" id="newPassword" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="renewPassword" type="password" class="form-control" id="renewPassword" required>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary">Change Password</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div><!-- End Bordered Tabs -->

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
    function openEditModal(id, name, relation, email, phoneNum, isDefault) {
        document.getElementById("editEmerCtc_ID").value = id;
        document.getElementById("editEmerCtc_name").value = name;
        document.getElementById("editEmerCtc_relation").value = relation;
        document.getElementById("editEmerCtc_email").value = email;
        document.getElementById("editEmerCtc_phoneNum").value = phoneNum;
        document.getElementById("editEmerCtc_default").checked = (isDefault === "1");
    }
  </script>


</body>

</html>