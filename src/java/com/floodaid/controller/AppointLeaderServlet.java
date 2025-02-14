package com.floodaid.controller;

import com.floodaid.model.VolunteerDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AppointLeaderServlet")
public class AppointLeaderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Retrieve parameters from the form
        int volunteerID = Integer.parseInt(request.getParameter("volunteer_id"));
        int shelterID = Integer.parseInt(request.getParameter("shelter_id"));

        VolunteerDAO volunteerDAO = new VolunteerDAO();
        boolean isUpdated = volunteerDAO.appointLeader(volunteerID, shelterID);

        if (isUpdated) {
            response.sendRedirect("AdminShelterVolunteersServlet?shelterID=" + shelterID + "&success=leader_assigned");
        } else {
            response.sendRedirect("AdminShelterVolunteersServlet?shelterID=" + shelterID + "&error=update_failed");
        }
    }
}
