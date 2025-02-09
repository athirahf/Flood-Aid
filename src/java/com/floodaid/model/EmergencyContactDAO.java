package com.floodaid.model;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmergencyContactDAO {
    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    public List<EmergencyContact> getEmergencyContactsByUserID(int userID) {
        List<EmergencyContact> contacts = new ArrayList<>();
        String sql = "SELECT * FROM EMERGENCY_CONTACT WHERE user_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                contacts.add(new EmergencyContact(
                    rs.getInt("emerCtc_ID"),
                    rs.getInt("user_ID"),
                    rs.getString("emerCtc_name"),
                    rs.getString("emerCtc_relation"),
                    rs.getString("emerCtc_email"),
                    rs.getString("emerCtc_phoneNum"),
                    rs.getInt("emerCtc_default") == 1
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contacts;
    }
    
    public boolean addEmergencyContact(EmergencyContact contact) {
        String sql = "INSERT INTO EMERGENCY_CONTACT (emerCtc_name, emerCtc_relation, emerCtc_email, emerCtc_phoneNum, emerCtc_default, user_ID) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, contact.getName());
            stmt.setString(2, contact.getRelation());
            stmt.setString(3, contact.getEmail());
            stmt.setString(4, contact.getPhoneNum());
            stmt.setInt(5, contact.isDefault() ? 1 : 0);
            stmt.setInt(6, contact.getUserId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean setDefaultContact(int userID, int emerCtc_ID) {
        String sqlReset = "UPDATE EMERGENCY_CONTACT SET emerCtc_default = 0 WHERE user_ID = ?";
        String sqlSet = "UPDATE EMERGENCY_CONTACT SET emerCtc_default = 1 WHERE emerCtc_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmtReset = conn.prepareStatement(sqlReset);
             PreparedStatement stmtSet = conn.prepareStatement(sqlSet)) {

            stmtReset.setInt(1, userID);
            stmtReset.executeUpdate(); // Reset all to non-default

            stmtSet.setInt(1, emerCtc_ID);
            return stmtSet.executeUpdate() > 0; // Set the selected one as default
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEmergencyContact(int emerCtc_ID) {
        String sql = "DELETE FROM EMERGENCY_CONTACT WHERE emerCtc_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, emerCtc_ID);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateEmergencyContact(int emerCtc_ID, String name, String relation, String email, String phoneNum, int isDefault) {
        String sql = "UPDATE EMERGENCY_CONTACT SET emerCtc_name = ?, emerCtc_relation = ?, emerCtc_email = ?, emerCtc_phoneNum = ?, emerCtc_default = ? WHERE emerCtc_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, relation);
            stmt.setString(3, email);
            stmt.setString(4, phoneNum);
            stmt.setInt(5, isDefault);
            stmt.setInt(6, emerCtc_ID);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
