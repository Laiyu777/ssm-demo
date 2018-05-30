package service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import dao.BookDao;
import dao.CartDao;
import entity.Book;

@Controller
public class CartServiceImpl {
	@Autowired
	private CartDao cartdao;
	@Autowired
	private BookDao bookdao;
	
	public void addcount(String user_id,Integer book_id){
		Book book = bookdao.selectOne(book_id);
		
	}
}
