package Dao;

import Entity.Menu;
import Entity.SubMenu;
import org.apache.ibatis.annotations.*;

import java.net.InetAddress;
import java.util.List;

/**
 * Created by Administrator on 2018/6/10.
 */
public interface MenuDao {
    List<Menu> getAllMenus();

    List<SubMenu> getSubMenuByMenuId(@Param("menu_id")Integer menuId);

    int updateMenu(List<Menu> menus);

    int updateSubMenu(List<SubMenu> subMenuList);

    @Delete("delete  from `menu`;")
    void emptyMenu();

    @Delete("delete  from `submenu`;")
    void emptySubmenu();

    Menu getMenuById(@Param("id") Integer id);

    SubMenu getSubmenuById(@Param("id")Integer id);

    @Select("select menu_id from submenu where submenu_id = #{submenuId}")
    Integer getMenuIdBySubmenuId(Integer submenuId);

    @Select("SELECT menu_name from menu where menu_id in (select menu_id from submenu where submenu_id = #{id})")
    String getMenuNameBySubmenuId(Integer submenuId);

    @Select("select menu_name from menu where menu_id=#{id}")
    String getMenuNameById(String id);

    @Select("select submenu_name from submenu where submenu_id=#{id}")
    String getSubmenuNameById(String id);

    @Insert("insert into submenu(submenu_name,menu_id) values(#{submenuName},#{menuId})")
    void addSubMenu(@Param("submenuName") String submenuName, @Param("menuId") String menuId);

    @Update("update submenu set submenu_name=#{submenuName} where submenu_id=#{submenuId}")
    void modifySubmenu(@Param("submenuName") String submenuName, @Param("submenuId") String submenuId);

    @Delete("delete from submenu where submenu_id = #{id}")
    void delSubmenu(String submenuId);

    @Update("update menu set menu_name=#{menuName} where menu_id=#{menuId}")
    void modifyMenuName(@Param("menuName") String menuName, @Param("menuId") String menuId);
}
