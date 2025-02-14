package com.floodaid.model;

public class Victim extends User {
    private int shelterID;
    private String emergencyContact;

    // Constructor that extends User properties and adds shelterID & emergencyContact
    public Victim(int userID, String name, String email, String role, String username, String password, String nric, int age, String address, String phoneNum, int shelterID, String emergencyContact) {
        super(userID, name, email, role, username, password, nric, age, address, phoneNum);
        this.shelterID = shelterID;
        this.emergencyContact = emergencyContact;
    }

    // Getters and Setters
    public int getShelterID() { return shelterID; }
    public void setShelterID(int shelterID) { this.shelterID = shelterID; }

    public String getEmergencyContact() { return emergencyContact; }
    public void setEmergencyContact(String emergencyContact) { this.emergencyContact = emergencyContact; }
}
