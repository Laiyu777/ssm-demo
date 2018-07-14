package Controller;


import Aspect.Annotation.Login;
import Entity.*;
import Help.Message;
import Help.Utils;
import Service.MenuService;
import Service.NewsService;
import Service.StayService;
import Service.UserService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/5/31.
 */
@Controller
public class PageController {

    @Autowired
    private UserService userService;

    @Autowired
    private NewsService newsService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private StayService stayService;

    @RequestMapping(value={"/index"})
    public String gotoindex(HttpSession session,HttpServletRequest request,
                            @RequestParam(value="pageNum",defaultValue = "1",required = false) int pageNum,
                            @RequestParam(value="pageSize",defaultValue = "10",required = false)int pageSize){
        System.out.println("进入到index");
        //加载数据库中的菜单
        List<Menu> menuList = menuService.getAllMenus();
        session.setAttribute("menuList",menuList);
        //获取最新发布的10条
        List<New> lastNewList = newsService.getLastNewList();
        request.setAttribute("lastNewList",lastNewList);
        //最新发布的10条通知
        request.setAttribute("lastNotificationList",newsService.getNewsBySubmenuName("最新通知",pageNum,pageSize).getList());
        //6个显示在主页的内容
        request.setAttribute("list1",newsService.getNewsByMenuName("传输发射",pageNum,pageSize).getList());
        request.setAttribute("list2",newsService.getNewsBySubmenuName("部门动态",pageNum,pageSize).getList());
        request.setAttribute("list3",newsService.getNewsByMenuName("党的建设",pageNum,pageSize).getList());
        request.setAttribute("list4",newsService.getNewsByMenuName("技术管理",pageNum,pageSize).getList());
        request.setAttribute("list5",newsService.getNewsByMenuName("安全月专题",pageNum,pageSize).getList());
        request.setAttribute("list6",newsService.getNewsByMenuName("规章制度",pageNum,pageSize).getList());

        //准备今天的留守数据
        Map<String,String> conditions = new HashMap<String, String>();
        conditions.put("month",new Date(System.currentTimeMillis()).toString());
        List<StayInfo> stayInfoList = stayService.getStayInfosByConditions(conditions);
        stayService.processInfoList(stayInfoList);
        request.setAttribute("stayInfoList",stayInfoList);

        return "index";
    }

    @RequestMapping("/hello")
    public void String(){
        System.out.println("请求进来了、。。。");
    }

    //登录方法
    @ResponseBody
    @RequestMapping("/login")
    public Message login(String username, String password, HttpSession session, HttpServletRequest request){
        User user = userService.getUserByUsernameAndPassword(username,password);
        String ipAddress = request.getRemoteAddr();
        if(user==null){
            userService.recordLoginLog(username,ipAddress,"登录失败");
            return new Message(400,"用户名或者密码错误");
        }else if(user.getRole().getRoleId() == 3){
            return new Message(400,"您的账号待审核中");
        }else if(user.getRole().getRoleId()==4){
            return new Message(400,"您的账号审核未通过");
        }
        else {
            userService.recordLoginLog(username,ipAddress,"登录成功");
            session.setAttribute("user",user);
            return new Message(200,"登录成功");
        }
    }



    //表单注册提交
    @ResponseBody
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public Message registerUser(User user){
        System.out.println("得到的用户："+user);
        System.out.println("得到的model是:");
        if(userService.ifUserExist(user.getUsername())) {
            return new Message(400, "用户名已经存在");
        }
        else {
            userService.addOneUser(user);
            return new Message(200,"注册成功");
        }
    }

    //退出登陆
    //退出登录
    @RequestMapping("/loginout")
    public String loginout(HttpSession session){
        session.invalidate();
        return "redirect:/index";
    }

    @RequestMapping(value = "/newsDetail",method = RequestMethod.GET)
    public String gotoNewDeatailJsp(@RequestParam("news_id")Long id,
                                    HttpSession session,
                                    HttpServletRequest request,
                                    HttpServletResponse response,
                                    @RequestParam(value = "menuId",required = false)String menuId,
                                    @RequestParam(value = "submenuId",required = false)String submenuId){
        New _new = newsService.getNewsById(id);
        //文章查看权限的处理
        if(_new.getCheckAuth()==1&&session.getAttribute("user")==null){
            try {
                Utils.invaildRequestBox(response,"请登录后在查看该文章");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        //System.out.println("查询到的new是："+_new);
        request.setAttribute("_new",_new);
        //处理导航条 和 大标题
        //processNavigationBar(request, menuId, submenuId, _new);
        return "news/newsDetail";
    }

    @RequestMapping(value = "/newsList",method = RequestMethod.GET)
    public String gotoNewsListJsp(HttpServletRequest request,
                                  @RequestParam(value = "pageNum",defaultValue = "1",required = false)int pageNum,
                                  @RequestParam(value = "pageSize",defaultValue = "16",required = false)int pageSize,
                                  @RequestParam(value = "menuId",required = false)String menuId,
                                  @RequestParam(value = "submenuId",required = false)String submenuId){
        PageInfo<New> pageInfo = newsService.getAllNewsInIndex(menuId,submenuId,pageNum,pageSize);
        request.setAttribute("pageInfo",pageInfo);

       // New news = pageInfo.getList().get(0);
            //处理导航条 和 大标题
        processNavigationBar(request, menuId, submenuId);

        return "news/newsList";
    }


    //处理导航条 和 大标题
    private void processNavigationBar(HttpServletRequest request,
                                      @RequestParam(value = "menuId", required = false) String menuId,
                                      @RequestParam(value = "submenuId", required = false) String submenuId) {

        if(menuId == null && submenuId !=null){//显示小类的新闻列表
            String menuName = menuService.getMenuNameBySubmenuId(Integer.valueOf(submenuId));
            Integer menuId2 = menuService.getMenuIdBySubmenuId(Integer.valueOf(submenuId));
            SubMenu submenu = menuService.getSubmenById(Integer.valueOf(submenuId));
            request.setAttribute("menuName",menuName);
            request.setAttribute("submenuName",submenu.getSubmenuName());
            request.setAttribute("title",submenu.getSubmenuName());
            request.setAttribute("submenuId",submenu.getSubmenuId());
            request.setAttribute("menuId",menuId2);
        }
        if(menuId != null && submenuId ==null){//显示大类的新闻列表
            String menuName = menuService.getMenuNameById(menuId);
            request.setAttribute("menuName",menuName);
            request.setAttribute("title",menuName);
            request.setAttribute("menuId",menuId);
        }
        if(menuId == null && submenuId ==null){//显示全部的新闻列表
            request.setAttribute("menuName","最新发布");
            request.setAttribute("title","最新发布");
        }
    }



    //跳转到更多留守信息页面
    @RequestMapping(value = "/moreStay",method = RequestMethod.GET)
    public String moreStay(@RequestParam(defaultValue = "0") Integer weekOffset,
                           @RequestParam(defaultValue = "0") Integer monthOffset,
                           String show,String deptName,
                           HttpServletRequest request){

        //默认显示这个日期的本周
        request.setAttribute("weekOffsetPre",weekOffset-1);
        request.setAttribute("weekOffsetNext",weekOffset+1);
        request.setAttribute("monthOffsetPre",monthOffset+1);
        request.setAttribute("monthOffsetNext",monthOffset-1);
        request.setAttribute("stayWeekMap",stayService.getStayByWeek(weekOffset.toString()));
        //如果按月显示
        if(show!=null&&show.equals("month")){
            request.setAttribute("show","month");
            request.setAttribute("stayWeekMap",stayService.getStayByMonth(monthOffset));
        }
//        if(deptName!=null){
//            request.setAttribute("deptName",deptName);
//        }
        return "user/moreStay";
    }


    //点击主页单个部门留守信息的时候发送的请求
    @ResponseBody
    @RequestMapping(value = "/getTodayStayByDeptName",method = RequestMethod.GET)
    public List<StayInfo> getTodayStayByDeptName(String deptName){
        Date date = new Date(System.currentTimeMillis());
        Map<String,String> conditions = new HashMap<String, String>();
        conditions.put("deptName",deptName);
        conditions.put("month",date.toString());
        return stayService.getStayInfosByConditions(conditions);
    }
}
