package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.bean.Song;
import models.bo.SongBO;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServerlet extends HttpServlet {
    private SongBO songBO = new models.bo.SongBO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Song> songList = songBO.getAllSongs();
        req.setAttribute("songList", songList);
        req.getRequestDispatcher("index.jsp").forward(req, resp);

    }
}
