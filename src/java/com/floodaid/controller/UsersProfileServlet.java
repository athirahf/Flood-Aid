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

        if (user != null) {
            session.setAttribute("user", user); // ✅ Reload updated user object into session
            request.setAttribute("user", user);
            RequestDispatcher dispatcher = request.getRequestDispatcher("users-profile.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("pages-login.html?error=session_expired");
        }
    }
}
