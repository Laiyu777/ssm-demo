package service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.xpath.internal.operations.Or;
import dao.OrderDao;
import entity.Order;
import entity.OrderDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/12.
 */
@Service
public class OrderService {
    @Autowired
    private OrderDao orderDao;

    public int addOrder(Order order){
        return orderDao.addOne(order);
    }

    public int addOrderDetail(OrderDetail detail) {
        return orderDao.addOderDetail(detail);
    }

    public PageInfo<Order> getOrderByUsername(int page, int size, Map<String,String> map){
        PageHelper.startPage(page,size);
        return new PageInfo<Order>(orderDao.getByUsername(map));
    }

    public Order getOrderById(Integer orderId){
        return orderDao.getById(orderId);
    }


    public PageInfo<Order> getAllOrder(int page, int size,Map<String,String> map) {
        PageHelper.startPage(page,size);
        return new PageInfo<Order>(orderDao.getAllOrders(map));
    }

    public int updateOrder(Order order) {
        return orderDao.updateOne(order);
    }


}
