package service;

import dao.CartItemDao;
import entity.CartItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2017/12/11.
 */
@Service
public class CartItemService {
    @Autowired
    private CartItemDao cartItemDao;

    public List<CartItem> getCartItemList(String username){
        return cartItemDao.getCartByUsername(username);
    }

    public int removeItem(String username, Integer goodId) {
        return cartItemDao.deleteByUsernameAndGoodId(username,goodId);
    }

    public int addCartItem(CartItem item){
        List<CartItem> cartItemList = getCartItemList(item.getUsername());
        //判断是更新表还是新加入一条记录
        for(CartItem item1 :cartItemList){
            //如果购物车里面已经有了,更新记录
            if(item1.getGood().getGoodId().equals(item.getGood().getGoodId())){
                item1.setCount(item.getCount()+item1.getCount());
                return cartItemDao.updateOne(item1);
            }
        }
        //否则的话新加入一条记录
        return cartItemDao.addOne(item);
    }
}
