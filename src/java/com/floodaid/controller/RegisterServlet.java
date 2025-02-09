package com.floodaid.controller;

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
import com.floodaid.model.User;
import com.floodaid.model.UserDAO;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password"); // Stored as plain text (as per request)

        // Validate input fields
        if (name == null || email == null || role == null || username == null || password == null ||
                name.isEmpty() || email.isEmpty() || role.isEmpty() || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pages-register.html?error=missing_fields");
            return;
        }

        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            response.sendRedirect(request.getContextPath() + "/pages-register.html?error=invalid_email");
            return;
        }

        // Validate password length
        if (password.length() < 6) {
            response.sendRedirect(request.getContextPath() + "/pages-register.html?error=weak_password");
            return;
        }

        User newUser = new User(name, email, role, username, password);
        UserDAO userDAO = new UserDAO();

        // Register user and get user ID
        int userID = userDAO.registerUser(newUser);

        if (userID > 0) {
            // Insert into role-specific table
            boolean roleInserted = insertUserRole(userID, role);
            if (roleInserted) {
                response.sendRedirect(request.getContextPath() + "/pages-login.html?success=registered");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages-register.html?error=role_insert_failed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/pages-register.html?error=registration_failed");
        }
    }

    private boolean insertUserRole(int userID, String role) {
        String sql = "";
        UserDAO userDAO = new UserDAO();
        Integer shelterID = userDAO.findAvailableShelter(); // Get available shelter (if any)

        if ("admin".equalsIgnoreCase(role)) {
            sql = "INSERT INTO ADMIN (user_ID, admin_status) VALUES (?, 'Active')";
        } else if ("user".equalsIgnoreCase(role)) {
            sql = "INSERT INTO VICTIM (user_ID, shelter_ID) VALUES (?, NULL)";
        } else if ("volunteer".equalsIgnoreCase(role)) {
            if (shelterID != null) {
                sql = "INSERT INTO VOLUNTEER (user_ID, vol_employment, availability, is_leader, shelter_ID) VALUES (?, NULL, 'Available', 0, ?)";
            } else {
                sql = "INSERT INTO VOLUNTEER (user_ID, vol_employment, availability, is_leader, shelter_ID) VALUES (?, NULL, 'Available', 0, NULL)";
            }
        } else {
                return false;
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            
            if ("volunteer".equalsIgnoreCase(role) && shelterID != null) {
                stmt.setInt(2, shelterID); // Assign a shelter if available
            }
            
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
