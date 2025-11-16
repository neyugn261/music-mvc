DROP DATABASE IF EXISTS musicdb;
CREATE DATABASE musicdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE musicdb;

DROP TABLE IF EXISTS singers;
CREATE TABLE singers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    image VARCHAR(255) -- lưu đường dân ảnh
) ENGINE=InnoDB;

DROP TABLE IF EXISTS songs;
CREATE TABLE songs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    singer_id INT,
    audio VARCHAR(255), -- lưu đường dẫn audio
    image VARCHAR(255), -- lưu đường dẫn ảnh
    description TEXT,
    FOREIGN KEY (singer_id) REFERENCES singers(id) ON DELETE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS admins;
CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
) ENGINE=InnoDB;
