package Test;

import Dao.MenuDao;
import Dao.NewsDao;
import Entity.Menu;
import Entity.New;
import Entity.SubMenu;
import Service.MenuService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2018/6/10.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring.xml","classpath:spring-mvc.xml"})
public class MenuTest {
    @Autowired
    MenuService menuService;
    @Autowired
    MenuDao menuDao;
    @Autowired
    NewsDao newsDao;
    @Test
    public void testGetAllMenus(){
        System.out.println(menuService.getAllMenus());
    }

    @Test
    public void testGetSubmenu(){
        System.out.println(menuDao.getSubMenuByMenuId(1));
    }

    @Test
    public void testInsertMenu(){
        Menu menu = new Menu();
        menu.setMenuId(20);
        menu.setMenuName("测试1");
        List<SubMenu> subMenuList = new ArrayList<SubMenu>();
        SubMenu subMenu1 = new SubMenu();
        subMenu1.setMenuId(20);
        subMenu1.setSubmenuName("测试20");
        SubMenu subMenu2= new SubMenu();
        subMenu2.setMenuId(20);
        subMenu2.setSubmenuName("测试20");
        subMenuList.add(subMenu1);
        subMenuList.add(subMenu2);
        menu.setSubMenuNames(subMenuList);

        List<Menu> menuList = new ArrayList<Menu>();
        menuList.add(menu);

        menuService.updateMenu(menuList);
    }

    @Test
    public void testGetSubmenuByID(){
        System.out.println("菜单："+menuDao.getSubmenuById(20));
    }

    @Test
    public void test(){
        Integer menuId  = menuDao.getMenuIdBySubmenuId(30);
        System.out.println("主菜单的id是："+menuId);
        New _new = newsDao.getNewsById(1528826692316L);
        System.out.println("新闻:"+_new);
    }
}
