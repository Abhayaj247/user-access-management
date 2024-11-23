package com.uams.dao;

import com.uams.model.Software;
import com.uams.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SoftwareDAO {
    
    public Software createSoftware(Software software) throws SQLException {
        String sql = "INSERT INTO software (name, description, access_levels) VALUES (?, ?, ?::text[])";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, software.getName());
            stmt.setString(2, software.getDescription());
            
            // Convert List to PostgreSQL array string format
            String arrayStr = software.getAccessLevels().toString()
                .replace("[", "{")
                .replace("]", "}")
                .replace(" ", "");
            stmt.setString(3, arrayStr);
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    software.setId(rs.getInt(1));
                }
            }
        }
        return software;
    }
    
    public Software findById(int id) throws SQLException {
        String sql = "SELECT id, name, description, array_to_string(access_levels, ',') as access_levels_str FROM software WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Software software = new Software();
                    software.setId(rs.getInt("id"));
                    software.setName(rs.getString("name"));
                    software.setDescription(rs.getString("description"));
                    
                    String accessLevelsStr = rs.getString("access_levels_str");
                    if (accessLevelsStr != null && !accessLevelsStr.isEmpty()) {
                        software.setAccessLevels(accessLevelsStr.split(","));
                    } else {
                        software.setAccessLevels(new ArrayList<>());
                    }
                    return software;
                }
            }
        }
        return null;
    }
    
    public List<Software> getAllSoftware() throws SQLException {
        String sql = "SELECT id, name, description, array_to_string(access_levels, ',') as access_levels_str FROM software";
        List<Software> softwareList = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Software software = new Software();
                software.setId(rs.getInt("id"));
                software.setName(rs.getString("name"));
                software.setDescription(rs.getString("description"));
                
                String accessLevelsStr = rs.getString("access_levels_str");
                if (accessLevelsStr != null && !accessLevelsStr.isEmpty()) {
                    software.setAccessLevels(accessLevelsStr.split(","));
                } else {
                    software.setAccessLevels(new ArrayList<>());
                }
                softwareList.add(software);
            }
        }
        return softwareList;
    }
}
