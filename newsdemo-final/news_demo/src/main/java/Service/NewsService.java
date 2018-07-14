package Service;

import Dao.NewsDao;
import Entity.New;
import Entity.NewFile;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/6/12.
 */
@Service
public class NewsService {

    @Autowired
    private NewsDao newsDao;

    //插入一条新闻
    public void insertOneNew(New _new){
        newsDao.insertOneRecord(_new);
        if(_new.getNewFileList().size()>0){
            newsDao.insertNewsFiles(_new.getNewFileList());
        }
    }

    //根据ID返回新闻
    public New getNewsById(Long id){
        return newsDao.getNewsById(id);
    }

    //管理员得到所有新闻
    public PageInfo<New> getAllNews(int pageNum,int pageSize){
        PageHelper.startPage(pageNum,pageSize);
        List<New> newList =  newsDao.getAllNews();
        PageInfo<New> pageInfo = new PageInfo<New>(newList);
        return pageInfo;
    }

    //根据用户名得到新闻
    public PageInfo<New> getNewsByUsername(int pageNum,int pageSize,String username){
        List<New> newList =  newsDao.getNewsByUsername(username);
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<New> pageInfo = new PageInfo<New>(newList);
        return pageInfo;
    }

    //修改新闻
    public void modifyNews(New _new){
        newsDao.modifyNews(_new);
        if(_new.getNewFileList().size()>0){
            newsDao.insertNewsFiles(_new.getNewFileList());
        }
    }

    public void deleteNewFile(String id, String fileName) {
        newsDao.deleteNewFile(id,fileName);
    }

    public void deleteOneRecord(String id,String realPath) {
        //删除news表
        newsDao.deleteOneRecord(id);
        List<NewFile> newFileList = newsDao.getFileNamesByNewsId(id);
        //删除news_files表 和 本地文件
        for(NewFile newFile : newFileList){
            newsDao.deleteNewFile(newFile.getNewId().toString(),newFile.getFileName());
            //删除本地文件
            File file = new File(realPath,newFile.getFileName());
            if(file.exists()){
                file.delete();
            }
        }
    }

    public void updateNewStatus(Long id, String status) {
        newsDao.updateNewStatus(id,status);
    }

    //获取最新发布的10条新闻
    public List<New> getLastNewList() {
        return newsDao.getLastNewList();
    }

    //根据主菜单的名字查找新闻
    public PageInfo<New> getNewsByMenuName(String menuName,int pageNum,int pageSize){
        List<New> newList = newsDao.getNewsByMenuName(menuName);
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<New> pageInfo = new PageInfo<New>(newList);
        return pageInfo;
    }

    //根据子菜单的名字查找新闻
    public PageInfo<New> getNewsBySubmenuName(String submenuName,int pageNum,int pageSize){
        List<New> newList = newsDao.getNewsBySubmenuName(submenuName);
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<New> pageInfo = new PageInfo<New>(newList);
        return pageInfo;
    }

    //根据新闻标题或者新闻内容的关键字检索新闻
    public PageInfo<New> getNewsByNewsKeyword(String keyword,String realName, int pageNum,int pageSize){
        List<New> newList = newsDao.getNewsByNewsKeyword(keyword,realName);
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<New> pageInfo = new PageInfo<New>(newList);
        return pageInfo;
    }

    //根据新闻状态返回新闻
    public PageInfo<New> getNewsByStatus(String status,String username,int pageNum,int pageSize){
        List<New> newList = newsDao.getNewsByStatus(status,username);
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<New> pageInfo = new PageInfo<New>(newList);
        return pageInfo;
    }

    //高级检索
    public PageInfo<New> advancedSearchNews(Map<String, String> conditions,int pageNum,int pageSize) {
        List<New> newList = newsDao.getNewsByConditions(conditions);
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<New> pageInfo = new PageInfo<New>(newList,10);
        return pageInfo;
    }

    //主页查看更多按钮获取的
    public PageInfo<New> getAllNewsInIndex(String menuId,String submenuId,int pageNum,int pageSize){
        PageHelper.startPage(pageNum,pageSize);
        List<New> newList = newsDao.getAllNewsInIndex(menuId,submenuId);
        PageInfo<New> pageInfo = new PageInfo<New>(newList);
        return pageInfo;
    }
}
