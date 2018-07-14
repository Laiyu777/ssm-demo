package Help;

import Entity.User;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.Calendar;

/**
 * Created by Administrator on 2018/5/31.
 */
public class Utils{
    //从session获取值
    public static<T> T  getAttrInSession(HttpSession session, String attrName){
        T t = (T)session.getAttribute(attrName);
        if(t!=null){
            return t;
        }else{
            return null;
        }
    }

    public static boolean ifLogin(HttpSession session){
       User user = getAttrInSession(session,"user");
       if(user!=null){
           return true;
       }else {
           return false;
       }
    }

    public static void invaildRequestBox(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>alert('非法请求');location.href='/index'</script>");
        out.close();
    }

    public static void invaildRequestBox(HttpServletResponse response,String message) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>alert('"+message+"');window.close()</script>");
        out.close();
    }

    //如果数字小于10，则加上0
    public static  String processMonth(Integer month1){
        if(month1>9){
            return month1.toString();
        }else{
            return "0"+month1;
        }
    }

    //*年*月 ==》*-*-  2018年07月 ==》 2018-07
    public static String processYearMonth(String dateStr){
        String year = dateStr.substring(0,4);
        String month =dateStr.substring(5,7);
        return year+"-"+month;
    }



    public static void invaildRequestBoxNoCloseWindow(HttpServletResponse response, String s,String href) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>alert('"+s+"');location.href='"+href+"'</script>");
        out.close();
    }

    public static String getWeekByDate(String date){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(Date.valueOf(date));
        int i = calendar.get(Calendar.DAY_OF_WEEK);
        switch (i){
            case 1:
                return "星期日";
            case 2:
                return "星期一";
            case 3:
                return "星期二";
            case 4:
                return "星期三";
            case 5:
                return "星期四";
            case 6:
                return "星期五";
            case 7:
                return "星期六";
        }
        return null;
    }

    public static void main(String[] args){
        String i= Utils.getWeekByDate("2018-07-01");
        System.out.println(i);
    }
}
