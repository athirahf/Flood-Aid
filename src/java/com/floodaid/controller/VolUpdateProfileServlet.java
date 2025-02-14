package com.floodaid.controller;

import com.floodaid.model.User;
import com.floodaid.model.UserDAO;
import com.floodaid.model.VolunteerDAO;
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

@WebServlet("/VolUpdateProfileServlet")
public class VolUpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("pages-login.html?error=session_expired");
            return;
        }

        int userID = Integer.parseInt(request.getParameter("userID"));
        String name = request.getParameter("name");
        String nric = request.getParameter("nric");
        int age = Integer.parseInt(request.getParameter("age"));
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String volEmployment = request.getParameter("volEmployment");
        int shelterID = Integer.parseInt(request.getParameter("shelterID"));
        String availability = request.getParameter("availability");
        
        VolunteerDAO volunteerDAO = new VolunteerDAO();
        boolean updated = volunteerDAO.updateVolunteer(userID, name, nric, age, address, phone, email, volEmployment, shelterID, availability);

        if (updated) {
            response.sendRedirect("VolunteerProfileServlet?success=profile_updated");
        } else {
            response.sendRedirect("VolunteerProfileServlet?error=update_failed");
        }
    }
}
