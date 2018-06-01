package controller;

import com.github.pagehelper.PageInfo;
import com.sun.org.apache.xpath.internal.operations.Or;
import com.sun.xml.internal.ws.server.sei.SEIInvokerTube;
import entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/7.
 */
@Controller
public class PageController {
    @Autowired
    private UserService userService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private CartItemService cartItemService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private SituationService situationService;
    @Autowired
    private MessageService messageService;
    //跳转到用户主页
    @RequestMapping("/index")
    public String index(HttpSession session){
        Object o  = session.getAttribute("user");
        if(o==null){
            return "redirect:/login.jsp";
        }
        return "index";
    }

     //跳转到修改密码界面
    @RequestMapping("/password")
    public String password(HttpSession session){
        Object o  = session.getAttribute("user");
        if(o==null){
            return "redirect:login.jsp";
        }
        return "password";
    }

    //跳转到管理零售商界面
    @RequestMapping("/admin/managerSeller")
    public String managerSeller(HttpSession session,
                                HttpServletRequest request,
                                @RequestParam(required = false,defaultValue = "1") int pageNum,
                                @RequestParam(required = false,defaultValue = "10")int pageSize,
                                Map<String,String> conditions){
        System.out.println("查询零售商的条件conditions的map是：");
        //做验证是否是管理员
        User user  = (User)session.getAttribute("user");
        if(user!=null&&user.getRole().getRoleId()==0){
            //显示零售商列表,基于分页的实现
            request.setAttribute("pageInfo",userService.getUsersExcludeAdmin(pageNum,pageSize,conditions));
            return "admin/manage_seller";
        }else{
            return "redirect:/index";
        }
    }

    //跳转到管理员商品管理界面
    @RequestMapping({"/admin/managerGoods"})
    public String managerGoods(HttpSession session,
                               @RequestParam(required = false,defaultValue = "1") int page,
                               @RequestParam(required = false,defaultValue = "15")int row,
                               Map<String,String> conditions){
        System.out.println("conditions的值是："+conditions);
        User user  = (User)session.getAttribute("user");
        if(user!=null&&user.getRole().getRoleId()==0){
            PageInfo pageInfo = goodsService.getGoodsByPage(page,row,conditions);
            session.setAttribute("pageInfo",pageInfo);
            return "admin/manage_goods";
        }else {
            return "redirect:/index";
        }
    }

    //跳转到普通用户货源查询界面
    @RequestMapping("/lookGoods")
    public String lookGoods(HttpSession session,HttpServletRequest request,
                            @RequestParam(required = false,defaultValue = "1") int page,
                            @RequestParam(required = false,defaultValue = "15")int row,
                            @RequestParam(required = false) Map<String,String> map){
        User user = (User) session.getAttribute("user");
        System.out.println("页面跳转的map："+map+"map对象类型是："+map.getClass().getName());
        PageInfo pageInfo =null ;
        if(user!=null){
            for (String s : map.keySet()){
                //如果是关键字查询
                if(s.equals("keyword")&&!map.get("keyword").equals("")){
                    System.out.println("进入关键字查询===》"+s+"=="+map.get(s));
                    request.setAttribute("keyword",map.get(s));
                }else if((s.equals("orderName")&&!map.get("orderName").equals(""))){//如果是排序查询
                    System.out.println("进入排序查询");
                    request.setAttribute("orderName",map.get(s));
                }else if (s.equals("order")&&!map.get("order").equals("")){//如果是排序查询
                    System.out.println("进入排序查询");
                    request.setAttribute("order",map.get(s));
                }
            }
             pageInfo = goodsService.getGoodsByPage(page,row,map);
            //按照成本排序
            if(map.get("orderName")!=null&&map.get("order")!=null){
                if(map.get("orderName").equals("cost")&&map.containsValue("DESC")){//成本降序排序
                    System.out.println("进入成本降序排序");
                    request.setAttribute("order","DESC");
                    request.setAttribute("orderName","cost");
                    goodsService.sortByCostDesc(pageInfo.getList(),user.getRole());
                }else if(map.get("orderName").equals("cost")&&map.containsValue("ASC")){//成本升序排序
                    System.out.println("进入成本升序排序");
                    request.setAttribute("order","ASC");
                    request.setAttribute("orderName","cost");
                    goodsService.sortByCostASC(pageInfo.getList(),user.getRole());
                }

            }
            System.out.println("数据长度是："+pageInfo.getList().size());
            session.setAttribute("pageInfo",pageInfo);
            return "look_goods";
        }else {
            return "redirect:/index";
        }
    }

    //跳转到购物车界面
    @RequestMapping("/cartPage")
    public String cartPage(HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user!=null){
            String username = user.getUsername();
            List<CartItem> cartItemList = cartItemService.getCartItemList(username);
            session.setAttribute("cartItemList",cartItemList);
            return "cart_item";
        }else {
            return "redirect:/index";
        }
    }

    //跳转到用户订单界面
    @RequestMapping("/orderPage")
    public String orderPage(HttpSession session,HttpServletRequest request,
                            @RequestParam(value = "page",defaultValue = "1",required = false)int page,
                            @RequestParam(value = "size",defaultValue = "15",required = false)int size,
                            @RequestParam Map<String,String> map){
        System.out.println("orderPage方法中的map："+map);
        //获取这个用户的orderList
        User user = (User) session.getAttribute("user");
        if(user!=null){
            for(String key:map.keySet()){
                //如果是关键字查询
                if(key.equals("keyword")&&!map.get(key).equals("")){
                    System.out.println("进入关键字查询...");
                   request.setAttribute("keyword",map.get(key));
                }else if(key.equals("status")&&!map.get(key).equals("")){//如果是按状态查询
                    System.out.println("进入状态查询...");
                    request.setAttribute("status",map.get(key));
                }else if(key.equals("startDay")&&map.get(key).equals("")){
                    System.out.println("进入日期查询");
                    request.setAttribute("startDay",map.get(key));
                }else if(key.equals("endDay")&&map.get(key).equals("")){
                    System.out.println("进入日期查询");
                    request.setAttribute("endDay",map.get(key));
                }
            }
            map.put("userName",user.getUsername());
            PageInfo<Order> pageInfo = orderService.getAllOrder(page,size,map);
            session.setAttribute("pageInfo",pageInfo);
            return "order_list";
        }
        return "redirect:index";
    }


    //跳转到管理员订单管理界面
    @RequestMapping("/admin/managerOrders")
    public String managerOrders(HttpSession session,
                                @RequestParam(value = "page",defaultValue = "1",required = false)int page,
                                @RequestParam(value = "size",defaultValue = "15",required = false)int size,
                                @RequestParam Map<String,String> map){
        User user = (User) session.getAttribute("user");
        if(user==null||user.getRole().getRoleId()!=0){
            return "redirect:/login.jsp";
        }
        //填充订单信息，管理员显示的所有用户的订单
        PageInfo<Order> pageInfo = orderService.getAllOrder(page,size,map);
        for (Order order : pageInfo.getList()){
            order.setTotal();
        }
        System.out.println(pageInfo);
        session.setAttribute("pageInfo",pageInfo);
        return "admin/manage_orders";
    }

    //跳转到登录日志界面
    @RequestMapping("/loginlog")
    public String gotoLoginLog(String username,
                               HttpServletRequest request,
                               @RequestParam(required = false,defaultValue = "1") int pageNum){
        PageInfo<LoginLog> pageInfo = userService.getLoginLogs(username,pageNum);
        for(LoginLog loginLog:pageInfo.getList()){
            System.out.println(loginLog);
        }
        request.setAttribute("pageInfo",pageInfo);
        return "loginlog";
    }

    //跳转到上传商品销售情况的界面
    @RequestMapping(value="/uploadSituation")
    public String gotoUploadSellSituationPage(HttpServletRequest request,HttpSession session){
        User user = (User) session.getAttribute("user");
        String username = user.getUsername();
        Situation situation= situationService.getSituationToday(username);
       if(situation!=null){
           request.setAttribute("lastTime",situation.getCreateTime());
           request.setAttribute("details",situation.getSituationDetails());
       }
        return "upload_situation";
    }

    //跳转到look_situation.jsp页面
    @RequestMapping(value = "/lookSituation")
    public String gotoLookSellSituationPage(){
        return "look_situation";
    }

    //跳转到填写意见的页面
    @RequestMapping(value = "fillAdvice")
    public String gotoFillAdvice(HttpSession session){
        return "fill_advice";
    }

    //跳转到收到信息的列表
    @RequestMapping(value="lookAdvice")
    public String gotoLookAdvicePage(HttpSession session,HttpServletRequest request,
                                     @RequestParam(required = false,defaultValue = "1") int pageNum,
                                     @RequestParam(required = false,defaultValue = "10") int pageSize){
        User user = (User) session.getAttribute("user");
        String username = user.getUsername();
        PageInfo<Message> pageInfo = messageService.selectMessage(username,pageNum,pageSize);//只要where to = username就可以了
        request.setAttribute("pageInfo",pageInfo);

        return "look_advice";
    }

}
