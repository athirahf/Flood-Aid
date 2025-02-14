package com.floodaid.controller;

import com.floodaid.model.NeedDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CancelNeedServlet")
public class CancelNeedServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String needIDStr = request.getParameter("needID");

        if (needIDStr == null || needIDStr.isEmpty()) {
            response.sendRedirect("ManageNeedServlet?error=missing_needID");
            return;
        }

        int needID;
        try {
            needID = Integer.parseInt(needIDStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("ManageNeedServlet?error=invalid_needID");
            return;
        }

        NeedDAO needDAO = new NeedDAO();
        boolean success = needDAO.cancelNeed(needID);

        if (success) {
            response.sendRedirect("ManageNeedServlet?success=canceled");
        } else {
            response.sendRedirect("ManageNeedServlet?error=cancel_failed");
        }
    }
}
