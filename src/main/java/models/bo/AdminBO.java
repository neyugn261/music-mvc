package models.bo;

import models.bean.Admin;
import models.dao.AdminDAO;

public class AdminBO {
    private AdminDAO adminDAO = new AdminDAO();
    
    public Admin login(String username, String password) {
        return adminDAO.login(username, password);
    }
}
