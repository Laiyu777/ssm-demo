package Dao;

import Entity.Department;
import org.apache.ibatis.annotations.Param;

/**
 * Created by Administrator on 2018/5/30.
 */
public interface DepartmentDao {
    Department getDepartmentById(@Param("department_id") Integer id);

    int addDepartment(Department department);

    int updateDepartment(Department department);

    int deleteDepartmentById(@Param("department_id") Integer id);
}
