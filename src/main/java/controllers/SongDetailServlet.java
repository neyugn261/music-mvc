package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.bean.Singer;
import models.bean.Song;
import models.bo.SongDetailBO;

import java.io.IOException;

@WebServlet("/song-detail")
public class SongDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Lấy ID từ parameter
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                resp.sendRedirect("home");
                return;
            }

            int songId = Integer.parseInt(idParam);
            SongDetailBO songDetailBO = new SongDetailBO();

            // Lấy thông tin bài hát
            Song song = songDetailBO.getSongById(songId);
            if (song == null) {
                resp.sendRedirect("home");
                return;
            }

            // Lấy thông tin nghệ sĩ
            Singer singer = songDetailBO.getSingerById(song.getSingerId());

            // Set attributes
            req.setAttribute("song", song);
            req.setAttribute("singer", singer);

            req.getRequestDispatcher("detailSong.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect("home");
        }
    }
}
