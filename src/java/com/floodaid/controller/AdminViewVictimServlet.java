package com.floodaid.controller;

import com.floodaid.model.Victim;
import com.floodaid.model.VictimDAO;
import com.floodaid.model.Shelter;
import com.floodaid.model.ShelterDAO;
import com.floodaid.model.User;
import com.floodaid.model.UserDAO;
import com.floodaid.model.EmergencyContact;
import com.floodaid.model.EmergencyContactDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/AdminViewVictimServlet")
public class AdminViewVictimServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIDStr = request.getParameter("userID");

        if (userIDStr == null || userIDStr.isEmpty()) {
            response.sendRedirect("AdminSheltersServlet?error=invalid_user");
            return;
        }

        try {
            int userID = Integer.parseInt(userIDStr);

            // Initialize DAOs
            VictimDAO victimDAO = new VictimDAO();
            UserDAO userDAO = new UserDAO();
            ShelterDAO shelterDAO = new ShelterDAO();
            EmergencyContactDAO emergencyContactDAO = new EmergencyContactDAO();

            // Fetch data
            Victim victim = victimDAO.getVictimByID(userID);
            User user = userDAO.getUserByID(userID);
            Shelter shelter = shelterDAO.getShelterByID(victim.getShelterID());
            List<EmergencyContact> emergencyContacts = emergencyContactDAO.getEmergencyContactsByUserID(userID);

            // Pass data to JSP
            request.setAttribute("victim", victim);
            request.setAttribute("user", user);
            request.setAttribute("shelter", shelter);
            request.setAttribute("emergencyContacts", emergencyContacts);

            // Forward request to JSP page
            request.getRequestDispatcher("admin-viewvictim.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("AdminSheltersServlet?error=invalid_user");
        }
    }
}
