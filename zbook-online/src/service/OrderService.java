package service;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import entity.Order;
import entity.vo.OrderDetail;

public interface OrderService {
	void add(Order order);
	void delete(Integer id);
	Order selectOne(Integer id);
	List<Order> selectList(String user_id);
	void updateOrder(Order order); 
	
	//添加到order_detail表中
	//void addOrderDetail(Integer order_id,Integer book_id,double amount,int count);
	//得到订单总价
//	double getTotal(Integer order_id);
	//根据order_id和book_id在order_detail中得到购买的图书数量
		int getCount(int order_id,int book_id);
		//得到店铺订单
		List<Order> selectListSeller(String seller_id);
		void addOrderDetail(Integer order_id, Integer book_id, int count);
		List<OrderDetail> getOrderDetailByOrderId(Integer order_id);
		void updateOrderAmount(Order order);
}
