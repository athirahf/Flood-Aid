package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.floodaid.model.NeedDAO;

@WebServlet("/AdminNeedEditServlet")
public class AdminNeedEditServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data from request
        String needItem = request.getParameter("NEED_ITEM");
        String needQuantityStr = request.getParameter("NEED_QUANTITY");
        String shelterIDStr = request.getParameter("shelterID");
        String needIDStr = request.getParameter("NeedID");
        String needStatus = request.getParameter("NEED_STATUS");

        // Validate input
        if (needItem == null || needItem.isEmpty() || 
            needQuantityStr == null || needQuantityStr.isEmpty() ||
            shelterIDStr == null || shelterIDStr.isEmpty() ||
            needIDStr == null || needIDStr.isEmpty()) {
            
            response.sendRedirect("admin-needEdit.jsp?NeedID="+Integer.parseInt(request.getParameter("needID"))+"&ShelterID=0&error=missing_fields");
            return;
        }

        int needQuantity, shelterID, needID;
        try {
            needQuantity = Integer.parseInt(needQuantityStr);
            shelterID = Integer.parseInt(shelterIDStr);
            needID = Integer.parseInt(needIDStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin-needEdit.jsp?NeedID="+Integer.parseInt(request.getParameter("needID"))+"&ShelterID=0&error=invalid_input");
            return;
        }

        // Insert need into the database
        NeedDAO needDAO = new NeedDAO();
        boolean success = needDAO.updateNeed(needItem, needQuantity, shelterID, needStatus, needID);

        if (success) {
            response.sendRedirect("AdminNeedServlet?success=added");
        } else {
            response.sendRedirect("admin-needEdit.jsp?NeedID="+Integer.parseInt(request.getParameter("needID"))+"&ShelterID=0&error=update_failed");
        }
    }
}
