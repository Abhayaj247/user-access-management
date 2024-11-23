package com.uams.servlet;

import com.uams.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends BaseServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (isAuthenticated(request)) {
            redirectBasedOnRole(request, response, getLoggedInUser(request));
            return;
        }
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            User user = userDAO.findByUsername(username);
            
            if (user != null && userDAO.validatePassword(password, user.getPassword())) {
                // Create session and store user
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Redirect based on role
                redirectBasedOnRole(request, response, user);
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error during login: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        }
    }
    
    private void redirectBasedOnRole(HttpServletRequest request, HttpServletResponse response, User user) 
            throws IOException {
        String contextPath = request.getContextPath();
        String role = user.getRole().toUpperCase();
        
        switch (role) {
            case "ADMIN":
                response.sendRedirect(contextPath + "/requests/pending");
                break;
            case "MANAGER":
                response.sendRedirect(contextPath + "/requests/pending");
                break;
            default: // Employee or other roles
                response.sendRedirect(contextPath + "/requests/my");
                break;
        }
    }
}
