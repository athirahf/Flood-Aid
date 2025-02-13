package com.floodaid.model;
import java.sql.Timestamp;

public class Signal {
    private int signalID;
    private Timestamp signalTime;
    private String signalPlace;
    private String signalArea;
    private String signalPostcode;
    private String signalStatus;
    private String remark;
    private int userID;

    // Constructors
    public Signal() {}

    public Signal(int signalID, Timestamp signalTime, String signalPlace, String signalArea, String signalPostcode, String signalStatus, String remark, int userID) {
        this.signalID = signalID;
        this.signalTime = signalTime;
        this.signalPlace = signalPlace;
        this.signalArea = signalArea;
        this.signalPostcode = signalPostcode;
        this.signalStatus = signalStatus; 
        this.remark = remark;
        this.userID = userID;
    }

    // Getters and Setters
    public int getSignalID() { return signalID; }
    public void setSignalID(int signalID) { this.signalID = signalID; }

    public Timestamp getSignalTime() { return signalTime; }
    public void setSignalTime(Timestamp signalTime) { this.signalTime = signalTime; }

    public String getSignalPlace() { return signalPlace; }
    public void setSignalPlace(String signalPlace) { this.signalPlace = signalPlace; }

    public String getSignalArea() { return signalArea; }
    public void setSignalArea(String signalArea) { this.signalArea = signalArea; }

    public String getSignalPostcode() { return signalPostcode; }
    public void setSignalPostcode(String signalPostcode) { this.signalPostcode = signalPostcode; }

    public String getSignalStatus() { return signalStatus; }
    public void setSignalStatus(String signalStatus) { this.signalStatus = signalStatus; }

    public String getSignalRemark() { return remark; }
    public void setSignalRemark(String remark) { this.remark = remark; }
    
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }
}
