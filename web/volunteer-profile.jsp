<%@ page import="com.floodaid.model.Volunteer" %>
<%@ page import="java.util.List, com.floodaid.model.Shelter" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />
<jsp:include page="include/volunteer-extension.jsp" />

<%
    // Retrieve user object set in VolProfileServlet
    Volunteer volunteer = (Volunteer) session.getAttribute("volunteer");
    List<Shelter> shelterList = (List<Shelter>) session.getAttribute("shelterList");

    if (volunteer == null) {
        response.sendRedirect("pages-login.html?error=session_expired");
        return;
    }
    
    String shelterName = "NOT ASSIGNED";
    if (volunteer.getShelterID() != 0) {
        for (Shelter shelter : shelterList) {
            if (shelter.getShelterID() == volunteer.getShelterID()) {
                shelterName = shelter.getShelterName();
                break;
            }
        }
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

  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">
  <link href="assets/css/style.css" rel="stylesheet">
</head>

<body>

  <main id="main" class="main">
    <div class="pagetitle">
      <h1>Profile</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="VolDashboardServlet">Home</a></li>
          <li class="breadcrumb-item active">Profile</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section profile">
      <div class="row">
        <!-- Profile Card Section (Left) -->
        <div class="col-md-4">
          <div class="card">
            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
              
            <img src="assets/img/default-profile.png" alt="Profile" class="rounded-circle">
              <h2><%= volunteer.getName() %></h2>
              <h3>Volunteer</h3>

              <button class="btn btn-primary mt-2" 
                  style="background-color: <%= volunteer.getShelterName() != null ? "#007bff" : "#808080" %>;  
                        border: none; 
                        font-size: 14px; 
                        padding: 6px 12px; 
                        border-radius: 10px; 
                        color: #fff; 
                        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); 
                        text-transform: uppercase;">
                  <%= volunteer.getShelterName() != null ? volunteer.getShelterName() : "NOT ASSIGNED" %>
              </button>

        
            </div>
          </div>
        </div>

        <!-- Tabs Section (Right) -->
        <div class="col-md-8">
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
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                </li>
              </ul>
              
<!-- Change Start Here -->
                  <div class="tab-content pt-2">
                      <!-- Profile Overview -->
                      <div class="tab-pane fade show active profile-overview" id="profile-overview">
                          <h5 class="card-title">Profile Details</h5>
                          
                          <div class="row">
                              <div class="col-lg-3 col-md-4 label">Full Name</div>
                              <div class="col-lg-9 col-md-8"><%= volunteer.getName() %></div>
                          </div>

                          <div class="row">
                              <div class="col-lg-3 col-md-4 label">NRIC</div>
                              <div class="col-lg-9 col-md-8"><%= volunteer.getNric() %></div>
                          </div>

                          <div class="row">
                              <div class="col-lg-3 col-md-4 label">Age</div>
                              <div class="col-lg-9 col-md-8"><%= volunteer.getAge() %></div>
                          </div>

                          <div class="row">
                              <div class="col-lg-3 col-md-4 label">Email</div>
                              <div class="col-lg-9 col-md-8"><%= volunteer.getEmail() %></div>
                          </div>

                          <div class="row">
                              <div class="col-lg-3 col-md-4 label">Phone</div>
                              <div class="col-lg-9 col-md-8"><%= volunteer.getPhoneNum() %></div>
                          </div>

                          <div class="row">
                              <div class="col-lg-3 col-md-4 label">Employment</div>
                              <div class="col-lg-9 col-md-8"><%= volunteer.getVolEmployment() %></div>
                          </div>

                       <div class="row">
                              <div class="col-lg-3 col-md-4 label">Address</div>
                              <div class="col-lg-9 col-md-8"><%= volunteer.getAddress()%></div>
                          </div>

                          <div class="row">
                              <div class="col-lg-3 col-md-4 label">Shelter Assigned</div>
                              <div class="col-lg-9 col-md-8"><%= shelterName %></div>
                          </div>

                          <div class="row">
                              <div class="col-lg-3 col-md-4 label">Status</div>
                              <div class="col-lg-9 col-md-8">
                                  <span class="badge <%= volunteer.getAvailability().equals("Available") ? "bg-success" : "bg-danger" %>">
                                    <%= volunteer.getAvailability() %>
                                  </span>
                              </div>
                          </div>
                                  
                      </div>

                      <!-- Profile Edit -->
                      <div class="tab-pane fade profile-edit pt-3" id="profile-edit">
                          <form action="VolUpdateProfileServlet" method="POST">
                              <input type="hidden" name="userID" value="<%= volunteer.getUserID() %>">
                              <div class="row mb-3">
                                  <label for="name" class="col-md-4 col-lg-3 col-form-label">Full Name</label>
                                  <div class="col-md-8 col-lg-9">
                                      <input name="name" type="text" class="form-control" id="name" value="<%= volunteer.getName() %>">
                                  </div>
                              </div>

                              <div class="row mb-3">
                                  <label for="nric" class="col-md-4 col-lg-3 col-form-label">NRIC</label>
                                  <div class="col-md-8 col-lg-9">
                                      <input name="nric" type="text" class="form-control" id="nric" value="<%= volunteer.getNric() %>">
                                  </div>
                              </div>

                              <div class="row mb-3">
                                <label for="age" class="col-md-4 col-lg-3 col-form-label">Age</label>
                                <div class="col-md-8 col-lg-9">
                                  <input type="number" id="age" name="age" value="<%= volunteer.getAge() %>" class="form-control">
                                </div>
                              </div>

                              <div class="row mb-3">
                                  <label for="email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                  <div class="col-md-8 col-lg-9">
                                      <input name="email" type="email" class="form-control" id="email" value="<%= volunteer.getEmail() %>">
                                  </div>
                              </div>
                              
                              <div class="row mb-3">
                                <label for="phone" class="col-md-4 col-lg-3 col-form-label">Phone Number</label>
                                <div class="col-md-8 col-lg-9">
                                  <input type="text" id="phone" name="phone" value="<%= volunteer.getPhoneNum() %>" class="form-control">
                                </div>
                              </div>

                             <div class="row mb-3">
                                <label for="volEmployment" class="col-md-4 col-lg-3 col-form-label">Employment</label>
                                <div class="col-md-8 col-lg-9">
                                    <select name="volEmployment" class="form-control" id="volEmployment">
                                        <option value="Working" <%= "Working".equals(volunteer.getVolEmployment()) ? "selected" : "" %>>Working</option>
                                        <option value="Student" <%= "Student".equals(volunteer.getVolEmployment()) ? "selected" : "" %>>Student</option>
                                        <option value="N/A" <%= "N/A".equals(volunteer.getVolEmployment()) ? "selected" : "" %>>N/A</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="address" class="col-md-4 col-lg-3 col-form-label">Address</label>
                                <div class="col-md-8 col-lg-9">
                                    <input name="address" type="text" class="form-control" id="address" value="<%= volunteer.getAddress() %>">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="shelterID" class="col-md-4 col-lg-3 col-form-label">Choose Shelter</label>
                                <div class="col-md-8 col-lg-9">
                                    <select name="shelterID" class="form-control" id="shelterID">
                                        <% for (Shelter shelter : shelterList) { %>
                                            <option value="<%= shelter.getShelterID() %>" 
                                                <%= (volunteer.getShelterID() == shelter.getShelterID()) ? "selected" : "" %>>
                                                <%= shelter.getShelterName() %>
                                            </option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>

                              <div class="row mb-3">
                                <label for="availability" class="col-md-4 col-lg-3 col-form-label">Availability Status</label>
                                <div class="col-md-8 col-lg-9">
                                    <select name="availability" class="form-control" id="status">
                                        <option value="Available" <%= "Available".equals(volunteer.getAvailability()) ? "selected" : "" %>>Available</option>
                                        <option value="Unavailable" <%= "Unavailable".equals(volunteer.getAvailability()) ? "selected" : "" %>>Unavailable</option>
                                    </select>
                                </div>
                              </div>


                              <div class="text-center">
                                  <button type="submit" class="btn btn-primary">Save Changes</button>
                          </div>
                        </form>
                      </div>

 <!-- Change Finish Here           -->

                <div class="tab-pane fade pt-3" id="profile-change-password">
                    
                        <!-- Change Password Form -->
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
              </div><!-- End Bordered Tabs -->
              
              
            </div>
          </div>
        </div>
      </div>
    </section>

  </main><!-- End #main -->

  <footer id="footer" class="footer">
    <div class="container">
      <div class="copyright">
<!--        &copy; 2024 <strong><span>Volunteer Management</span></strong>. All Rights Reserved-->
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top"><i class="bi bi-arrow-up-short"></i></a>

  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/js/main.js"></script>
  
  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>
  
  <script>
    function validatePasswordChange() {
        let newPassword = document.getElementById("newPassword").value;
        let renewPassword = document.getElementById("renewPassword").value;

        if (newPassword !== renewPassword) {
            alert("New Password and Re-entered Password do not match.");
            return false;
        }

        if (newPassword.length < 6) {
            alert("New password must be at least 6 characters long.");
            return false;
        }

        return true;
    }
  </script>
</body>

</html>
