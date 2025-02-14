package com.floodaid.controller;

import com.floodaid.model.User;
import com.floodaid.model.UserDAO;
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

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:derby://localhost:1527/FloodAid";
    private static final String DB_USER = "FloodAid";
    private static final String DB_PASSWORD = "FloodAid";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("pages-login.html?error=session_expired");
            return;
        }

        int userID = (int) session.getAttribute("userID"); // ✅ Use user_ID instead of username

        String name = request.getParameter("name");
        String nric = request.getParameter("nric");
        String age = request.getParameter("age");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false);

            String sql = "UPDATE USERS SET name=?, nric=?, age=?, address=?, phoneNum=?, email=? WHERE user_ID=?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, name);
            stmt.setString(2, nric);
            stmt.setInt(3, Integer.parseInt(age));
            stmt.setString(4, address);
            stmt.setString(5, phone);
            stmt.setString(6, email);
            stmt.setInt(7, userID);

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                conn.commit(); 

                UserDAO userDAO = new UserDAO();
                User updatedUser = userDAO.getUserByID(userID); // ✅ Fetch updated user data

                session.setAttribute("user", updatedUser); // ✅ Update session with latest data

                String redirectPage;
                if ("Admin".equalsIgnoreCase(updatedUser.getRole())) {
                    redirectPage = "admin-profile.jsp";  // Redirect Admins to admin-profile.jsp
                } else {
                    redirectPage = "users-profile.jsp";  // Redirect Users to users-profile.jsp
                }
                
                response.sendRedirect(redirectPage + "?success=profile_updated");
            } else {
                conn.rollback(); 
                
                String errorPage = "users-profile.jsp"; // Default for users
                if ("Admin".equalsIgnoreCase(session.getAttribute("role").toString())) {
                    errorPage = "admin-profile.jsp"; // Admins go to admin-profile.jsp
                }
                
                response.sendRedirect(errorPage + "?error=no_update");
            }

            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            
            String errorPage = "users-profile.jsp"; // Default for users
            if ("Admin".equalsIgnoreCase(session.getAttribute("role").toString())) {
                errorPage = "admin-profile.jsp"; // Admins go to admin-profile.jsp
            }

            response.sendRedirect(errorPage + "?error=update_failed");
        }
    }
}
