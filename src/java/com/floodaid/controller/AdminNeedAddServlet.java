package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.floodaid.model.NeedDAO;

@WebServlet("/AdminNeedAddServlet")
public class AdminNeedAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data from request
        String needItem = request.getParameter("NEED_ITEM");
        String needQuantityStr = request.getParameter("NEED_QUANTITY");
        String shelterIDStr = request.getParameter("shelterID");
        String userIDStr = request.getParameter("USER_ID");

        // Validate input
        if (needItem == null || needItem.isEmpty() || 
            needQuantityStr == null || needQuantityStr.isEmpty() ||
            shelterIDStr == null || shelterIDStr.isEmpty() ||
            userIDStr == null || userIDStr.isEmpty()) {
            
            response.sendRedirect("admin-addNeed.jsp?error=missing_fields");
            return;
        }

        int needQuantity, shelterID, userID;
        try {
            needQuantity = Integer.parseInt(needQuantityStr);
            shelterID = Integer.parseInt(shelterIDStr);
            userID = Integer.parseInt(userIDStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin-addNeed.jsp?error=invalid_input");
            return;
        }

        // Insert need into the database
        NeedDAO needDAO = new NeedDAO();
        boolean success = needDAO.registerNeed(needItem, needQuantity, shelterID, userID);

        if (success) {
            response.sendRedirect("AdminNeedServlet?success=added");
        } else {
            response.sendRedirect("admin-addNeed.jsp?error=registration_failed");
        }
    }
}
