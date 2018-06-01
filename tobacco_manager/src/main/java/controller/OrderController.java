package controller;

import com.github.pagehelper.PageInfo;
import com.sun.org.apache.xpath.internal.operations.Or;
import entity.Good;
import entity.Order;
import entity.OrderDetail;
import entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpOutputMessage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.CartItemService;
import service.GoodsService;
import service.OrderService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Administrator on 2017/12/12.
 */
@Controller
public class OrderController {
    @Autowired
    private OrderService oderService;
    @Autowired
    private CartItemService cartItemService;
    @Autowired
    private GoodsService goodsService;
    //添加订单操作,orderDetailList是前台发送过来json数据

    @RequestMapping("/addOrder")
    public void addOrder(HttpSession session, @RequestBody List<OrderDetail> orderDetailList){
        System.out.println("添加的订单细节是："+orderDetailList);
        User user = (User) session.getAttribute("user");
        if(user!=null){
            Order order = new Order();
            order.setUsername(user.getUsername());
            oderService.addOrder(order);//数据库中设置了状态默认值：等待审核
//            System.out.println(order.getOrderId());
//            System.out.println("长度是："+orderDetailList.size());
            for (OrderDetail detail : orderDetailList){
                Good good = goodsService.getGoodsById(detail.getGood().getGoodId());
                detail.setOrderId(order.getOrderId());
                detail.setGood(good);
//                System.out.println(detail);
                oderService.addOrderDetail(detail);//order_detail表中增加条目
            //还要将购物车里对应的商品删除delete from cart where username =? and good_id=?
                cartItemService.removeItem(user.getUsername(),detail.getGood().getGoodId());
                //减少对应库存
                good.setStock(good.getStock()-detail.getCount());
                goodsService.update(good);
            }
        }
    }
    //得到某个订单里面的具体内容
    @ResponseBody
    @RequestMapping("/getOrderDetail")
    public Order getOrderDetail(int orderId){
        return oderService.getOrderById(orderId);
    }

    //管理员或者用户更新订单状态
    @ResponseBody
    @RequestMapping(value = {"updateOrderStatus","admin/updateOrderStatus"},produces = "text/plain;charset=utf-8")
    public String updateOderStatus(Order order,HttpSession session){
        System.out.println(order);
        //更新对象
        oderService.updateOrder(order);

        return "修改成功";
    }

    //处理取消订单的表单，管理员和用户都是用这个方法，所以要确定返回页面的不一样
    @RequestMapping("/cancelOrder")
    public String cancelOrder(Order order, HttpServletRequest request){
        System.out.println("order:"+order);
        oderService.updateOrder(order);
        String referer = request.getHeader("Referer");
        //System.out.println("referer:"+referer);
        if ("http://localhost:8080/tobacco_manager/admin/managerOrders".equals(referer)){
            return "redirect:/admin/managerOrders";
        }
        return "redirect:/orderPage";
    }

    //处理确认收货的按钮
    @ResponseBody
    @RequestMapping(value = "/confirmReceipt",produces = "text/plain;charset=utf-8")
    public String confirmReceipt(Order order){
        System.out.println(order);
        order.setStatus("订单已完成");
        oderService.updateOrder(order);
        return "确认收货成功";
    }
}
