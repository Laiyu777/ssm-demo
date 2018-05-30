package test;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import dao.BookDao;
import entity.Book;
import entity.vo.BookHelp;

public class testBean {
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		ApplicationContext ac=new ClassPathXmlApplicationContext("xml/spring-context.xml");
		BookDao bookdao = ac.getBean(BookDao.class);
		PageHelper.startPage(1,9);
		List<Book> list = bookdao.selectByShopID(39);
		PageInfo<Book> page=new PageInfo<>(list,15);
		System.out.println("pagesNum:"+page.getPageNum());
		System.out.println("pages:"+page.getPages());
		System.out.println("pageSize:"+page.getPageSize());
		System.out.println(page.getTotal());
	}

	private static void testOrderDao() {
//		ApplicationContext context=new ClassPathXmlApplicationContext("xml/spring-context.xml");
//		OrderDao dao = context.getBean(OrderDao.class);
//		System.out.println(dao.getTotal(23));
	}
	
	private static void testCheckBookHelpList(){
		List<BookHelp> list=new ArrayList<>();
		Book book1=new Book();
		book1.setId(1);
		BookHelp b1=new BookHelp();
		b1.setBook(book1);
		list.add(b1);
		
		Book book2=new Book();
		book2.setId(2);
		BookHelp b2=new BookHelp();
		b2.setBook(book2);
		list.add(b2);
		
		System.out.println(list);
		
	
		
		BookHelp b3=new BookHelp();
		Book book3=new Book();
		book3.setId(3);
		b3.setBook(book3);
		
		for(BookHelp bookHelp:list){
			
		}
	}


}
