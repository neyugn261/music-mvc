package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.bean.Admin;
import models.bo.SingerBO;
import models.bo.SongBO;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
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
        
        // Get statistics
        int totalSongs = songBO.getAllSongs().size();
        int totalSingers = singerBO.getAllSinger().size();
        
        request.setAttribute("totalSongs", totalSongs);
        request.setAttribute("totalSingers", totalSingers);
        
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
