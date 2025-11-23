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
    lyrics TEXT, -- lời bài hát
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (singer_id) REFERENCES singers(id) ON DELETE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS admins;
CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

-- Thêm dữ liệu mẫu cho bảng singers
INSERT INTO singers (name, country, image) VALUES
('Sơn Tung M-TP', 'Việt Nam', 'uploads/images/singer/sontung.jpg'),
('AMEE', 'Việt Nam', 'uploads/images/singer/amee.jpg'),
('Hoàng Dũng', 'Việt Nam', 'uploads/images/singer/hoangdung.jpg'),
('Đen Vâu', 'Việt Nam', 'uploads/images/singer/denvau.jpg'),
('HIEUTHUHAI', 'Việt Nam', 'uploads/images/singer/hieuthuhai.jpg'),
('Tlinh', 'Việt Nam', 'uploads/images/singer/tlinh.jpg'),
('Bích Phương', 'Việt Nam', 'uploads/images/singer/bichphuong.jpg'),
('Hòa Minzy', 'Việt Nam', 'uploads/images/singer/hoaminzy.jpg'),
('Jack', 'Việt Nam', 'uploads/images/singer/jack.jpg'),
('Chi Pu', 'Việt Nam', 'uploads/images/singer/chipu.jpg'),
('MIN', 'Việt Nam', 'uploads/images/singer/min.jpg'),
('Erik', 'Việt Nam', 'uploads/images/singer/erik.jpg'),
('Hương Ly', 'Việt Nam', 'uploads/images/singer/huongly.jpg'),
('Vũ', 'Việt Nam', 'uploads/images/singer/vu.jpg'),
('Karik', 'Việt Nam', 'uploads/images/singer/karik.jpg');

-- Thêm dữ liệu mẫu cho bảng songs
INSERT INTO songs (title, singer_id, audio, image, created_at) VALUES
-- Bài hát mới nhất (7 ngày gần đây)
('Chúng Ta Của Tương Lai', 1, 'uploads/audio/song/chungtacuatuonglai.mp3', 'uploads/images/song/chungtacuatuonglai.jpg', DATE_SUB(NOW(), INTERVAL 1 DAY)),
('Trói Em Lại', 2, 'uploads/audio/song/troiemlai.mp3', 'uploads/images/song/troiemlai.jpg', DATE_SUB(NOW(), INTERVAL 2 DAY)),
('Em Là', 3, 'uploads/audio/song/emla.mp3', 'uploads/images/song/emla.jpg', DATE_SUB(NOW(), INTERVAL 3 DAY)),
('Đi Về Nhà', 4, 'uploads/audio/song/divenha.mp3', 'uploads/images/song/divenha.jpg', DATE_SUB(NOW(), INTERVAL 4 DAY)),
('Ngủ Một Mình', 5, 'uploads/audio/song/ngumoitminh.mp3', 'uploads/images/song/ngumotminh.jpg', DATE_SUB(NOW(), INTERVAL 5 DAY)),
('Thật Xa', 6, 'uploads/audio/song/thatxa.mp3', 'uploads/images/song/thatxa.jpg', DATE_SUB(NOW(), INTERVAL 6 DAY)),
('Đi Đu Đưa Đi', 7, 'uploads/audio/song/diduduadi.mp3', 'uploads/images/song/diduduadi.jpg', DATE_SUB(NOW(), INTERVAL 7 DAY)),

-- Bài hát cũ hơn
('Rời Bỏ', 8, 'uploads/audio/song/roibo.mp3', 'uploads/images/song/roibo.jpg', DATE_SUB(NOW(), INTERVAL 15 DAY)),
('Thiên Lý Ơi', 9, 'uploads/audio/song/thienlyoi.mp3', 'uploads/images/song/thienlyoi.jpg', DATE_SUB(NOW(), INTERVAL 20 DAY)),
('Đóa Hoa Hồng', 10, 'uploads/audio/song/doahoahong.mp3', 'uploads/images/song/doahoahong.jpg', DATE_SUB(NOW(), INTERVAL 25 DAY)),
('Yêu Là Cưới', 11, 'uploads/audio/song/yeulacuoi.mp3', 'uploads/images/song/yeulacuoi.jpg', DATE_SUB(NOW(), INTERVAL 30 DAY)),
('Sau Tất Cả', 12, 'uploads/audio/song/sautatca.mp3', 'uploads/images/song/sautatca.jpg', DATE_SUB(NOW(), INTERVAL 35 DAY)),
('Cưới Luôn Được Không', 13, 'uploads/audio/song/cuoiluonduockhong.mp3', 'uploads/images/song/cuoiluonduockhong.jpg', DATE_SUB(NOW(), INTERVAL 40 DAY)),
('Lạc Trôi', 1, 'uploads/audio/song/lactroi.mp3', 'uploads/images/song/lactroi.jpg', DATE_SUB(NOW(), INTERVAL 45 DAY)),
('Anh Ơi Ở Lại', 2, 'uploads/audio/song/anhoiolai.mp3', 'uploads/images/song/anhoiolai.jpg', DATE_SUB(NOW(), INTERVAL 50 DAY)),
('Anh Đang Ở Đâu Đấy Anh', 3, 'uploads/audio/song/anhdangodaudayanh.mp3', 'uploads/images/song/anhdangodaudayanh.jpg', DATE_SUB(NOW(), INTERVAL 55 DAY)),
('Bài Này Chill Phết', 4, 'uploads/audio/song/bainaychillphet.mp3', 'uploads/images/song/bainaychillphet.jpg', DATE_SUB(NOW(), INTERVAL 60 DAY)),
('Trống Rỗng', 14, 'uploads/audio/song/trongrong.mp3', 'uploads/images/song/trongrong.jpg', DATE_SUB(NOW(), INTERVAL 65 DAY)),
('Anh Nhà Ở Đâu Thế', 15, 'uploads/audio/song/anhnhaodauthe.mp3', 'uploads/images/song/anhnhaodauthe.jpg', DATE_SUB(NOW(), INTERVAL 70 DAY)),
('Em Của Ngày Hôm Qua', 1, 'uploads/audio/song/emcuangayhomuqua.mp3', 'uploads/images/song/emcuangayhomqua.jpg', DATE_SUB(NOW(), INTERVAL 75 DAY)),
('Có Chắc Yêu Là Đây', 1, 'uploads/audio/song/cochacyeulacay.mp3', 'uploads/images/song/cochacyeuladay.jpg', DATE_SUB(NOW(), INTERVAL 80 DAY));

-- Thêm tài khoản admin mẫu (password: admin123)
INSERT INTO admins (username, password) VALUES
('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy'),
('qn', '123');
