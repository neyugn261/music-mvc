package models.dao;

import models.bean.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {
    
    // Đăng nhập admin
    public Admin login(String username, String password) {
        Admin admin = null;
        String sql = "SELECT * FROM admins WHERE username = ? AND password = ?";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    admin = new Admin();
                    admin.setId(rs.getInt("id"));
                    admin.setUsername(rs.getString("username"));
                    admin.setPassword(rs.getString("password"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }
}
