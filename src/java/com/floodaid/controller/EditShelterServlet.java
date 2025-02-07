package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.floodaid.model.ShelterDAO;

@WebServlet("/EditShelterServlet")
public class EditShelterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String shelterIDStr = request.getParameter("shelterID");

        // ✅ Check if shelterID is missing
        if (shelterIDStr == null || shelterIDStr.isEmpty()) {
            response.sendRedirect("AdminSheltersServlet?error=missing_id");
            return;
        }

        int shelterID = Integer.parseInt(shelterIDStr); // Now safe
        String name = request.getParameter("shelterName");
        int capacity = Integer.parseInt(request.getParameter("shelterSpace"));
        String address = request.getParameter("address");

        ShelterDAO shelterDAO = new ShelterDAO();
        boolean success = shelterDAO.updateShelter(shelterID, name, capacity, address);

        if (success) {
            response.sendRedirect("AdminSheltersServlet?success=edit");
        } else {
            response.sendRedirect("admin-editshelter.jsp?shelterID=" + shelterID + "&error=update_failed");
        }
    }
}
