package dao;

import entity.LoginLog;
import entity.User;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * Created by Administrator on 2017/12/6.
 */
public interface UserDao extends BaseDao<User>{
    User getUserByUsername(String username);

    List<User> getUsersNotIncludeAdmin();


    @Update("update `user` set status = 0 WHERE username = #{username}")
    int forbiddenUserStatus(String username);

    @Update("update `user` set status = 1 WHERE username = #{username}")
    int enabledUserStatus(String username);


    List<LoginLog> getLoinLogs(String username);

    int addLoginLog(LoginLog loginLog);
}
