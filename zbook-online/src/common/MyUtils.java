package common;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

public class MyUtils {
	public static void ifBlank(String message,String key) throws MyException{
		if(key.trim().length()==0||key==null){
			throw new MyException(message);
		}
	}
	
	public static void ifBlankBatch(String message,String...keys) throws MyException{
		for(String key:keys){
			if(key.trim().length()==0||key==null){
				throw new MyException(message);
			}
		}
	}

	public static void ifBlankInt(String message, Integer  age) throws MyException {
		// TODO Auto-generated method stub
		if(age==null){
			throw new MyException(message);
		};
	}
	
	//µ¯¿ò¹¤¾ß
	public static void box(HttpServletResponse resp,String message){
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out = null;
		try {
			out = resp.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.print("<script>alert('"+message+"')</script>");
		out.flush();
	}

	public static Date getNowTime(){
		return  new Date(System.currentTimeMillis());
	} 
	
}
