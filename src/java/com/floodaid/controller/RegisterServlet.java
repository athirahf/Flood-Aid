package com.floodaid.controller;

import com.floodaid.model.User;
import com.floodaid.model.UserDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("Starting registration process...");

            // Retrieve form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            System.out.println("Form Data: Name=" + name + ", Email=" + email + 
                               ", Role=" + role + ", Username=" + username);

            // Generate user_ID
            String userID = "USR" + System.currentTimeMillis();
            System.out.println("Generated user_ID: " + userID);

            // Create User object
            User user = new User(userID, name, email, role, username, password);

            // Save user to database
            UserDAO userDAO = new UserDAO();
            boolean isRegistered = userDAO.registerUser(user);

            if (isRegistered) {
                System.out.println("Registration successful!");
                response.sendRedirect("pages-login.html?success=true");
            } else {
                System.out.println("Registration failed.");
                response.sendRedirect("pages-register.html?error=registration_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("pages-register.html?error=internal_error");
        }
    }
}
