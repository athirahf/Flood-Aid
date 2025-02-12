package com.floodaid.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VolunteerDAO {
    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    // Method to update Volunteer details
    public boolean updateVolunteerDetails(Volunteer volunteer) {
        String updateUserSQL = "UPDATE USERS SET name = ?, email = ?, username = ?, password = ?, nric = ?, age = ?, address = ?, phoneNum = ? WHERE user_ID = ?";
        String updateVolunteerSQL = "UPDATE VOLUNTEER SET vol_employment = ?, availability = ?, is_leader = ?, shelter_ID = ? WHERE user_ID = ?";
        
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            conn.setAutoCommit(false); // Start transaction

            try (PreparedStatement userStmt = conn.prepareStatement(updateUserSQL);
                 PreparedStatement volunteerStmt = conn.prepareStatement(updateVolunteerSQL)) {

                // Update USER table
                userStmt.setString(1, volunteer.getName());
                userStmt.setString(2, volunteer.getEmail());
                userStmt.setString(3, volunteer.getUsername());
                userStmt.setString(4, volunteer.getPassword());
                userStmt.setString(5, volunteer.getNric());
                userStmt.setInt(6, volunteer.getAge());
                userStmt.setString(7, volunteer.getAddress());
                userStmt.setString(8, volunteer.getPhoneNum());
                userStmt.setInt(9, volunteer.getUserID());
                userStmt.executeUpdate();

                // Update VOLUNTEER table
                volunteerStmt.setString(1, volunteer.getVolEmployment());
                volunteerStmt.setString(2, volunteer.getAvailability());
                volunteerStmt.setInt(3, volunteer.isLeader());
                volunteerStmt.setInt(4, volunteer.getShelterID());
                volunteerStmt.setInt(5, volunteer.getUserID());
                volunteerStmt.executeUpdate();

                conn.commit(); // Commit transaction
                return true;
            } catch (SQLException e) {
                conn.rollback(); // Rollback if any update fails
                e.printStackTrace();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // ✅ Retrieve volunteer details by userID
    public Volunteer getVolunteerByID(int userID) {
        Volunteer volunteer = null;
        String sql = "SELECT * FROM volunteer v JOIN users u ON v.user_ID = u.user_ID WHERE v.user_ID = ?";

         try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                volunteer = new Volunteer(
                    rs.getInt("userID"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("role"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("nric"),
                    rs.getInt("age"),
                    rs.getString("address"),
                    rs.getString("phoneNum"),
                    rs.getString("registrationTime"),
                    rs.getString("volEmployment"),
                    rs.getString("availability"),
                    rs.getInt("isLeader"),
                    rs.getInt("shelterID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return volunteer;
    }

    
    // Get the shelter ID of the currently logged-in user
    public int getShelterIDByUserID(int userID) {
        String sql = "SELECT shelter_ID FROM VOLUNTEER WHERE user_ID = ?";
        int shelterID = -1; // Default value if not found

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                shelterID = rs.getInt("shelter_ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shelterID;
    }


    // Get all volunteers assigned to the same shelter, including the logged-in user
    public List<Volunteer> getVolunteersByCurrentUser(int userID) {
        List<Volunteer> volunteers = new ArrayList<>();
        int shelterID = getShelterIDByUserID(userID);

        if (shelterID == -1) {
            return volunteers; // Return empty list if no shelter is found
        }

        String sql = "SELECT u.USER_ID, u.NAME, u.EMAIL u.USER_ROLE, u.USERNAME, u.PASSWORD, String NRIC,  u.AGE, u.ADDRESS u.PHONENUM, " +
                     "u.REGISTRATION_TIME v.VOL_EMPLOYMENT, v.AVAILABILITY, v.IS_LEADER, v.SHELTER_ID " +
                     "FROM USERS u " +
                     "JOIN VOLUNTEER v ON u.USER_ID = v.USER_ID " +
                     "WHERE v.SHELTER_ID = ?"; // No exclusion of the current user

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, shelterID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Volunteer volunteer = new Volunteer(
                    rs.getInt("USER_ID"),
                    rs.getString("NAME"),
                    rs.getString("EMAIL"),
                    rs.getString("USER_ROLE"),
                    rs.getString("USERNAME"),
                    rs.getString("PASSWORD"),
                    rs.getString("NRIC"),
                    rs.getInt("AGE"),
                    rs.getString("ADDRESS"),
                    rs.getString("PHONENUM"),
                    rs.getString("REGISTRATION_TIME"),
                    rs.getString("VOL_EMPLOYMENT"),
                    rs.getString("AVAILABILITY"),
                    rs.getInt("IS_LEADER"),
                    rs.getInt("SHELTER_ID")
                );
                volunteers.add(volunteer);
            }
            // Log the number of volunteers fetched
            System.out.println("Number of Volunteers Fetched: " + volunteers.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return volunteers;
    }


    // Method to get the shelter name using shelter ID
    public String getShelterName(int shelterID) {
        String sql = "SELECT shelterName FROM SHELTER WHERE shelter_ID = ?";
        String shelterName = null;

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, shelterID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                shelterName = rs.getString("shelterName");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shelterName;
    }
}
