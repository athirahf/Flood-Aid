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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // ✅ Fix: Use correct parameter names
        String volIDParam = request.getParameter("volunteer_id");
        String shelterIDParam = request.getParameter("shelterID");

        if (volIDParam == null || shelterIDParam == null) {
            response.sendRedirect("AdminShelterVolunteersServlet?error=missing_parameters");
            return;
        }

        try {
            int volunteerID = Integer.parseInt(volIDParam);
            int shelterID = Integer.parseInt(shelterIDParam);

            VolunteerDAO volunteerDAO = new VolunteerDAO();
            boolean isUpdated = volunteerDAO.appointLeader(volunteerID, shelterID);

            if (isUpdated) {
                response.sendRedirect("AdminShelterVolunteersServlet?shelterID=" + shelterID + "&success=leader_assigned");
            } else {
                response.sendRedirect("AdminShelterVolunteersServlet?shelterID=" + shelterID + "&error=update_failed");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("AdminShelterVolunteersServlet?error=invalid_parameters");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response); // ✅ Calls doGet() for handling both GET and POST
    }
}
