package com.floodaid.model;

import java.sql.Timestamp;

public class Need {
    private int needID;
    private String needItem;
    private int needQuantity;
    private Timestamp timeRequest;
    private Timestamp actionTime;
    private String needStatus;
    private int shelterID;
    private int userID;

    // Default constructor
    public Need() {
    }

    // Parameterized constructor
    public Need(int needID, String needItem, int needQuantity, Timestamp timeRequest, Timestamp actionTime, String needStatus, int shelterID, int userID) {
        this.needID = needID;
        this.needItem = needItem;
        this.needQuantity = needQuantity;
        this.timeRequest = timeRequest;
        this.actionTime = actionTime;
        this.needStatus = needStatus;
        this.shelterID = shelterID;
        this.userID = userID;
    }

    // Getters and Setters
    public int getNeedID() {
        return needID;
    }

    public void setNeedID(int needID) {
        this.needID = needID;
    }

    public String getNeedItem() {
        return needItem;
    }

    public void setNeedItem(String needItem) {
        this.needItem = needItem;
    }

    public int getNeedQuantity() {
        return needQuantity;
    }

    public void setNeedQuantity(int needQuantity) {
        this.needQuantity = needQuantity;
    }

    public Timestamp getTimeRequest() {
        return timeRequest;
    }

    public void setTimeRequest(Timestamp timeRequest) {
        this.timeRequest = timeRequest;
    }

    public Timestamp getActionTime() {
        return actionTime;
    }

    public void setActionTime(Timestamp actionTime) {
        this.actionTime = actionTime;
    }

    public String getNeedStatus() {
        return needStatus;
    }

    public void setNeedStatus(String needStatus) {
        this.needStatus = needStatus;
    }

    public int getShelterID() {
        return shelterID;
    }

    public void setShelterID(int shelterID) {
        this.shelterID = shelterID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }
}
