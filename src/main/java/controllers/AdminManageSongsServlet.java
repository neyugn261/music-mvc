package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.bean.Singer;
import models.bean.Song;
import models.bo.SingerBO;
import models.bo.SongBO;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/songs")
public class AdminManageSongsServlet extends HttpServlet {
    private SongBO songBO = new SongBO();
    private SingerBO singerBO = new SingerBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        // Pagination parameters
        int page = 1;
        int recordsPerPage = 10;
        
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Get search parameter
        String searchKeyword = request.getParameter("search");
        
        // Get all songs and singers
        List<Song> allSongs = songBO.getAllSongs();
        List<Singer> singers = singerBO.getAllSinger();
        
        // Filter by search keyword if provided
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            String keyword = searchKeyword.trim().toLowerCase();
            allSongs = allSongs.stream()
                .filter(song -> 
                    song.getTitle().toLowerCase().contains(keyword) ||
                    (song.getSingerName() != null && song.getSingerName().toLowerCase().contains(keyword))
                )
                .collect(java.util.stream.Collectors.toList());
            request.setAttribute("searchKeyword", searchKeyword);
        }
        
        // Calculate pagination
        int totalRecords = allSongs.size();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        
        // Get songs for current page
        int start = (page - 1) * recordsPerPage;
        int end = Math.min(start + recordsPerPage, totalRecords);
        List<Song> songs = allSongs.subList(start, end);
        
        request.setAttribute("songs", songs);
        request.setAttribute("singers", singers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        
        request.getRequestDispatcher("/admin/songs.jsp").forward(request, response);
    }
}
