package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import entity.Shop;
import entity.User;
import entity.vo.UserKey;

public interface UserDao {
	User selectOne(String id);
	List<User> selectList(String name);
	void update(User user);
	void delete(String id);
	void add(User user);
	void updateIfShop(@Param("user_id")String user_id,
						@Param("shop_id")Integer shop_id);
	//返回用户开设的店铺
	Shop getShop(String id);
	
	//修改密码
	@Update("update user set password=#{password} where id=#{id}")
	void updatePassword(@Param("id")String id,@Param("password")String password);
	//根据店铺id返回一个user 一个用户开一个店铺
	@Select("select * from user where shop_id=#{shop_id} ")
	User getUserByShopId(Integer shop_id);
	//在shop表根据shop_id获取user_id
	@Select("select user_id from shop where id=#{shop_id}")
	String getUserIdByShopId(int shop_id);
	
	@Insert("insert into userkey(user_id,`user_key`) values(#{user_id},#{user_key})")
	void addUserKey(@Param("user_id")String user_id,@Param("user_key")String key);
	
	List<UserKey> getUserKeys(String user_id);
	
	@Select("select * from user where id like concat('%',#{user_id},'%') ")
	List<User> getUserByInputUserId(String user_id);
	
	@Update("update user set shop_id=NULL where id=#{user_id}")
	void setShopIdNull(String user_id);
}
