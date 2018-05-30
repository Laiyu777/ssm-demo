package dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import entity.Admin;
import entity.User;

public interface AdminDao {
	
   @Select("select * from admin where id=#{id} and password=#{password}")
   Admin login(@Param("id")String id,@Param("password")String password);
   
   @Select("select * from user")
   List<User> showAllUser();
   
   @Delete("update user set state='½ûÓÃ' where id=#{id}")
   void delete(String id);
@Update("update user set state=null where id=#{id}")
void cancelstop(String id);
}
