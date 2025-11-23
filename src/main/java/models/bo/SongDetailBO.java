package models.bo;

import models.bean.Singer;
import models.bean.Song;
import models.dao.SongDetailDAO;

public class SongDetailBO {
    private SongDetailDAO songDetailDAO = new SongDetailDAO();

    public Song getSongById(int id) {
        return songDetailDAO.getSongById(id);
    }

    public Singer getSingerById(int id) {
        return songDetailDAO.getSingerById(id);
    }
}
