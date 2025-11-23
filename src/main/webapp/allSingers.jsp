<%@ page import="models.bean.Singer" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tất Cả Nghệ Sĩ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e1e2e 0%, #2d2d44 100%);
            color: #fff;
            padding: 20px;
            min-height: 100vh;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        /* Header */
        .page-header {
            margin-bottom: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        h1 {
            font-size: 2.5rem;
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .back-btn {
            padding: 12px 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.6);
        }
        
        /* Grid Layout */
        .singer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }
        
        /* Singer Card */
        .singer-card {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            border: 2px solid transparent;
        }
        
        .singer-card:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: #ff6b6b;
            transform: translateY(-5px);
        }
        
        .singer-image {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            margin: 0 auto 15px;
            border: 3px solid #4ecdc4;
        }
        
        .singer-name {
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .singer-country {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.6);
        }
        
        .no-singers {
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
            padding: 60px;
            font-size: 1.3rem;
        }
        
        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 40px;
            padding: 20px;
        }

        .pagination a,
        .pagination span {
            padding: 10px 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            text-decoration: none;
            color: #fff;
            transition: all 0.3s;
            font-weight: 500;
            background: rgba(255, 255, 255, 0.05);
        }

        .pagination a:hover {
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            border-color: transparent;
            transform: translateY(-2px);
        }

        .pagination .current {
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            border-color: transparent;
        }

        .pagination .disabled {
            opacity: 0.3;
            cursor: not-allowed;
            pointer-events: none;
        }

        .pagination-info {
            text-align: center;
            color: rgba(255, 255, 255, 0.7);
            margin-top: 15px;
            font-size: 0.9em;
        }
        
        @media (max-width: 768px) {
            .singer-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }
            
            h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1>🎤 Tất Cả Nghệ Sĩ</h1>
            <a href="home" class="back-btn">← Quay lại</a>
        </div>

        <%
            List<Singer> singers = (List<Singer>) request.getAttribute("singers");
            if (singers != null && !singers.isEmpty()) {
        %>
            <div class="singer-grid">
                <% for (Singer singer : singers) { %>
                    <a href="singer-detail?id=<%= singer.getId() %>" style="text-decoration: none; color: inherit;">
                        <div class="singer-card">
                            <img src="<%= request.getContextPath() + "/" + singer.getImage() %>" 
                                 alt="<%= singer.getName() %>" 
                                 class="singer-image"
                                 onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22120%22 height=%22120%22%3E%3Ccircle fill=%22%23ff6b6b%22 cx=%2260%22 cy=%2260%22 r=%2260%22/%3E%3Ctext fill=%22%23fff%22 font-size=%2240%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22%3E🎤%3C/text%3E%3C/svg%3E'">
                            <div class="singer-name"><%= singer.getName() %></div>
                            <div class="singer-country"><%= singer.getCountry() != null ? singer.getCountry() : "" %></div>
                        </div>
                    </a>
                <% } %>
            </div>
            
            <!-- Pagination -->
            <%
                Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");
                Integer totalRecords = (Integer) request.getAttribute("totalRecords");
                if (currentPage == null) currentPage = 1;
                if (totalPages == null) totalPages = 1;
                if (totalRecords == null) totalRecords = 0;
            %>
            
            <% if (totalPages > 1) { %>
            <div class="pagination">
                <% if (currentPage > 1) { %>
                    <a href="singer?view=all&page=<%= currentPage - 1 %>">← Trước</a>
                <% } else { %>
                    <span class="disabled">← Trước</span>
                <% } %>
                
                <% 
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, currentPage + 2);
                    
                    for (int i = startPage; i <= endPage; i++) {
                        if (i == currentPage) {
                %>
                            <span class="current"><%= i %></span>
                <%      } else { %>
                            <a href="singer?view=all&page=<%= i %>"><%= i %></a>
                <%      }
                    }
                %>
                
                <% if (currentPage < totalPages) { %>
                    <a href="singer?view=all&page=<%= currentPage + 1 %>">Sau →</a>
                <% } else { %>
                    <span class="disabled">Sau →</span>
                <% } %>
            </div>
            <div class="pagination-info">
                Hiển thị <%= ((currentPage - 1) * 20 + 1) %> - <%= Math.min(currentPage * 20, totalRecords) %> trong tổng số <%= totalRecords %> nghệ sĩ
            </div>
            <% } %>
        <% } else { %>
            <div class="no-singers">Chưa có nghệ sĩ nào 😢</div>
        <% } %>
    </div>
</body>
</html>
