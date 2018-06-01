package util;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 * Created by Administrator on 2018/3/22.
 */
public class Utils {

    public static String getIpAddress(HttpServletRequest request){
       return  request.getRemoteAddr();
    }

    //日期转换:当前时间的long转换为String的date
    public static String DateToString(long millions){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return simpleDateFormat.format(millions);
    }
    //将timestamp转换为String的date
    public static String DateToString(Timestamp timestamp){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return simpleDateFormat.format(timestamp);
    }
}
