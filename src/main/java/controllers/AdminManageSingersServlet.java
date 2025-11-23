package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.bean.Singer;
import models.bo.SingerBO;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/singers")
public class AdminManageSingersServlet extends HttpServlet {
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
        
        // Get all singers
        List<Singer> allSingers = singerBO.getAllSinger();
        
        // Filter by search keyword if provided
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            String keyword = searchKeyword.trim().toLowerCase();
            allSingers = allSingers.stream()
                .filter(singer -> 
                    singer.getName().toLowerCase().contains(keyword) ||
                    (singer.getCountry() != null && singer.getCountry().toLowerCase().contains(keyword))
                )
                .collect(java.util.stream.Collectors.toList());
            request.setAttribute("searchKeyword", searchKeyword);
        }
        
        // Calculate pagination
        int totalRecords = allSingers.size();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        
        // Get singers for current page
        int start = (page - 1) * recordsPerPage;
        int end = Math.min(start + recordsPerPage, totalRecords);
        List<Singer> singers = allSingers.subList(start, end);
        
        request.setAttribute("singers", singers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        
        request.getRequestDispatcher("/admin/singers.jsp").forward(request, response);
    }
}
