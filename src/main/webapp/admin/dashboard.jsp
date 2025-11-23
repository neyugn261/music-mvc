<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="models.bean.Admin" %> <% Admin admin = (Admin)
session.getAttribute("admin"); if (admin == null) {
response.sendRedirect(request.getContextPath() + "/admin/login"); return; } int
totalSongs = (Integer) request.getAttribute("totalSongs"); int totalSingers =
(Integer) request.getAttribute("totalSingers"); %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Dashboard - Admin Panel</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f7fa;
            }

            /* Sidebar */
            .sidebar {
                position: fixed;
                left: 0;
                top: 0;
                width: 260px;
                height: 100vh;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px 0;
            }

            .sidebar-header {
                text-align: center;
                padding: 0 20px 30px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            }

            .sidebar-header h2 {
                font-size: 1.5em;
                margin-bottom: 5px;
            }

            .sidebar-header p {
                font-size: 0.9em;
                opacity: 0.8;
            }

            .sidebar-menu {
                padding: 30px 0;
            }

            .menu-item {
                display: block;
                padding: 15px 30px;
                color: white;
                text-decoration: none;
                transition: all 0.3s;
                border-left: 4px solid transparent;
            }

            .menu-item:hover,
            .menu-item.active {
                background: rgba(255, 255, 255, 0.1);
                border-left-color: white;
            }

            .logout-btn {
                position: absolute;
                bottom: 30px;
                left: 30px;
                right: 30px;
                padding: 12px;
                background: rgba(255, 255, 255, 0.2);
                border: 2px solid white;
                border-radius: 10px;
                color: white;
                text-align: center;
                text-decoration: none;
                display: block;
                transition: all 0.3s;
            }

            .logout-btn:hover {
                background: white;
                color: #667eea;
            }

            /* Main Content */
            .main-content {
                margin-left: 260px;
                padding: 40px;
            }

            .top-bar {
                background: white;
                padding: 20px 30px;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
            }

            .top-bar h1 {
                color: #333;
                font-size: 2em;
            }

            .welcome-text {
                color: #666;
                margin-top: 3px;
                font-size: 0.9em;
            }

            /* Stats Cards */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                transition: all 0.3s;
            }

            .stat-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.12);
            }

            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.8em;
                margin-bottom: 12px;
            }

            .stat-card-1 .stat-icon {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            .stat-card-2 .stat-icon {
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            }

            .stat-title {
                font-size: 0.85em;
                color: #666;
                margin-bottom: 8px;
            }

            .stat-value {
                font-size: 2em;
                font-weight: bold;
                color: #333;
            }

            /* Quick Actions */
            .quick-actions {
                background: white;
                padding: 20px;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .quick-actions h2 {
                margin-bottom: 20px;
                color: #333;
                font-size: 1.4em;
            }

            .action-buttons {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                gap: 12px;
            }

            .action-btn {
                padding: 12px 20px;
                border-radius: 8px;
                text-decoration: none;
                text-align: center;
                font-weight: 500;
                transition: all 0.3s;
                display: block;
                font-size: 0.9em;
            }

            .action-btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .action-btn-secondary {
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                color: white;
            }

            .action-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                }

                .main-content {
                    margin-left: 0;
                    padding: 20px;
                }

                .logout-btn {
                    position: relative;
                    bottom: auto;
                    left: auto;
                    right: auto;
                    margin: 30px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>🎵 Music Admin</h2>
                <p>Xin chào, <%= admin.getUsername() %></p>
            </div>

            <div class="sidebar-menu">
                <a href="dashboard" class="menu-item active">📊 Dashboard</a>
                <a href="songs" class="menu-item">🎵 Quản lý bài hát</a>
                <a href="singers" class="menu-item">🎤 Quản lý ca sĩ</a>
            </div>

            <a href="logout" class="logout-btn">🚪 Đăng xuất</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="top-bar">
                <h1>Dashboard</h1>
                <p class="welcome-text">Tổng quan hệ thống quản lý âm nhạc</p>
            </div>

            <!-- Statistics -->
            <div class="stats-grid">
                <a href="songs" style="text-decoration: none; color: inherit">
                    <div class="stat-card stat-card-1">
                        <div class="stat-icon">🎵</div>
                        <div class="stat-title">Tổng số bài hát</div>
                        <div class="stat-value"><%= totalSongs %></div>
                    </div>
                </a>

                <a href="singers" style="text-decoration: none; color: inherit">
                    <div class="stat-card stat-card-2">
                        <div class="stat-icon">🎤</div>
                        <div class="stat-title">Tổng số ca sĩ</div>
                        <div class="stat-value"><%= totalSingers %></div>
                    </div>
                </a>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h2>Quản lý nội dung</h2>
                <div class="action-buttons">
                    <a href="songs" class="action-btn action-btn-primary"
                        >🎵 Quản lý bài hát</a
                    >
                    <a href="singers" class="action-btn action-btn-secondary"
                        >🎤 Quản lý ca sĩ</a
                    >
                    <a
                        href="<%= request.getContextPath() %>/home"
                        class="action-btn action-btn-primary"
                        >🌐 Xem trang chủ</a
                    >
                </div>
            </div>
        </div>
    </body>
</html>
