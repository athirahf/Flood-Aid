/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.floodaid.controller;

import com.floodaid.model.UserDAO;
import com.floodaid.model.VolunteerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.floodaid.model.UserDAO;

/**
 *
 * @author User
 */
@WebServlet(name = "UserDashboardServlet", urlPatterns = {"/UserDashboardServlet"})
public class UserDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int victimCount = UserDAO.getCount("VICTIM");
        int needCount = UserDAO.getCount("NEED");
        int volunteerCount = UserDAO.getCount("VOLUNTEER");

        // Pass the values to the JSP page
        request.setAttribute("victimCount", victimCount);
        request.setAttribute("needCount", needCount);
        request.setAttribute("volunteerCount", volunteerCount);

        // Forward the request to the JSP page
        request.getRequestDispatcher("users-index.jsp").forward(request, response);
    }

}
