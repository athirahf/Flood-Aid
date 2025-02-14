package com.floodaid.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShelterDAO {
    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    // ✅ Register a new shelter
    public boolean registerShelter(String shelterName, int shelterCapacity, String shelterAddress) {
        String sql = "INSERT INTO SHELTER (SHELTER_NAME, SHELTER_CAPACITY, CURRENT_OCCUPANT, SHELTER_ADDRESS) VALUES (?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, shelterName);
            stmt.setInt(2, shelterCapacity);
            stmt.setInt(3, 0); // ✅ Default CURRENT_OCCUPANT to 0
            stmt.setString(4, shelterAddress);

            int rowsInserted = stmt.executeUpdate();
            System.out.println("Shelter Inserted: " + shelterName + ", Rows affected: " + rowsInserted);

            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Retrieve all shelters
    public List<Shelter> getAllShelters() {
        List<Shelter> shelters = new ArrayList<>();
        String sql = "SELECT SHELTER_ID, SHELTER_NAME, SHELTER_CAPACITY, CURRENT_OCCUPANT, SHELTER_ADDRESS FROM SHELTER";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                shelters.add(new Shelter(
                    rs.getInt("SHELTER_ID"),
                    rs.getString("SHELTER_NAME"),
                    rs.getInt("SHELTER_CAPACITY"),
                    rs.getInt("CURRENT_OCCUPANT"),
                    rs.getString("SHELTER_ADDRESS")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shelters;
    }
    
    public Shelter getShelterByID(int shelterID) {
        String sql = "SELECT * FROM SHELTER WHERE SHELTER_ID=?";
        Shelter shelter = null;

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, shelterID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                shelter = new Shelter(
                    rs.getInt("SHELTER_ID"),
                    rs.getString("SHELTER_NAME"),
                    rs.getInt("SHELTER_CAPACITY"),
                    rs.getString("SHELTER_ADDRESS")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shelter;
    }
    
    public boolean updateShelter(int shelterID, String name, int capacity, String address) {
        String sql = "UPDATE SHELTER SET SHELTER_NAME=?, SHELTER_CAPACITY=?, SHELTER_ADDRESS=? WHERE SHELTER_ID=?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setInt(2, capacity);
            stmt.setString(3, address);
            stmt.setInt(4, shelterID);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteShelter(int shelterID) {
        String sql = "DELETE FROM SHELTER WHERE SHELTER_ID=?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, shelterID);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean incrementOccupantCount(int shelterID) {
        String sql = "UPDATE SHELTER SET CURRENT_OCCUPANT = CURRENT_OCCUPANT + 1 WHERE SHELTER_ID = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, shelterID);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public String getShelterNameByID(int shelterID) {
        String sql = "SELECT SHELTER_NAME FROM SHELTER WHERE SHELTER_ID = ?";
        String shelterName = "Unknown Shelter"; // Default if not found

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

}
