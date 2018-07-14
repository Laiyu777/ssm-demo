package Service;

import Dao.StayDao;
import Entity.Employee;
import Entity.StayInfo;
import Help.Utils;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.*;

/**
 * Created by Administrator on 2018/6/26.
 */
@Service
public class StayService {

    @Autowired
    private StayDao stayDao;

    //添加部门员工
    public void addEmp(Employee employee){
        stayDao.addEmp(employee);
    }

    //删除部门员工
    public void delEmp(String id) {
        stayDao.delEmp(id);
    }

    //添加一条留守信息
    public void addStayInfo(StayInfo stayInfo) {
        stayDao.addStayInfo(stayInfo);
    }

    //根据部门名字得到员工
    public List<Employee> getEmpByDeptName(String deptName){
        return stayDao.getEmpByDeptName(deptName);
    }

    //根据部门名字得到留守信息
    public List<StayInfo> getStayInfosBydeptName(String deptName){
        List<StayInfo> infoList = stayDao.getStayInfosBydeptName(deptName);
        processInfoList(infoList);
        return infoList;
    }

    //根据StayInfo里的content1和content2填充dayEmps和nightEmps的list
    public void processInfoList(List<StayInfo> list){
        for (StayInfo info : list){
            String content1 = info.getContent1();
            String content2 = info.getContent2();
            if(content1!=null){
                info.setDayEmps(stayDao.getEmpsByIds(content1.split(",")));
            }
            if(content2!=null) {
                info.setNightEmps(stayDao.getEmpsByIds(content2.split(",")));
            }
        }
    }

    //根据数据的内容返回 日期数组
    public List<String> getDateStringArray(String deptName) {
        List<Date> dates =stayDao.getDates(deptName);
        List<String> result = new ArrayList<String>();
        for(int i=0;i<dates.size()-1;i++){
            Date date1 = dates.get(i);
            Date date2 = dates.get(i+1);
            Calendar c1 = Calendar.getInstance();
            c1.setTime(date1);
            Calendar c2 = Calendar.getInstance();
            c2.setTime(date2);

            Integer year1 = c1.get(Calendar.YEAR);
            Integer month1 = c1.get(Calendar.MONTH)+1;

            Integer year2 = c2.get(Calendar.YEAR);
            Integer month2 = c2.get(Calendar.MONTH)+1;


            if(year1.equals(year2)){
                if(!month1.equals(month2)){
                    if(!result.contains(year1+"年"+Utils.processMonth(month1)+"月")){
                        result.add(year1+"年"+Utils.processMonth(month1)+"月");
                    }
                    //处理最后一个(最后一次循环，可以不用新穿件monthStr)
                    if(i==dates.size()-2){
                        result.add(year2+"年"+Utils.processMonth(month2)+"月");
                    }
                    if(!result.contains(year2+"年"+Utils.processMonth(month2)+"月")){
                        result.add(year2+"年"+Utils.processMonth(month2)+"月");
                    }
                }
            }else {
                if(!result.contains(year1+"年"+Utils.processMonth(month1)+"月")){
                    result.add(year1+"年"+Utils.processMonth(month1)+"月");
                }
                if(i==dates.size()-2){
                    if(!result.contains(year2+"年"+Utils.processMonth(month2)+"月")){
                        result.add(year2+"年"+Utils.processMonth(month2)+"月");
                    }
                }
            }
        }
        return result;
    }

    //返回list形式的留守信息
    public List<StayInfo> getStayInfosByConditions(Map<String,String> conditions){
        List<StayInfo> infoList = stayDao.getStayInfosByConditions(conditions);
        processInfoList(infoList);
        return infoList;
    }

    //返回json格式的留守信息
    public Object getEmpByDeptNameJson(String deptName) {
        JSONArray jsonArray = JSONArray.fromObject(getEmpByDeptName(deptName));
        return jsonArray;
    }

    //修改一条留守记录 要修改的content1,content2,date
    public void updateStayInfo(StayInfo stayInfo){
        stayDao.updateStayInfo(stayInfo);
    }

    //删除一条留守信息
    public void delStayInfo(String id) {
        stayDao.delStayInfo(id);
    }

    //修改部门员工
    public void updateEmp(Employee employee) {
        stayDao.updateEmp(employee);
    }

    //一次性添加一个月的留守信息
    public void addStayInfoByMonth(String year1,String month1,String deptName) {
        Integer[] monthes = {1,3,5,7,8,10,12,};
        //判断大月小月
        Integer month = Integer.valueOf(month1);
        Integer year = Integer.valueOf(year1);
        int days = 0;
        for(Integer i : monthes){
            if(i.equals(month)){//大月31天
                days = 31;
                break;
            }else {
                days = 30;
            }
        }
        if (month.equals(2)){
            if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0){//闰年
                days = 29;
            }else {
                days = 28;
            }
        }

        for(int  i = 1;i<=days;i++){
            String date = year1+"-"+month1+"-";
            date += i;
            StayInfo stayInfo = new StayInfo();
            stayInfo.setId(System.currentTimeMillis());
            stayInfo.setDeptName(deptName);
            stayInfo.setDate(Date.valueOf(date));
            stayDao.addStayInfo(stayInfo);
        }

    }

    //获取一个礼拜的留守数据
    public Map<String,List<StayInfo>> getStayByWeek(String weekOffset){
        Map<String,String> conditions = new HashMap<String, String>();
        conditions.put("offset",weekOffset);
        List<StayInfo> list = stayDao.getByWeek(conditions);
        return listGroup(list);
    }

    //为结果根据日期分类
    public Map<String, List<StayInfo>> listGroup(List<StayInfo> list) {
        LinkedHashSet<String> linkedHashSet = new LinkedHashSet();
        for(StayInfo stayInfo:list){
            linkedHashSet.add(stayInfo.getDate().toString());
        }
        Map<String,List<StayInfo>> result = new LinkedHashMap<String, List<StayInfo>>();

        for(String  date: linkedHashSet){
            Map<String,String> conditions = new HashMap<String, String>();
            conditions.put("month",date);
            List<StayInfo> stayInfoList = stayDao.getStayInfosByConditions(conditions);
            processInfoList(stayInfoList);
            result.put(date,stayInfoList);
        }
        return result;
    }

    //获取一个月的留守数据
    public Map<String,List<StayInfo>> getStayByMonth(Integer monthOffset) {
        Map<String,String> conditions = new HashMap<String, String>();
        conditions.put("offsetMonth",monthOffset.toString());
        List<StayInfo> list = stayDao.getByMonth(conditions);
        return listGroup(list);
    }


}
