package com.floodaid.controller;

import com.floodaid.model.NeedDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VolunteerNeedEditServlet")
public class VolunteerNeedEditServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String needItem = request.getParameter("item");
        String needQuantityStr = request.getParameter("quantity");
        String needIDStr = request.getParameter("needID");

        if (needItem == null || needItem.isEmpty() || needQuantityStr == null || needQuantityStr.isEmpty() || needIDStr == null || needIDStr.isEmpty()) {
            response.sendRedirect("volunteer-editneed.jsp?needID=" + needIDStr + "&error=missing_fields");
            return;
        }

        int needQuantity, needID;
        try {
            needQuantity = Integer.parseInt(needQuantityStr);
            needID = Integer.parseInt(needIDStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("volunteer-editneed.jsp?needID=" + needIDStr + "&error=invalid_input");
            return;
        }

        NeedDAO needDAO = new NeedDAO();
        boolean success = needDAO.updateNeedVol(needItem, needQuantity, needID);

        if (success) {
            response.sendRedirect("ManageNeedServlet?success=updated");
        } else {
            response.sendRedirect("ManageNeedServlet?needID=" + needIDStr + "&error=update_failed");
        }
    }
}
