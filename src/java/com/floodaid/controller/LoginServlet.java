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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate user input
        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("pages-login.html?error=missing_fields");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.validateUser(username, password); // ✅ Retrieve user object from DB

        if (user != null) {
            // ✅ Create session and store necessary attributes
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userID", user.getUserID()); // ✅ Store userID in session
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setAttribute("name", user.getName());

            session.setMaxInactiveInterval(30 * 60); // ✅ Set session timeout (30 minutes)

            // Redirect based on user role
            switch (user.getRole().toLowerCase()) {
                case "admin":
                    response.sendRedirect("admin-index.jsp");
                    break;
                case "user":
                    response.sendRedirect("users-index.jsp");
                    break;
                case "volunteer":
                    response.sendRedirect("volunteer-index.jsp");
                    break;
                default:
                    response.sendRedirect("homepage.html");
                    break;
            }
        } else {
            response.sendRedirect("pages-login.html?error=invalid_credentials");
        }
    }
}
