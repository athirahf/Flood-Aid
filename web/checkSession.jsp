<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if the user is logged in
    if (session.getAttribute("userID") == null) {
        application.log("Session expired or userID not found in CheckSession.jsp.");
        response.sendRedirect("pages-login.html?error=session_expired");
        return;
    }

    // Retrieve session attributes
    String userID = String.valueOf(session.getAttribute("userID"));
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    String name = (String) session.getAttribute("name");

    // Log session attributes for debugging
    application.log("CheckSession.jsp:");
    application.log("userID: " + userID);
    application.log("username: " + username);
    application.log("role: " + role);
    application.log("name: " + name);
%>
