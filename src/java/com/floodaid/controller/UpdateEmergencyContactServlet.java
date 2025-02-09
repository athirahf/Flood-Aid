package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.floodaid.model.EmergencyContactDAO;

@WebServlet("/UpdateEmergencyContactServlet")
public class UpdateEmergencyContactServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        int emerCtc_ID = Integer.parseInt(request.getParameter("emerCtc_ID"));
        String name = request.getParameter("emerCtc_name");
        String relation = request.getParameter("emerCtc_relation");
        String email = request.getParameter("emerCtc_email");
        String phoneNum = request.getParameter("emerCtc_phoneNum");
        int isDefault = request.getParameter("emerCtc_default") != null ? 1 : 0;

        EmergencyContactDAO emergencyDAO = new EmergencyContactDAO();
        boolean success = emergencyDAO.updateEmergencyContact(emerCtc_ID, name, relation, email, phoneNum, isDefault);

        if (success) {
            response.sendRedirect("UsersProfileServlet?success=updated");
        } else {
            response.sendRedirect("UsersProfileServlet?error=update_failed");
        }
    }
}
