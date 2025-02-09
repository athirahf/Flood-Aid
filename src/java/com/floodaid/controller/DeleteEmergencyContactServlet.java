package com.floodaid.controller;

import com.floodaid.model.EmergencyContactDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteEmergencyContactServlet")
public class DeleteEmergencyContactServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int emerCtc_ID = Integer.parseInt(request.getParameter("emerCtc_ID"));

        EmergencyContactDAO contactDAO = new EmergencyContactDAO();
        boolean success = contactDAO.deleteEmergencyContact(emerCtc_ID);

        if (success) {
            response.sendRedirect("UsersProfileServlet?success=contact_deleted");
        } else {
            response.sendRedirect("UsersProfileServlet?error=delete_failed");
        }
    }
}
