<%@ page import="models.bean.Song" %> <%@ page import="models.bean.Singer" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>
            <%= ((Song)request.getAttribute("song")).getTitle() %> - Music
            Detail
        </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #1e1e2e 0%, #2d2d44 100%);
                color: #fff;
                min-height: 100vh;
                padding: 20px;
            }

            .container {
                max-width: 1400px;
                margin: 0 auto;
            }

            /* Back Button */
            .back-btn {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 10px 20px;
                background: rgba(255, 255, 255, 0.1);
                border: 2px solid rgba(255, 255, 255, 0.2);
                border-radius: 25px;
                color: #fff;
                text-decoration: none;
                font-size: 14px;
                margin-bottom: 30px;
                transition: all 0.3s;
            }

            .back-btn:hover {
                background: rgba(255, 255, 255, 0.2);
                transform: translateX(-5px);
            }

            /* Main Layout */
            .main-layout {
                display: grid;
                grid-template-columns: 1fr 350px;
                gap: 40px;
                margin-bottom: 40px;
            }

            /* Song Header Section */
            .song-header {
                display: flex;
                gap: 30px;
                background: rgba(255, 255, 255, 0.05);
                padding: 30px;
                border-radius: 20px;
                margin-bottom: 40px;
            }

            .song-cover {
                flex-shrink: 0;
            }

            .song-cover img {
                width: 280px;
                height: 280px;
                object-fit: cover;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            }

            .song-info {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .song-label {
                font-size: 0.9rem;
                color: rgba(255, 255, 255, 0.6);
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 10px;
            }

            .song-title {
                font-size: 3rem;
                font-weight: bold;
                margin-bottom: 15px;
                line-height: 1.2;
                background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .song-artist {
                font-size: 1.3rem;
                color: rgba(255, 255, 255, 0.8);
                margin-bottom: 20px;
            }

            .song-description {
                font-size: 1rem;
                color: rgba(255, 255, 255, 0.7);
                line-height: 1.6;
                margin-bottom: 30px;
            }

            .action-buttons {
                display: flex;
                gap: 15px;
            }

            .btn-play {
                padding: 15px 40px;
                background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
                border: none;
                border-radius: 30px;
                color: #fff;
                font-size: 1.1rem;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .btn-play:hover {
                transform: scale(1.05);
                box-shadow: 0 5px 20px rgba(255, 107, 107, 0.4);
            }

            .btn-download {
                padding: 15px 35px;
                background: transparent;
                border: 2px solid #4ecdc4;
                border-radius: 30px;
                color: #4ecdc4;
                font-size: 1.1rem;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .btn-download:hover {
                background: #4ecdc4;
                color: #1e1e2e;
            }

            /* Lyrics Section */
            .lyrics-section {
                background: rgba(255, 255, 255, 0.05);
                padding: 30px;
                border-radius: 20px;
            }

            .lyrics-header {
                margin-bottom: 20px;
            }

            .lyrics-title {
                font-size: 1.8rem;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .lyrics-author {
                font-size: 0.9rem;
                color: rgba(255, 255, 255, 0.6);
            }

            .lyrics-content {
                font-size: 1rem;
                line-height: 2;
                color: rgba(255, 255, 255, 0.85);
                white-space: pre-line;
                max-height: 400px;
                overflow: hidden;
                transition: max-height 0.3s;
            }

            .lyrics-content.expanded {
                max-height: none;
            }

            .btn-show-more {
                margin-top: 20px;
                padding: 10px 25px;
                background: transparent;
                border: 2px solid rgba(255, 255, 255, 0.3);
                border-radius: 20px;
                color: #fff;
                font-size: 0.95rem;
                cursor: pointer;
                transition: all 0.3s;
                width: 100%;
            }

            .btn-show-more:hover {
                background: rgba(255, 255, 255, 0.1);
                border-color: #4ecdc4;
            }

            /* Artist Section */
            .artist-section {
                background: rgba(255, 255, 255, 0.05);
                padding: 25px;
                border-radius: 20px;
                position: sticky;
                top: 20px;
            }

            .artist-title {
                font-size: 1.5rem;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .artist-card {
                display: flex;
                align-items: center;
                gap: 15px;
                padding: 15px;
                background: rgba(255, 255, 255, 0.05);
                border-radius: 15px;
                transition: all 0.3s;
                cursor: pointer;
            }

            .artist-card:hover {
                background: rgba(255, 255, 255, 0.1);
                transform: translateX(5px);
            }

            .artist-avatar {
                width: 70px;
                height: 70px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #4ecdc4;
            }

            .artist-info h3 {
                font-size: 1.1rem;
                margin-bottom: 5px;
            }

            .artist-info p {
                font-size: 0.9rem;
                color: rgba(255, 255, 255, 0.6);
            }

            /* Audio Player */
            .audio-player {
                margin-top: 20px;
                width: 100%;
            }

            .audio-player audio {
                width: 100%;
                border-radius: 10px;
                background: rgba(255, 255, 255, 0.1);
            }

            /* Responsive */
            @media (max-width: 1024px) {
                .main-layout {
                    grid-template-columns: 1fr;
                }

                .artist-section {
                    position: static;
                }
            }

            @media (max-width: 768px) {
                .song-header {
                    flex-direction: column;
                    align-items: center;
                    text-align: center;
                }

                .song-cover img {
                    width: 100%;
                    max-width: 280px;
                }

                .song-title {
                    font-size: 2rem;
                }

                .action-buttons {
                    flex-direction: column;
                    width: 100%;
                }

                .btn-play,
                .btn-download {
                    width: 100%;
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <% Song song = (Song) request.getAttribute("song"); Singer singer =
        (Singer) request.getAttribute("singer"); %>

        <div class="container">
            <a href="home" class="back-btn">← Quay lại trang chủ</a>

            <!-- Song Header -->
            <div class="song-header">
                <div class="song-cover">
                    <img src="<%= request.getContextPath() + "/" +
                    song.getImage() %>" alt="<%= song.getTitle() %>"
                    onerror="this.onerror=null;
                    this.src='data:image/svg+xml,%3Csvg
                    xmlns=%22http://www.w3.org/2000/svg%22 width=%22280%22
                    height=%22280%22%3E%3Crect fill=%22%234ecdc4%22
                    width=%22280%22 height=%22280%22/%3E%3Ctext
                    fill=%22%23fff%22 font-size=%2240%22 x=%2250%25%22
                    y=%2250%25%22 text-anchor=%22middle%22
                    dy=%22.3em%22%3E🎵%3C/text%3E%3C/svg%3E'">
                </div>

                <div class="song-info">
                    <div class="song-label">Song</div>
                    <h1 class="song-title"><%= song.getTitle() %></h1>
                    <div class="song-artist">
                        🎤 <%= song.getSingerName() != null ?
                        song.getSingerName() : "Unknown Artist" %>
                    </div>

                    <div class="action-buttons">
                        <button class="btn-play" onclick="playAudio()">
                            ▶️ Play
                        </button>
                        <button class="btn-download" onclick="downloadSong()">
                            ⬇️ Download
                        </button>
                    </div>
                </div>
            </div>

            <!-- Main Layout -->
            <div class="main-layout">
                <!-- Lyrics Section -->
                <div class="lyrics-section">
                    <div class="lyrics-header">
                        <h2 class="lyrics-title">Lyrics</h2>
                        <p class="lyrics-author">
                            Lời bài hát • <%= song.getSingerName() %>
                        </p>
                    </div>

                    <div class="lyrics-content" id="lyricsContent">
                        <%= song.getLyrics() != null &&
                        !song.getLyrics().trim().isEmpty() ? song.getLyrics() :
                        "Lời bài hát chưa được cập nhật.\n\nHãy quay lại sau để xem lời bài hát đầy đủ!" %>
                    </div>

                    <% if (song.getLyrics() != null && song.getLyrics().length()
                    > 300) { %>
                    <button class="btn-show-more" onclick="toggleLyrics()">
                        Show more
                    </button>
                    <% } %>
                </div>

                <!-- Artist Section -->
                <div class="artist-section">
                    <h2 class="artist-title">Artist</h2>

                    <% if (singer != null) { %>
                    <a
                        href="singer-detail?id=<%= singer.getId() %>"
                        style="text-decoration: none; color: inherit"
                    >
                        <div class="artist-card">
                            <img src="<%= request.getContextPath() + "/" +
                            singer.getImage() %>" alt="<%= singer.getName() %>"
                            class="artist-avatar" onerror="this.onerror=null;
                            this.src='data:image/svg+xml,%3Csvg
                            xmlns=%22http://www.w3.org/2000/svg%22
                            width=%22120%22 height=%22120%22%3E%3Ccircle
                            fill=%22%23ff6b6b%22 cx=%2260%22 cy=%2260%22
                            r=%2260%22/%3E%3Ctext fill=%22%23fff%22
                            font-size=%2240%22 x=%2250%25%22 y=%2250%25%22
                            text-anchor=%22middle%22
                            dy=%22.3em%22%3E🎤%3C/text%3E%3C/svg%3E'">
                            <div class="artist-info">
                                <h3><%= singer.getName() %></h3>
                                <p>
                                    <%= singer.getCountry() != null ?
                                    singer.getCountry() : "" %>
                                </p>
                            </div>
                        </div>
                    </a>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Audio Player (Hidden) -->
        <div
            id="audioPlayer"
            style="
                position: fixed;
                bottom: 0;
                left: 0;
                right: 0;
                background: rgba(0, 0, 0, 0.9);
                padding: 20px;
                display: none;
                z-index: 1000;
            "
        >
            <div
                style="
                    max-width: 1400px;
                    margin: 0 auto;
                    display: flex;
                    align-items: center;
                    gap: 20px;
                "
            >
                <div style="flex: 1">
                    <div
                        id="nowPlayingTitle"
                        style="font-weight: bold; margin-bottom: 5px"
                    ></div>
                    <div
                        id="nowPlayingArtist"
                        style="
                            font-size: 0.9em;
                            color: rgba(255, 255, 255, 0.7);
                        "
                    ></div>
                </div>
                <audio id="audioElement" controls style="flex: 2">
                    Your browser does not support the audio element.
                </audio>
                <button
                    onclick="closePlayer()"
                    style="
                        padding: 10px 20px;
                        background: #ff6b6b;
                        border: none;
                        border-radius: 5px;
                        color: white;
                        cursor: pointer;
                    "
                >
                    ✕ Đóng
                </button>
            </div>
        </div>

        <script>
            function playAudio() {
                const player = document.getElementById("audioPlayer");
                const audioElement = document.getElementById("audioElement");
                const titleElement = document.getElementById("nowPlayingTitle");
                const artistElement =
                    document.getElementById("nowPlayingArtist");

                // Set audio source
                audioElement.src =
                    '<%= request.getContextPath() + "/" + song.getAudio() %>';
                titleElement.textContent = "<%= song.getTitle() %>";
                artistElement.textContent =
                    '<%= song.getSingerName() != null ? song.getSingerName() : "Unknown Artist" %>';

                // Show player and play
                player.style.display = "block";
                audioElement.play();
            }

            function closePlayer() {
                const player = document.getElementById("audioPlayer");
                const audioElement = document.getElementById("audioElement");

                audioElement.pause();
                player.style.display = "none";
            }

            function downloadSong() {
                const audioSrc =
                    '<%= request.getContextPath() + "/" + song.getAudio() %>';
                const link = document.createElement("a");
                link.href = audioSrc;
                link.download = "<%= song.getTitle() %>.mp3";
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            }

            function toggleLyrics() {
                const lyricsContent = document.getElementById("lyricsContent");
                const btn = event.target;

                if (lyricsContent.classList.contains("expanded")) {
                    lyricsContent.classList.remove("expanded");
                    btn.textContent = "Show more";
                } else {
                    lyricsContent.classList.add("expanded");
                    btn.textContent = "Show less";
                }
            }
        </script>
    </body>
</html>
