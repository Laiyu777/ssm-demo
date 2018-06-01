package dao;

import com.sun.org.apache.xpath.internal.operations.Or;
import entity.Order;
import entity.OrderDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/7.
 */
public interface OrderDao extends BaseDao<Order>{
    List<Order> getByUsername(Map<String,String> map);

    int addOderDetail(OrderDetail detail);

    List<Order> getAllOrders(Map<String,String> map);


}
