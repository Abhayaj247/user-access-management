package com.uams.dao;

import com.uams.model.Request;
import com.uams.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RequestDAO {
    
    public Request createRequest(Request request) throws SQLException {
        String sql = "INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, request.getUserId());
            stmt.setInt(2, request.getSoftwareId());
            stmt.setString(3, request.getAccessType());
            stmt.setString(4, request.getReason());
            stmt.setString(5, request.getStatus()); // Use the status from the request object
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    request.setId(rs.getInt(1));
                }
            }
        }
        return request;
    }
    
    public void updateRequestStatus(int requestId, String status) throws SQLException {
        String sql = "UPDATE requests SET status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status.toUpperCase()); // Ensure status is uppercase
            stmt.setInt(2, requestId);
            stmt.executeUpdate();
        }
    }
    
    public List<Request> getPendingRequests() throws SQLException {
        List<Request> requests = new ArrayList<>();
        String sql = "SELECT r.*, s.name as software_name, u.username as username, " +
                    "TO_CHAR(r.created_at, 'YYYY-MM-DD') as formatted_date " +
                    "FROM requests r " +
                    "JOIN software s ON r.software_id = s.id " +
                    "JOIN users u ON r.user_id = u.id " +
                    "WHERE r.status = 'PENDING' " +
                    "ORDER BY r.created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Request request = new Request();
                request.setId(rs.getInt("id"));
                request.setUserId(rs.getInt("user_id"));
                request.setUsername(rs.getString("username"));
                request.setSoftwareId(rs.getInt("software_id"));
                request.setSoftwareName(rs.getString("software_name"));
                request.setAccessType(rs.getString("access_type"));
                request.setReason(rs.getString("reason"));
                request.setStatus(rs.getString("status"));
                request.setRequestDate(rs.getString("formatted_date"));
                requests.add(request);
            }
        }
        return requests;
    }
    
    public List<Request> getRequestsByUserId(int userId) throws SQLException {
        List<Request> requests = new ArrayList<>();
        String sql = "SELECT r.*, s.name as software_name, " +
                    "TO_CHAR(r.created_at, 'YYYY-MM-DD') as formatted_date " +
                    "FROM requests r " +
                    "JOIN software s ON r.software_id = s.id " +
                    "WHERE r.user_id = ? " +
                    "ORDER BY r.created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Request request = new Request();
                    request.setId(rs.getInt("id"));
                    request.setUserId(rs.getInt("user_id"));
                    request.setSoftwareId(rs.getInt("software_id"));
                    request.setSoftwareName(rs.getString("software_name"));
                    request.setAccessType(rs.getString("access_type"));
                    request.setReason(rs.getString("reason"));
                    request.setStatus(rs.getString("status"));
                    request.setRequestDate(rs.getString("formatted_date"));
                    requests.add(request);
                }
            }
        }
        return requests;
    }
}
