package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

@WebServlet("/uploads/*")
public class FileServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get the requested file path
        String requestedFile = request.getPathInfo();
        
        if (requestedFile == null || requestedFile.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Get absolute path to uploads folder
        String applicationPath = getServletContext().getRealPath("");
        File webappDir = new File(applicationPath);
        File projectRoot = webappDir.getParentFile().getParentFile();
        File file = new File(projectRoot, "uploads" + requestedFile);
        
        // Check if file exists and is within uploads directory
        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Security check: ensure file is within uploads directory
        String uploadsPath = new File(projectRoot, "uploads").getCanonicalPath();
        if (!file.getCanonicalPath().startsWith(uploadsPath)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // Set content type based on file extension
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) {
            mimeType = Files.probeContentType(file.toPath());
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
        }
        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());
        
        // Set cache headers for better performance
        response.setHeader("Cache-Control", "public, max-age=31536000");
        
        // Stream the file to response
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}
