<%@ page import="models.bean.Song" %>
<%@ page import="models.bean.Singer" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Music Home</title>
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
        header {
            margin-bottom: 40px;
        }
        
        h1 {
            font-size: 2.5rem;
            margin-bottom: 30px;
            text-align: center;
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        /* Admin Button */
        .admin-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 12px 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            transition: all 0.3s;
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .admin-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.6);
        }
        
        /* Search Bar */
        .search-container {
            max-width: 600px;
            margin: 0 auto 40px;
        }
        
        .search-form {
            display: flex;
            gap: 10px;
        }
        
        .search-input {
            flex: 1;
            padding: 15px 20px;
            border: 2px solid #4ecdc4;
            border-radius: 25px;
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            font-size: 16px;
            outline: none;
            transition: all 0.3s;
        }
        
        .search-input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }
        
        .search-input:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: #ff6b6b;
        }
        
        .search-btn {
            padding: 15px 30px;
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            border: none;
            border-radius: 25px;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s;
        }
        
        .search-btn:hover {
            transform: scale(1.05);
        }
        
        /* Section */
        .section {
            margin-bottom: 50px;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .section-title {
            font-size: 1.8rem;
            font-weight: bold;
        }
        
        .btn-refresh, .btn-view-all {
            padding: 10px 20px;
            background: rgba(78, 205, 196, 0.2);
            border: 2px solid #4ecdc4;
            border-radius: 20px;
            color: #4ecdc4;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-refresh:hover, .btn-view-all:hover {
            background: #4ecdc4;
            color: #1e1e2e;
        }
        
        /* Grid Layout */
        .song-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }
        
        .singer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
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
        
        .song-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 10px;
            transition: transform 0.3s;
            position: relative;
        }
        
        .song-image:hover {
            transform: scale(1.05);
        }
        
        .song-image-container {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            margin-bottom: 10px;
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
            cursor: pointer;
        }
        
        .song-title:hover {
            color: #4ecdc4;
        }
        
        .song-description {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.7);
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            transition: color 0.3s;
        }
        
        .song-description:hover {
            color: #ff6b6b;
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
        
        /* Search Results */
        .search-results {
            background: rgba(255, 107, 107, 0.1);
            border: 2px solid #ff6b6b;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .no-results {
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
            padding: 40px;
            font-size: 1.2rem;
        }
        
        @media (max-width: 768px) {
            .song-grid, .singer-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }
            
            h1 {
                font-size: 1.8rem;
            }
            
            .section-title {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <!-- Admin Button -->
    <%
        models.bean.Admin admin = (models.bean.Admin) session.getAttribute("admin");
        if (admin != null) {
    %>
        <a href="<%= request.getContextPath() %>/admin/dashboard" class="admin-btn">
            👤 Admin Panel
        </a>
    <% } else { %>
        <a href="<%= request.getContextPath() %>/admin/login" class="admin-btn">
            🔐 Admin Login
        </a>
    <% } %>

    <div class="container">
        <header>
            <h1>🎵 Music Home 🎵</h1>
            
            <!-- Search Bar -->
            <div class="search-container">
                <form class="search-form" action="home" method="get">
                    <input type="text" 
                           name="keyword" 
                           class="search-input" 
                           placeholder="Tìm kiếm theo bài hát, nghệ sĩ..."
                           value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
                    <button type="submit" class="search-btn">🔍 Tìm kiếm</button>
                </form>
            </div>
        </header>

        <%
            List<Song> searchResults = (List<Song>) request.getAttribute("searchResults");
            String keyword = (String) request.getAttribute("keyword");
            
            if (searchResults != null) {
        %>
            <!-- Search Results Section -->
            <div class="section search-results">
                <div class="section-header">
                    <h2 class="section-title">Kết quả tìm kiếm cho "<%= keyword %>"</h2>
                </div>
                
                <% if (searchResults.isEmpty()) { %>
                    <div class="no-results">Không tìm thấy kết quả nào 😢</div>
                <% } else { %>
                    <div class="song-grid">
                        <% for (Song song : searchResults) { %>
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
                <% } %>
            </div>
        <% } %>

        <!-- Suggested Songs Section -->
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">Gợi Ý Bài Hát</h2>
                <button class="btn-refresh" onclick="window.location.reload()">🔄 Làm mới</button>
            </div>
            
            <div class="song-grid">
                <%
                    List<Song> suggestedSongs = (List<Song>) request.getAttribute("suggestedSongs");
                    if (suggestedSongs != null) {
                        for (Song song : suggestedSongs) {
                %>
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
                <%
                        }
                    }
                %>
            </div>
        </div>

        <!-- Recent Songs Section -->
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">Mới Phát Hành</h2>
                <a href="song?view=all" class="btn-view-all">Xem tất cả →</a>
            </div>
            
            <div class="song-grid">
                <%
                    List<Song> recentSongs = (List<Song>) request.getAttribute("recentSongs");
                    if (recentSongs != null) {
                        for (Song song : recentSongs) {
                %>
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
                <%
                        }
                    }
                %>
            </div>
        </div>

        <!-- Artists Section -->
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">Nghệ Sĩ Nổi Bật</h2>
                <a href="singer?view=all" class="btn-view-all">Xem tất cả →</a>
            </div>
            
            <div class="singer-grid">
                <%
                    List<Singer> singerList = (List<Singer>) request.getAttribute("singerList");
                    if (singerList != null) {
                        for (Singer singer : singerList) {
                %>
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
                <%
                        }
                    }
                %>
            </div>
        </div>
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