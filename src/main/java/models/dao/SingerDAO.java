package models.dao;

import models.bean.Singer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SingerDAO {
    public List<Singer> getAllSingers() {
        List<Singer> singers = new ArrayList<>();
        String sql = "SELECT * FROM singers";
        try(Connection conn = DatabaseConection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()){
            while (rs.next()) {
                Singer singer = new Singer();
                singer.setId(rs.getInt("id"));
                singer.setName(rs.getString("name"));
                singer.setCountry(rs.getString("country"));
                singer.setImage(rs.getString("image"));
                singers.add(singer);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return singers;
    }

    // Lấy danh sách nghệ sĩ với giới hạn
    public List<Singer> getSingers(int limit) {
        List<Singer> singers = new ArrayList<>();
        String sql = "SELECT * FROM singers LIMIT ?";
        try(Connection conn = DatabaseConection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            
            pstmt.setInt(1, limit);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Singer singer = new Singer();
                    singer.setId(rs.getInt("id"));
                    singer.setName(rs.getString("name"));
                    singer.setCountry(rs.getString("country"));
                    singer.setImage(rs.getString("image"));
                    singers.add(singer);
                }
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return singers;
    }

    // Lấy thông tin chi tiết nghệ sĩ theo ID
    public Singer getSingerById(int id) {
        Singer singer = null;
        String sql = "SELECT * FROM singers WHERE id = ?";
        try(Connection conn = DatabaseConection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    singer = new Singer();
                    singer.setId(rs.getInt("id"));
                    singer.setName(rs.getString("name"));
                    singer.setCountry(rs.getString("country"));
                    singer.setImage(rs.getString("image"));
                }
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return singer;
    }

    // Thêm ca sĩ mới
    public boolean addSinger(Singer singer) {
        String sql = "INSERT INTO singers (name, country, image) VALUES (?, ?, ?)";
        try(Connection conn = DatabaseConection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            
            pstmt.setString(1, singer.getName());
            pstmt.setString(2, singer.getCountry());
            pstmt.setString(3, singer.getImage());
            
            return pstmt.executeUpdate() > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật thông tin ca sĩ
    public boolean updateSinger(Singer singer) {
        String sql = "UPDATE singers SET name = ?, country = ?, image = ? WHERE id = ?";
        try(Connection conn = DatabaseConection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            
            pstmt.setString(1, singer.getName());
            pstmt.setString(2, singer.getCountry());
            pstmt.setString(3, singer.getImage());
            pstmt.setInt(4, singer.getId());
            
            return pstmt.executeUpdate() > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa ca sĩ
    public boolean deleteSinger(int id) {
        String sql = "DELETE FROM singers WHERE id = ?";
        try(Connection conn = DatabaseConection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            
            pstmt.setInt(1, id);
            
            return pstmt.executeUpdate() > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
