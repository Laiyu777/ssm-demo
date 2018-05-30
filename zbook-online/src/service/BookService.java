package service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import entity.Book;
import entity.vo.BookComment;

public interface BookService {
	//添加图书
	void addBook(Book book);
	//显示指定店铺发布的图书
	List<Book> selectByShopID(Integer shop_id);
	//更新图书
	void updateBook(Book book);
	//根据id删除图书
	void deleteBook(Integer id);
	//根据id获取一个图书
	Book getOne(Integer id);
	//获取全部图书
	List<Book> getAll();
	
	//根据订单获取图书id的集合
	List<Integer> getBookIdList(Integer order_id);
	
	//更新折扣价格
	void discountPrice(int id,double price2);
	
	List<Book> getKillBooks();
	List<Book> getCommonBooks();
	void cancelKill(Integer book_id);
	List<Book> search(String bookname);
	void addBookComment(String user_id,Integer book_id,String comment);
	
	List<BookComment> getCommentByBookID(Integer id);
	
	void addClick(Integer id);
	
	void bookdown(Integer id);
	
	void bookup(int id);
	List<Book> getBookClick();
	List<Book> getBookBySaleCount();
	List<Book> getKillBooksInShop(Integer id);
	List<Book> getBooksInShopByKey(Integer id, String key);
	List<Book> getBookByKind(String kind);
	List<String> getBookNameList();
	
	
}
