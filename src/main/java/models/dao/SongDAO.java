package models.dao;

import models.bean.Song;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SongDAO {
    public List<Song> getAllSongs() {
        List<Song> songs = new ArrayList<>();
        String sql = "SELECT s.*, si.name as singer_name FROM songs s " +
                    "LEFT JOIN singers si ON s.singer_id = si.id";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Song song = new Song();
                song.setId(rs.getInt("id"));
                song.setTitle(rs.getString("title"));
                song.setSingerId(rs.getInt("singer_id"));
                song.setAudio(rs.getString("audio"));
                song.setImage(rs.getString("image"));
                song.setCreatedAt(rs.getTimestamp("created_at"));
                song.setSingerName(rs.getString("singer_name"));
                songs.add(song);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return songs;
    }

    // Tìm kiếm bài hát theo tên bài hát hoặc tên nghệ sĩ
    public List<Song> searchSongs(String keyword) {
        List<Song> songs = new ArrayList<>();
        String sql = "SELECT s.*, si.name as singer_name FROM songs s " +
                    "LEFT JOIN singers si ON s.singer_id = si.id " +
                    "WHERE s.title LIKE ? OR si.name LIKE ?";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchKeyword = "%" + keyword + "%";
            pstmt.setString(1, searchKeyword);
            pstmt.setString(2, searchKeyword);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Song song = new Song();
                    song.setId(rs.getInt("id"));
                    song.setTitle(rs.getString("title"));
                    song.setSingerId(rs.getInt("singer_id"));
                    song.setAudio(rs.getString("audio"));
                    song.setImage(rs.getString("image"));
                    song.setCreatedAt(rs.getTimestamp("created_at"));
                    song.setSingerName(rs.getString("singer_name"));
                    songs.add(song);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return songs;
    }

    // Lấy danh sách bài hát ngẫu nhiên
    public List<Song> getRandomSongs(int limit) {
        List<Song> songs = new ArrayList<>();
        String sql = "SELECT s.*, si.name as singer_name FROM songs s " +
                    "LEFT JOIN singers si ON s.singer_id = si.id " +
                    "ORDER BY RAND() LIMIT ?";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Song song = new Song();
                    song.setId(rs.getInt("id"));
                    song.setTitle(rs.getString("title"));
                    song.setSingerId(rs.getInt("singer_id"));
                    song.setAudio(rs.getString("audio"));
                    song.setImage(rs.getString("image"));
                    song.setCreatedAt(rs.getTimestamp("created_at"));
                    song.setSingerName(rs.getString("singer_name"));
                    songs.add(song);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return songs;
    }

    // Lấy bài hát mới phát hành trong 1 tuần
    public List<Song> getRecentSongs(int limit) {
        List<Song> songs = new ArrayList<>();
        String sql = "SELECT s.*, si.name as singer_name FROM songs s " +
                    "LEFT JOIN singers si ON s.singer_id = si.id " +
                    "ORDER BY s.created_at DESC LIMIT ?";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Song song = new Song();
                    song.setId(rs.getInt("id"));
                    song.setTitle(rs.getString("title"));
                    song.setSingerId(rs.getInt("singer_id"));
                    song.setAudio(rs.getString("audio"));
                    song.setImage(rs.getString("image"));
                    song.setCreatedAt(rs.getTimestamp("created_at"));
                    song.setSingerName(rs.getString("singer_name"));
                    songs.add(song);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return songs;
    }

    // Lấy tất cả bài hát của một nghệ sĩ
    public List<Song> getSongsBySingerId(int singerId) {
        List<Song> songs = new ArrayList<>();
        String sql = "SELECT s.*, si.name as singer_name FROM songs s " +
                    "LEFT JOIN singers si ON s.singer_id = si.id " +
                    "WHERE s.singer_id = ? ORDER BY s.created_at DESC";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, singerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Song song = new Song();
                    song.setId(rs.getInt("id"));
                    song.setTitle(rs.getString("title"));
                    song.setSingerId(rs.getInt("singer_id"));
                    song.setAudio(rs.getString("audio"));
                    song.setImage(rs.getString("image"));
                    song.setCreatedAt(rs.getTimestamp("created_at"));
                    song.setSingerName(rs.getString("singer_name"));
                    songs.add(song);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return songs;
    }

    // Lấy bài hát theo ID
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

    // Thêm bài hát mới
    public boolean addSong(Song song) {
        String sql = "INSERT INTO songs (title, singer_id, audio, image, lyrics) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, song.getTitle());
            pstmt.setInt(2, song.getSingerId());
            pstmt.setString(3, song.getAudio());
            pstmt.setString(4, song.getImage());
            pstmt.setString(5, song.getLyrics());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật bài hát
    public boolean updateSong(Song song) {
        String sql = "UPDATE songs SET title = ?, singer_id = ?, audio = ?, image = ?, lyrics = ? WHERE id = ?";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, song.getTitle());
            pstmt.setInt(2, song.getSingerId());
            pstmt.setString(3, song.getAudio());
            pstmt.setString(4, song.getImage());
            pstmt.setString(5, song.getLyrics());
            pstmt.setInt(6, song.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa bài hát
    public boolean deleteSong(int id) {
        String sql = "DELETE FROM songs WHERE id = ?";
        try (Connection conn = DatabaseConection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
