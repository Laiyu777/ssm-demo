package Controller;

import Aspect.Annotation.Login;
import Entity.LoginLog;
import Entity.User;
import Help.Message;
import Service.UserService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2018/5/30.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;





//    @ResponseBody
//    @RequestMapping("/validateUsername")
//    public Message validateUsername(String username){
//        //User user = userService.ifUserExist(username);
//        if (user!=null){
//            System.out.println("username==>"+username);
//            return new Message(400,"用户名已经被注册");
//        }else {
//            return new Message(200,"用户名可以使用");
//        }
//    }



    @ResponseBody
    @RequestMapping(value = "/modifyUser",method = RequestMethod.POST)//这里是模态框显示，不需要get方法对应
    public Message modifyUser(User user){
        try {
            userService.updateUser(user);
            return new Message(200,"修改成功");
        }catch (Exception e){
            e.printStackTrace();
            return new Message(400,"修改失败");
        }
    }

    //个人信息的显示
    @RequestMapping(value = "/userInfo",method = RequestMethod.GET)
    public String showUserInfo(HttpSession session){
        User user = (User) session.getAttribute("user");
        //修改以后更新信息
        if(user != null){
            session.setAttribute("user", userService.getUserByUsername(user.getUsername()));
        }
        return "/user/userInfo";
    }

    //跳转到修改密码界面
    @RequestMapping(value = "/updatePassword",method = RequestMethod.GET)
    public String updatePassword(HttpSession session){
        return "/user/updatePassword";
    }

    public Message updatePassword(HttpSession session,String oldPassword,String newPassword){
        return null;
    }

    //修改密码表单提交的处理
    @ResponseBody
    @RequestMapping(value = "/updatePassword",method = RequestMethod.POST)
    public Message processPasswordUpdate(String oldPassword,String newPassword,String confirmPassword,HttpSession session){
        if(!newPassword.equals(confirmPassword)){
            return new Message(400,"两次输入的密码不一样");
        }
        User user = (User) session.getAttribute("user");
        if(!user.getPassword().equals(oldPassword)){
            return new Message(200,"与原密码不同");
        }
        userService.updateUserPassword(user.getUsername(),newPassword);
        return new Message(200,"修改成功");
    }

    //跳转到登录日志页面
    @RequestMapping(value = "/loginLog",method = RequestMethod.GET)
    public String gotoLoginLog(@RequestParam(value = "pageNumber",defaultValue = "1") int pageNumber,
                               @RequestParam(value = "pageSize",defaultValue = "10") int pageSize,
                               HttpSession session, HttpServletRequest request){
        User user = (User) session.getAttribute("user");
        String username = user.getUsername();
        PageInfo<LoginLog> pageInfo = userService.getLoginLogsByUsername(pageNumber,pageSize,username);
        request.setAttribute("pageInfo",pageInfo);
        return "user/loginLog";
    }

}
