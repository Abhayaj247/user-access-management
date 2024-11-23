package com.uams.filter;

import com.uams.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // Allow access to login and signup pages without authentication
        if (path.equals("/login") || path.equals("/signup") || 
            path.startsWith("/css/") || path.startsWith("/js/")) {
            chain.doFilter(request, response);
            return;
        }
        
        HttpSession session = httpRequest.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        String userRole = user.getRole().toUpperCase();
        
        // Check role-based access
        if (path.startsWith("/software/create") && !"ADMIN".equals(userRole)) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        if (path.startsWith("/requests/pending") && 
            !"MANAGER".equals(userRole) && !"ADMIN".equals(userRole)) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
    }
}
