package Controller;

import Entity.User;
import Help.Message;
import Service.UserService;
import com.github.pagehelper.PageHelper;
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
 * Created by Administrator on 2018/6/3.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    UserService userService;

    //跳转到后台
//    @RequestMapping(value = "admin/gotoback")
//    public String gotoBack(HttpSession session){
//        User user = (User) session.getAttribute("user");
//        if(user!=null&&user.getRole().getRoleId()==0){
//            return "admin/publishNews";
//        }else{
//            return "redirect:index.jsp";//暂时没有做权限认证，只有管理员可以进入后台
//        }
//    }

    //跳转到用户列表界面
    @RequestMapping(value="/manageUser/userList",method = RequestMethod.GET)
    public String gotoMananageUserJsp(@RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
                                      @RequestParam(value = "pageSize",defaultValue = "10") int pageSize,
                                      HttpSession session, HttpServletRequest request){
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<User> pageInfo = userService.selectUserNotAdmin(pageNum,pageSize);
        request.setAttribute("pageInfo",pageInfo);
        return "admin/manageUser";
    }

    //编辑按钮返回一个user实体
    @RequestMapping(value = "/manageUser/getUser",method = RequestMethod.GET)
    @ResponseBody
    public User getUserByUserName(String username){
       User user =  userService.getUserByUsername(username);
        return user;
    }

    //管理员修改用户
    @RequestMapping(value = "/manageUser/modifyUser",method = RequestMethod.POST)
    @ResponseBody
    public Message modifyUser(User user,HttpSession session){
        try {
            userService.updateUser(user);
            return new Message(200,"修改成功");
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    //跳转到添加用户界面
    @RequestMapping(value="/manageUser/addUser",method = RequestMethod.GET)
    public String  gotoAddUserJsp(HttpSession session){
        return "admin/addUser";
    }

    //执行添加用户的操作
    @ResponseBody
    @RequestMapping(value="/manageUser/addUser",method = RequestMethod.POST)
    public Message adminAddUser(User user){
        try {
            System.out.println("前台传来的user是："+user);
            userService.adminAddUser(user);
            return new Message(200,"添加成功");
        }catch (Exception e){
            e.printStackTrace();
            return new Message(400,"添加失败");
        }
    }
}
