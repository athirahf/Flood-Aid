package com.floodaid.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.floodaid.model.VolDashboardDAO;

@WebServlet("/VolDashboardServlet")
public class VolDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int victimCount = VolDashboardDAO.getCount("VICTIM");
        int needCount = VolDashboardDAO.getCount("NEED");
        int volunteerCount = VolDashboardDAO.getCount("VOLUNTEER");

        // Pass the values to the JSP page
        request.setAttribute("victimCount", victimCount);
        request.setAttribute("needCount", needCount);
        request.setAttribute("volunteerCount", volunteerCount);

        // Forward the request to the JSP page
        request.getRequestDispatcher("volunteer-index.jsp").forward(request, response);
    }
}
