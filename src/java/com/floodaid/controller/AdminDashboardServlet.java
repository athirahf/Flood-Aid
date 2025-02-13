package com.floodaid.controller;

import com.floodaid.model.Signal;
import com.floodaid.model.SignalDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final String URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String USER = "FloodAid";
    private static final String PASSWORD = "FloodAid";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int adminCount = getCount("SELECT COUNT(*) FROM users WHERE user_role = 'Admin'");
        int victimCount = getCount("SELECT COUNT(*) FROM users WHERE user_role = 'User'");
        int volunteerCount = getCount("SELECT COUNT(*) FROM users WHERE user_role = 'Volunteer'");
        int shelterCount = getCount("SELECT COUNT(*) FROM shelter");
        int needCount = getCount("SELECT COUNT(*) FROM need");
        int signalCount = getCount("SELECT COUNT(*) FROM signal");

        request.setAttribute("adminCount", adminCount);
        request.setAttribute("victimCount", victimCount);
        request.setAttribute("volunteerCount", volunteerCount);
        request.setAttribute("shelterCount", shelterCount);
        request.setAttribute("needCount", needCount);
        request.setAttribute("signalCount", signalCount);
        
        SignalDAO signalDAO = new SignalDAO();
        List<Signal> signals = signalDAO.getAllSignal();

        System.out.println("Signal List Size: " + signals.size());

        request.setAttribute("signals", signals);

        request.getRequestDispatcher("admin-index.jsp").forward(request, response);
    }

    private int getCount(String query) {
        int count = 0;
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
