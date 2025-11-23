package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.bean.Singer;
import models.bo.SingerBO;

import java.io.IOException;
import java.util.List;

@WebServlet("/singer")
public class SingerServerlet extends HttpServlet {
    private SingerBO singerBO = new SingerBO();
    private static final int RECORDS_PER_PAGE = 20;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String view = request.getParameter("view");
        
        if ("all".equals(view)) {
            // Get pagination parameters
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) currentPage = 1;
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            
            // Get all singers
            List<Singer> allSingers = singerBO.getAllSinger();
            int totalRecords = allSingers.size();
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);
            
            // Calculate pagination
            int start = (currentPage - 1) * RECORDS_PER_PAGE;
            int end = Math.min(start + RECORDS_PER_PAGE, totalRecords);
            
            // Get singers for current page
            List<Singer> singers = allSingers.subList(start, end);
            
            // Set attributes
            request.setAttribute("singers", singers);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);
            
            request.getRequestDispatcher("allSingers.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}
