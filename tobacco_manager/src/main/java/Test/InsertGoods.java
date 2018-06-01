package Test;

import dao.GoodsDao;
import entity.Good;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Random;

/**
 * Created by Administrator on 2017/12/8.
 */
public class InsertGoods {
    public static void main(String[] ars){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("spring.xml");
        System.out.println(applicationContext);
        GoodsDao goodsDao = applicationContext.getBean(GoodsDao.class);
       for(int i=0;i<100;i++){
           Good good  = new Good();
           String name = "商品"+i;
           int stock=new Random().nextInt(100);
           int maxPrice=new Random().nextInt(100)+20;
           int minPrice = maxPrice-10;
           good.setGoodName(name);
           good.setStock(stock);
           good.setMaxPrice((double) maxPrice);
           good.setMinPrice((double) minPrice);
           good.setDescription("这是商品"+i+"的描述");
           //good.setCost((double) minPrice+5);

           goodsDao.addOne(good);
       }
    }

}
