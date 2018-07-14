package Test;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;


/**
 * Created by Administrator on 2018/6/14.
 */
public class main {
    public static void main(String[] arg){
        test3();

    }

    private static void test1() {
        //        System.out.println("时间是:"+new Date(1528892040228L));
//        Timestamp t = new Timestamp(System.currentTimeMillis());
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = "2018-06-10 16:01:25";
        long time = 0;
        try {
            time = sdf.parse(date).getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        System.out.println("时间是"+time);
    }

    private static void test2(){
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        int day = timestamp.getDay();
        System.out.println(day);
    }

    private static void test3(){
//        Date date = Date.valueOf("2018-06-26");
//        System.out.println(date);
        //System.out.println(Integer.valueOf("0"+5));
//        Date date = new Date(System.currentTimeMillis());
//        System.out.println(date.toString().substring(0,7));

        System.out.println("month".endsWith("month"));
    }
}
