package com.floodaid.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import com.floodaid.model.Need;
import com.floodaid.model.NeedDAO;
import com.floodaid.model.VolunteerDAO;

@WebServlet("/ManageNeedServlet")
public class ManageNeedServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("pages-login.html?error=session_expired");
            return;
        }

        int userID = (int) session.getAttribute("userID");

        // Get the shelter ID of the logged-in volunteer
        VolunteerDAO volunteerDAO = new VolunteerDAO();
        int shelterID = volunteerDAO.getShelterIDByUserID(userID);

        if (shelterID == -1) {
            request.setAttribute("needs", null);
        } else {
            NeedDAO needDAO = new NeedDAO();
            List<Need> needs = needDAO.getNeedsByShelterID(shelterID);
            request.setAttribute("needs", needs);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("volunteer-need.jsp");
        dispatcher.forward(request, response);
    }
}
