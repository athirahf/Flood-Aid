package com.floodaid.controller;

import com.floodaid.model.User;
import com.floodaid.model.UserDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/VolUpdateProfileServlet")
public class VolUpdateProfileServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String DB_USER = "FloodAid";
    private static final String DB_PASSWORD = "FloodAid";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("pages-login.html?error=session_expired");
            return;
        }

        int userID = (int) session.getAttribute("userID"); 
        System.out.println("Updating user ID: " + userID); // ✅ Debug log

        String name = request.getParameter("name");
        String nric = request.getParameter("nric");
        String age = request.getParameter("age");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            conn.setAutoCommit(false);

            String sql = "UPDATE USERS SET name=?, nric=?, age=?, address=?, phoneNum=?, email=? WHERE user_ID=?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, name);
            stmt.setString(2, nric);
            stmt.setInt(3, Integer.parseInt(age));
            stmt.setString(4, address);
            stmt.setString(5, phone);
            stmt.setString(6, email);
            stmt.setInt(7, userID);

            int rowsUpdated = stmt.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated); // ✅ Debug log

            if (rowsUpdated >= 0) { // ✅ Allow no-change updates
                conn.commit();

                UserDAO userDAO = new UserDAO();
                User updatedUser = userDAO.getUserByID(userID);

                if (updatedUser == null) {
                    System.out.println("User retrieval failed after update for ID: " + userID);
                } else {
                    System.out.println("Updated user fetched: " + updatedUser.getName() + " | Email: " + updatedUser.getEmail());
                    session.setAttribute("user", updatedUser);
                    System.out.println("Session updated: " + ((User) session.getAttribute("user")).getName());
                }

                response.sendRedirect("volunteer-profile.jsp?success=profile_updated");
            } else {
                conn.rollback();
                response.sendRedirect("volunteer-profile.jsp?error=no_update");
            }

            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("volunteer-profile.jsp?error=update_failed");
        }
    }
}





//package com.floodaid.controller;
//
//import com.floodaid.model.User;
//import com.floodaid.model.Volunteer;
//import com.floodaid.model.UserDAO;
//import com.floodaid.model.VolunteerDAO;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//@WebServlet("/VolUpdateProfileServlet")
//public class VolUpdateProfileServlet extends HttpServlet {
//    private static final String DB_URL = "jdbc:derby://localhost:1527/FloodAid";
//    private static final String DB_USER = "FloodAid";
//    private static final String DB_PASSWORD = "FloodAid";
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        // ✅ Retrieve the session
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("userID") == null) {
//            response.sendRedirect("pages-login.html?error=session_expired");
//            return;
//        }
//
//        int userID = (int) session.getAttribute("userID"); // ✅ Get user ID
//
//        // ✅ Get parameters from form
//        String name = request.getParameter("name");
//        String nric = request.getParameter("nric");
//        String age = request.getParameter("age");
//        String address = request.getParameter("address");
//        String phone = request.getParameter("phone");
//        String email = request.getParameter("email");
//
//        // ✅ Additional volunteer fields
//        String employmentStatus = request.getParameter("employmentStatus");
//        String availability = request.getParameter("availability");
//        boolean isLeader = request.getParameter("isLeader") != null;
//
//        try {
//            Class.forName("org.apache.derby.jdbc.ClientDriver");
//            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
//            conn.setAutoCommit(false);
//
//            // ✅ Update USER table
//            String sqlUser = "UPDATE USERS SET name=?, nric=?, age=?, address=?, phoneNum=?, email=? WHERE user_ID=?";
//            PreparedStatement stmtUser = conn.prepareStatement(sqlUser);
//
//            stmtUser.setString(1, name);
//            stmtUser.setString(2, nric);
//            stmtUser.setInt(3, Integer.parseInt(age));
//            stmtUser.setString(4, address);
//            stmtUser.setString(5, phone);
//            stmtUser.setString(6, email);
//            stmtUser.setInt(7, userID);
//
//            int rowsUpdatedUser = stmtUser.executeUpdate();
//
//            // ✅ Update VOLUNTEER table
//            String sqlVolunteer = "UPDATE VOLUNTEERS SET volEmployment=?, availability=?, isLeader=? WHERE user_ID=?";
//            PreparedStatement stmtVolunteer = conn.prepareStatement(sqlVolunteer);
//
//            stmtVolunteer.setString(1, employmentStatus);
//            stmtVolunteer.setString(2, availability);
//            stmtVolunteer.setBoolean(3, isLeader);
//            stmtVolunteer.setInt(4, userID);
//
//            int rowsUpdatedVolunteer = stmtVolunteer.executeUpdate();
//
//            if (rowsUpdatedUser > 0 || rowsUpdatedVolunteer > 0) {
//                conn.commit();
//
//                // ✅ Fetch updated user and volunteer data
//                UserDAO userDAO = new UserDAO();
//                VolunteerDAO volunteerDAO = new VolunteerDAO();
//                User updatedUser = userDAO.getUserByID(userID);
//                Volunteer updatedVolunteer = volunteerDAO.getVolunteerByID(userID);
//
//                // ✅ Update session attributes
//                session.setAttribute("user", updatedUser);
//                session.setAttribute("volunteer", updatedVolunteer);
//
//                response.sendRedirect("volunteer-profile.jsp?success=profile_updated");
//            } else {
//                conn.rollback();
//                response.sendRedirect("volunteer-profile.jsp?error=no_update");
//            }
//
//            stmtUser.close();
//            stmtVolunteer.close();
//            conn.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("volunteer-profile.jsp?error=update_failed");
//        }
//    }
//}
