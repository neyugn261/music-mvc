package models.bo;

import models.bean.Song;
import models.dao.SongDAO;

import java.util.List;

public class SongBO {
    private SongDAO songDAO = new SongDAO();
    public List<Song> getAllSongs() {
        return songDAO.getAllSongs();
    }

}
