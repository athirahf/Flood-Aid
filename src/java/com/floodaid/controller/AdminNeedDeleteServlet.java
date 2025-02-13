package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.floodaid.model.NeedDAO;

@WebServlet("/AdminNeedDeleteServlet")
public class AdminNeedDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data from request
        String needIDStr = request.getParameter("NeedID");

        // Validate input
        if (needIDStr == null || needIDStr.isEmpty()) {
            
            response.sendRedirect("admin-needDelete.jsp?NeedID="+Integer.parseInt(request.getParameter("needID"))+"&error=missing_fields");
            return;
        }

        int needID;
        try {
            needID = Integer.parseInt(needIDStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin-needDelete.jsp?NeedID="+Integer.parseInt(request.getParameter("needID"))+"&error=invalid_input");
            return;
        }

        // Insert need into the database
        NeedDAO needDAO = new NeedDAO();
        boolean success = needDAO.deleteNeed(needID);

        if (success) {
            response.sendRedirect("AdminNeedServlet?success=deleted");
        } else {
            response.sendRedirect("admin-needDelete.jsp?NeedID="+Integer.parseInt(request.getParameter("needID"))+"&error=update_failed");
        }
    }
}
