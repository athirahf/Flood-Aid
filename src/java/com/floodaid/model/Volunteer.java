package com.floodaid.model;

public class Volunteer extends User {
    private String volEmployment;
    private String availability;
    private boolean isLeader;
    private int shelterID;

    // Constructor including all fields
    public Volunteer(int userID, String name, String email, String role, String username, String password, String nric, int age, String address, String phoneNum, String registrationTime, String volEmployment, String availability, boolean isLeader, int shelterID) {
        super(userID, name, email, role, username, password, nric, age, address, phoneNum, registrationTime);
        this.volEmployment = volEmployment;
        this.availability = availability;
        this.isLeader = isLeader;
        this.shelterID = shelterID;
    }

    // Constructor for new volunteer registration
    public Volunteer(String name, String email, String role, String username, String password, String volEmployment, String availability, boolean isLeader, int shelterID) {
        super(name, email, role, username, password);
        this.volEmployment = volEmployment;
        this.availability = availability;
        this.isLeader = isLeader;
        this.shelterID = shelterID;
    }

    // Getters and Setters
    public String getVolEmployment() { return volEmployment; }
    public void setVolEmployment(String volEmployment) { this.volEmployment = volEmployment; }

    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }

    public boolean isLeader() { return isLeader; }
    public void setLeader(boolean isLeader) { this.isLeader = isLeader; }

    public int getShelterID() { return shelterID; }
    public void setShelterID(int shelterID) { this.shelterID = shelterID; }
}
