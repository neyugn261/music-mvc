package models.bo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import models.bean.Singer;
import models.dao.SingerDAO;

import java.util.List;

public class SingerBO {
    private SingerDAO singerDAO = new SingerDAO();
    private FileBO fileBO;
    
    public SingerBO() {
        // Default constructor
    }
    
    public SingerBO(ServletContext servletContext) {
        this.fileBO = new FileBO(servletContext);
    }
    
    /**
     * Add singer with file upload
     */
    public boolean addSingerWithFiles(Singer singer, Part imagePart) {
        try {
            // Save image file
            if (imagePart != null && imagePart.getSize() > 0) {
                String imagePath = fileBO.saveFile(imagePart, "images/singer");
                singer.setImage(imagePath);
            }
            
            // Save to database
            return singerDAO.addSinger(singer);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Update singer with optional file upload
     */
    public boolean updateSingerWithFiles(Singer singer, Part imagePart) {
        try {
            // Get current singer data
            Singer currentSinger = singerDAO.getSingerById(singer.getId());
            if (currentSinger == null) {
                return false;
            }
            
            // Handle image file update
            if (imagePart != null && imagePart.getSize() > 0) {
                // Delete old image file
                fileBO.deleteFile(currentSinger.getImage());
                
                // Save new image file
                String imagePath = fileBO.saveFile(imagePart, "images/singer");
                singer.setImage(imagePath);
            } else {
                // Keep old image
                singer.setImage(currentSinger.getImage());
            }
            
            // Update database
            return singerDAO.updateSinger(singer);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Delete singer with associated file
     */
    public boolean deleteSingerWithFiles(int id) {
        try {
            // Get singer info before deleting
            Singer singer = singerDAO.getSingerById(id);
            
            // Delete from database
            boolean success = singerDAO.deleteSinger(id);
            
            // Delete associated file if database deletion was successful
            if (success && singer != null) {
                fileBO.deleteFile(singer.getImage());
            }
            
            return success;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Singer> getAllSinger() {
        return singerDAO.getAllSingers();
    }

    public List<Singer> getSingers(int limit) {
        return singerDAO.getSingers(limit);
    }

    public Singer getSingerById(int id) {
        return singerDAO.getSingerById(id);
    }

    public boolean addSinger(Singer singer) {
        return singerDAO.addSinger(singer);
    }

    public boolean updateSinger(Singer singer) {
        return singerDAO.updateSinger(singer);
    }

    public boolean deleteSinger(int id) {
        return singerDAO.deleteSinger(id);
    }
}
