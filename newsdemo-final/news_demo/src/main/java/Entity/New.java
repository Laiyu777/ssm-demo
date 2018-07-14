package Entity;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/5/28.
 */
public class New {
    private Long id;
    private String title;
    private String content;
    private Integer checkAuth;
    private Timestamp createTime;

    private Integer menuId;
    private String menuName;

    private Integer status;
    private Timestamp lastTime;

    private List<NewFile> newFileList;

    private SubMenu submenu;
    private User user ;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getCheckAuth() {
        return checkAuth;
    }

    public void setCheckAuth(Integer checkAuth) {
        this.checkAuth = checkAuth;
    }

    public SubMenu getSubmenu() {
        return submenu;
    }

    public void setSubmenu(SubMenu submenu) {
        this.submenu = submenu;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<NewFile> getNewFileList() {
        return newFileList;
    }

    public void setNewFileList(List<NewFile> newFileList) {
        this.newFileList = newFileList;
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Timestamp getLastTime() {
        return lastTime;
    }

    public void setLastTime(Timestamp lastTime) {
        this.lastTime = lastTime;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    @Override
    public String toString() {
        return "New{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", checkAuth=" + checkAuth +
                ", createTime=" + createTime +
                ", menuId=" + menuId +
                ", menuName='" + menuName + '\'' +
                ", status=" + status +
                ", lastTime=" + lastTime +
                ", newFileList=" + newFileList +
                ", submenu=" + submenu +
                ", user=" + user +
                '}';
    }
}
