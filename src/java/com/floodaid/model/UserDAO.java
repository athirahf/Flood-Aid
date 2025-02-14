package com.floodaid.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    // for register at pages-register.html
    public int registerUser(User user) {
        String sql = "INSERT INTO USERS (name, email, user_role, username, password) VALUES (?, ?, ?, ?, ?)";
        int userID = -1; // Default value indicating failure

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql, new String[]{"user_ID"})) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getRole());
            stmt.setString(4, user.getUsername());
            stmt.setString(5, user.getPassword());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                // Retrieve the generated user_ID
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        userID = generatedKeys.getInt(1);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userID;
    }
    
    public Integer findAvailableShelter() {
        String sql = "SELECT shelter_ID FROM SHELTER ORDER BY shelter_ID ASC FETCH FIRST 1 ROWS ONLY";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("shelter_ID"); // Return the first available shelter
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // No shelters registered yet
    }

    // for login at pages-login.html
    public User validateUser(String username, String password) {
        String sql = "SELECT user_ID, name, email, user_role FROM USERS WHERE username = ? AND password = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getInt("user_ID"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("user_role"),
                    username,
                    password
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Retrieve user details by username
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM USERS WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getInt("user_ID"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("user_role"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("nric"),
                    rs.getInt("age"),
                    rs.getString("address"),
                    rs.getString("phoneNum")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Fixed getUserByID() to use correct connection variables
    public User getUserByID(int userID) {
        String sql = "SELECT * FROM USERS WHERE user_ID = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getInt("user_ID"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("user_role"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("nric"),
                    rs.getInt("age"),
                    rs.getString("address"),
                    rs.getString("phoneNum")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update user profile details
    public boolean updateUserProfile(String username, String name, String nric, int age, String phone, String address) {
        String sql = "UPDATE USERS SET name = ?, nric = ?, age = ?, phoneNum = ?, address = ? WHERE username = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, nric);
            stmt.setInt(3, age);
            stmt.setString(4, phone);
            stmt.setString(5, address);
            stmt.setString(6, username);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateUser(int userID, String name, String nric, int age, String email, String phone, String address) {
        String sql = "UPDATE USERS SET name = ?, nric = ?, age = ?, email = ?, phoneNum = ?, address = ? WHERE user_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, nric);
            stmt.setInt(3, age);
            stmt.setString(4, email);
            stmt.setString(5, phone);
            stmt.setString(6, address);
            stmt.setInt(7, userID);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Change user password
    public boolean changePassword(String username, String currentPassword, String newPassword) {
        String sql = "UPDATE USERS SET password = ? WHERE username = ? AND password = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPassword);
            stmt.setString(2, username);
            stmt.setString(3, currentPassword);

            int rowsUpdated = stmt.executeUpdate();

            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // ✅ Retrieve all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT user_ID, name, email, user_role, username, password, nric, age, address, phoneNum, registration_time FROM USERS";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                users.add(new User(
                    rs.getInt("user_ID"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("user_role"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("nric"),
                    rs.getInt("age"),
                    rs.getString("address"),
                    rs.getString("phoneNum"),
                    rs.getString("registration_time")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    public boolean deleteUser(int userID) {
        String sql = "DELETE FROM USERS WHERE user_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public Integer getVolunteerShelter(int userID) {
        String sql = "SELECT shelter_ID FROM VOLUNTEER WHERE user_ID = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("shelter_ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // No shelter assigned
    }
    
    public static int getCount(String tableName) {
        int count = 0;
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

            String query = "SELECT COUNT(*) FROM "+ tableName;
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) count = rs.getInt(1);

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
