package com.floodaid.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VictimDAO {
    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    // ✅ Get all victims assigned to a specific shelter
    public List<Victim> getVictimsByShelterID(int shelterID) {
        List<Victim> victims = new ArrayList<>();
        String sql = "SELECT u.USER_ID, u.NAME, u.EMAIL, u.USER_ROLE, u.USERNAME, u.PASSWORD, " +
                     "u.NRIC, u.AGE, u.ADDRESS, u.PHONENUM, v.SHELTER_ID " +
                     "FROM USERS u " +
                     "JOIN VICTIM v ON u.USER_ID = v.USER_ID " +
                     "WHERE v.SHELTER_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, shelterID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Fetch emergency contact
                String emergencyContact = getEmergencyContact(rs.getInt("USER_ID"));

                Victim victim = new Victim(
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
                    rs.getInt("SHELTER_ID"),
                    emergencyContact
                );
                victims.add(victim);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return victims;
    }

    // ✅ Get emergency contact for a victim
    public String getEmergencyContact(int userID) {
        String sql = "SELECT EMERCTC_PHONENUM FROM EMERGENCY_CONTACT WHERE USER_ID = ? ORDER BY EMERCTC_DEFAULT DESC, EMERCTC_ID ASC";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString("EMERCTC_PHONENUM"); // Return default or first contact
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "-"; // Return "-" if no emergency contact found
    }
    
    public boolean reassignVictimShelter(int victimID, int newShelterID) {
        String sql = "UPDATE VICTIM SET SHELTER_ID = ? WHERE USER_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, newShelterID);
            stmt.setInt(2, victimID);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public Victim getVictimByID(int userID) {
        String sql = "SELECT u.USER_ID, u.NAME, u.EMAIL, u.USER_ROLE, u.USERNAME, u.PASSWORD, " +
                     "u.NRIC, u.AGE, u.ADDRESS, u.PHONENUM, v.SHELTER_ID, " +
                     "(SELECT EMERCTC_PHONENUM FROM EMERGENCY_CONTACT WHERE USER_ID = u.USER_ID AND EMERCTC_DEFAULT = 1 FETCH FIRST ROW ONLY) AS DEFAULT_EMERGENCY_CONTACT, " +
                     "(SELECT EMERCTC_PHONENUM FROM EMERGENCY_CONTACT WHERE USER_ID = u.USER_ID FETCH FIRST ROW ONLY) AS ANY_EMERGENCY_CONTACT " +
                     "FROM USERS u " +
                     "JOIN VICTIM v ON u.USER_ID = v.USER_ID " +
                     "WHERE u.USER_ID = ?";

        Victim victim = null;
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Get emergency contact
                String emergencyContact = rs.getString("DEFAULT_EMERGENCY_CONTACT");
                if (emergencyContact == null) {
                    emergencyContact = rs.getString("ANY_EMERGENCY_CONTACT");
                }
                if (emergencyContact == null) {
                    emergencyContact = "-"; // Default value if no emergency contact found
                }

                // ✅ Match constructor properly
                victim = new Victim(
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
                    rs.getInt("SHELTER_ID"),
                    emergencyContact
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return victim;
    }

}
