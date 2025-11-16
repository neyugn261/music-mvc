package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.dao.DatabaseConection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/testdb")
public class TestDbServerlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try (Connection conn = DatabaseConection.getConnection()) {
            if (conn != null) {
                out.println("Kết nối CSDL thành công!");
            } else {
                out.println("Kết nối CSDL thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
