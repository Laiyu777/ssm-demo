package dao;

import entity.CartItem;
import org.apache.ibatis.annotations.Param;


import java.util.List;

/**
 * Created by Administrator on 2017/12/11.
 */
public interface CartItemDao extends BaseDao<CartItem> {
    List<CartItem> getCartByUsername(String username);

    int deleteByUsernameAndGoodId(@Param("username") String username, @Param("goodId") Integer goodId);
}
