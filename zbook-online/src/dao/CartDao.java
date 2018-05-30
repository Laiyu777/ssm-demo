package dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import entity.vo.Cart;

public interface CartDao {
	@Insert("insert into cart(user_id,book_id,count) values(#{user_id},#{book_id},#{count})")
	void add(Cart cart);
	@Delete("delete from cart where id=#{id}")
	void delete(Integer id);
	@Update("update cart set count=#{count} where id=#{id}")
	void update(Cart cart);
	@Select("select * from cart where id=#{id}")
	Cart getOne(Integer id);
	@Select("select * from cart where user_id=#{id}")
	List<Cart> getCartList(String user_id);
	@Update("update cart set count=count+1 where user_id=#{user_id} and book_id=#{book_id}")
	void addcount(@Param("user_id")String user_id,@Param("book_id")Integer book_id);
	
	@Update("update cart set count=count-1 where user_id=#{user_id} and book_id=#{book_id}")
	void reducecount(@Param("user_id")String user_id,@Param("book_id")Integer book_id);

	@Select("select * from cart where user_id=#{user_id} and book_id=#{book_id}")
	Cart getOneByUserIdAndBookId(@Param("user_id")String user_id,@Param("book_id")int book_id);
	
	@Delete("delete from cart where book_id=#{bookid} and user_id=#{userid}")
	void removeCart(@Param("bookid")int bookid,@Param("userid")String userid);
	@Delete("delete from cart where book_id=#{id}")
	void deleteByBookId(Integer id);
}
