package com.floodaid.controller;

import com.floodaid.model.SignalDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SendSignalServlet")
public class SendSignalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("pages-login.html?error=session_expired");
            return;
        }

        // Retrieve input values
        String place = request.getParameter("inputPlace");
        String area = request.getParameter("inputArea");
        String postcode = request.getParameter("inputPostcode");
        int userID = (int) session.getAttribute("userID");

        // Validate inputs
        if (place == null || area == null || postcode == null || place.isEmpty() || area.isEmpty() || postcode.isEmpty()) {
            response.sendRedirect("users-signal.jsp?error=missing_fields");
            return;
        }

        // Insert into database
        SignalDAO signalDAO = new SignalDAO();
        boolean success = signalDAO.registerSignal(place, area, postcode, userID);

        if (success) {
            response.sendRedirect("users-signal.jsp?success=signal_sent");
        } else {
            response.sendRedirect("users-signal.jsp?error=failed_to_send");
        }
    }
}
