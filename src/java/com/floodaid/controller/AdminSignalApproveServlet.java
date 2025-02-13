package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.floodaid.model.SignalDAO;

@WebServlet("/AdminSignalApproveServlet")
public class AdminSignalApproveServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String SignalIDStr = request.getParameter("SignalID");
        // ✅ Check if signalID is missing
        if (SignalIDStr == null || SignalIDStr.isEmpty()) {
            response.sendRedirect("AdminSignalServlet?error=missing_id");
            return;
        }
        int signalID = Integer.parseInt(SignalIDStr); // Now safe
        
        String shelterIDStr = request.getParameter("shelterID");
        int shelterID = Integer.parseInt(shelterIDStr);
        // ✅ Check if shelterID is missing
        if (shelterID == 0 || shelterIDStr == null) {
            response.sendRedirect("admin-signalApprove.jsp?SignalID="+signalID+"&ShelterID=0&error=shelter_not_selected");
            return;
        }
        
        String status = "Approved";
        String remark = "Signal found and the victim will be sent to shelter with ID,"+shelterID+".";
        String otherRemark = "No Other Remark";
        
        int userID = Integer.parseInt(request.getParameter("userID"));

        SignalDAO signalDAO = new SignalDAO();
        boolean success = signalDAO.updateSignal(status, remark, otherRemark, shelterID, signalID, userID);

        if (success) {
            response.sendRedirect("AdminSignalServlet");
        } else {
            response.sendRedirect("admin-signalApprove.jsp?SignalID="+signalID+"&ShelterID=0&error=update_failed");
        }
    }
}
