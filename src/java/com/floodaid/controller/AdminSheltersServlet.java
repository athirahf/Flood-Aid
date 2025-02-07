package com.floodaid.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import com.floodaid.model.Shelter;
import com.floodaid.model.ShelterDAO;

@WebServlet("/AdminSheltersServlet")
public class AdminSheltersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ShelterDAO shelterDAO = new ShelterDAO();
        List<Shelter> shelters = shelterDAO.getAllShelters();

        System.out.println("Shelter List Size: " + shelters.size());

        request.setAttribute("shelters", shelters);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin-shelters.jsp");
        dispatcher.forward(request, response);
    }
}

