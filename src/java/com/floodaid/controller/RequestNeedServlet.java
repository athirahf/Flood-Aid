package com.floodaid.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.floodaid.model.UserDAO;

@WebServlet("/RequestNeedServlet")
public class RequestNeedServlet extends HttpServlet {
    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("pages-login.html?error=session_expired");
            return;
        }

        int userID = (int) session.getAttribute("userID");  // Retrieve the logged-in user's ID
        UserDAO userDAO = new UserDAO();
        Integer shelterID = userDAO.getVolunteerShelter(userID); // Get volunteer's assigned shelter

        if (shelterID == null) {
            response.sendRedirect("volunteer-reqneed.jsp?error=no_shelter_assigned");
            return;
        }

        String item = request.getParameter("item");
        String quantity = request.getParameter("quantity");

        if (item == null || item.isEmpty() || quantity == null || quantity.isEmpty()) {
            response.sendRedirect("volunteer-reqneed.jsp?error=missing_fields");
            return;
        }

        String sql = "INSERT INTO NEED (need_item, need_quantity, time_request, need_status, shelter_ID) VALUES (?, ?, CURRENT_TIMESTAMP, 'Pending', ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, item);
            stmt.setInt(2, Integer.parseInt(quantity));
            stmt.setInt(3, shelterID);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("ManageNeedServlet?success=request_sent");
            } else {
                response.sendRedirect("volunteer-reqneed.jsp?error=request_failed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("volunteer-reqneed.jsp?error=database_error");
        }
    }
}
