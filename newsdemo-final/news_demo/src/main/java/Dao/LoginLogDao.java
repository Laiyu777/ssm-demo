package Dao;

import Entity.LoginLog;

import java.util.List;

/**
 * Created by Administrator on 2018/5/31.
 */
public interface LoginLogDao {
    int insertOneRecord(LoginLog loginLog);

    List<LoginLog> getLoginLogsByUsername(String username);
}
