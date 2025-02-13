package com.floodaid.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SignalDAO {
    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    // ✅ Insert a new signal
    public boolean registerSignal(String place, String area, String postcode, int userID) {
        String sql = "INSERT INTO SIGNAL (SIGNAL_TIME, SIGNAL_PLACE, SIGNAL_AREA, SIGNAL_POSTCODE, SIGNAL_STATUS, REMARK, USER_ID) VALUES (CURRENT_TIMESTAMP, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, place);
            stmt.setString(2, area);
            stmt.setString(3, postcode);
            stmt.setString(4, "Pending"); // Default status
            stmt.setString(5, "No Remark Yet"); // Default remark
            stmt.setInt(6, userID);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // ✅ Get all signal in db
    public List<Signal> getAllSignal() {
        List<Signal> signals = new ArrayList<>();
        String sql = "SELECT SIGNAL_ID, SIGNAL_TIME, SIGNAL_PLACE, SIGNAL_AREA, SIGNAL_POSTCODE, SIGNAL_STATUS, REMARK, USER_ID FROM SIGNAL";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                signals.add(new Signal( 
                    rs.getInt("SIGNAL_ID"),
                    rs.getTimestamp("SIGNAL_TIME"),
                    rs.getString("SIGNAL_PLACE"),
                    rs.getString("SIGNAL_AREA"),
                    rs.getString("SIGNAL_POSTCODE"),
                    rs.getString("SIGNAL_STATUS"),
                    rs.getString("REMARK"),
                    rs.getInt("USER_ID") 
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return signals;
    }
    
    // ✅ Get signal by id
    public Signal getSignalByID(int signalID) {
        String sql = "SELECT * FROM SIGNAL WHERE SIGNAL_ID=?";
        Signal signal = null;

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, signalID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                signal = new Signal(
                    rs.getInt("SIGNAL_ID"),
                    rs.getTimestamp("SIGNAL_TIME"),
                    rs.getString("SIGNAL_PLACE"),
                    rs.getString("SIGNAL_AREA"),
                    rs.getString("SIGNAL_POSTCODE"),
                    rs.getString("SIGNAL_STATUS"),
                    rs.getString("REMARK"),
                    rs.getInt("USER_ID")
                );
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return signal;
    }
    
    // ✅ Update signal by id
    public boolean updateSignal(String status, String remark, String otherRemark, int shelterID, int signalID, int userID) {
        if(status.equalsIgnoreCase("rejected")){
            String updateSignalSQL = "UPDATE SIGNAL SET SIGNAL_STATUS=?, REMARK=? WHERE SIGNAL_ID=?";
            String updateUserSQL = "UPDATE VICTIM SET SHELTER_ID=? WHERE USER_ID=?";
            
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                conn.setAutoCommit(false); // Start transaction

                // Update SIGNAL table
                try (PreparedStatement stmt1 = conn.prepareStatement(updateSignalSQL)) {
                    stmt1.setString(1, status);
                    if(remark.equalsIgnoreCase("other")){
                        stmt1.setString(2, otherRemark); 
                    }else{
                        stmt1.setString(2, remark);  
                    }
                    stmt1.setInt(3, signalID);
                    stmt1.executeUpdate();
                }
                
                 // Update VICTIM table
                try (PreparedStatement stmt2 = conn.prepareStatement(updateUserSQL)) {
                    stmt2.setNull(1, java.sql.Types.INTEGER); 
                    stmt2.setInt(2, userID);
                    stmt2.executeUpdate();
                }

                conn.commit(); // Commit transaction if both updates succeed
                return true;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }else if(status.equalsIgnoreCase("approved")){
            String updateSignalSQL = "UPDATE SIGNAL SET SIGNAL_STATUS=?, REMARK=? WHERE SIGNAL_ID=?";
            String updateUserSQL = "UPDATE VICTIM SET SHELTER_ID=? WHERE USER_ID=?";
            
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                conn.setAutoCommit(false); // Start transaction
                // Update SIGNAL table
                try (PreparedStatement stmt1 = conn.prepareStatement(updateSignalSQL)) {
                    stmt1.setString(1, status);
                    stmt1.setString(2, remark);
                    stmt1.setInt(3, signalID);
                    stmt1.executeUpdate();
                }

                // Update VICTIM table
                try (PreparedStatement stmt2 = conn.prepareStatement(updateUserSQL)) {
                    stmt2.setInt(1, shelterID); 
                    stmt2.setInt(2, userID);
                    stmt2.executeUpdate();
                }


                conn.commit(); // Commit transaction if both updates succeed
                return true;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }
        
        return false;
    }

}

