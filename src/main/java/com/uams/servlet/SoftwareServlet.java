package com.uams.servlet;

import com.uams.model.Software;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/software/*")
public class SoftwareServlet extends BaseServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        try {
            if ("/create".equals(pathInfo)) {
                if (!isUserInRole(request, "Admin")) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/jsp/createSoftware.jsp").forward(request, response);
            } else if ("/list".equals(pathInfo)) {
                List<Software> softwareList = softwareDAO.getAllSoftware();
                request.setAttribute("softwareList", softwareList);
                request.getRequestDispatcher("/WEB-INF/jsp/listSoftware.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Error processing software request", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isUserInRole(request, "Admin")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String[] accessLevels = request.getParameterValues("accessLevels");
        
        if (accessLevels == null || accessLevels.length == 0) {
            request.setAttribute("error", "At least one access level must be selected");
            request.getRequestDispatcher("/WEB-INF/jsp/createSoftware.jsp").forward(request, response);
            return;
        }
        
        try {
            Software software = new Software(name, description, accessLevels);
            softwareDAO.createSoftware(software);
            response.sendRedirect(request.getContextPath() + "/software/list");
        } catch (Exception e) {
            request.setAttribute("error", "Error creating software: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/createSoftware.jsp").forward(request, response);
        }
    }
}
