package com.floodaid.controller;

import com.floodaid.model.VictimDAO;
import com.floodaid.model.VolunteerDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReassignShelterServlet")
public class ReassignShelterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String userType = request.getParameter("user_type");
        int userID = Integer.parseInt(request.getParameter("userID"));
        int newShelterID = Integer.parseInt(request.getParameter("shelter_id"));

        boolean success = false;
        
        if ("volunteer".equals(userType)) {
            VolunteerDAO volunteerDAO = new VolunteerDAO();
            success = volunteerDAO.reassignVolunteerShelter(userID, newShelterID);
        } else if ("victim".equals(userType)) {
            VictimDAO victimDAO = new VictimDAO();
            success = victimDAO.reassignVictimShelter(userID, newShelterID);
        }

        if (success) {
            response.sendRedirect("AdminShelterVolunteersServlet?shelterID=" + newShelterID + "&success=reassigned");
        } else {
            response.sendRedirect("AdminShelterVolunteersServlet?shelterID=" + newShelterID + "&error=reassign_failed");
        }
    }
}
