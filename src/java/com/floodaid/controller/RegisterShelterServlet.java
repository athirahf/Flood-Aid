package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.floodaid.model.ShelterDAO;

@WebServlet("/RegisterShelterServlet")
public class RegisterShelterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String shelterName = request.getParameter("name");
        String capacityStr = request.getParameter("capacity");
        String shelterAddress = request.getParameter("address");

        // Validate input
        if (shelterName == null || shelterName.isEmpty() || capacityStr == null || shelterAddress == null || shelterAddress.isEmpty()) {
            response.sendRedirect("admin-regshelter.jsp?error=missing_fields");
            return;
        }

        int shelterCapacity;
        try {
            shelterCapacity = Integer.parseInt(capacityStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin-regshelter.jsp?error=invalid_capacity");
            return;
        }

        // Insert shelter into DB
        ShelterDAO shelterDAO = new ShelterDAO();
        boolean success = shelterDAO.registerShelter(shelterName, shelterCapacity, shelterAddress);

        if (success) {
            response.sendRedirect("AdminSheltersServlet?success=registered");
        } else {
            response.sendRedirect("admin-regshelter.jsp?error=registration_failed");
        }
    }
}
