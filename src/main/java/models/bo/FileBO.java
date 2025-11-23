package models.bo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

public class FileBO {
    private ServletContext servletContext;
    
    public FileBO(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
    
    /**
     * Save uploaded file to uploads directory
     * @param filePart The uploaded file part
     * @param uploadDir Directory path relative to uploads folder (e.g., "images/song", "audio/song")
     * @return Relative path for database (e.g., "uploads/images/song/123456.jpg") or null if no file
     */
    public String saveFile(Part filePart, String uploadDir) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        // Get filename
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        // Generate unique filename
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = System.currentTimeMillis() + fileExtension;
        
        // Get absolute path to uploads folder (outside target)
        String applicationPath = servletContext.getRealPath("");
        File webappDir = new File(applicationPath);
        File projectRoot = webappDir.getParentFile().getParentFile();
        String uploadPath = projectRoot.getAbsolutePath() + File.separator + "uploads" + File.separator + uploadDir;
        
        // Create directory if not exists
        File uploadDirFile = new File(uploadPath);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }
        
        // Save file
        Path filePath = Paths.get(uploadPath, uniqueFileName);
        Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        
        // Return relative path for database
        return "uploads/" + uploadDir + "/" + uniqueFileName;
    }
    
    /**
     * Delete file from uploads directory
     * @param filePath Relative path from database (e.g., "uploads/images/song/123456.jpg")
     */
    public void deleteFile(String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return;
        }
        
        try {
            // Get absolute path to project root
            String applicationPath = servletContext.getRealPath("");
            File webappDir = new File(applicationPath);
            File projectRoot = webappDir.getParentFile().getParentFile();
            
            // Build full path to file
            File file = new File(projectRoot, filePath);
            
            // Delete if exists
            if (file.exists() && file.isFile()) {
                if (file.delete()) {
                    System.out.println("Deleted file: " + filePath);
                } else {
                    System.out.println("Failed to delete file: " + filePath);
                }
            }
        } catch (Exception e) {
            System.out.println("Error deleting file: " + filePath);
            e.printStackTrace();
        }
    }
    
    /**
     * Get absolute path to a file in uploads directory
     * @param filePath Relative path from database
     * @return Absolute path to the file
     */
    public String getAbsolutePath(String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return null;
        }
        
        String applicationPath = servletContext.getRealPath("");
        File webappDir = new File(applicationPath);
        File projectRoot = webappDir.getParentFile().getParentFile();
        
        return projectRoot.getAbsolutePath() + File.separator + filePath;
    }
}
