package service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import common.MyException;
import entity.Address;
import entity.Shop;
import entity.User;
import entity.vo.Cart;
import entity.vo.UserKey;

public interface UserService {
	public User login(String id,String password) throws MyException;
	
	public void add(User user,String...args) throws MyException;

	public boolean validateIfShop(String id) throws MyException;
	
	public Shop getShop(String id)throws Exception;
	
	public User getOne(String id);
	
	public User getUserByShopId(Integer shop_id);
	
	public void updateUser(User user);
	
	public void updatePassword(String id,String password);
	
	public void addAddress(Address address);
	
	public void updateAddress(Address address);
	
	public void deleAddress(Integer id);
	
	List<Address> getUserAddress(String user_id);
	
	Address getOneUserAddressById(Integer id);

	void addCart(Cart cart);
	
	void deleteCart(Integer id);
	
	void update(Cart cart);
	
	Cart getOne(Integer id);
	
	List<Cart> getCartList(String user_id);
	
	String getUserIdByShopId(int shop_id);
	
	void addUserKey(String user_id,String key);
	
	List<UserKey> getUserKeys(String user_id);
	
	List<User> getUserByInputUserId(String user_id);
	
	void setShopIdNull(String user_id);
}
