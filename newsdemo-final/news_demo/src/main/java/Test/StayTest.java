package Test;

import Dao.StayDao;
import Entity.Employee;
import Entity.StayInfo;
import Service.StayService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.sql.Date;
import java.util.*;

/**
 * Created by Administrator on 2018/6/26.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring.xml","classpath:spring-mvc.xml"})
public class StayTest {
    @Autowired
    StayDao stayDao;

    @Autowired
    StayService stayService;

    @Test
    public void test1(){//[\\u4e00-\\u9fa5] //匹配中文
        String day = "2018年5月20日";
        day = day.replaceAll("[\\u4e00-\\u9fa5]","-");
        System.err.println("输出:"+day.substring(0,day.length()-1));
    }

    @Test
    public void test2(){
        List<Employee> list = stayDao.getEmpsByIds(new String[]{"1","2"});
        System.err.println(list);
    }

    @Test
    public void test3(){//获取日期拥有的月份
//        List<Date> dates =stayDao.getDates();
//        List<String> result = new ArrayList<String>();
//        for(int i=0;i<dates.size()-1;i++){
//            Date date1 = dates.get(i);
//            Date date2 = dates.get(i+1);
//            Calendar c1 = Calendar.getInstance();
//            c1.setTime(date1);
//            Calendar c2 = Calendar.getInstance();
//            c2.setTime(date2);
//            if(c1.get(Calendar.YEAR)==c2.get(Calendar.YEAR)){
//                if(c1.get(Calendar.MONTH)!=c2.get(Calendar.MONTH)){
//                    result.add(c1.get(Calendar.YEAR)+"年"+(c1.get(Calendar.MONTH)+1)+"月");
//                    //处理最后一个
//                    if(i==dates.size()-2){
//                        result.add(c2.get(Calendar.YEAR)+"年"+(c2.get(Calendar.MONTH)+1)+"月");
//                    }
//                }
//            }else {
//                result.add(c1.get(Calendar.YEAR)+"年"+(c1.get(Calendar.MONTH)+1)+"月");
//            }
//        }
        //System.err.println(result);
    }

    @Test
    public void test4(){
        Map<String,String> map = new HashMap<String, String>();
        map.put("deptName","台办室");
        map.put("month","2018-06");

        List<StayInfo> list = stayDao.getStayInfosByConditions(map);
        stayService.processInfoList(list);
        System.err.println(list);
    }

    @Test
    public void test5(){
        Map<String,String> map =  new HashMap<String, String>();
        Date date = new Date(System.currentTimeMillis());
        map.put("month",date.toString());
       // map.put("deptName","台办室");
         List<StayInfo> list = stayDao.getStayInfosByConditions(map);
         stayService.processInfoList(list);
        System.err.println("留守："+list);
    }
    @Test //插入一个月的留守记录
    public void insertMonth(){
        for(int  i = 1;i<=30;i++){
            String month = "2018-06-";
            month += i;
            String deptName = "保卫科";
            StayInfo stayInfo = new StayInfo();
            stayInfo.setDeptName(deptName);
            stayInfo.setDate(Date.valueOf(month));
            stayInfo.setId(Date.valueOf(month).getTime());
            stayService.addStayInfo(stayInfo);
        }
    }

    @Test
    public void test88(){
        Map<String,String> map = new HashMap<String, String>();
        List<StayInfo> list = stayDao.getByWeek(map);
        //System.err.println(stayDao.getByWeek(map).size());
        Map<String, List<StayInfo>> result = ListGroup(list);

        System.out.println(result);

    }

    private Map<String, List<StayInfo>> ListGroup(List<StayInfo> list) {
        LinkedHashSet<String> linkedHashSet = new LinkedHashSet();
        for(StayInfo stayInfo:list){
            linkedHashSet.add(stayInfo.getDate().toString());
        }
        Map<String,List<StayInfo>> result = new HashMap<String, List<StayInfo>>();

        for(String  date: linkedHashSet){
            Map<String,String> conditions = new HashMap<String, String>();
            conditions.put("month",date);
            List<StayInfo> stayInfoList = stayDao.getStayInfosByConditions(conditions);
            stayService.processInfoList(stayInfoList);
            result.put(date,stayInfoList);
        }
        return result;
    }

    @Test
    public void test99(){

        Map<String,List<StayInfo>> map = stayService.getStayByWeek(null);
        System.out.println(map);
    }

    @Test
    public void test1213(){
        Map<String,String> conditions = new LinkedHashMap<String, String>();
        conditions.put("offsetMonth","1");
        Map<String, List<StayInfo>> list = stayService.getStayByMonth(-1);
        System.out.println(list);
    }
}
