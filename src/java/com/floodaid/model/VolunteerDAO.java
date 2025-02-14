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
        String sql = "SELECT * FROM volunteer v JOIN users u ON v.user_ID = u.user_ID LEFT JOIN SHELTER s ON v.SHELTER_ID = s.SHELTER_ID WHERE v.user_ID = ?";

         try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                volunteer = new Volunteer(
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
                    rs.getInt("SHELTER_ID"),
                    rs.getString("SHELTER_NAME")
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

        String sql = "SELECT u.USER_ID, u.NAME, u.EMAIL, u.USER_ROLE, u.USERNAME, u.PASSWORD, " +
                 "u.NRIC, u.AGE, u.ADDRESS, u.PHONENUM, u.REGISTRATION_TIME, " +
                 "v.VOL_EMPLOYMENT, v.AVAILABILITY, v.IS_LEADER, v.SHELTER_ID " +
                 "FROM USERS u " +
                 "JOIN VOLUNTEER v ON u.USER_ID = v.USER_ID " +
                 "WHERE v.SHELTER_ID = ?"; //No exclusion of the current user

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
        String sql = "SELECT SHELTER_NAME FROM SHELTER WHERE shelter_ID = ?";
        String shelterName = null;

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, shelterID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                shelterName = rs.getString("SHELTER_NAME");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shelterName;
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
    
    public boolean updateVolunteer(int userID, String name, String nric, int age, String address, String phone, 
                               String email, String volEmployment, int shelterID, String availability) {
        String sqlUser = "UPDATE USERS SET NAME = ?, NRIC = ?, AGE = ?, ADDRESS = ?, PHONENUM = ?, EMAIL = ? WHERE USER_ID = ?";
        String sqlVolunteer = "UPDATE VOLUNTEER SET VOL_EMPLOYMENT = ?, SHELTER_ID = ?, AVAILABILITY = ? WHERE USER_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmtUser = conn.prepareStatement(sqlUser);
             PreparedStatement stmtVolunteer = conn.prepareStatement(sqlVolunteer)) {

            // 🔍 Debugging Output
            System.out.println("🔄 Updating USERS table for userID: " + userID);
            stmtUser.setString(1, name);
            stmtUser.setString(2, nric);
            stmtUser.setInt(3, age);
            stmtUser.setString(4, address);
            stmtUser.setString(5, phone);
            stmtUser.setString(6, email);
            stmtUser.setInt(7, userID);
            int rowsUpdatedUser = stmtUser.executeUpdate();

            System.out.println("🔄 Updating VOLUNTEER table for userID: " + userID);
            stmtVolunteer.setString(1, volEmployment);
            stmtVolunteer.setInt(2, shelterID);
            stmtVolunteer.setString(3, availability);
            stmtVolunteer.setInt(4, userID);
            int rowsUpdatedVolunteer = stmtVolunteer.executeUpdate();

            boolean success = (rowsUpdatedUser > 0 && rowsUpdatedVolunteer > 0);
            if (success) {
                System.out.println("✅ Update successful for userID: " + userID);
            } else {
                System.out.println("❌ Update failed, no rows affected.");
            }
            return success;

        } catch (SQLException e) {
            System.out.println("❌ SQL Exception: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // ✅ Retrieve all volunteers assigned to a specific shelter
    public List<Volunteer> getVolunteersByShelterID(int shelterID) {
        List<Volunteer> volunteers = new ArrayList<>();
        String sql = "SELECT u.USER_ID, u.NAME, u.EMAIL, u.AGE, u.PHONENUM, " +
                     "v.VOL_EMPLOYMENT, v.AVAILABILITY, v.IS_LEADER " +
                     "FROM USERS u " +
                     "JOIN VOLUNTEER v ON u.USER_ID = v.USER_ID " +
                     "WHERE v.SHELTER_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, shelterID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Volunteer volunteer = new Volunteer(
                    rs.getInt("USER_ID"),
                    rs.getString("NAME"),
                    rs.getString("EMAIL"),
                    "Volunteer", // Hardcoded role for volunteers
                    "", // Username not needed here
                    "", // Password not needed here
                    "", // NRIC not needed here
                    rs.getInt("AGE"),
                    "", // Address not needed here
                    rs.getString("PHONENUM"),
                    "", // Registration time not needed here
                    rs.getString("VOL_EMPLOYMENT"),
                    rs.getString("AVAILABILITY"),
                    rs.getInt("IS_LEADER"),
                    shelterID
                );
                volunteers.add(volunteer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return volunteers;
    }

    public boolean appointLeader(int volunteerID, int shelterID) {
        String sql = "UPDATE VOLUNTEER SET IS_LEADER = 1 WHERE USER_ID = ? AND SHELTER_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, volunteerID);
            stmt.setInt(2, shelterID);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean reassignVolunteerShelter(int volunteerID, int newShelterID) {
        String resetLeaderSQL = "UPDATE VOLUNTEER SET IS_LEADER = 0 WHERE USER_ID = ?";
        String updateShelterSQL = "UPDATE VOLUNTEER SET SHELTER_ID = ? WHERE USER_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement resetStmt = conn.prepareStatement(resetLeaderSQL);
             PreparedStatement updateStmt = conn.prepareStatement(updateShelterSQL)) {

            // Step 1: Reset is_leader if they were a leader
            resetStmt.setInt(1, volunteerID);
            resetStmt.executeUpdate(); // Execute leader reset

            // Step 2: Reassign the shelter
            updateStmt.setInt(1, newShelterID);
            updateStmt.setInt(2, volunteerID);
            int rowsUpdated = updateStmt.executeUpdate();

            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
