package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.floodaid.model.UserDAO;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.deleteUser(userID);

            if (success) {
                response.sendRedirect("AdminUsersServlet?success=delete");
            } else {
                response.sendRedirect("admin-users.jsp?error=delete_failed");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("admin-users.jsp?error=invalid_user");
        }
    }
}
