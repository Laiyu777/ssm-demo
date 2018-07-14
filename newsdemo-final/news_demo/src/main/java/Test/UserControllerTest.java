package Test;

import Controller.PageController;
import Controller.UserController;
import Dao.LoginLogDao;
import Entity.LoginLog;
import Entity.User;
import Service.UserService;
import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2018/5/30.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring.xml","classpath:spring-mvc.xml"})
public class UserControllerTest{

    @Autowired
    UserController userController;
    @Autowired
    UserService userService;
    @Autowired
    LoginLogDao loginLogDao;

    @Autowired
    PageController pageController;

    @Test
    public void test(){
        System.out.println("这个"+pageController.login("admin","1",null,null));
    }

    @Test
    public void test2(){
        User user = userService.getUserByUsernameAndPassword("admin","1");
        System.out.println("用户是："+user);
    }

    @Test
    public void insertIntoLoginlog(){
        LoginLog loginLog = new LoginLog();
        loginLog.setIpAddress("111.111.111.111");
        loginLog.setLoginTime(new Timestamp(System.currentTimeMillis()));
        loginLog.setUsername("admin");
        loginLog.setResult("登录成功");
        loginLogDao.insertOneRecord(loginLog);
    }

    @Test
    public void testgetLoginlog(){
        PageInfo<LoginLog> pageInfo = userService.getLoginLogsByUsername(1,10,"admin");
        for(LoginLog loginLog : pageInfo.getList()){
            System.out.println("日志："+loginLog);
        }
    }

    @Test
    public void testGetUsersNotAdmin(){
        PageInfo<User> pageInfo = userService.selectUserNotAdmin(1,10);
        System.out.println("日志："+pageInfo.getList());
    }


}
