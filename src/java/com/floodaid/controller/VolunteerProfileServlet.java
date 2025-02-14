package com.floodaid.controller;

import com.floodaid.model.Shelter;
import com.floodaid.model.ShelterDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.floodaid.model.User;
import com.floodaid.model.UserDAO;
import com.floodaid.model.Volunteer;
import com.floodaid.model.VolunteerDAO;
import java.util.List;
import javax.servlet.RequestDispatcher;

@WebServlet("/VolunteerProfileServlet")
public class VolunteerProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("pages-login.html?error=session_expired");
            return;
        }

        // ✅ Ensure userID is retrieved properly
        int userID = (int) session.getAttribute("userID");
        
        // Get volunteer details
        VolunteerDAO volunteerDAO = new VolunteerDAO();
        Volunteer volunteer = volunteerDAO.getVolunteerByID(userID);
        
        if (volunteer == null) {
            response.sendRedirect("pages-login.html?error=user_not_found");
            return;
        }
        
        // Get the list of shelters (for dropdown selection)
        ShelterDAO shelterDAO = new ShelterDAO();
        List<Shelter> shelterList = shelterDAO.getAllShelters();

         session.setAttribute("volunteer", volunteer);
        session.setAttribute("shelterList", shelterList);

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("volunteer-profile.jsp");
        dispatcher.forward(request, response);
    }
}