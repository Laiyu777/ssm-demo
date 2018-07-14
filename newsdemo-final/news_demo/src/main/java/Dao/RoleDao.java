package Dao;

import Entity.Role;
import org.apache.ibatis.annotations.Param;

/**
 * Created by Administrator on 2018/5/30.
 */
public interface RoleDao {
    Role getRoleById(@Param("role_id") Integer id);

    int addRole(Role role);

    int updateRole(Role role);

    int deleteRoleById(@Param("role_id")Integer id);
}
