package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.OrderDao;
import entity.Order;
import entity.vo.OrderDetail;
import service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderDao odao;
	@Override
	public void add(Order order) {
		odao.add(order);
	}

	@Override
	public void delete(Integer id) {
		odao.delete(id);
	}

	@Override
	public Order selectOne(Integer id) {
		return odao.selectOne(id);
	}

	@Override
	public List<Order> selectList(String user_id) {
		return odao.selectList(user_id);
	}

	@Override
	public void updateOrder(Order order) {
		odao.updateOrder(order);
	}

	@Override
	public void addOrderDetail(Integer order_id, Integer book_id,int count) {
		odao.addOrderDetail(order_id, book_id,count);
		
	}

//	@Override
//	public double getTotal(Integer order_id) {
//		
//		return odao.getTotal(order_id);
//	}

	@Override
	public int getCount(int order_id, int book_id) {
		return odao.getCount(order_id, book_id);
	}

	@Override
	public List<Order> selectListSeller(String seller_id) {
		return odao.selectListSeller(seller_id);
	}

	@Override
	public List<OrderDetail> getOrderDetailByOrderId(Integer order_id) {
		
		return  odao.getOrderDetailByOrderId(order_id);
	}

	@Override
	public void updateOrderAmount(Order order) {
		odao.updateOrderAmount(order);
	}



	
	
	

}
