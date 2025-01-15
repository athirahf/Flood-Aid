/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.floodaid.model;

/**
 *
 * @author User
 */
public class Admin {
    private int adminID, adminAge;
    private String adminName, adminEmail, adminPhone;
    
    // default constructor
    public Admin(){
        this.adminID = 0;
        this.adminName = "unknown";
        this.adminAge = 0;
        this.adminEmail = "unknown";
        this.adminPhone = "unknown";
    }
    
    // normal constructor
    public Admin (int adminID, String adminName, int adminAge, String adminEmail, String adminPhone){
        this.adminID = adminID;
        this.adminName = adminName;
        this.adminAge = adminAge;
        this.adminEmail = adminEmail;
        this.adminPhone = adminPhone;
    }
    
    //getter
    public int getAdminID(){
        return adminID;
    }
    
    public String getAdminName(){
        return adminName;
    }
    
    public int getAdminAge(){
        return adminAge;
    }
    
    public String getAdminEmail(){
        return adminEmail;
    }
    
    public String getAdminPhone(){
        return adminPhone;
    }
    
    //setter
    public void setAdminID(int adminID){
        this.adminID = adminID;
    }
    
    public void setAdminName(String adminName){
        this.adminName = adminName;
    }
    
    public void setAdminAge(int adminAge){
        this.adminAge = adminAge;
    }
    
    public void setAdminEmail(String adminEmail){
        this.adminEmail = adminEmail;
    }
    
    public void setAdminPhone(String adminPhone){
        this.adminPhone = adminPhone;
    }
}
