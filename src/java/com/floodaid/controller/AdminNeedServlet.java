package com.floodaid.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import com.floodaid.model.Need;
import com.floodaid.model.NeedDAO;

@WebServlet("/AdminNeedServlet")
public class AdminNeedServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NeedDAO needDAO = new NeedDAO();
        List<Need> needs = needDAO.getAllNeeds();

        System.out.println("Signal List Size: " + needs.size());

        request.setAttribute("needs", needs);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin-need.jsp");
        dispatcher.forward(request, response);
    }
}

