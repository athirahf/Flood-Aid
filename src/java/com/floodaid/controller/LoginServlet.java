package com.floodaid.controller;

import com.floodaid.model.User;
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
            User user = userDAO.validateAndGetUser(username, password);

            if (user != null) {
                // Create a session and store attributes
                HttpSession session = request.getSession();
                session.setAttribute("userID", user.getUserID()); // Use consistent naming
                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());
                session.setAttribute("name", user.getName());

                // Log session attributes for debugging
                System.out.println("Login Successful:");
                System.out.println("userID: " + user.getUserID());
                System.out.println("username: " + user.getUsername());
                System.out.println("role: " + user.getRole());
                System.out.println("name: " + user.getName());

                // Redirect based on role
                switch (user.getRole()) {
                    case "Admin":
                        response.sendRedirect("admin-index.jsp");
                        break;
                    case "Volunteer":
                        response.sendRedirect("volunteer-index.jsp");
                        break;
                    case "User":
                        response.sendRedirect("users-index.jsp");
                        break;
                    case "Shelter":
                        response.sendRedirect("shelter-index.jsp");
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
