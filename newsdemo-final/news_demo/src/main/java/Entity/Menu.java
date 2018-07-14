package Entity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2018/6/10.
 */
public class Menu {
    private Integer menuId;
    private String menuName;
    private List<SubMenu> subMenuNames = new ArrayList<SubMenu>();

    public Menu(){}

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public List<SubMenu> getSubMenuNames() {
        return subMenuNames;
    }

    public void setSubMenuNames(List<SubMenu> subMenuNames) {
        this.subMenuNames = subMenuNames;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "menuId=" + menuId +
                ", menuName='" + menuName + '\'' +
                ", subMenuNames=" + subMenuNames +
                '}';
    }
}
