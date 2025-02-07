package com.floodaid.model;

public class User {
    private int userID;
    private String name;
    private String email;
    private String role;
    private String username;
    private String password;
    private String nric;
    private int age;
    private String address;
    private String phoneNum;
    private String registrationTime;

    // for getUserByID()
    public User(int userID, String name, String email, String role, String username, String password, String nric, int age, String address, String phoneNum) {
        this.userID = userID;
        this.name = name;
        this.email = email;
        this.role = role;
        this.username = username;
        this.password = password;
        this.nric = nric;
        this.age = age;
        this.address = address;
        this.phoneNum = phoneNum;
    }

    // getUserByUsername()
    public User(int userID, String name, String email, String role, String username, String password) {
        this.userID = userID;
        this.name = name;
        this.email = email;
        this.role = role;
        this.username = username;
        this.password = password;
    }

    // constructor for RegisterServlet.java
    public User(String name, String email, String role, String username, String password) {
        this.name = name;
        this.email = email;
        this.role = role;
        this.username = username;
        this.password = password;
    }
    
    // constructor to retrieve user information
    public User(int userID, String name, String email, String role, String username, String password, String nric, int age, String address, String phoneNum, String registrationTime) {
        this.userID = userID;
        this.name = name;
        this.email = email;
        this.role = role;
        this.username = username;
        this.password = password;
        this.nric = nric;
        this.age = age;
        this.address = address;
        this.phoneNum = phoneNum;
        this.registrationTime = registrationTime;
    }

    // Getters and Setters
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getNric() { return nric; }
    public void setNric(String nric) { this.nric = nric; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhoneNum() { return phoneNum; }
    public void setPhoneNum(String phoneNum) { this.phoneNum = phoneNum; }
    
    public String getRegistrationTime() { return registrationTime; } // ✅ Get as a String
    public void setRegistrationTime(String registrationTime) { this.registrationTime = registrationTime; } // ✅ Set as a String
}
