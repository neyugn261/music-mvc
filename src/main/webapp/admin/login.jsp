<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Music Manager</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
        }

        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
        }

        .login-header h1 {
            font-size: 2em;
            margin-bottom: 10px;
        }

        .login-header p {
            font-size: 0.95em;
            opacity: 0.9;
        }

        .login-form {
            padding: 40px 30px;
        }

        .form-group {
            margin-bottom: 25px;
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
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }

        .error-message {
            background: #fee;
            border-left: 4px solid #f44336;
            color: #c62828;
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 0.9em;
        }

        .success-message {
            background: #e8f5e9;
            border-left: 4px solid #4caf50;
            color: #2e7d32;
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 0.9em;
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .login-footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }

        .login-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .login-footer a:hover {
            text-decoration: underline;
        }

        .back-home {
            text-align: center;
            margin-top: 15px;
        }

        .back-home a {
            color: #666;
            text-decoration: none;
            font-size: 0.9em;
        }

        .back-home a:hover {
            color: #667eea;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>🎵 Admin Panel</h1>
            <p>Đăng nhập để quản lý hệ thống</p>
        </div>

        <div class="login-form">
            <% String error = (String) request.getAttribute("error"); 
               String success = (String) request.getAttribute("success"); 
               if (error != null) { %>
                <div class="error-message"><%= error %></div>
            <% } 
               if (success != null) { %>
                <div class="success-message"><%= success %></div>
            <% } %>

            <form method="post" action="login">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <button type="submit" class="btn-login">Đăng nhập</button>
            </form>

            <div class="back-home" style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #e0e0e0;">
                <a href="<%= request.getContextPath() %>/home">← Quay về trang chủ</a>
            </div>
        </div>
    </div>
</body>
</html>
