<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="models.bean.Admin" %> <%@ page import="models.bean.Singer" %> <%@ page
import="java.util.List" %> <% Admin admin = (Admin)
session.getAttribute("admin"); if (admin == null) {
response.sendRedirect(request.getContextPath() + "/admin/login"); return; }
List<Singer>
    singers = (List<Singer
        >) request.getAttribute("singers"); String success =
        request.getParameter("success"); String error =
        request.getParameter("error"); %>
        <!DOCTYPE html>
        <html lang="vi">
            <head>
                <meta charset="UTF-8" />
                <meta
                    name="viewport"
                    content="width=device-width, initial-scale=1.0"
                />
                <title>Quản lý Ca sĩ - Admin Panel</title>
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: "Segoe UI", Tahoma, Geneva, Verdana,
                            sans-serif;
                        background: #f5f7fa;
                    }

                    /* Sidebar */
                    .sidebar {
                        position: fixed;
                        left: 0;
                        top: 0;
                        width: 260px;
                        height: 100vh;
                        background: linear-gradient(
                            135deg,
                            #667eea 0%,
                            #764ba2 100%
                        );
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
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        flex-wrap: wrap;
                        gap: 15px;
                    }

                    .top-bar h1 {
                        color: #333;
                        font-size: 2em;
                    }

                    .btn-add {
                        padding: 12px 25px;
                        background: linear-gradient(
                            135deg,
                            #667eea 0%,
                            #764ba2 100%
                        );
                        color: white;
                        border: none;
                        border-radius: 10px;
                        font-size: 1em;
                        font-weight: 500;
                        cursor: pointer;
                        transition: all 0.3s;
                    }

                    .btn-add:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
                    }

                    /* Alert Messages */
                    .alert {
                        padding: 15px 20px;
                        border-radius: 10px;
                        margin-bottom: 20px;
                        font-weight: 500;
                    }

                    .alert-success {
                        background: #d4edda;
                        border-left: 4px solid #28a745;
                        color: #155724;
                    }

                    .alert-error {
                        background: #f8d7da;
                        border-left: 4px solid #dc3545;
                        color: #721c24;
                    }

                    /* Table */
                    .table-container {
                        background: white;
                        border-radius: 15px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        overflow: hidden;
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    thead {
                        background: linear-gradient(
                            135deg,
                            #667eea 0%,
                            #764ba2 100%
                        );
                        color: white;
                    }

                    thead th {
                        padding: 15px 20px;
                        text-align: left;
                        font-weight: 500;
                    }

                    tbody tr {
                        border-bottom: 1px solid #f0f0f0;
                        transition: all 0.2s;
                    }

                    tbody tr:hover {
                        background: #f8f9fa;
                    }

                    tbody td {
                        padding: 15px 20px;
                    }

                    .singer-avatar {
                        width: 50px;
                        height: 50px;
                        border-radius: 50%;
                        object-fit: cover;
                    }

                    .action-btns {
                        display: flex;
                        gap: 10px;
                    }

                    .btn-edit,
                    .btn-delete {
                        background: none;
                        border: none;
                        cursor: pointer;
                        font-size: 0.9em;
                        transition: all 0.3s;
                        padding: 0;
                    }

                    .btn-edit {
                        color: #007bff;
                        text-decoration: none;
                    }

                    .btn-edit:hover {
                        text-decoration: underline;
                    }

                    .btn-delete {
                        padding: 8px 15px;
                        background: #dc3545;
                        color: white;
                        border-radius: 5px;
                    }

                    .btn-delete:hover {
                        background: #c82333;
                    }

                    /* Bulk Delete */
                    .bulk-actions {
                        display: none;
                        position: fixed;
                        bottom: 30px;
                        right: 30px;
                        background: linear-gradient(
                            135deg,
                            #dc3545 0%,
                            #c82333 100%
                        );
                        color: white;
                        padding: 15px 25px;
                        border-radius: 50px;
                        box-shadow: 0 5px 20px rgba(220, 53, 69, 0.4);
                        z-index: 100;
                        cursor: pointer;
                        transition: all 0.3s;
                        font-weight: 500;
                        border: none;
                        font-size: 1em;
                    }

                    .bulk-actions.active {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .bulk-actions:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 8px 25px rgba(220, 53, 69, 0.5);
                    }

                    .bulk-actions .count {
                        background: rgba(255, 255, 255, 0.3);
                        padding: 3px 10px;
                        border-radius: 20px;
                        font-weight: bold;
                    }

                    /* Checkbox */
                    .checkbox-cell {
                        width: 50px;
                        text-align: center;
                    }

                    .checkbox-cell input[type="checkbox"] {
                        width: 18px;
                        height: 18px;
                        cursor: pointer;
                        accent-color: #667eea;
                    }

                    thead .checkbox-cell input[type="checkbox"] {
                        width: 20px;
                        height: 20px;
                    }

                    tbody tr.selected {
                        background: #e8eaf6 !important;
                    }

                    /* Pagination */
                    .pagination {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        gap: 10px;
                        margin-top: 30px;
                        padding: 20px;
                    }

                    .pagination a,
                    .pagination span {
                        padding: 10px 15px;
                        border: 1px solid #ddd;
                        border-radius: 8px;
                        text-decoration: none;
                        color: #333;
                        transition: all 0.3s;
                        font-weight: 500;
                    }

                    .pagination a:hover {
                        background: linear-gradient(
                            135deg,
                            #667eea 0%,
                            #764ba2 100%
                        );
                        color: white;
                        border-color: #667eea;
                        transform: translateY(-2px);
                    }

                    .pagination .current {
                        background: linear-gradient(
                            135deg,
                            #667eea 0%,
                            #764ba2 100%
                        );
                        color: white;
                        border-color: #667eea;
                    }

                    .pagination .disabled {
                        opacity: 0.5;
                        cursor: not-allowed;
                        pointer-events: none;
                    }

                    .pagination-info {
                        text-align: center;
                        color: #666;
                        margin-top: 15px;
                        font-size: 0.9em;
                    }

                    /* Modal */
                    .modal {
                        display: none;
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background: rgba(0, 0, 0, 0.5);
                        z-index: 1000;
                        justify-content: center;
                        align-items: center;
                    }

                    .modal.active {
                        display: flex;
                    }

                    .modal-content {
                        background: white;
                        border-radius: 15px;
                        padding: 30px;
                        width: 90%;
                        max-width: 500px;
                        max-height: 90vh;
                        overflow-y: auto;
                    }

                    .modal-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 25px;
                    }

                    .modal-header h2 {
                        color: #333;
                    }

                    .btn-close {
                        background: none;
                        border: none;
                        font-size: 1.5em;
                        cursor: pointer;
                        color: #999;
                    }

                    .btn-close:hover {
                        color: #333;
                    }

                    .form-group {
                        margin-bottom: 20px;
                    }

                    .form-group label {
                        display: block;
                        margin-bottom: 8px;
                        color: #333;
                        font-weight: 500;
                    }

                    .form-group input {
                        width: 100%;
                        padding: 12px 15px;
                        border: 2px solid #e0e0e0;
                        border-radius: 10px;
                        font-size: 1em;
                    }

                    .form-group input:focus {
                        outline: none;
                        border-color: #667eea;
                    }

                    /* Custom File Input */
                    .file-input-wrapper {
                        position: relative;
                        overflow: hidden;
                        display: inline-block;
                        width: 100%;
                    }

                    .file-input-wrapper input[type="file"] {
                        position: absolute;
                        left: -9999px;
                    }

                    .file-input-label {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        padding: 12px 15px;
                        background: white;
                        color: #333;
                        border: 2px solid #ddd;
                        border-radius: 10px;
                        cursor: pointer;
                        transition: all 0.3s;
                        font-weight: 500;
                    }

                    .file-input-label:hover {
                        border-color: #667eea;
                        background: #f8f9ff;
                    }

                    .file-input-label .icon {
                        font-size: 1.2em;
                        color: #667eea;
                    }

                    .file-name {
                        margin-top: 8px;
                        padding: 8px 12px;
                        background: #f0f0f0;
                        border-radius: 8px;
                        font-size: 0.9em;
                        color: #666;
                        display: none;
                    }

                    .file-name.active {
                        display: block;
                    }

                    .btn-submit {
                        width: 100%;
                        padding: 14px;
                        background: linear-gradient(
                            135deg,
                            #667eea 0%,
                            #764ba2 100%
                        );
                        border: none;
                        border-radius: 10px;
                        color: white;
                        font-size: 1.1em;
                        font-weight: bold;
                        cursor: pointer;
                        transition: all 0.3s;
                    }

                    .btn-submit:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
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
                            margin: 20px 30px 0;
                        }

                        .top-bar {
                            flex-direction: column;
                            gap: 15px;
                        }

                        .btn-add {
                            width: 100%;
                        }

                        table {
                            font-size: 0.9em;
                        }

                        .singer-avatar {
                            width: 40px;
                            height: 40px;
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
                        <a href="dashboard" class="menu-item">📊 Dashboard</a>
                        <a href="songs" class="menu-item">🎵 Quản lý bài hát</a>
                        <a href="singers" class="menu-item active"
                            >🎤 Quản lý ca sĩ</a
                        >
                    </div>

                    <a href="logout" class="logout-btn">🚪 Đăng xuất</a>
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <div class="top-bar">
                        <h1>Quản lý Ca sĩ</h1>
                        <div
                            style="
                                display: flex;
                                gap: 15px;
                                align-items: center;
                            "
                        >
                            <form
                                method="get"
                                action="singers"
                                style="display: flex; gap: 10px"
                            >
                                <input type="text" name="search"
                                placeholder="Tìm kiếm ca sĩ..." value="<%=
                                request.getParameter("search") != null ?
                                request.getParameter("search") : "" %>"
                                style="padding: 10px 15px; border: 2px solid
                                #e0e0e0; border-radius: 8px; width: 250px;
                                font-size: 0.95em;">
                                <button
                                    type="submit"
                                    style="
                                        padding: 10px 20px;
                                        background: linear-gradient(
                                            135deg,
                                            #667eea 0%,
                                            #764ba2 100%
                                        );
                                        color: white;
                                        border: none;
                                        border-radius: 8px;
                                        cursor: pointer;
                                        font-weight: 500;
                                    "
                                >
                                    🔍 Tìm
                                </button>
                                <% if (request.getParameter("search") != null &&
                                !request.getParameter("search").isEmpty()) { %>
                                <a
                                    href="singers"
                                    style="
                                        padding: 10px 20px;
                                        background: linear-gradient(
                                            135deg,
                                            #dc3545 0%,
                                            #c82333 100%
                                        );
                                        color: white;
                                        border: none;
                                        border-radius: 8px;
                                        text-decoration: none;
                                        display: inline-block;
                                        font-weight: 500;
                                    "
                                    >✕ Xóa lọc</a
                                >
                                <% } %>
                            </form>
                            <button class="btn-add" onclick="openAddModal()">
                                + Thêm ca sĩ mới
                            </button>
                        </div>
                    </div>

                    <% if (success != null) { %>
                    <div class="alert alert-success">
                        <% if ("added".equals(success)) { %> Thêm ca sĩ thành
                        công! <% } else if ("updated".equals(success)) { %> Cập
                        nhật ca sĩ thành công! <% } else if
                        ("deleted".equals(success)) { %> <% String count =
                        request.getParameter("count"); if (count != null) { %>
                        Đã xóa <%= count %> ca sĩ thành công! <% } else { %> Xóa
                        ca sĩ thành công! <% } %> <% } %>
                    </div>
                    <% } %> <% if (error != null) { %>
                    <div class="alert alert-error">
                        Có lỗi xảy ra. Vui lòng thử lại!
                    </div>
                    <% } %>

                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th class="checkbox-cell">
                                        <input
                                            type="checkbox"
                                            id="selectAll"
                                            onchange="toggleSelectAll(this)"
                                        />
                                    </th>
                                    <th>ID</th>
                                    <th>Ảnh</th>
                                    <th>Tên ca sĩ</th>
                                    <th>Quốc gia</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (singers != null && !singers.isEmpty()) {
                                for (Singer singer : singers) { %>
                                <tr>
                                    <td class="checkbox-cell">
                                        <input
                                            type="checkbox"
                                            class="singer-checkbox"
                                            value="<%= singer.getId() %>"
                                            onchange="updateBulkDelete()"
                                        />
                                    </td>
                                    <td><%= singer.getId() %></td>
                                    <td>
                                        <img src="<%= request.getContextPath() +
                                        "/" + singer.getImage() %>" alt="<%=
                                        singer.getName() %>"
                                        class="singer-avatar"
                                        onerror="this.src='data:image/svg+xml,%3Csvg
                                        xmlns=%22http://www.w3.org/2000/svg%22
                                        width=%2250%22
                                        height=%2250%22%3E%3Ccircle
                                        fill=%22%23667eea%22 cx=%2225%22
                                        cy=%2225%22 r=%2225%22/%3E%3Ctext
                                        fill=%22%23fff%22 font-size=%2220%22
                                        x=%2250%25%22 y=%2250%25%22
                                        text-anchor=%22middle%22
                                        dy=%22.3em%22%3E🎤%3C/text%3E%3C/svg%3E'">
                                    </td>
                                    <td><%= singer.getName() %></td>
                                    <td>
                                        <%= singer.getCountry() != null ?
                                        singer.getCountry() : "" %>
                                    </td>
                                    <td>
                                        <button
                                            class="btn-edit"
                                            onclick='openEditModal(<%= singer.getId() %>, "<%= singer.getName() %>", "<%= singer.getCountry() != null ? singer.getCountry() : "" %>", "<%= singer.getImage() %>")'
                                        >
                                            ✏️ Sửa
                                        </button>
                                    </td>
                                </tr>
                                <% } } else { %>
                                <tr>
                                    <td
                                        colspan="6"
                                        style="
                                            text-align: center;
                                            padding: 30px;
                                        "
                                    >
                                        Chưa có ca sĩ nào
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <% Integer currentPage = (Integer)
                    request.getAttribute("currentPage"); Integer totalPages =
                    (Integer) request.getAttribute("totalPages"); Integer
                    totalRecords = (Integer)
                    request.getAttribute("totalRecords"); if (currentPage ==
                    null) currentPage = 1; if (totalPages == null) totalPages =
                    1; if (totalRecords == null) totalRecords = 0; %> <% if
                    (totalPages > 1) { %>
                    <div class="pagination">
                        <% if (currentPage > 1) { %>
                        <a href="?page=1">« Đầu</a>
                        <a href="?page=<%= currentPage - 1 %>">‹ Trước</a>
                        <% } else { %>
                        <span class="disabled">« Đầu</span>
                        <span class="disabled">‹ Trước</span>
                        <% } %> <% int startPage = Math.max(1, currentPage - 2);
                        int endPage = Math.min(totalPages, currentPage + 2); for
                        (int i = startPage; i <= endPage; i++) { if (i ==
                        currentPage) { %>
                        <span class="current"><%= i %></span>
                        <% } else { %>
                        <a href="?page=<%= i %>"><%= i %></a>
                        <% } } %> <% if (currentPage < totalPages) { %>
                        <a href="?page=<%= currentPage + 1 %>">Tiếp ›</a>
                        <a href="?page=<%= totalPages %>">Cuối »</a>
                        <% } else { %>
                        <span class="disabled">Tiếp ›</span>
                        <span class="disabled">Cuối »</span>
                        <% } %>
                    </div>
                    <div class="pagination-info">
                        Hiển thị <%= (currentPage - 1) * 10 + 1 %> - <%=
                        Math.min(currentPage * 10, totalRecords) %> trong tổng
                        số <%= totalRecords %> ca sĩ
                    </div>
                    <% } %>

                    <!-- Bulk Delete Button -->
                    <button
                        id="bulkDeleteBtn"
                        class="bulk-actions"
                        onclick="confirmBulkDelete()"
                    >
                        <span>🗑️</span>
                        <span
                            >Xóa
                            <span class="count" id="selectedCount">0</span> ca
                            sĩ</span
                        >
                    </button>
                </div>

                <!-- Add/Edit Modal -->
                <div id="modal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2 id="modalTitle">Thêm ca sĩ mới</h2>
                            <button class="btn-close" onclick="closeModal()">
                                ×
                            </button>
                        </div>
                        <form
                            id="singerForm"
                            method="post"
                            action="singer-action"
                            enctype="multipart/form-data"
                        >
                            <input
                                type="hidden"
                                name="action"
                                id="formAction"
                                value="add"
                            />
                            <input type="hidden" name="id" id="singerId" />

                            <div class="form-group">
                                <label for="name">Tên ca sĩ *</label>
                                <input
                                    type="text"
                                    id="name"
                                    name="name"
                                    required
                                />
                            </div>

                            <div class="form-group">
                                <label for="country">Quốc gia</label>
                                <input
                                    type="text"
                                    id="country"
                                    name="country"
                                />
                            </div>

                            <div class="form-group">
                                <label>Ảnh ca sĩ</label>
                                <div class="file-input-wrapper">
                                    <input
                                        type="file"
                                        id="imageFile"
                                        name="imageFile"
                                        accept="image/*"
                                        onchange="updateFileName(this, 'imageFileName')"
                                    />
                                    <label
                                        for="imageFile"
                                        class="file-input-label"
                                    >
                                        <span class="icon">📁</span>
                                        <span>Chọn ảnh ca sĩ</span>
                                    </label>
                                    <div
                                        id="imageFileName"
                                        class="file-name"
                                    ></div>
                                </div>
                                <small
                                    style="
                                        color: #666;
                                        font-size: 0.85em;
                                        display: block;
                                        margin-top: 5px;
                                    "
                                    >Hỗ trợ: JPG, PNG, GIF (Max 10MB)</small
                                >
                            </div>

                            <button type="submit" class="btn-submit">
                                Lưu
                            </button>
                        </form>
                    </div>
                </div>

                <script>
                    function toggleSelectAll(checkbox) {
                        const checkboxes =
                            document.querySelectorAll(".singer-checkbox");
                        checkboxes.forEach((cb) => {
                            cb.checked = checkbox.checked;
                            if (cb.checked) {
                                cb.closest("tr").classList.add("selected");
                            } else {
                                cb.closest("tr").classList.remove("selected");
                            }
                        });
                        updateBulkDelete();
                    }

                    function updateBulkDelete() {
                        const checkboxes = document.querySelectorAll(
                            ".singer-checkbox:checked"
                        );
                        const bulkBtn =
                            document.getElementById("bulkDeleteBtn");
                        const countSpan =
                            document.getElementById("selectedCount");
                        const selectAllCheckbox =
                            document.getElementById("selectAll");

                        // Update selected row styling
                        document
                            .querySelectorAll(".singer-checkbox")
                            .forEach((cb) => {
                                if (cb.checked) {
                                    cb.closest("tr").classList.add("selected");
                                } else {
                                    cb.closest("tr").classList.remove(
                                        "selected"
                                    );
                                }
                            });

                        // Update select all checkbox
                        const allCheckboxes =
                            document.querySelectorAll(".singer-checkbox");
                        const allChecked =
                            allCheckboxes.length > 0 &&
                            Array.from(allCheckboxes).every((cb) => cb.checked);
                        selectAllCheckbox.checked = allChecked;

                        if (checkboxes.length > 0) {
                            countSpan.textContent = checkboxes.length;
                            bulkBtn.classList.add("active");
                        } else {
                            bulkBtn.classList.remove("active");
                        }
                    }

                    function confirmBulkDelete() {
                        const checkboxes = document.querySelectorAll(
                            ".singer-checkbox:checked"
                        );
                        const count = checkboxes.length;

                        if (count === 0) return;

                        if (
                            confirm(
                                `Bạn có chắc chắn muốn xóa ${count} ca sĩ đã chọn?`
                            )
                        ) {
                            const ids = Array.from(checkboxes).map(
                                (cb) => cb.value
                            );
                            bulkDeleteSingers(ids);
                        }
                    }

                    function bulkDeleteSingers(ids) {
                        const form = document.createElement("form");
                        form.method = "POST";
                        form.action = "singer-action";

                        const actionInput = document.createElement("input");
                        actionInput.type = "hidden";
                        actionInput.name = "action";
                        actionInput.value = "bulkDelete";
                        form.appendChild(actionInput);

                        ids.forEach((id) => {
                            const input = document.createElement("input");
                            input.type = "hidden";
                            input.name = "ids";
                            input.value = id;
                            form.appendChild(input);
                        });

                        document.body.appendChild(form);
                        form.submit();
                    }

                    function updateFileName(input, displayId) {
                        const display = document.getElementById(displayId);
                        if (input.files && input.files[0]) {
                            display.textContent = "📄 " + input.files[0].name;
                            display.classList.add("active");
                        } else {
                            display.textContent = "";
                            display.classList.remove("active");
                        }
                    }

                    function openAddModal() {
                        document.getElementById("modalTitle").textContent =
                            "Thêm ca sĩ mới";
                        document.getElementById("formAction").value = "add";
                        document.getElementById("singerForm").reset();
                        document.getElementById("imageFileName").textContent =
                            "";
                        document
                            .getElementById("imageFileName")
                            .classList.remove("active");
                        document
                            .getElementById("modal")
                            .classList.add("active");
                    }

                    function openEditModal(id, name, country, image) {
                        document.getElementById("modalTitle").textContent =
                            "Sửa thông tin ca sĩ";
                        document.getElementById("formAction").value = "edit";
                        document.getElementById("singerId").value = id;
                        document.getElementById("name").value = name;
                        document.getElementById("country").value = country;
                        document.getElementById("imageFile").value = "";
                        document.getElementById("imageFileName").textContent =
                            "";
                        document
                            .getElementById("imageFileName")
                            .classList.remove("active");
                        document
                            .getElementById("modal")
                            .classList.add("active");
                    }

                    function closeModal() {
                        document
                            .getElementById("modal")
                            .classList.remove("active");
                    }

                    function confirmDelete(id, name) {
                        if (
                            confirm(
                                'Bạn có chắc muốn xóa ca sĩ "' +
                                    name +
                                    '"?\nTất cả bài hát của ca sĩ này cũng sẽ bị xóa!'
                            )
                        ) {
                            const form = document.createElement("form");
                            form.method = "post";
                            form.action = "singer-action";

                            const actionInput = document.createElement("input");
                            actionInput.type = "hidden";
                            actionInput.name = "action";
                            actionInput.value = "delete";

                            const idInput = document.createElement("input");
                            idInput.type = "hidden";
                            idInput.name = "id";
                            idInput.value = id;

                            form.appendChild(actionInput);
                            form.appendChild(idInput);
                            document.body.appendChild(form);
                            form.submit();
                        }
                    }

                    // Close modal when clicking outside
                    document
                        .getElementById("modal")
                        .addEventListener("click", function (e) {
                            if (e.target === this) {
                                closeModal();
                            }
                        });
                </script>
            </body>
        </html>
    </Singer></Singer
>
