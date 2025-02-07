package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.floodaid.model.ShelterDAO;

@WebServlet("/DeleteShelterServlet")
public class DeleteShelterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int shelterID = Integer.parseInt(request.getParameter("shelterID"));

        ShelterDAO shelterDAO = new ShelterDAO();
        boolean success = shelterDAO.deleteShelter(shelterID);

        if (success) {
            response.sendRedirect("AdminSheltersServlet?success=deleted");
        } else {
            response.sendRedirect("AdminSheltersServlet?error=delete_failed");
        }
    }
}
