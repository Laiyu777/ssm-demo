package Dao;

import Entity.Employee;
import Entity.StayInfo;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.sql.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/6/26.
 */
public interface StayDao {
    void addEmp(Employee employee);

    @Delete("delete from emp where id = #{id}")
    void delEmp(String id);

    void addStayInfo(StayInfo stayInfo);

    List<Employee> getEmpByDeptName(String deptName);

    List<Employee> getEmpsByIds(String[] ids);

    List<StayInfo> getStayInfosBydeptName(String deptName);

    @Select("select `date` from stay where dept_name=#{deptName} order by `date` asc")
    List<Date> getDates(String deptName);

    List<StayInfo> getStayInfosByConditions(Map<String,String> conditions);

    void updateStayInfo(StayInfo stayInfo);

    void delStayInfo(String id);

    void updateEmp(Employee employee);

    List<StayInfo> getByWeek(Map<String,String> conditions);

    List<StayInfo> getByMonth(Map<String, String> conditions);
}
