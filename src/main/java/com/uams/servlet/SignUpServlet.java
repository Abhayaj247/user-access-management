package com.uams.servlet;

import com.uams.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/signup")
public class SignUpServlet extends BaseServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        try {
            // Check if username already exists
            if (userDAO.findByUsername(username) != null) {
                request.setAttribute("error", "Username already exists");
                request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
                return;
            }
            
            // Create new user with EMPLOYEE role
            User user = new User(username, password, email, "EMPLOYEE");
            userDAO.createUser(user);
            
            // Redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
            
        } catch (Exception e) {
            request.setAttribute("error", "Error creating user: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
        }
    }
}
