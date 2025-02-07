package com.floodaid.model;

public class Shelter {
    private int shelterID;
    private String shelterName;  // ✅ Renamed to match DB
    private int shelterCapacity; // ✅ Renamed to match DB
    private int currentOccupant;
    private String shelterAddress; // ✅ Renamed to match DB

    // Constructor
    public Shelter(int shelterID, String shelterName, int shelterCapacity, int currentOccupant, String shelterAddress) {
        this.shelterID = shelterID;
        this.shelterName = shelterName;
        this.shelterCapacity = shelterCapacity;
        this.currentOccupant = currentOccupant;
        this.shelterAddress = shelterAddress;
    }
    
    // Constructor for getShelterByID
    public Shelter(int shelterID, String shelterName, int shelterCapacity, String shelterAddress) {
        this.shelterID = shelterID;
        this.shelterName = shelterName;
        this.shelterCapacity = shelterCapacity;
        this.shelterAddress = shelterAddress;
    }

    // Getters
    public int getShelterID() { return shelterID; }
    public String getShelterName() { return shelterName; }
    public int getShelterCapacity() { return shelterCapacity; }
    public int getCurrentOccupant() { return currentOccupant; }
    public String getShelterAddress() { return shelterAddress; }
}
