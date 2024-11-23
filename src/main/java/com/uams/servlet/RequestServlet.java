package com.uams.servlet;

import com.uams.dao.RequestDAO;
import com.uams.dao.SoftwareDAO;
import com.uams.model.Request;
import com.uams.model.Software;
import com.uams.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/requests/*")
public class RequestServlet extends HttpServlet {
    private RequestDAO requestDAO;
    private SoftwareDAO softwareDAO;

    @Override
    public void init() throws ServletException {
        requestDAO = new RequestDAO();
        softwareDAO = new SoftwareDAO();
    }

    private boolean isUserInRole(HttpServletRequest request, String... roles) {
        User user = getLoggedInUser(request);
        if (user != null) {
            String userRole = user.getRole().toUpperCase();
            for (String role : roles) {
                if (userRole.equals(role.toUpperCase())) {
                    return true;
                }
            }
        }
        return false;
    }

    private User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (User) session.getAttribute("user") : null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        try {
            if ("/create".equals(pathInfo)) {
                // Allow EMPLOYEE, MANAGER, and ADMIN to create requests
                if (!isUserInRole(request, "EMPLOYEE", "MANAGER", "ADMIN")) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                List<Software> softwareList = softwareDAO.getAllSoftware();
                request.setAttribute("softwareList", softwareList);
                request.getRequestDispatcher("/WEB-INF/jsp/createRequest.jsp").forward(request, response);
            } else if ("/pending".equals(pathInfo)) {
                // Only MANAGER and ADMIN can view pending requests
                if (!isUserInRole(request, "MANAGER", "ADMIN")) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                List<Request> pendingRequests = requestDAO.getPendingRequests();
                request.setAttribute("requests", pendingRequests);
                request.getRequestDispatcher("/WEB-INF/jsp/pendingRequests.jsp").forward(request, response);
            } else if ("/my".equals(pathInfo)) {
                // All authenticated users can view their own requests
                User user = getLoggedInUser(request);
                List<Request> userRequests = requestDAO.getRequestsByUserId(user.getId());
                request.setAttribute("requests", userRequests);
                request.getRequestDispatcher("/WEB-INF/jsp/myRequests.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Error processing request", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        try {
            if ("/create".equals(pathInfo)) {
                // Allow EMPLOYEE, MANAGER, and ADMIN to create requests
                if (!isUserInRole(request, "EMPLOYEE", "MANAGER", "ADMIN")) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                createRequest(request, response);
            } else if ("/approve".equals(pathInfo)) {
                // Only MANAGER and ADMIN can approve requests
                if (!isUserInRole(request, "MANAGER", "ADMIN")) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                approveRequest(request, response);
            } else if ("/reject".equals(pathInfo)) {
                // Only MANAGER and ADMIN can reject requests
                if (!isUserInRole(request, "MANAGER", "ADMIN")) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                rejectRequest(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Error processing request", e);
        }
    }

    private void createRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int softwareId = Integer.parseInt(request.getParameter("softwareId"));
            String accessType = request.getParameter("accessType");
            String reason = request.getParameter("reason");
            User user = getLoggedInUser(request);

            Request newRequest = new Request();
            newRequest.setUserId(user.getId());
            newRequest.setSoftwareId(softwareId);
            newRequest.setAccessType(accessType);
            newRequest.setReason(reason);
            newRequest.setStatus("PENDING");

            requestDAO.createRequest(newRequest);
            response.sendRedirect(request.getContextPath() + "/requests/my");
        } catch (Exception e) {
            request.setAttribute("error", "Error creating request: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void approveRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            requestDAO.updateRequestStatus(requestId, "APPROVED");
            response.sendRedirect(request.getContextPath() + "/requests/pending");
        } catch (Exception e) {
            throw new ServletException("Error approving request", e);
        }
    }

    private void rejectRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            requestDAO.updateRequestStatus(requestId, "REJECTED");
            response.sendRedirect(request.getContextPath() + "/requests/pending");
        } catch (Exception e) {
            throw new ServletException("Error rejecting request", e);
        }
    }
}
