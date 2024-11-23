package com.uams.servlet;

import com.uams.dao.UserDAO;
import com.uams.dao.SoftwareDAO;
import com.uams.dao.RequestDAO;
import com.uams.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public abstract class BaseServlet extends HttpServlet {
    protected UserDAO userDAO;
    protected SoftwareDAO softwareDAO;
    protected RequestDAO requestDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
        softwareDAO = new SoftwareDAO();
        requestDAO = new RequestDAO();
    }
    
    protected User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute("user");
        }
        return null;
    }
    
    protected boolean isUserInRole(HttpServletRequest request, String role) {
        User user = getLoggedInUser(request);
        return user != null && user.getRole().equalsIgnoreCase(role);
    }
    
    protected boolean isAuthenticated(HttpServletRequest request) {
        return getLoggedInUser(request) != null;
    }
}
