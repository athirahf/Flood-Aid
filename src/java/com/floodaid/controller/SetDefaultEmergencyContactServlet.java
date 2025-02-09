package com.floodaid.controller;

import com.floodaid.model.EmergencyContactDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SetDefaultEmergencyContactServlet")
public class SetDefaultEmergencyContactServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int emerCtc_ID = Integer.parseInt(request.getParameter("emerCtc_ID"));
        int userID = Integer.parseInt(request.getSession().getAttribute("userID").toString());

        EmergencyContactDAO contactDAO = new EmergencyContactDAO();
        boolean success = contactDAO.setDefaultContact(userID, emerCtc_ID);

        if (success) {
            response.sendRedirect("UsersProfileServlet?success=default_set");
        } else {
            response.sendRedirect("UsersProfileServlet?error=default_failed");
        }
    }
}
