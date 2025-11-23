package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.bean.Singer;
import models.bean.Song;
import models.bo.SingerBO;
import models.bo.SongBO;

import java.io.IOException;
import java.util.List;

@WebServlet("/singer-detail")
public class SingerDetailServlet extends HttpServlet {
    private SingerBO singerBO = new SingerBO();
    private SongBO songBO = new SongBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        // Kiểm tra tham số id
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("home");
            return;
        }
        
        try {
            int singerId = Integer.parseInt(idParam);
            
            // Lấy thông tin nghệ sĩ
            Singer singer = singerBO.getSingerById(singerId);
            
            if (singer == null) {
                response.sendRedirect("home");
                return;
            }
            
            // Lấy danh sách bài hát của nghệ sĩ
            List<Song> songs = songBO.getSongsBySingerId(singerId);
            
            // Gửi dữ liệu sang JSP
            request.setAttribute("singer", singer);
            request.setAttribute("songs", songs);
            request.getRequestDispatcher("detailSinger.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }
}
