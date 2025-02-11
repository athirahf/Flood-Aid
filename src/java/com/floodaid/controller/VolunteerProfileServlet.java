package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.floodaid.model.User;
import com.floodaid.model.UserDAO;
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

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByID(userID); // ✅ Fetch user by ID

        if (user != null) {
            session.setAttribute("user", user); // ✅ Reload updated user object into session
            request.setAttribute("user", user);
            RequestDispatcher dispatcher = request.getRequestDispatcher("volunteer-profile.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("pages-login.html?error=session_expired");
        }
    }
}


//package com.floodaid.controller;
//
//import java.io.IOException;
//import java.util.List;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import javax.servlet.RequestDispatcher;
//
//import com.floodaid.model.User;
//import com.floodaid.model.Volunteer;
//import com.floodaid.model.Shelter;
//import com.floodaid.model.UserDAO;
//import com.floodaid.model.VolunteerDAO;
//import com.floodaid.model.ShelterDAO;
//
///**
// * VolunteerProfileServlet handles volunteer profile data retrieval and forwards it to the JSP.
// * 
// * @author anisa
// */
//@WebServlet(name = "VolunteerProfileServlet", urlPatterns = {"/VolunteerProfileServlet"})
//public class VolunteerProfileServlet extends HttpServlet {
//    
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("userID") == null) {
//            response.sendRedirect("pages-login.html?error=session_expired");
//            return;
//        }
//
//        // ✅ Get user ID from session
//        int userID = (int) session.getAttribute("userID");
//
//        // ✅ Initialize DAOs
//        UserDAO userDAO = new UserDAO();
//        VolunteerDAO volunteerDAO = new VolunteerDAO();
//        ShelterDAO shelterDAO = new ShelterDAO();
//
//        // ✅ Fetch user data
//        User user = userDAO.getUserByID(userID);
//        
//        if (user != null) {
//            // ✅ Check if user is a volunteer
//            Volunteer volunteer = volunteerDAO.getVolunteerByID(userID);
//            
//            if (volunteer != null) {
//                int shelterID = volunteer.getShelterID();
//
//                // ✅ Get shelter name
//                String shelterName = volunteerDAO.getShelterName(shelterID);
//                
//                // ✅ Get list of volunteers in the same shelter
//                List<Volunteer> volunteersInSameShelter = volunteerDAO.getVolunteersByCurrentUser(shelterID);
//                
//                // ✅ Get list of all available shelters
//                List<Shelter> shelterList = shelterDAO.getAllShelters(); // Fetch all shelters
//                
//                // ✅ Set attributes for JSP
//                session.setAttribute("user", user);
//                request.setAttribute("volunteer", volunteer);
//                request.setAttribute("shelterName", shelterName);
//                request.setAttribute("volunteersInSameShelter", volunteersInSameShelter);
//                request.setAttribute("shelterList", shelterList); // ✅ Pass shelter list
//
//                System.out.println("User ID: " + userID);
//                System.out.println("User found: " + (user != null));
//                System.out.println("Volunteer found: " + (volunteer != null));
//                System.out.println("Shelter Name: " + shelterName);
//
//                // ✅ Forward to JSP
//                RequestDispatcher dispatcher = request.getRequestDispatcher("volunteer-profile.jsp");
//                dispatcher.forward(request, response);
//            } else {
//                response.sendRedirect("dashboard.jsp?error=not_a_volunteer");
//            }
//        } else {
//            response.sendRedirect("pages-login.html?error=session_expired");
//        }
//    }
//}
