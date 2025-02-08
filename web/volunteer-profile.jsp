<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="checkSession.jsp" />

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
  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
      <a href="homepage.html" class="logo d-flex align-items-center">
        <img src="assets/img/FloodAidLogo.png" alt="">
        <span class="d-none d-lg-block">Banjir Rescue </span>
      </a>
      <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">

        <li class="nav-item dropdown pe-3">

          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <img src="assets/img/default-profile.png" alt="Profile" class="rounded-circle">
            <!-- <span class="d-none d-md-block dropdown-toggle ps-2">K. Anderson</span> -->
          </a><!-- End Profile Iamge Icon -->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
              <h6><%= session.getAttribute("username") %></h6>
              <span>Volunteer</span>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="volunteer-profile.jsp">
                <i class="bi bi-person"></i>
                <span>My Profile</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="LogoutServlet">
                <i class="bi bi-box-arrow-right"></i>
                <span>Log Out</span>
              </a>
            </li>

          </ul><!-- End Profile Dropdown Items -->
        </li><!-- End Profile Nav -->

      </ul>
    </nav><!-- End Icons Navigation -->

  </header><!-- End Header -->

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link collapsed" href="volunteer-index.jsp">
          <i class="bi bi-grid"></i>
          <span>Dashboard</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <!-- View Team Nav -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="volunteer-viewteam.jsp">
          <i class="bi bi-people-fill"></i>
          <span>View Team</span>
        </a>
      </li><!-- End View Team Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="volunteer-reqneed.jsp">
          <i class="bi bi-bag-plus"></i>
          <span>Request Need</span>
        </a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="volunteer-need.jsp">
          <i class="bi bi-bag-plus-fill"></i>
          <span>Manage Need</span>
        </a>
      </li>

      <!-- Profile Page Nav -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="volunteer-profile.jsp">
          <i class="bi bi-person"></i>
          <span>Profile</span>
        </a>
      </li><!-- End Profile Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="LogoutServlet">
          <i class="bi bi-box-arrow-right"></i>
          <span>Log Out</span>
        </a>
      </li><!-- End Logout Page Nav -->

    </ul>

  </aside><!-- End Sidebar-->

  <main id="main" class="main">
    <div class="pagetitle">
      <h1>Profile</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="volunteer-index.jsp">Home</a></li>
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
              <h2>Ahmad Amin</h2>
              <h3>Volunteer</h3>

              <!-- Shelter Name -->
              <button class="btn btn-primary mt-2" style="background-color: #808080; border: none; font-size: 14px; padding: 6px 12px; border-radius: 10px; color: #fff; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); text-transform: uppercase;">
                Seri Muda
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
              <div class="tab-content pt-2">
                <div class="tab-pane fade show active profile-overview" id="profile-overview">
                  
                <h5 class="card-title">Profile Details</h5>

                <div class="row">
                  <div class="col-lg-3 col-md-4 label ">Full Name</div>
                  <div class="col-lg-9 col-md-8">Ahmad Amin Bin Aminuddin</div>
                </div>

                <div class="row">
                  <div class="col-lg-3 col-md-4 label">NRIC</div>
                  <div class="col-lg-9 col-md-8">990213-10-2099</div>
                </div>

                <div class="row">
                  <div class="col-lg-3 col-md-4 label">Email</div>
                  <div class="col-lg-9 col-md-8">aminaminuddin99@gmail.com</div>
                </div>

                <div class="row">
                  <div class="col-lg-3 col-md-4 label">Phone</div>
                  <div class="col-lg-9 col-md-8">019-6659132</div>
                </div>

                <div class="row">
                  <div class="col-lg-3 col-md-4 label">Occupation</div>
                  <div class="col-lg-9 col-md-8">Student</div>
                </div>

                <div class="row">
                  <div class="col-lg-3 col-md-4 label">Address</div>
                  <div class="col-lg-9 col-md-8">No 60, Taman Melawati, Seksyen 18, 4000 Shah Alam, Selangor</div>
                </div>

                <div class="row">
                  <div class="col-lg-3 col-md-4 label">Shelter Assigned</div>
                  <div class="col-lg-9 col-md-8">Seri Muda</div>
                </div>
           

                <div class="row">
                  <div class="col-lg-3 col-md-4 label">Status</div>
                  <div class="col-lg-9 col-md-8">
                    <span class="badge bg-success">Available</span>
                  </div>
                </div>
                
                </div>
                

                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                     <!-- Profile Edit Form -->
                <form>

                  <div class="row mb-3">
                    <label for="fullName" class="col-md-4 col-lg-3 col-form-label">Full Name</label>
                    <div class="col-md-8 col-lg-9">
                      <input name="fullName" type="text" class="form-control" id="fullName" value="Ahmad Amin Bin Aminuddin">
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="nric" class="col-md-4 col-lg-3 col-form-label">NRIC</label>
                    <div class="col-md-8 col-lg-9">
                      <input name="nric" type="text" class="form-control" id="nric" value="990213-10-2099">
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                    <div class="col-md-8 col-lg-9">
                      <input name="email" type="email" class="form-control" id="email" value="aminaminuddin99@gmail.com">
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="phone" class="col-md-4 col-lg-3 col-form-label">Phone</label>
                    <div class="col-md-8 col-lg-9">
                      <input name="phone" type="text" class="form-control" id="phone" value="019-6659132">
                    </div>
                  </div>

                  <!-- Updated Occupation Section -->
                  <div class="row mb-3">
                    <label class="col-md-4 col-lg-3 col-form-label">Occupation</label>
                    <div class="col-md-8 col-lg-9">
                      <div class="form-check">
                        <input class="form-check-input" type="radio" name="occupation" id="occupation1" value="Working Adult">
                        <label class="form-check-label" for="occupation1">Working Adult</label>
                      </div>
                      <div class="form-check">
                        <input class="form-check-input" type="radio" name="occupation" id="occupation2" value="Student" checked>
                        <label class="form-check-label" for="occupation2">Student</label>
                      </div>
                      <div class="form-check">
                        <input class="form-check-input" type="radio" name="occupation" id="occupation3" value="Others/Not Applicable">
                        <label class="form-check-label" for="occupation3">Others/Not Applicable</label>
                      </div>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="address" class="col-md-4 col-lg-3 col-form-label">Address</label>
                    <div class="col-md-8 col-lg-9">
                      <input name="address" type="text" class="form-control" id="address" value="No 60, Taman Melawati, Seksyen 18, 4000 Shah Alam, Selangor">
                    </div>
                  </div>

                  <!-- Updated Choose Shelter Dropdown -->
                  <div class="row mb-3">
                    <label for="shelter" class="col-md-4 col-lg-3 col-form-label">Choose Shelter</label>
                    <div class="col-md-8 col-lg-9">
                      <select name="shelter" class="form-control" id="shelter">
                        <option value="Seri Muda">Seri Muda</option>
                        <option value="Seksyen 7">Seksyen 7</option>
                        <option value="Kampung Padang Jawa">Kampung Padang Jawa</option>
                        <option value="Taman Sri Andalas">Taman Sri Andalas</option>
                        <option value="Bukit Naga">Bukit Naga</option>
                        <option value="Taman Alam Megah">Taman Alam Megah</option>
                      </select>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="Availability" class="col-md-4 col-lg-3 col-form-label">Availability Status</label>
                    <div class="col-md-8 col-lg-9">
                      <select name="Availability" class="form-control" id="Availability">
                        <option value="Available">Available</option>
                        <option value="Unavailable">Unavailable</option>
                      </select>
                    </div>
                  </div>


                  <div class="text-center">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                  </div>
                </form>

                </div>

           

                <div class="tab-pane fade pt-3" id="profile-change-password">
                  <!-- Change Password Form -->
                  <form>

                    <div class="row mb-3">
                      <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="password" type="password" class="form-control" id="currentPassword">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="newpassword" type="password" class="form-control" id="newPassword">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="renewpassword" type="password" class="form-control" id="renewPassword">
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">Change Password</button>
                    </div>
                  </form><!-- End Change Password Form -->

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
        &copy; 2024 <strong><span>Volunteer Management</span></strong>. All Rights Reserved
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top"><i class="bi bi-arrow-up-short"></i></a>

  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/js/main.js"></script>
</body>

</html>
