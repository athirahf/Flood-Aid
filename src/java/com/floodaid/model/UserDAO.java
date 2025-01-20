package com.floodaid.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private String jdbcURL = "jdbc:derby://localhost:1527/FloodAid";
    private String jdbcUsername = "FloodAid";
    private String jdbcPassword = "FloodAid";

    private static final String INSERT_USER_SQL = 
        "INSERT INTO USERS (user_ID, name, email, user_role, username, password, registration_time) " +
        "VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";

    private static final String INSERT_ADMIN_SQL = 
        "INSERT INTO ADMIN (user_ID, admin_status) VALUES (?, 'active')";

    private static final String INSERT_VOLUNTEER_SQL = 
        "INSERT INTO VOLUNTEER (user_ID, is_leader) VALUES (?, 0)";

    private static final String INSERT_VICTIM_SQL = 
        "INSERT INTO VICTIM (user_ID, loc_country) VALUES (?, 'Malaysia')";

    private static final String GET_MAX_USER_ID_SQL = 
        "SELECT MAX(CAST(user_ID AS INT)) FROM USERS";

    public boolean registerUser(User user) {
        boolean isRegistered = false;

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            System.out.println("Connected to database.");

            // Generate a new incremental user_ID
            String userID = generateNewUserID(connection);
            System.out.println("Generated user_ID: " + userID);
            user.setUserID(userID);

            // Insert into USERS table
            try (PreparedStatement userStmt = connection.prepareStatement(INSERT_USER_SQL)) {
                userStmt.setString(1, user.getUserID());
                userStmt.setString(2, user.getName());
                userStmt.setString(3, user.getEmail());
                userStmt.setString(4, user.getRole());
                userStmt.setString(5, user.getUsername());
                userStmt.setString(6, user.getPassword());
                userStmt.executeUpdate();
            }

            // Role-specific insertion
            switch (user.getRole()) {
                case "Admin":
                    try (PreparedStatement adminStmt = connection.prepareStatement(INSERT_ADMIN_SQL)) {
                        adminStmt.setString(1, user.getUserID());
                        adminStmt.executeUpdate();
                    }
                    break;

                case "Volunteer":
                    try (PreparedStatement volunteerStmt = connection.prepareStatement(INSERT_VOLUNTEER_SQL)) {
                        volunteerStmt.setString(1, user.getUserID());
                        volunteerStmt.executeUpdate();
                    }
                    break;

                case "User":
                    try (PreparedStatement victimStmt = connection.prepareStatement(INSERT_VICTIM_SQL)) {
                        victimStmt.setString(1, user.getUserID());
                        victimStmt.executeUpdate();
                    }
                    break;
            }

            isRegistered = true;

        } catch (Exception e) {
            System.err.println("Error during registration: " + e.getMessage());
            e.printStackTrace();
        }

        return isRegistered;
    }

    private String generateNewUserID(Connection connection) {
        int newID = 1; // Default starting ID
        try (PreparedStatement stmt = connection.prepareStatement(GET_MAX_USER_ID_SQL);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                int maxID = rs.getInt(1); // Get the current max ID
                newID = maxID + 1;       // Increment by 1
            }

        } catch (Exception e) {
            System.err.println("Error generating user_ID: " + e.getMessage());
            e.printStackTrace();
        }
        return String.valueOf(newID); // Return as a string
    }
    
    public User validateAndGetUser(String username, String password) {
        User user = null;
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            String sql = "SELECT user_ID, name, user_role FROM USERS WHERE username = ? AND password = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, username);
                statement.setString(2, password);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        String userID = resultSet.getString("user_ID");
                        String name = resultSet.getString("name");
                        String role = resultSet.getString("user_role");
                        user = new User(userID, name, null, role, username, null); // Include user_ID
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean updateProfile(String userID, String fullName, String phone, int age, String address, 
                             String postcode, String city, String state, String country) {
        String updateSQL = "UPDATE USERS SET name = ?, phone = ?, age = ?, address = ?, postcode = ?, " +
                           "city = ?, state = ?, country = ? WHERE user_ID = ?";
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = connection.prepareStatement(updateSQL)) {
            stmt.setString(1, fullName);
            stmt.setString(2, phone);
            stmt.setInt(3, age);
            stmt.setString(4, address);
            stmt.setString(5, postcode);
            stmt.setString(6, city);
            stmt.setString(7, state);
            stmt.setString(8, country);
            stmt.setString(9, userID);

            return stmt.executeUpdate() > 0; // Return true if update was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean changePassword(String userID, String currentPassword, String newPassword) {
        String checkPasswordSQL = "SELECT password FROM USERS WHERE user_ID = ?";
        String updatePasswordSQL = "UPDATE USERS SET password = ? WHERE user_ID = ?";

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement checkStmt = connection.prepareStatement(checkPasswordSQL);
             PreparedStatement updateStmt = connection.prepareStatement(updatePasswordSQL)) {

            // Verify current password
            checkStmt.setString(1, userID);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getString("password").equals(currentPassword)) {
                // Update password
                updateStmt.setString(1, newPassword);
                updateStmt.setString(2, userID);
                return updateStmt.executeUpdate() > 0; // Return true if update was successful
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


}