<%@ page import="models.bean.Song" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Music Home</title>
</head>
<body>
<h1>Danh sách bài hát</h1>
<table border="1">
    <thead>
        <tr>
            <th>ID</th>
            <th>Tiêu đề</th>
            <th>Ảnh</th>
            <th>Mô tả</th>
        </tr>
    </thead>
    <tbody>
    <%
        List<Song> songList = (List<Song>) request.getAttribute("songList");
        for (Song song : songList) {
    %>
        <tr>
            <td><%= song.getId() %></td>
            <td><%= song.getTitle() %></td>
            <td><img src="<%= request.getContextPath() + "/" + song.getImage() %>" alt="<%= song.getTitle() %>" width="100"/></td>
            <td><%= song.getDescription() %></td>
        </tr>
    <%
        }
    %>

    </tbody>
</table>
</body>
</html>