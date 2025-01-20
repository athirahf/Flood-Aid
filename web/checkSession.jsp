<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if session exists and contains necessary attributes
    if (session == null || session.getAttribute("userID") == null) {
        System.out.println("Session expired or userID not found in checkSession.jsp.");
        response.sendRedirect("pages-login.html?error=session_expired");
        return;
    }

    // Retrieve session attributes
    String userID = (String) session.getAttribute("userID");
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    String name = (String) session.getAttribute("name");

    // Log session attributes for debugging
    System.out.println("checkSession.jsp:");
    System.out.println("userID: " + userID);
    System.out.println("username: " + username);
    System.out.println("role: " + role);
    System.out.println("name: " + name);
%>
