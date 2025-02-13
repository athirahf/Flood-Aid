package com.floodaid.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import com.floodaid.model.Signal;
import com.floodaid.model.SignalDAO;

@WebServlet("/AdminSignalServlet")
public class AdminSignalServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SignalDAO signalDAO = new SignalDAO();
        List<Signal> signals = signalDAO.getAllSignal();

        System.out.println("Signal List Size: " + signals.size());

        request.setAttribute("signals", signals);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin-signal.jsp");
        dispatcher.forward(request, response);
    }
}

