package service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dao.UserDao;
import entity.LoginLog;
import entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import util.Utils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/7.
 */
@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    public User login(String name, String password, HttpServletRequest request){
        //先根据用户名找到这个user
        User user = userDao.getUserByUsername(name);
        //判断密码是否正确
       if(user!=null) {//如果不是空，找到这个用户了。
           //登录日志的更新处理
           LoginLog loginLog = new LoginLog();
           loginLog.setUsername(user.getUsername());
           loginLog.setIpAddress(Utils.getIpAddress(request));

           if (user.getPassword().equals(password)) {//验证密码
               //保存日志
               loginLog.setResult("登录成功");
               userDao.addLoginLog(loginLog);
               return user;//最终正确
           } else {
               //保存日志
               loginLog.setResult("登录失败,密码不正确");
               userDao.addLoginLog(loginLog);
               return null;
           }
       }else {
           return null;
       }
    }

    public int update(User user) {
        return userDao.updateOne(user);
    }

    public User getUserByUsername(String username){
        return userDao.getUserByUsername(username);
    }

    //获取除了管理员外的零售商
    public PageInfo<User> getUsersExcludeAdmin(int pageNum, int pageSize, Map<String,String> conditions){
        PageHelper.startPage(pageNum,pageSize);
        List<User> users =  userDao.getUsersNotIncludeAdmin();
        return new PageInfo<User>(users);
    }

    public int addSeller(User user){
        return userDao.addOne(user);
    }


    //禁用零售商
    public int forbiddenUserStatus(String username){
        return userDao.forbiddenUserStatus(username);
    }

    //启用零售商
    public int enabledUserStatus(String username){
        return userDao.enabledUserStatus(username);
    }

    //获取登录日志的分页信息pageInfo
    public PageInfo<LoginLog> getLoginLogs(String username,int pageNum) {
        PageHelper.startPage(pageNum,10);
        List<LoginLog> loginLogs = userDao.getLoinLogs(username);
        PageInfo<LoginLog> pageInfo = new PageInfo<LoginLog>(loginLogs);
       return  pageInfo;
    }
}
