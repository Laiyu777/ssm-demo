package Test;

import dao.OrderDao;
import entity.Order;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Random;

/**
 * Created by Administrator on 2017/12/16.
 */
public class InsertOrders {
    public static void main(String[] args){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        OrderDao orderDao = context.getBean(OrderDao.class);
        String[] status = new String[]{"等待审核","审核未通过","订单已取消","已审核，正在出库","订单已完成"};
        for(int i=0;i<100;i++){
            int index = new Random().nextInt(5);
            Order order =new Order();
            order.setStatus(status[index]);
            order.setUsername("admin");
            orderDao.addOne(order);
        }
    }
}
