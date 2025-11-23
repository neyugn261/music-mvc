<%@ page import="models.bean.Song" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tất Cả Bài Hát</title>
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
        .song-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }
        
        /* Song Card */
        .song-card {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            padding: 15px;
            transition: all 0.3s;
            border: 2px solid transparent;
        }
        
        .song-card:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: #4ecdc4;
            transform: translateY(-5px);
        }
        
        .song-image-container {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            margin-bottom: 10px;
        }
        
        .song-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.3s;
        }
        
        .song-image:hover {
            transform: scale(1.05);
        }
        
        .play-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.6);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s;
        }
        
        .song-image-container:hover .play-overlay {
            opacity: 1;
        }
        
        .play-button {
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            box-shadow: 0 5px 15px rgba(78, 205, 196, 0.4);
            transform: scale(0.8);
            transition: transform 0.3s;
        }
        
        .song-image-container:hover .play-button {
            transform: scale(1);
        }
        
        .song-title {
            font-size: 1.1rem;
            font-weight: bold;
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .song-title:hover {
            color: #4ecdc4;
        }
        
        .song-description {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.7);
            transition: color 0.3s;
        }
        
        .song-description:hover {
            color: #ff6b6b;
        }
        
        .no-songs {
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
            .song-grid {
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
            <h1>🎵 Tất Cả Bài Hát</h1>
            <a href="home" class="back-btn">← Quay lại</a>
        </div>

        <%
            List<Song> songs = (List<Song>) request.getAttribute("songs");
            if (songs != null && !songs.isEmpty()) {
        %>
            <div class="song-grid">
                <% for (Song song : songs) { %>
                    <div class="song-card">
                        <div class="song-image-container" onclick="playSong('<%= song.getAudio() %>', '<%= song.getTitle() %>', '<%= song.getSingerName() %>')" style="cursor: pointer;">
                            <img src="<%= request.getContextPath() + "/" + song.getImage() %>" 
                                 alt="<%= song.getTitle() %>" 
                                 class="song-image"
                                 onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22200%22 height=%22200%22%3E%3Crect fill=%22%234ecdc4%22 width=%22200%22 height=%22200%22/%3E%3Ctext fill=%22%23fff%22 font-size=%2220%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22%3E🎵%3C/text%3E%3C/svg%3E'">
                            <div class="play-overlay">
                                <div class="play-button">▶</div>
                            </div>
                        </div>
                        <a href="song-detail?id=<%= song.getId() %>" style="text-decoration: none; color: inherit;">
                            <div class="song-title"><%= song.getTitle() %></div>
                        </a>
                        <a href="singer-detail?id=<%= song.getSingerId() %>" style="text-decoration: none; color: inherit;">
                            <div class="song-description"><%= song.getSingerName() != null ? song.getSingerName() : "Unknown Artist" %></div>
                        </a>
                    </div>
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
                    <a href="song?view=all&page=<%= currentPage - 1 %>">← Trước</a>
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
                            <a href="song?view=all&page=<%= i %>"><%= i %></a>
                <%      }
                    }
                %>
                
                <% if (currentPage < totalPages) { %>
                    <a href="song?view=all&page=<%= currentPage + 1 %>">Sau →</a>
                <% } else { %>
                    <span class="disabled">Sau →</span>
                <% } %>
            </div>
            <div class="pagination-info">
                Hiển thị <%= ((currentPage - 1) * 20 + 1) %> - <%= Math.min(currentPage * 20, totalRecords) %> trong tổng số <%= totalRecords %> bài hát
            </div>
            <% } %>
        <% } else { %>
            <div class="no-songs">Chưa có bài hát nào 😢</div>
        <% } %>
    </div>
    
    <!-- Audio Player (Hidden) -->
    <div id="audioPlayer" style="position: fixed; bottom: 0; left: 0; right: 0; background: rgba(0, 0, 0, 0.9); padding: 20px; display: none; z-index: 1000;">
        <div style="max-width: 1400px; margin: 0 auto; display: flex; align-items: center; gap: 20px;">
            <div style="flex: 1;">
                <div id="nowPlayingTitle" style="font-weight: bold; margin-bottom: 5px;"></div>
                <div id="nowPlayingArtist" style="font-size: 0.9em; color: rgba(255, 255, 255, 0.7);"></div>
            </div>
            <audio id="audioElement" controls style="flex: 2;">
                Your browser does not support the audio element.
            </audio>
            <button onclick="closePlayer()" style="padding: 10px 20px; background: #ff6b6b; border: none; border-radius: 5px; color: white; cursor: pointer;">✕ Đóng</button>
        </div>
    </div>
    
    <script>
        function playSong(audioPath, title, artist) {
            const player = document.getElementById('audioPlayer');
            const audioElement = document.getElementById('audioElement');
            const titleElement = document.getElementById('nowPlayingTitle');
            const artistElement = document.getElementById('nowPlayingArtist');
            
            // Set audio source
            audioElement.src = '<%= request.getContextPath() %>/' + audioPath;
            titleElement.textContent = title;
            artistElement.textContent = artist || 'Unknown Artist';
            
            // Show player and play
            player.style.display = 'block';
            audioElement.play();
        }
        
        function closePlayer() {
            const player = document.getElementById('audioPlayer');
            const audioElement = document.getElementById('audioElement');
            
            audioElement.pause();
            player.style.display = 'none';
        }
    </script>
</body>
</html>
