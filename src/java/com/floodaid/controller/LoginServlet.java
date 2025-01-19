package com.floodaid.controller;

import com.floodaid.model.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Validate credentials
            UserDAO userDAO = new UserDAO();
            String role = userDAO.validateUser(username, password);

            if (role != null) {
                // Create a session
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                // Redirect based on role
                switch (role) {
                    case "Admin":
                        response.sendRedirect("admin-index.html");
                        break;
                    case "Volunteer":
                        response.sendRedirect("volunteer-index.html");
                        break;
                    case "User":
                        response.sendRedirect("users-index.html");
                        break;
                    case "Shelter":
                        response.sendRedirect("shelter-index.html");
                        break;
                    default:
                        response.sendRedirect("pages-login.html?error=invalid_role");
                }
            } else {
                // Invalid credentials
                response.sendRedirect("pages-login.html?error=invalid_credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("pages-login.html?error=internal_error");
        }
    }
}
