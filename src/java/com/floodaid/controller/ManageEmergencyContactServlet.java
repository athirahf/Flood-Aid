package com.floodaid.controller;

import com.floodaid.model.EmergencyContact;
import com.floodaid.model.EmergencyContactDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ManageEmergencyContactServlet")
public class ManageEmergencyContactServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("user_ID"));
        String name = request.getParameter("emerCtc_name");
        String relation = request.getParameter("emerCtc_relation");
        String email = request.getParameter("emerCtc_email");
        String phoneNum = request.getParameter("emerCtc_phoneNum");
        boolean isDefault = request.getParameter("emerCtc_default") != null; // Checkbox returns "on" if checked

        EmergencyContactDAO contactDAO = new EmergencyContactDAO();
        boolean success = contactDAO.addEmergencyContact(new EmergencyContact(0, userID, name, relation, email, phoneNum, isDefault));

        if (success) {
            response.sendRedirect("UsersProfileServlet?success=contact_added");
        } else {
            response.sendRedirect("UsersProfileServlet?error=contact_add_failed");
        }
    }
}
