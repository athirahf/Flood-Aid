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
        
        // Get the logged-in user ID from session
        Integer userID = (Integer) request.getSession().getAttribute("userID");
        
        // Validate session user ID
        if (userID == null) {
            response.sendRedirect("login.jsp?error=session_expired");
            return;
        }
        
        // Get form data from request
        String needItem = request.getParameter("NEED_ITEM");
        String needQuantityStr = request.getParameter("NEED_QUANTITY");
        String shelterIDStr = request.getParameter("shelterID");

        // Validate input
        if (needItem == null || needItem.isEmpty() || 
            needQuantityStr == null || needQuantityStr.isEmpty() ||
            shelterIDStr == null || shelterIDStr.isEmpty()) {
            
            response.sendRedirect("admin-needAdd.jsp?ShelterID=0&error=missing_fields");
            return;
        }

        int needQuantity, shelterID;
        try {
            needQuantity = Integer.parseInt(needQuantityStr);
            shelterID = Integer.parseInt(shelterIDStr);
            
            // Validate input
            if (shelterID == 0) {
                response.sendRedirect("admin-needAdd.jsp?ShelterID=0&error=missing_shelter");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("admin-needAdd.jsp?ShelterID=0&error=invalid_input");
            return;
        }

        // Insert need into the database
        NeedDAO needDAO = new NeedDAO();
        boolean success = needDAO.registerNeed(needItem, needQuantity, shelterID, userID);

        if (success) {
            response.sendRedirect("AdminNeedServlet?success=added");
        } else {
            response.sendRedirect("admin-needAdd.jsp?ShelterID=0&error=request_failed");
        }
    }
}