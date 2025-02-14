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

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("pages-login.html?error=session_expired");
            return;
        }
        
        User userSession = (User) session.getAttribute("user");
        String userRole = userSession.getRole();

        // Retrieve parameters from form
        String username = request.getParameter("username");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // Initialize DAO
        UserDAO userDAO = new UserDAO();

        // Validate current password
        User user = userDAO.validateUser(username, currentPassword);
        if (user == null) {
            String redirectPage;
            if (userRole.equalsIgnoreCase("Admin")) {
                redirectPage = "admin-profile.jsp";
            } else if (userRole.equalsIgnoreCase("Volunteer")) {
                redirectPage = "volunteer-profile.jsp";
            } else {
                redirectPage = "users-profile.jsp";
            }
            
            response.sendRedirect(redirectPage + "?error=wrong_current_password");
            return;
        }

        // Change password
        boolean isChanged = userDAO.changePassword(username, currentPassword, newPassword);

        if (isChanged) {
            session.invalidate(); // ✅ Logout after password change
            response.sendRedirect("pages-login.html?success=password_updated");
        } else {
            String redirectPage;
            if (userRole.equalsIgnoreCase("Admin")) {
                redirectPage = "admin-profile.jsp";
            } else if (userRole.equalsIgnoreCase("Volunteer")) {
                redirectPage = "volunteer-profile.jsp";
            } else {
                redirectPage = "users-profile.jsp";
            }
            response.sendRedirect(redirectPage + "?error=password_update_failed");
        }
    }
}
