package models.bo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import models.bean.Song;
import models.dao.SongDAO;

import java.util.List;

public class SongBO {
    private SongDAO songDAO = new SongDAO();
    private FileBO fileBO;
    
    public SongBO() {
        // Default constructor
    }
    
    public SongBO(ServletContext servletContext) {
        this.fileBO = new FileBO(servletContext);
    }
    
    /**
     * Add song with file uploads
     */
    public boolean addSongWithFiles(Song song, Part audioPart, Part imagePart) {
        try {
            // Save audio file
            if (audioPart != null && audioPart.getSize() > 0) {
                String audioPath = fileBO.saveFile(audioPart, "audio/song");
                song.setAudio(audioPath);
            }
            
            // Save image file
            if (imagePart != null && imagePart.getSize() > 0) {
                String imagePath = fileBO.saveFile(imagePart, "images/song");
                song.setImage(imagePath);
            }
            
            // Save to database
            return songDAO.addSong(song);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Update song with optional file uploads
     */
    public boolean updateSongWithFiles(Song song, Part audioPart, Part imagePart) {
        try {
            // Get current song data
            Song currentSong = songDAO.getSongById(song.getId());
            if (currentSong == null) {
                return false;
            }
            
            // Handle audio file update
            if (audioPart != null && audioPart.getSize() > 0) {
                // Delete old audio file
                fileBO.deleteFile(currentSong.getAudio());
                
                // Save new audio file
                String audioPath = fileBO.saveFile(audioPart, "audio/song");
                song.setAudio(audioPath);
            } else {
                // Keep old audio
                song.setAudio(currentSong.getAudio());
            }
            
            // Handle image file update
            if (imagePart != null && imagePart.getSize() > 0) {
                // Delete old image file
                fileBO.deleteFile(currentSong.getImage());
                
                // Save new image file
                String imagePath = fileBO.saveFile(imagePart, "images/song");
                song.setImage(imagePath);
            } else {
                // Keep old image
                song.setImage(currentSong.getImage());
            }
            
            // Update database
            return songDAO.updateSong(song);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Delete song with associated files
     */
    public boolean deleteSongWithFiles(int id) {
        try {
            // Get song info before deleting
            Song song = songDAO.getSongById(id);
            
            // Delete from database
            boolean success = songDAO.deleteSong(id);
            
            // Delete associated files if database deletion was successful
            if (success && song != null) {
                fileBO.deleteFile(song.getAudio());
                fileBO.deleteFile(song.getImage());
            }
            
            return success;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Song> getAllSongs() {
        return songDAO.getAllSongs();
    }

    public List<Song> searchSongs(String keyword) {
        return songDAO.searchSongs(keyword);
    }

    public List<Song> getRandomSongs(int limit) {
        return songDAO.getRandomSongs(limit);
    }

    public List<Song> getRecentSongs(int limit) {
        return songDAO.getRecentSongs(limit);
    }

    public List<Song> getSongsBySingerId(int singerId) {
        return songDAO.getSongsBySingerId(singerId);
    }

    public Song getSongById(int id) {
        return songDAO.getSongById(id);
    }

    public boolean addSong(Song song) {
        return songDAO.addSong(song);
    }

    public boolean updateSong(Song song) {
        return songDAO.updateSong(song);
    }

    public boolean deleteSong(int id) {
        return songDAO.deleteSong(id);
    }
}
