package com.floodaid.controller;

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

        int volunteerID = Integer.parseInt(request.getParameter("volunteer_id"));
        int newShelterID = Integer.parseInt(request.getParameter("shelter_id"));

        VolunteerDAO volunteerDAO = new VolunteerDAO();
        boolean success = volunteerDAO.reassignVolunteerShelter(volunteerID, newShelterID);

        if (success) {
            response.sendRedirect("AdminShelterVolunteersServlet?shelterID=" + newShelterID + "&success=reassigned");
        } else {
            response.sendRedirect("AdminShelterVolunteersServlet?shelterID=" + newShelterID + "&error=reassign_failed");
        }
    }
}
