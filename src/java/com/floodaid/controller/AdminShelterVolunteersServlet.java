package com.floodaid.controller;

import com.floodaid.model.Shelter;
import com.floodaid.model.ShelterDAO;
import com.floodaid.model.Volunteer;
import com.floodaid.model.VolunteerDAO;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/AdminShelterVolunteersServlet")
public class AdminShelterVolunteersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // Get shelter ID from the request
        int shelterID;
        try {
            shelterID = Integer.parseInt(request.getParameter("shelterID"));
        } catch (NumberFormatException e) {
            response.sendRedirect("admin-shelters.jsp?error=invalid_shelter_id");
            return;
        }

        // Retrieve shelter details
        ShelterDAO shelterDAO = new ShelterDAO();
        List<Shelter> shelters = shelterDAO.getAllShelters();
        Shelter shelter = shelterDAO.getShelterByID(shelterID);
        
        // Retrieve volunteers assigned to this shelter
        VolunteerDAO volunteerDAO = new VolunteerDAO();
        List<Volunteer> volunteers = volunteerDAO.getVolunteersByShelterID(shelterID);

        if (shelter == null) {
            response.sendRedirect("admin-shelters.jsp?error=shelter_not_found");
            return;
        }

        // Pass data to JSP
        request.setAttribute("shelter", shelter);
        request.setAttribute("shelters", shelters);
        request.setAttribute("volunteers", volunteers);

        // Forward request to admin-sheltersvol.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin-sheltersvol.jsp");
        dispatcher.forward(request, response);
    }
}
