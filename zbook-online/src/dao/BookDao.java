package dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import entity.Book;
import entity.vo.BookComment;

public interface BookDao {
	List<Book> selectAll(); 
	void addBook(Book book);
	List<Book> selectByShopID(Integer shop_id);
	void updateBook(Book book);
	void deleteBook(Integer id);
	@Select("select * from book where id=#{id}")
	Book selectOne(Integer id);
	@Select("select book_id from order_detail where order_id=#{order_id}")
	List<Integer> getListBookId(Integer order_id);
	
	void discountPrice(@Param("id")int id,@Param("price2")double price2);
	
	@Select("select * from book where ifkill=1")
	List<Book> getKillBooks();
	@Select("select * from book where ifkill=0")
	List<Book> getCommonBooks();
	
	@Update("update book set price2=0,ifkill=0 where id=#{book_id}")
	void cancelKill(Integer book_id);
	
	List<Book> search(String bookname);
	
	@Insert("insert into bookcomment(user_id,book_id,comment) values(#{user_id},#{book_id},#{comment})")
	void addBookComment(@Param("user_id")String user_id,@Param("book_id")Integer book_id,@Param("comment")String comment);
	
	@Select("select * from bookcomment where book_id=#{book_id}")
	List<BookComment> getCommentByBookID(Integer id);
	
	@Delete("delete from bookcomment where book_id=#{id}")
	void deleteBookCommentByBookId(Integer id);
	
	@Update("update book set clickcount=clickcount+1 where id=#{id}")
	void addClick(Integer id);
	
	@Update("update book set bookdown=1 where id=#{id}")
	void bookdown(Integer id);
	
	@Update("update book set bookdown=0 where id=#{id}")
	void bookup(int id);
	
	@Select("select * from book order by salecount desc")
	List<Book> getRankBook();
	
	@Select("select * from book order by clickcount desc")
	List<Book> getBookByClick();
	
	@Select("select * from book where ifkill=1 and shop_id=#{id}")
	List<Book> getKillBooksInShop(Integer id);
	
	@Select("select * from book where shop_id=#{id} and `name` like concat('%',#{key},'%')")
	List<Book> getBooksInShopByKey(@Param("id")Integer id,@Param("key")String key);
	
	@Select("select * from book where kind=#{kind}")
	List<Book> getBookByKind(String kind);
	
	@Select("select name from book")
	List<String> getBookNameList();
}
