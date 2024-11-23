package com.uams.servlet;

import com.uams.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/")
public class HomeServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String role = user.getRole().toUpperCase();

        switch (role) {
            case "ADMIN":
            case "MANAGER":
                // Redirect managers and admins to pending requests
                response.sendRedirect(request.getContextPath() + "/requests/pending");
                break;
            case "EMPLOYEE":
            default:
                // Redirect employees to their requests
                response.sendRedirect(request.getContextPath() + "/requests/my");
                break;
        }
    }
}
