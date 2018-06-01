package Test;

import dao.CartItemDao;
import dao.GoodsDao;
import dao.UserDao;
import entity.CartItem;
import entity.Good;
import entity.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

/**
 * Created by Administrator on 2017/12/11.
 */
public class TestInsertIntoCartItem {
    public static void main(String[] rags){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
//        CartItemDao dao = context.getBean(CartItemDao.class);
//        GoodsDao goodsDao = context.getBean(GoodsDao.class);
//        CartItem cartItem = new CartItem();
//        Good good = goodsDao.getById(20);
//        cartItem.setGood(good);
//        cartItem.setCount(10);
//        cartItem.setUsername("xiaohong");
//        dao.addOne(cartItem);
//        System.out.println("插入成了");

        UserDao userDao = context.getBean(UserDao.class);
        System.out.println(userDao.getUsersNotIncludeAdmin());
    }
}
