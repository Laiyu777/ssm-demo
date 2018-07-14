package Service;

import Dao.LoginLogDao;
import Dao.UserDao;
import Entity.LoginLog;
import Entity.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2018/5/30.
 */

@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    @Autowired
    private LoginLogDao loginLogDao;

    //校验密码
    public User getUserByUsernameAndPassword(String username, String password){
        User user =  userDao.getUserByUsername(username);
        if(user == null){
            return null;
        }
        if(password.equals(user.getPassword())){
            return user;
        }else {
            return null;
        }
    }

    //根据用户名返回一条记录
    public User getUserByUsername(String username){
        return userDao.getUserByUsername(username);
    }

    //验证用户名是否存在
    public boolean ifUserExist(String username){
       User user = userDao.getUserByUsername(username);
       if(user!=null){
           return true;
       }else {
           return false;
       }
    }

    //记录登录日志
    public int recordLoginLog(String username,String ip,String result){
        LoginLog loginLog = new LoginLog();
        loginLog.setUsername(username);
        loginLog.setIpAddress(ip);
        loginLog.setResult(result);
        loginLog.setLoginTime(new Timestamp(System.currentTimeMillis()));
        return loginLogDao.insertOneRecord(loginLog);
    }


    //添加一个用户  适用于注册或者添加用户
    public int addOneUser(User user){
        user.setCreateTime(new Timestamp(System.currentTimeMillis()));
        return userDao.addOneUser(user);
    }

    //修改一个用户
    public int updateUser(User user) {
        return userDao.updateUser(user);
    }

    //修改用户的密码
    public int updateUserPassword(String username, String newPassword) {
        return userDao.updateUserPassword(username,newPassword);
    }

    //根据用户名选取登录日志
    public PageInfo<LoginLog> getLoginLogsByUsername(int pageNumber, int pageSize, String username) {
        PageHelper.startPage(pageNumber,pageSize);
        List<LoginLog> loginLogList = loginLogDao.getLoginLogsByUsername(username);
        PageInfo<LoginLog> pageInfo = new PageInfo<LoginLog>(loginLogList,7);
        return pageInfo;
    }

    //选取非管理员的用户
    public PageInfo<User> selectUserNotAdmin(int pageNum,int pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<User> userList = userDao.selectUserNotAdmin();
        PageInfo<User> userPageInfo = new PageInfo<User>(userList);
         return userPageInfo;
    }

    public int adminAddUser(User user) {
        user.setCreateTime(new Timestamp(System.currentTimeMillis()));
        return userDao.adminAddUser(user);
    }
}
