package Dao;

import Entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2018/5/30.
 */
public interface UserDao {
    User getUserByUsername(String username);
    int addOneUser(User user);

    int updateUser(User user);

    int updateUserPassword(@Param("username") String username, @Param("password") String newPassword);

    List<User> selectUserNotAdmin();

    int adminAddUser(User user);
}
