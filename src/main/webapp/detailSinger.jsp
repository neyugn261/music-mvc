<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="models.bean.Singer" %> <%@ page import="models.bean.Song" %> <%@ page
import="java.util.List" %> <% Singer singer = (Singer)
request.getAttribute("singer"); List<Song>
    songs = (List<Song
        >) request.getAttribute("songs"); %>
        <!DOCTYPE html>
        <html lang="vi">
            <head>
                <meta charset="UTF-8" />
                <meta
                    name="viewport"
                    content="width=device-width, initial-scale=1.0"
                />
                <title><%= singer.getName() %> - Chi tiết nghệ sĩ</title>
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: "Segoe UI", Tahoma, Geneva, Verdana,
                            sans-serif;
                        background: linear-gradient(
                            135deg,
                            #1e1e2e 0%,
                            #2d2d44 100%
                        );
                        color: #fff;
                        min-height: 100vh;
                        padding: 20px;
                    }

                    .container {
                        max-width: 1200px;
                        margin: 0 auto;
                    }

                    /* Header Section */
                    .singer-header {
                        background: linear-gradient(
                            135deg,
                            #2a2a3e 0%,
                            #3d3d5c 100%
                        );
                        border-radius: 20px;
                        padding: 30px;
                        margin-bottom: 40px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 25px;
                    }

                    .singer-avatar {
                        width: 120px;
                        height: 120px;
                        border-radius: 50%;
                        object-fit: cover;
                        border: 3px solid rgba(138, 43, 226, 0.5);
                        box-shadow: 0 5px 15px rgba(138, 43, 226, 0.3);
                        flex-shrink: 0;
                    }

                    .singer-info {
                        flex: 0 1 auto;
                    }

                    .singer-info h1 {
                        font-size: 1.8em;
                        margin-bottom: 8px;
                        background: linear-gradient(
                            135deg,
                            #8a2be2 0%,
                            #da70d6 100%
                        );
                        background-clip: text;
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                    }

                    .singer-meta {
                        font-size: 0.95em;
                        color: #b8b8d1;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .singer-meta span {
                        display: flex;
                        align-items: center;
                        gap: 5px;
                    }

                    /* Songs Section */
                    .songs-section {
                        margin-top: 40px;
                    }

                    .section-title {
                        font-size: 2em;
                        margin-bottom: 30px;
                        color: #fff;
                    }

                    .songs-grid {
                        display: grid;
                        grid-template-columns: repeat(5, 1fr);
                        gap: 25px;
                    }

                    .song-card {
                        background: rgba(255, 255, 255, 0.05);
                        border-radius: 15px;
                        padding: 15px;
                        transition: all 0.3s;
                        border: 2px solid transparent;
                    }

                    .song-card:hover {
                        background: rgba(255, 255, 255, 0.1);
                        border-color: #8a2be2;
                        transform: translateY(-5px);
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
                        background: linear-gradient(45deg, #8a2be2, #da70d6);
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 24px;
                        color: white;
                        box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
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
                        color: #8a2be2;
                    }

                    .song-artist {
                        font-size: 0.9rem;
                        color: rgba(255, 255, 255, 0.7);
                    }

                    .back-button {
                        display: inline-block;
                        background: linear-gradient(
                            135deg,
                            #8a2be2 0%,
                            #da70d6 100%
                        );
                        color: white;
                        padding: 12px 30px;
                        border-radius: 25px;
                        text-decoration: none;
                        margin-bottom: 30px;
                        transition: all 0.3s ease;
                        box-shadow: 0 5px 15px rgba(138, 43, 226, 0.3);
                    }

                    .back-button:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(138, 43, 226, 0.5);
                    }

                    .no-songs {
                        text-align: center;
                        padding: 60px 20px;
                        color: #b8b8d1;
                        font-size: 1.2em;
                    }

                    @media (max-width: 768px) {
                        .singer-header {
                            flex-direction: column;
                            text-align: center;
                            padding: 25px 20px;
                        }

                        .singer-info h1 {
                            font-size: 1.5em;
                        }

                        .singer-meta {
                            justify-content: center;
                            font-size: 0.9em;
                        }

                        .songs-grid {
                            grid-template-columns: repeat(2, 1fr);
                        }
                    }

                    @media (max-width: 1200px) and (min-width: 769px) {
                        .songs-grid {
                            grid-template-columns: repeat(4, 1fr);
                        }
                    }

                    @media (max-width: 900px) and (min-width: 769px) {
                        .songs-grid {
                            grid-template-columns: repeat(3, 1fr);
                        }
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <a href="home" class="back-button">← Quay lại trang chủ</a>

                    <!-- Singer Header -->
                    <div class="singer-header">
                        <img src="<%= request.getContextPath() + "/" +
                        singer.getImage() %>" alt="<%= singer.getName() %>"
                        class="singer-avatar" onerror="this.onerror=null;
                        this.src='data:image/svg+xml,%3Csvg
                        xmlns=%22http://www.w3.org/2000/svg%22 width=%22120%22
                        height=%22120%22%3E%3Ccircle fill=%22%23ff6b6b%22
                        cx=%2260%22 cy=%2260%22 r=%2260%22/%3E%3Ctext
                        fill=%22%23fff%22 font-size=%2240%22 x=%2250%25%22
                        y=%2250%25%22 text-anchor=%22middle%22
                        dy=%22.3em%22%3E🎤%3C/text%3E%3C/svg%3E';">
                        <div class="singer-info">
                            <h1><%= singer.getName() %></h1>
                            <div class="singer-meta">
                                <span
                                    ><%= singer.getCountry() != null ?
                                    singer.getCountry() : "Việt Nam" %></span
                                >
                                <span>/</span>
                                <span
                                    >Bài hát: <%= songs != null ? songs.size() :
                                    0 %></span
                                >
                            </div>
                        </div>
                    </div>

                    <!-- Songs Section -->
                    <div class="songs-section">
                        <h2 class="section-title">
                            Bài hát của <%= singer.getName() %>
                        </h2>

                        <% if (songs != null && !songs.isEmpty()) { %>
                        <div class="songs-grid">
                            <% for (Song song : songs) { %>
                            <div class="song-card">
                                <div
                                    class="song-image-container"
                                    onclick="playSong('<%= song.getAudio() %>', '<%= song.getTitle() %>', '<%= song.getSingerName() != null ? song.getSingerName() : singer.getName() %>')"
                                    style="cursor: pointer"
                                >
                                    <img src="<%= request.getContextPath() + "/"
                                    + song.getImage() %>" alt="<%=
                                    song.getTitle() %>" class="song-image"
                                    onerror="this.onerror=null;
                                    this.src='data:image/svg+xml,%3Csvg
                                    xmlns=%22http://www.w3.org/2000/svg%22
                                    width=%22250%22 height=%22250%22%3E%3Crect
                                    fill=%22%234ecdc4%22 width=%22250%22
                                    height=%22250%22/%3E%3Ctext
                                    fill=%22%23fff%22 font-size=%2260%22
                                    x=%2250%25%22 y=%2250%25%22
                                    text-anchor=%22middle%22
                                    dy=%22.3em%22%3E🎵%3C/text%3E%3C/svg%3E';">
                                    <div class="play-overlay">
                                        <div class="play-button">▶</div>
                                    </div>
                                </div>
                                <a
                                    href="song-detail?id=<%= song.getId() %>"
                                    style="
                                        text-decoration: none;
                                        color: inherit;
                                    "
                                >
                                    <div class="song-title">
                                        <%= song.getTitle() %>
                                    </div>
                                </a>
                                <div class="song-artist">
                                    <%= song.getSingerName() != null ?
                                    song.getSingerName() : singer.getName() %>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <% } else { %>
                        <div class="no-songs">
                            Nghệ sĩ này chưa có bài hát nào
                        </div>
                        <% } %>
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
                                background: #8a2be2;
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
                    function playSong(audioPath, title, artist) {
                        const player = document.getElementById("audioPlayer");
                        const audioElement =
                            document.getElementById("audioElement");
                        const titleElement =
                            document.getElementById("nowPlayingTitle");
                        const artistElement =
                            document.getElementById("nowPlayingArtist");

                        // Set audio source
                        audioElement.src =
                            "<%= request.getContextPath() %>/" + audioPath;
                        titleElement.textContent = title;
                        artistElement.textContent = artist || "Unknown Artist";

                        // Show player and play
                        player.style.display = "block";
                        audioElement.play();
                    }

                    function closePlayer() {
                        const player = document.getElementById("audioPlayer");
                        const audioElement =
                            document.getElementById("audioElement");

                        audioElement.pause();
                        player.style.display = "none";
                    }
                </script>
            </body>
        </html>
    </Song></Song
>
