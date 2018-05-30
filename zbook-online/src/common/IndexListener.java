package common;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import dao.BookDao;
import dao.UserDao;
import entity.Book;
import entity.User;

@WebListener
public class IndexListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext sc=sce.getServletContext();
		ApplicationContext spring = new ClassPathXmlApplicationContext("xml/spring-context.xml");
		BookDao bookDao = spring.getBean(BookDao.class);
		List<Book> list = bookDao.selectAll();//根据最新发布的
		sc.setAttribute("indexbooks", list);
		List<Book> rankbook = bookDao.getRankBook();
		sc.setAttribute("rankbook", rankbook);
		
		//booklist.jsp右边的排行榜信息
		List<Book> salelist = bookDao.getRankBook();
		sc.setAttribute("rightsale", salelist);
		
		List<Book> clicklist = bookDao.getBookByClick();
		sc.setAttribute("rightclick", clicklist);
	}
	

}
