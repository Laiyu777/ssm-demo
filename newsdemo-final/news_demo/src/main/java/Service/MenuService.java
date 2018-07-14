package Service;

import Dao.MenuDao;
import Dao.NewsDao;
import Entity.Menu;
import Entity.New;
import Entity.SubMenu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2018/6/10.
 */
@Service
public class MenuService {

    @Autowired
    private MenuDao menuDao;
    @Autowired
    private NewsDao newsDao;

    public List<Menu> getAllMenus(){
        return menuDao.getAllMenus();
    }

    //更新菜单和子菜单
    public void updateMenu(List<Menu> menus) {
        //先要清除两张表的内容
        menuDao.emptyMenu();
        menuDao.emptySubmenu();
        //更新菜单
        menuDao.updateMenu(menus);
        //更新子菜单
        for(Menu menu : menus){
            List<SubMenu> subMenuList = menu.getSubMenuNames();
            menuDao.updateSubMenu(subMenuList);
        }
    }

    //获取一个菜单
    public Menu getMenuById(Integer id){
        return menuDao.getMenuById(id);
    }
    //获取主菜单的名字根据id
    public String getMenuNameById(String id){
        return menuDao.getMenuNameById(id);
    }

    //获取子菜单的名字根据id
    public String getSubmenuNameById(String id){
        return menuDao.getSubmenuNameById(id);
    }
    //根据子菜单的id获取主菜单的名字
    public String getMenuNameBySubmenuId(Integer submenuId){
        return menuDao.getMenuNameBySubmenuId(submenuId);
    }
    //根据id获取子菜单的实体
    public SubMenu getSubmenById(Integer id){
        return menuDao.getSubmenuById(id);
    }

    public Integer getMenuIdBySubmenuId(Integer submenuId){
        return menuDao.getMenuIdBySubmenuId(submenuId);
    }

    public void addSubMenu(String submenuName, String menuId) {
        menuDao.addSubMenu(submenuName,menuId);
    }

    public void modifySubmenu(String submenName, String submenuId) {
        menuDao.modifySubmenu(submenName,submenuId);
    }

    //是否删除
    public boolean delSubmenu(String submenuId) {
        if(!ifHaveNewsInSubmenuId(submenuId)){
            menuDao.delSubmenu(submenuId);
            return true;
        }else{
            return false;
        }
    }

    public boolean ifHaveNewsInSubmenuId(String submenuId){
        List<New> newList = newsDao.getAllNewsInIndex(null,submenuId);
        if(newList.size()>0){
            return true;
        }
        return false;
    }

    public boolean modifyMenuvName(String menuName, String menuId) {
        menuDao.modifyMenuName(menuName,menuId);
        return true;
    }
}
