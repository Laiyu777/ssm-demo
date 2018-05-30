package test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import dao.OrderDao;
import entity.vo.OrderDetail;

public class test2 {
	public static void main(String[] a) throws JsonProcessingException{
		ApplicationContext ac=new ClassPathXmlApplicationContext("xml/spring-context.xml");
		OrderDao o = ac.getBean(OrderDao.class);
		//主要是对这个list做处理，可以将这个list作为参数传递
		List<OrderDetail> list = o.getAllOrderDetail();
		List<String> days = new ArrayList<>();
		for(OrderDetail od:list){
			int month = od.getDate().getMonth()+1;
			int day = od.getDate().getDate();
			String s=month+"-"+day;
			days.add(s);
		}
		Set<String> set = new HashSet<>();
		Map<String,Integer> map = new HashMap<>();
		set.addAll(days);
		for(String s:set){
			int i = 0;
			for(String day : days){
				if(s.equals(day)){
					i+=1;
				}
				//System.out.println(day+"--"+i);
				map.put(s, i);
			}
		}
		//System.out.println(map);
		ObjectMapper om =new ObjectMapper();
		System.out.println(om.writeValueAsString(map));
	}
}
