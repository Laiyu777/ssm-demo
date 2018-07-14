package Test;

import Entity.New;
import Service.NewsService;
import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Created by Administrator on 2018/6/21.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring.xml","classpath:spring-mvc.xml"})
public class NewsControllerTest {

    @Autowired
    private NewsService newsService;

    @Test
    public void  test1(){
        //List<New> newList = newsService.getNewsByMenuName("新闻中心");
        PageInfo<New> pageInfo = newsService.getNewsBySubmenuName("最新通知",1,10);
        System.out.println("获取到的新闻是："+pageInfo);
    }

    @Test
    public void test2(){
        //PageInfo<New> pageInfo = newsService.getNewsByNewsKeyword("十九大",1,10);
       // System.out.println("获取到的新闻是："+pageInfo.getSize());
    }
}
