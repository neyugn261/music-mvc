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

import java.awt.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServerlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SongBO songBO = new SongBO();
        SingerBO singerBO = new SingerBO();

        // Lấy keyword tìm kiếm nếu có
        String keyword = req.getParameter("keyword");
        
        // Lấy gợi ý bài hát (5 bài random)
        List<Song> suggestedSongs = songBO.getRandomSongs(5);
        System.out.println("Suggested Songs: " + suggestedSongs);
        
        // Lấy bài hát mới phát hành (5bài)
        List<Song> recentSongs = songBO.getRecentSongs(5);
        System.out.println("Recent Songs: " + recentSongs);
        
        // Lấy danh sách nghệ sĩ (6 nghệ sĩ)
        List<Singer> singerList = singerBO.getSingers(6);
        System.out.println("Singer List: " + singerList);
        
        // Nếu có tìm kiếm
        List<Song> searchResults = null;
        if (keyword != null && !keyword.trim().isEmpty()) {
            searchResults = songBO.searchSongs(keyword);
        }

        // Set attributes
        req.setAttribute("suggestedSongs", suggestedSongs);
        req.setAttribute("recentSongs", recentSongs);
        req.setAttribute("singerList", singerList);
        req.setAttribute("searchResults", searchResults);
        req.setAttribute("keyword", keyword);
        
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}
