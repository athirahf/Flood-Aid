package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.floodaid.model.SignalDAO;

@WebServlet("/AdminSignalRejectServlet")
public class AdminSignalRejectServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String SignalIDStr = request.getParameter("SignalID");

        // ✅ Check if signalID is missing
        if (SignalIDStr == null || SignalIDStr.isEmpty()) {
            response.sendRedirect("AdminSignalServlet?error=missing_id");
            return;
        }

        int signalID = Integer.parseInt(SignalIDStr); // Now safe
        String status = "Rejected";
        String remark = request.getParameter("remark");
        String otherRemark = request.getParameter("otherRemark");
        
        String shelterIDStr = request.getParameter("shelterID");
        // ✅ Check if shelterID is missing
        if (shelterIDStr == null || shelterIDStr.isEmpty()) {
            response.sendRedirect("admin_signalReject.jsp?SignalID="+signalID+"&ShelterID=0&error=update_failed");
            return;
        }
        int shelterID = Integer.parseInt(shelterIDStr);
        
        int userID = Integer.parseInt(request.getParameter("userID"));

        SignalDAO signalDAO = new SignalDAO();
        boolean success = signalDAO.updateSignal(status, remark, otherRemark, shelterID, signalID, userID);

        if (success) {
            response.sendRedirect("AdminSignalServlet");
        } else {
            response.sendRedirect("admin_signalReject.jsp?SignalID="+signalID+"&ShelterID=0&error=update_failed");
        }
    }
}
