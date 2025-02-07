package com.floodaid.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.floodaid.model.UserDAO;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        String name = request.getParameter("name");
        String nric = request.getParameter("nric");
        int age = Integer.parseInt(request.getParameter("age"));
        String email = request.getParameter("email");
        String phoneNum = request.getParameter("phoneNum");
        String address = request.getParameter("address");

        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.updateUser(userID, name, nric, age, email, phoneNum, address);

        if (success) {
            response.sendRedirect("AdminUsersServlet?success=edit");
        } else {
            response.sendRedirect("admin-edituser.jsp?userID=" + userID + "&error=update_failed");
        }
    }
}
