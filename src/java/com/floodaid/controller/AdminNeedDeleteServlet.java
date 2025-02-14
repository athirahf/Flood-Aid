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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String needIDStr = request.getParameter("needID");

        // Validate input
        if (needIDStr == null || needIDStr.isEmpty()) {
            
            response.sendRedirect("AdminNeedServlet?error=missing_id");
            return;
        }

        int needID = Integer.parseInt(needIDStr);

        // Insert need into the database
        NeedDAO needDAO = new NeedDAO();
        boolean success = needDAO.deleteNeed(needID);

        if (success) {
            response.sendRedirect("AdminNeedServlet?success=deleted");
        } else {
            response.sendRedirect("AdminNeedServlet?error=delete_failed");
        }
    }
}
