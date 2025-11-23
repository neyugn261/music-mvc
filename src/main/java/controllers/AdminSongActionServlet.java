package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import models.bean.Song;
import models.bean.Singer;
import models.bo.SongBO;
import models.bo.SingerBO;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

@WebServlet("/admin/song-action")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 50,       // 50MB
    maxRequestSize = 1024 * 1024 * 100    // 100MB
)
public class AdminSongActionServlet extends HttpServlet {
    private SongBO songBO;
    private SingerBO singerBO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize BO with ServletContext
        songBO = new SongBO(getServletContext());
        singerBO = new SingerBO(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                addSong(request, response);
            } else if ("edit".equals(action)) {
                editSong(request, response);
            } else if ("delete".equals(action)) {
                deleteSong(request, response);
            } else if ("bulkDelete".equals(action)) {
                bulkDeleteSongs(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/songs");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/songs?error=" + e.getMessage());
        }
    }
    
    private void addSong(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        String title = request.getParameter("title");
        int singerId = Integer.parseInt(request.getParameter("singerId"));
        String lyrics = request.getParameter("lyrics");
        
        // Get file parts
        Part audioPart = request.getPart("audioFile");
        Part imagePart = request.getPart("imageFile");
        
        // Create song object
        Song song = new Song();
        song.setTitle(title);
        song.setSingerId(singerId);
        song.setLyrics(lyrics);
        
        // Add song with files using BO
        boolean success = songBO.addSongWithFiles(song, audioPart, imagePart);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/songs?success=added");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/songs?error=add_failed");
        }
    }
    
    private void editSong(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        int singerId = Integer.parseInt(request.getParameter("singerId"));
        String lyrics = request.getParameter("lyrics");
        
        // Get file parts
        Part audioPart = request.getPart("audioFile");
        Part imagePart = request.getPart("imageFile");
        
        // Create song object
        Song song = new Song();
        song.setId(id);
        song.setTitle(title);
        song.setSingerId(singerId);
        song.setLyrics(lyrics);
        
        // Update song with files using BO
        boolean success = songBO.updateSongWithFiles(song, audioPart, imagePart);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/songs?success=updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/songs?error=update_failed");
        }
    }
    
    private void deleteSong(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        // Delete song with files using BO
        boolean success = songBO.deleteSongWithFiles(id);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/songs?success=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/songs?error=delete_failed");
        }
    }
    
    private void bulkDeleteSongs(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String[] ids = request.getParameterValues("ids");
        
        if (ids == null || ids.length == 0) {
            response.sendRedirect(request.getContextPath() + "/admin/songs?error=no_ids");
            return;
        }
        
        int successCount = 0;
        for (String idStr : ids) {
            try {
                int id = Integer.parseInt(idStr);
                // Delete song with files using BO
                if (songBO.deleteSongWithFiles(id)) {
                    successCount++;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        if (successCount > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/songs?success=deleted&count=" + successCount);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/songs?error=delete_failed");
        }
    }
}
