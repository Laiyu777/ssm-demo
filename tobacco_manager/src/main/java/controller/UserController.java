package controller;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.sun.deploy.net.HttpResponse;
import com.sun.org.apache.regexp.internal.RE;
import entity.CartItem;
import entity.Message;
import entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import service.CartItemService;
import service.GoodsService;
import service.MessageService;
import service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.Writer;

/**
 * Created by Administrator on 2017/12/7.
 */
@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private CartItemService cartItemService;

    @Autowired
    private MessageService messageService;

    //登录
    @RequestMapping("/login")
    public String login(String name, String password,HttpSession session,HttpServletRequest request){
        //登录主要逻辑
        User user = userService.login(name,password,request);
        if(user!=null){
            session.removeAttribute("msg");
            session.setAttribute("user",user);
            //判断这个是不是管理员
            int count = 0;
            if(user.getRole().getRoleId().equals(0)){
                session.setAttribute("isAdmin",true);
                 count = messageService.getNoReadMsgByUserName(user.getUsername(),true);
            }else{
                session.setAttribute("isAdmin",false);
                count = messageService.getNoReadMsgByUserName(user.getUsername(),false);
            }
            session.setAttribute("no_read_count",count);
            //验证有没有被管理员封
            if(user.getStatus()==0){
                session.setAttribute("msg","你的账号被禁用了，请联系管理员");
                return "redirect:login.jsp";
            }//判断账号是否被禁用
            //判断未读信息的数量
            return "redirect:/index";
        }
        session.setAttribute("msg","用户名或者密码错误");
        return "redirect:login.jsp";
    }

    //更新用户信息
    @RequestMapping("/update")
    public String update(User user1,HttpSession session){
        System.out.println(user1);
        User user = (User) session.getAttribute("user");
        if(user==null){
            return "redirect:login.jsp";
        }
        user.setRealName(user1.getRealName());
        user.setCardNumber(user1.getCardNumber());
        user.setPhone(user1.getPhone());
        user.setShopAddress(user1.getShopAddress());
        session.setAttribute("user",user);
        userService.update(user);

        return "redirect:index";
    }


    //更新密码
    @ResponseBody
    @RequestMapping(value="/updatePassword",produces = "text/plain;charset=utf-8")
    public String updatePassword(@RequestParam("password") String password,@RequestParam("newpassword") String newpassword,HttpSession session){
        //是否登录
        User user = (User) session.getAttribute("user");
        if (user==null){
            return "redirect:login.jsp";
        }


        if(!password.equals(user.getPassword())){
            //session.setAttribute("msg","与旧密码不同");
            return "与原密码不同";
        }

        //session.setAttribute("msg","修改成功");
        user.setPassword(newpassword);
        System.out.println("用户名:"+user);
        userService.update(user);
        //session.setAttribute("user",user);
        return  "修改成功";
    }




    //注销功能
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/login.jsp";
    }

    //添加购物车
    @RequestMapping("/addCartItem")
    public String addCartItem(HttpSession session,CartItem cartItem,String goodId){
        User user = (User) session.getAttribute("user");
        if(user!=null){
            String username = user.getUsername();
            cartItem.setGood(goodsService.getGoodsById(Integer.parseInt(goodId)));
            cartItem.setUsername(username);
            //System.out.println(cartItem);
            cartItemService.addCartItem(cartItem);
            return "look_goods";
        }else {
            return "redirect:index";
        }
    }

    //返回一个User实体
    @ResponseBody
    @RequestMapping("/getUserByUserName")
    public User getUserByUserName(String name){
        return userService.getUserByUsername(name);
    }

    //添加一个零售商的页面跳转
    @RequestMapping(value = "/admin/managerSeller/addSeller",method = RequestMethod.GET)
    public String addSellerPage(){
        System.out.println("路径映射：/admin/managerSeller/addSeller");
        return "admin/addSeller";
    }

    //添加一个零售的实际操作
    @RequestMapping(value = "/admin/managerSeller/addSeller",method = RequestMethod.POST)
    public String addSeller(User user){
        System.out.println("添加用户操作:"+user);
        userService.addSeller(user);
        return "redirect:/admin/managerSeller";
    }

    //获取零售商的接口
    @ResponseBody//为了填充模态框
    @RequestMapping(value="/admin/getSellerForModal",method = RequestMethod.GET)
    public User getUserForModal(@RequestParam(value = "username") String username){
        User user = userService.getUserByUsername(username);
        //返回到用户的页面
        return user;
    }

    @RequestMapping(value="/admin/updateSeller",method = RequestMethod.POST)
    public String adminUpdateSeller(HttpServletRequest request,User user, MultipartFile file,int page){
        System.out.println("模态框中的用户详细信息"+user);
        System.out.println("文件的名字："+file.getName());
        System.out.println("文件是否为空："+file.isEmpty());
        System.out.println("当前的页码是："+page);

        //如果有上传图片
        if(!file.isEmpty()){
            String path = request.getRealPath("/static/images/users");
            File file1 = new File(path,user.getUsername());
            try {
                file.transferTo(file1);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        //处理管理员零售商信息的更新
        userService.update(user);

        return "redirect:/admin/managerSeller?page="+page;
    }

    //禁用一个用户
    @RequestMapping(value = "/admin/managerSeller/forbiddenSeller")
    public String forbiddenSeller(@RequestParam("username") String username,int page){
        //更新一个字段
        userService.forbiddenUserStatus(username);
        return "redirect:/admin/managerSeller?page="+page;
    }

    //启用一个用户
    @RequestMapping("/admin/managerSeller/enabledSeller")
    public String enabledSeller(String username,int page){
        //更新一个字段
        userService.enabledUserStatus(username);
        return "redirect:/admin/managerSeller?page="+page;
    }

    //零售商填写意见,默认发送给admin管理员
    @RequestMapping(value="sendMessage",method = RequestMethod.POST)
    public String sendMessage(Message message,HttpSession session,@RequestParam(required = false)String to){
        System.out.println(message);
        User user = (User) session.getAttribute("user");
        String username = user.getUsername();
        message.setFrom(username);
        if(user.getRole().getRoleId()!=0){
            message.setTo("admin");
        }else {
            message.setTo(to);
        }
        messageService.SellerSendMessageToAdmin(message);

        return "redirect:lookAdvice";
    }

    //标识普通用户读取信息
    @ResponseBody
    @RequestMapping(value = "/markAlreadyRead")
    public void markAlreadyRead(String id,String role){
        messageService.markUserAlreadyRead(id,role);
    }


}
