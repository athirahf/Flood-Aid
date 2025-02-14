package com.floodaid.controller;

import com.floodaid.model.EmergencyContact;
import com.floodaid.model.EmergencyContactDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.floodaid.model.User;
import com.floodaid.model.UserDAO;
import java.util.List;
import javax.servlet.RequestDispatcher;

@WebServlet("/UsersProfileServlet")
public class UsersProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("pages-login.html?error=session_expired");
            return;
        }

        // ✅ Retrieve userID from session
        int userID = (int) session.getAttribute("userID");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByID(userID); // ✅ Fetch user by ID
        
        EmergencyContactDAO contactDAO = new EmergencyContactDAO();
        List<EmergencyContact> emergencyContacts = contactDAO.getEmergencyContactsByUserID(userID);

        if (user != null) {
            session.setAttribute("user", user); // ✅ Reload updated user object into session
            request.setAttribute("user", user);
            request.setAttribute("emergencyContacts", emergencyContacts);
            
            String profilePage;
            if ("Admin".equalsIgnoreCase(user.getRole())) {
                profilePage = "admin-profile.jsp";  // Admins go to admin-profile.jsp
            } else {
                profilePage = "users-profile.jsp";  // Regular users go to users-profile.jsp
            }
            
            RequestDispatcher dispatcher = request.getRequestDispatcher(profilePage);
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("pages-login.html?error=session_expired");
        }
    }
}
