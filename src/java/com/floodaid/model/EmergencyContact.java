package com.floodaid.model;

public class EmergencyContact {
    private int id;
    private int userId;
    private String name;
    private String relation;
    private String email;
    private String phoneNum;
    private boolean isDefault;

    public EmergencyContact(int id, int userId, String name, String relation, String email, String phoneNum, boolean isDefault) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.relation = relation;
        this.email = email;
        this.phoneNum = phoneNum;
        this.isDefault = isDefault;
    }

    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getName() { return name; }
    public String getRelation() { return relation; }
    public String getEmail() { return email; }
    public String getPhoneNum() { return phoneNum; }
    public boolean isDefault() { return isDefault; }
}
