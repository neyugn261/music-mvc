package models.dao;

import models.bean.Singer;
import models.bean.Song;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SongDetailDAO {
    // Lấy thông tin chi tiết bài hát theo ID
    public Song getSongById(int id) {
        Song song = null;
        String sql = "SELECT s.*, si.name as singer_name FROM songs s " +
                    "LEFT JOIN singers si ON s.singer_id = si.id " +
                    "WHERE s.id = ?";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    song = new Song();
                    song.setId(rs.getInt("id"));
                    song.setTitle(rs.getString("title"));
                    song.setSingerId(rs.getInt("singer_id"));
                    song.setAudio(rs.getString("audio"));
                    song.setImage(rs.getString("image"));
                    song.setLyrics(rs.getString("lyrics"));
                    song.setCreatedAt(rs.getTimestamp("created_at"));
                    song.setSingerName(rs.getString("singer_name"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return song;
    }

    // Lấy thông tin nghệ sĩ theo ID
    public Singer getSingerById(int id) {
        Singer singer = null;
        String sql = "SELECT * FROM singers WHERE id = ?";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return singer;
    }
}
