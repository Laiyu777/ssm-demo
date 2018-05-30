package dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import entity.Order;
import entity.vo.OrderDetail;

public interface OrderDao {
	void add(Order order);
	void delete(Integer id);
	Order selectOne(Integer id);
	List<Order> selectList(String user_id);
	void updateOrder(Order order); 
	
	@Select("select * from `order` where sellerid=#{user_id}")
	List<Order> selectListSeller(String seller_id);
	
	//添加到order_detail表
	@Insert("insert into order_detail(order_id,book_id,count) values(#{order_id},#{book_id},#{count}) ")
	void addOrderDetail(@Param("order_id")Integer order_id,@Param("book_id")Integer book_id,@Param("count")int count);

	//得到订单总价
//	@Select("select sum(amount) from order_detail where order_id=#{order_id}")
//	double getTotal(Integer order_id);
	//根据order_id和book_id在order_detail中得到购买的图书数量
	@Select("select count from order_detail where order_id=#{order_id} and book_id=#{book_id}")
	int getCount(@Param("order_id")int order_id,@Param("book_id")int book_id);

	@Select("select * from order_detail where order_id=#{order_id}")
	List<OrderDetail> getOrderDetailByOrderId(Integer order_id);
	
	@Update("update `order` set amount=#{amount} where id=#{id}")
	void updateOrderAmount(Order order);
	

	List<Integer> getBookIdIfUserBuy(String user_id);
	
	@Select("select * from `order`")
	List<Order> showAll();
	
	@Select("select * from `order` where id like concat('%',#{key},'%')")
	List<Order> selectOrderByKeyUserId(String key);
	
	@Delete("delete from order_detail where order_id=#{id}")
	void deleteDetailByOrderId(Integer id);
	
	@Delete("delete from order_detail where book_id=#{id}")
	void deleteDetailByBookId(Integer id);
	
	@Select("select id from `order` where id in (select order_id  from order_detail where book_id=#{id})  ")
	List<Integer> getOrderIdListByBookId(Integer id);
	
	@Select("select book_id from order_detail where book_id=#{id}")
	List<Integer> getBookIdListInOrderDetail(Integer id);
	
	@Select("select * from order_detail ")
	List<OrderDetail> getAllOrderDetail();
	
	@Select("select * from `order` where sellerid=#{seller_id}")
	List<Order> getOrderBySellerId(String user_id);
	
	@Select("select * from order_detail where order_id in (select id from `order` where sellerid=#{user_id} and state='订单完成')")
	List<OrderDetail> getShopOrderDetail(String user_id);
	
	@Select("select * from `order` where sellerid=#{seller_id} and state='订单完成'")
	List<Order> getCompleteOrderBySellId(String user_id);
	
	@Select("SELECT * from `order` where id in (select order_id from `order_detail` where book_id in (select id from book where name like concat('%',#{key},'%')))")
	List<Order> serchOrderByBookName(String key);
}
