package dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import entity.Shop;

public interface ShopDao {
	//用户开设店铺，即往数据库中添加店铺
	Shop add(@Param("user_id")String user_id,
			@Param("name")String name,
			@Param("description")String description);
	//修改店铺信息
	Shop update(Shop shop);
	Shop selectByUser(@Param("user_id")String user_id);
	Shop selectById(@Param("id")Integer id);
	
	@Select("select shop_id from book where id=#{book_id}")
	int  getShopIdByBookId(Integer book_id);
	@Select("select * from shop")
	List<Shop> showAll();
	@Select("select * from shop where name like concat('%',#{name},'%')")
	List<Shop> getShopsByName(String name);
	@Delete("delete from shop where id=#{id}")
	void delete(Integer id);
	@Update("update shop set shopstate=1 where id = #{id}")
	void stopShop(Integer id);
	@Update("update shop set shopstate=0 where id = #{id}")
	void regainShop(Integer id);
	
	
	
}
