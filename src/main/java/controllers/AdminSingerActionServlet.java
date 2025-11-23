package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import models.bean.Singer;
import models.bo.SingerBO;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/admin/singer-action")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 20     // 20MB
)
public class AdminSingerActionServlet extends HttpServlet {
    private SingerBO singerBO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize BO with ServletContext
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
                addSinger(request, response);
            } else if ("edit".equals(action)) {
                editSinger(request, response);
            } else if ("delete".equals(action)) {
                deleteSinger(request, response);
            } else if ("bulkDelete".equals(action)) {
                bulkDeleteSingers(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/singers");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/singers?error=" + e.getMessage());
        }
    }
    
    private void addSinger(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        String name = request.getParameter("name");
        String country = request.getParameter("country");
        
        // Get file part
        Part imagePart = request.getPart("imageFile");
        
        // Create singer object
        Singer singer = new Singer();
        singer.setName(name);
        singer.setCountry(country);
        
        // Add singer with file using BO
        boolean success = singerBO.addSingerWithFiles(singer, imagePart);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/singers?success=added");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/singers?error=add_failed");
        }
    }
    
    private void editSinger(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String country = request.getParameter("country");
        
        // Get file part
        Part imagePart = request.getPart("imageFile");
        
        // Create singer object
        Singer singer = new Singer();
        singer.setId(id);
        singer.setName(name);
        singer.setCountry(country);
        
        // Update singer with file using BO
        boolean success = singerBO.updateSingerWithFiles(singer, imagePart);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/singers?success=updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/singers?error=update_failed");
        }
    }
    
    private void deleteSinger(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        // Delete singer with file using BO
        boolean success = singerBO.deleteSingerWithFiles(id);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/singers?success=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/singers?error=delete_failed");
        }
    }
    
    private void bulkDeleteSingers(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String[] ids = request.getParameterValues("ids");
        
        if (ids == null || ids.length == 0) {
            response.sendRedirect(request.getContextPath() + "/admin/singers?error=no_ids");
            return;
        }
        
        int successCount = 0;
        for (String idStr : ids) {
            try {
                int id = Integer.parseInt(idStr);
                // Delete singer with file using BO
                if (singerBO.deleteSingerWithFiles(id)) {
                    successCount++;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        if (successCount > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/singers?success=deleted&count=" + successCount);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/singers?error=delete_failed");
        }
    }
}
