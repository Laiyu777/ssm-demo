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
	
	//��ӵ�order_detail����
	//void addOrderDetail(Integer order_id,Integer book_id,double amount,int count);
	//�õ������ܼ�
//	double getTotal(Integer order_id);
	//����order_id��book_id��order_detail�еõ������ͼ������
		int getCount(int order_id,int book_id);
		//�õ����̶���
		List<Order> selectListSeller(String seller_id);
		void addOrderDetail(Integer order_id, Integer book_id, int count);
		List<OrderDetail> getOrderDetailByOrderId(Integer order_id);
		void updateOrderAmount(Order order);
}
