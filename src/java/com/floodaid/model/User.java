package com.floodaid.model;

public class User {
    private String userID;
    private String name;
    private String email;
    private String role;
    private String username;
    private String password;

    public User(String userID, String name, String email, String role, String username, String password) {
        this.userID = userID;
        this.name = name;
        this.email = email;
        this.role = role;
        this.username = username;
        this.password = password;
    }
    
    public User() {
        userID = "unknown";
        name = "unknown";
        email = "unknown";
        role = "unknown";
        username = "unknown";
        password = "unknown";
    }

    public String getUserID() {
        return userID;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getRole() {
        return role;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
}
