package service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.MyException;
import common.MyUtils;
import dao.AddressDao;
import dao.CartDao;
import dao.ShopDao;
import dao.UserDao;
import entity.Address;
import entity.Shop;
import entity.User;
import entity.vo.Cart;
import entity.vo.UserKey;
import service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private AddressDao adDao;
	@Autowired
	private CartDao cartDao;
	@Autowired
	private ShopDao shopDao;
	@Override
	public User login(String id,String password) throws MyException{
		MyUtils.ifBlank("账户不能为空", id);
		MyUtils.ifBlank("密码不能为空", password);
		User user;
		user = userDao.selectOne(id);
		if(user==null){
			throw new MyException("用户 "+id+" 不存在");
		}	
		if(user.getState()!=null){
			if (user.getState().equals("禁用")) {
				throw new MyException("用户 " + id + " 非法");
			} 
		}
		if(user.getPassword().equals(password)){
			return user;
		}else{
			throw new MyException("密码不正确");
		}
		
		
	}

	@Override
	public void add(User user,String...args) throws MyException {
		//验证参数
		MyUtils.ifBlank("账户不能为空", user.getId());
		MyUtils.ifBlank("昵称不能为空", user.getName());
		MyUtils.ifBlank("密码不能为空", user.getPassword());
		MyUtils.ifBlankInt("年龄不能为空", user.getAge());
		MyUtils.ifBlank("邮箱不能为空", user.getEmail());
		MyUtils.ifBlank("性别不能为空", user.getSex());
		//校验密码长度
		if(user.getPassword().length()<8){
			throw new MyException("密码长度必须大于等于8位");
		}
		if(user.getAge()<=0){
			throw new MyException("年龄必须要大于0！");
		}
		//验证密码
		for(int i=0;i<args.length;i++){
			if(!args[0].equals(user.getPassword())){
				throw new MyException("两次输入的密码不一样");
			}
		}
		//账户是否存在
		User repeatUser = userDao.selectOne(user.getId());
		if(repeatUser!=null){
			throw new MyException("账号已经存在");
		}
		userDao.add(user);
	}
	
	@Override//验证用户是否开设过店铺
	public boolean validateIfShop(String id){
		User user = userDao.selectOne(id);
		if(user.getShop_id()==null){
			return false;
		}
		
		return true;
	}

	@Override
	public Shop getShop(String id) throws Exception {
		return userDao.getShop(id);
	}

	@Override
	public User getOne(String id) {
		return userDao.selectOne(id);
	}

	@Override
	public void updateUser(User user) {
		userDao.update(user);
	}

	@Override
	public void updatePassword(String id, String password) {
		userDao.updatePassword(id, password);
	}

	@Override
	public void addAddress(Address address) {
		adDao.add(address);
		
	}

	@Override
	public void updateAddress(Address address) {
		adDao.update(address);
	}

	@Override
	public void deleAddress(Integer id) {
		adDao.delete(id);
	}

	@Override
	public List<Address> getUserAddress(String user_id) {
		return adDao.selectList(user_id);
	}

	@Override
	public User getUserByShopId(Integer shop_id) {
		return userDao.getUserByShopId(shop_id);
	}

	@Override
	public Address getOneUserAddressById(Integer id) {
		return adDao.selectOne(id);
	}

	@Override
	public void addCart(Cart cart) {
		cartDao.add(cart);
	}

	@Override
	public void deleteCart(Integer id) {
		cartDao.delete(id);		
	}

	@Override
	public void update(Cart cart) {
		cartDao.update(cart);
	}

	@Override
	public Cart getOne(Integer id) {
		
		return cartDao.getOne(id);
	}

	@Override
	public List<Cart> getCartList(String user_id) {
		return cartDao.getCartList(user_id);
	}

	@Override
	public String getUserIdByShopId(int shop_id) {
		return userDao.getUserIdByShopId(shop_id);
	}

	@Override
	public void addUserKey(String user_id, String key) {
		userDao.addUserKey(user_id, key);
	}

	@Override
	public List<UserKey> getUserKeys(String user_id) {
		return userDao.getUserKeys(user_id);
	}

	@Override
	public List<User> getUserByInputUserId(String user_id) {
		return userDao.getUserByInputUserId(user_id);
	}

	@Override
	public void setShopIdNull(String user_id) {
		userDao.setShopIdNull(user_id);
	}

	
	
	
	
}
