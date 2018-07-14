package Controller;

import Entity.Employee;
import Entity.StayInfo;
import Entity.User;
import Help.Message;
import Help.Utils;
import Service.StayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/6/26.
 */
@Controller
@RequestMapping("/user/stay")
public class StayController {

    @Autowired
    private StayService stayService;



    //跳转到留守排班界面
    @RequestMapping(value = "/manageStay")
    public String gotoStayJsp(HttpServletRequest request,
                                HttpSession session,
                                @RequestParam Map<String,String> conditions){//这个map是非null的
        User user = (User) session.getAttribute("user");
        String deptName = user.getDepartment().getDepartmentName();
        //System.out.println("条件:"+conditions);
        conditions.put("deptName",deptName);

        //默认显示当月
        if(conditions.size()==1){
            String thisMonth = new Date(System.currentTimeMillis()).toString().substring(0,7);
            conditions.put("month",thisMonth);
        }



        System.out.println("上一个页面是："+request.getHeader("Referer"));

        //获取留守记录 条件是部门和当月
        request.setAttribute("infoList",stayService.getStayInfosByConditions(conditions));

        //获取部门员工
        request.setAttribute("empList",stayService.getEmpByDeptName(deptName));
        request.setAttribute("empListJson",stayService.getEmpByDeptNameJson(deptName));
        //获取留守记录
        //request.setAttribute("infoList",stayService.getStayInfosBydeptName(deptName));
        //自动生成按钮 根据月份划分
        request.setAttribute("dateList",stayService.getDateStringArray(deptName));
        request.getSession().setAttribute("dateList",stayService.getDateStringArray(deptName));
        return "admin/manageStay";
    }

    //添加员工
    @RequestMapping(value = "/addEmp",method = RequestMethod.POST)
    public String addEmp( Employee employee){
        //System.out.println("传递："+employee);
        stayService.addEmp(employee);
        return "redirect:manageStay";
    }

    //删除员工
    @RequestMapping(value = "/delEmp",method = RequestMethod.POST)
    public String delEmp(String id){
        stayService.delEmp(id);
        return "redirect:manageStay";
    }

    //插入一条留守记录
    @RequestMapping(value = "/addStayInfo",method = RequestMethod.POST)
    public String addStayInfo(HttpSession session, StayInfo stayInfo, String dateStr){
        User user = (User) session.getAttribute("user");
        Date date = processDate(dateStr);

        stayInfo.setId(System.currentTimeMillis());
        stayInfo.setDate(date);
        stayInfo.setDeptName(user.getDepartment().getDepartmentName());

        stayService.addStayInfo(stayInfo);

        return "redirect:manageStay";
    }

    private Date processDate(String dateStr){
        String dateStr1 =  dateStr.replaceAll("[\\u4e00-\\u9fa5]","-").substring(0,dateStr.length()-1);
        return Date.valueOf(dateStr1);
    }

    //修改留守信息
    @RequestMapping(value = "/editStayInfo",method = RequestMethod.POST)
    public String editStayInfo(StayInfo stayInfo){
        stayService.updateStayInfo(stayInfo);
        //处理返回页面
        Date date = stayInfo.getDate();
        String dateStr = date.toString().substring(0,7);
        return "redirect:manageStay?month="+dateStr;
    }

    //删除一条留守信息
    @ResponseBody
    @RequestMapping(value = "/delStayInfo",method = RequestMethod.POST)
    public Message delStayInfo(String id){
        try{
            stayService.delStayInfo(id);
            return new Message(200,"删除成功");
        }catch (Exception e){
            e.printStackTrace();
            return new Message(400,"服务器错误");
        }
    }

    //编辑部门的员工
    @RequestMapping(value = "/editEmp",method = RequestMethod.POST)
    public String editEmp(Employee employee,HttpServletRequest request){
        stayService.updateEmp(employee);
        //记录在哪个页面(月份)修改的
        String preUrl = request.getHeader("Referer");
        if(preUrl!=null&&preUrl.length()>0){
            if(preUrl.endsWith("/manageStay")){
                return "redirect:manageStay";
            }else {
                String paramStr = preUrl.substring(preUrl.indexOf("?")+1,preUrl.length());
                return "redirect:manageStay?"+paramStr;
            }
        }

        return "redirect:manageStay";
    }

    //按月添加留守记录
    @RequestMapping(value = "/addStayInfoByMonth", method = RequestMethod.POST)
    public String addStayInfoByMonth(String dateStr, String deptName,HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String year = dateStr.substring(0,4);
        String month =dateStr.substring(5,7);
        //如果已经添加了这个月的 则不能再添加
        List<String> monthList = (List<String>) session.getAttribute("dateList");
        boolean had = false ;
        for(String s : monthList){
            if(s.equals(dateStr)){
                had = true;
            }
        }
//        month = year+"-"+month+"-";
        if(!had){
            stayService.addStayInfoByMonth(year,month,deptName);
        }else {
            Utils.invaildRequestBoxNoCloseWindow(response,dateStr+"的留守记录已经存在了","manageStay?month="+Utils.processYearMonth(dateStr));
        }
        return "redirect:manageStay?month="+Utils.processYearMonth(dateStr);
    }
}
