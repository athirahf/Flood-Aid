package com.floodaid.model;

import java.sql.*;

public class SignalDAO {
    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    // ✅ Insert a new signal
    public boolean registerSignal(String place, String area, String postcode, int userID) {
        String sql = "INSERT INTO SIGNAL (SIGNAL_TIME, SIGNAL_PLACE, SIGNAL_AREA, SIGNAL_POSTCODE, SIGNAL_STATUS, USER_ID) VALUES (CURRENT_TIMESTAMP, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, place);
            stmt.setString(2, area);
            stmt.setString(3, postcode);
            stmt.setString(4, "Pending"); // Default status
            stmt.setInt(5, userID);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

