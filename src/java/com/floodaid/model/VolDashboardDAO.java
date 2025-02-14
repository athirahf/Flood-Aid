package com.floodaid.model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class VolDashboardDAO {
     private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

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
