package Entity;

/**
 * Created by Administrator on 2018/6/10.
 */
public class SubMenu {
    private String submenuName;
    private String submenuId;
    private Integer menuId;

    public SubMenu(){}

    public String getSubmenuName() {
        return submenuName;
    }

    public void setSubmenuName(String submenuName) {
        this.submenuName = submenuName;
    }

    public String getSubmenuId() {
        return submenuId;
    }

    public void setSubmenuId(String submenuId) {
        this.submenuId = submenuId;
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    @Override
    public String toString() {
        return "SubMenu{" +
                "submenuName='" + submenuName + '\'' +
                ", submenuId='" + submenuId + '\'' +
                ", menuId=" + menuId +
                '}';
    }
}
