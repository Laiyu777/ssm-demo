package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BookDao;
import entity.Book;
import entity.vo.BookComment;
import service.BookService;

@Service
public class BookServiceImpl implements BookService{
	
	@Autowired
	private BookDao dao;
	
	//添加图书
	@Override
	public void addBook(Book book) {
		dao.addBook(book);
	}
	//根据店铺来获取图书列表
	@Override
	public List<Book> selectByShopID(Integer shop_id) {
		return dao.selectByShopID(shop_id);
	}
	@Override
	public void updateBook(Book book) {
		dao.updateBook(book);
	}
	@Override
	public void deleteBook(Integer id) {
		dao.deleteBook(id);
	}
	@Override
	public Book getOne(Integer id) {
		return dao.selectOne(id);
	}
	@Override
	public List<Book> getAll() {
		return dao.selectAll();
	}
	@Override
	public List<Integer> getBookIdList(Integer order_id) {
		return dao.getListBookId(order_id);
	}
	@Override
	public void discountPrice(int id, double price2) {
		dao.discountPrice(id, price2);
	}
	@Override
	public List<Book> getKillBooks() {
		return dao.getKillBooks();
	}
	@Override
	public List<Book> getCommonBooks() {
		return dao.getCommonBooks();
	}
	@Override
	public void cancelKill(Integer book_id) {
		dao.cancelKill(book_id);
	}
	@Override
	public List<Book> search(String bookname) {
		
		return dao.search(bookname);
	}
	@Override
	public void addBookComment(String user_id, Integer book_id, String comment) {
		 dao.addBookComment(user_id, book_id, comment);
	}
	@Override
	public List<BookComment> getCommentByBookID(Integer id) {
		
		return dao.getCommentByBookID(id);
	}
	@Override
	public void addClick(Integer id) {
		dao.addClick(id);
	}
	@Override
	public void bookdown(Integer id) {
		dao.bookdown(id);
	}
	@Override
	public void bookup(int id) {
		dao.bookup(id);
	}
	@Override
	public List<Book> getBookClick() {
		return dao.getBookByClick();
	}
	@Override
	public List<Book> getBookBySaleCount() {
		return dao.getRankBook();
	}
	@Override
	public List<Book> getKillBooksInShop(Integer id) {
		return dao.getKillBooksInShop(id);
	}
	@Override
	public List<Book> getBooksInShopByKey(Integer id, String key) {
		return dao.getBooksInShopByKey(id,key);
	}
	@Override
	public List<Book> getBookByKind(String kind) {
		return dao.getBookByKind(kind);
	}
	@Override
	public List<String> getBookNameList() {
		return dao.getBookNameList();
	}
	
	
}
