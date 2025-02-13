package com.floodaid.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NeedDAO {
    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    // ✅ Insert a new need
    public boolean registerNeed(String needItem, int needQuantity, int shelterID, int userID) {
        String sql = "INSERT INTO NEED (NEED_ITEM, NEED_QUANTITY, TIME_REQUEST, ACTION_TIME, NEED_STATUS, SHELTER_ID, USER_ID) VALUES (?, ?, CURRENT_TIMESTAMP, NULL, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, needItem);
            stmt.setInt(2, needQuantity);
            stmt.setString(3, "Pending"); // Default status
            stmt.setInt(4, shelterID);
            stmt.setInt(5, userID);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Get all needs in db
    public List<Need> getAllNeeds() {
        List<Need> needs = new ArrayList<>();
        String sql = "SELECT NEED_ID, NEED_ITEM, NEED_QUANTITY, TIME_REQUEST, ACTION_TIME, NEED_STATUS, SHELTER_ID, USER_ID FROM NEED";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                needs.add(new Need( 
                    rs.getInt("NEED_ID"),
                    rs.getString("NEED_ITEM"),
                    rs.getInt("NEED_QUANTITY"),
                    rs.getTimestamp("TIME_REQUEST"),
                    rs.getTimestamp("ACTION_TIME"),
                    rs.getString("NEED_STATUS"),
                    rs.getInt("SHELTER_ID"),
                    rs.getInt("USER_ID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return needs;
    }

    // ✅ Get need by ID
    public Need getNeedByID(int needID) {
        String sql = "SELECT * FROM NEED WHERE NEED_ID=?";
        Need need = null;

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, needID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                need = new Need(
                    rs.getInt("NEED_ID"),
                    rs.getString("NEED_ITEM"),
                    rs.getInt("NEED_QUANTITY"),
                    rs.getTimestamp("TIME_REQUEST"),
                    rs.getTimestamp("ACTION_TIME"),
                    rs.getString("NEED_STATUS"),
                    rs.getInt("SHELTER_ID"),
                    rs.getInt("USER_ID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return need;
    }
    
    public boolean updateNeed(String needItem, int needQuantity, int shelterID, String needStatus, int needID) {
        String sql = "UPDATE NEED SET ACTION_TIME=CURRENT_TIMESTAMP, NEED_ITEM = ?, NEED_QUANTITY = ?, SHELTER_ID = ?, NEED_STATUS=? WHERE NEED_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, needItem);
            stmt.setInt(2, needQuantity);
            stmt.setInt(3, shelterID);
            stmt.setString(4, needStatus);
            stmt.setInt(5, needID);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteNeed(int needID) {
        String sql = "DELETE FROM NEED WHERE NEED_ID = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, needID);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}

