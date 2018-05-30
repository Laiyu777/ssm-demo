package service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import entity.Book;
import entity.vo.BookComment;

public interface BookService {
	//���ͼ��
	void addBook(Book book);
	//��ʾָ�����̷�����ͼ��
	List<Book> selectByShopID(Integer shop_id);
	//����ͼ��
	void updateBook(Book book);
	//����idɾ��ͼ��
	void deleteBook(Integer id);
	//����id��ȡһ��ͼ��
	Book getOne(Integer id);
	//��ȡȫ��ͼ��
	List<Book> getAll();
	
	//���ݶ�����ȡͼ��id�ļ���
	List<Integer> getBookIdList(Integer order_id);
	
	//�����ۿۼ۸�
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
