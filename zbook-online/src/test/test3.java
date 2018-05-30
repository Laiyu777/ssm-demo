package test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class test3 {
	private static  class TT{
		private Integer value;
		private String name;
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public TT( Integer value,String name) {
			super();
			this.name = name;
			this.value = value;
		}
		public Integer getValue() {
			return value;
		}
		public void setValue(Integer value) {
			this.value = value;
		}
	}
	public static void main(String[] args) throws JsonProcessingException {
		ObjectMapper om = new ObjectMapper();
		Map<Integer,String> map= new HashMap<>();
		map.put(1, "aa");
		map.put(2, "bb");
		Map<Integer,String> map2= new HashMap<>();
		map2.put(1, "aa");
		map2.put(2, "bb");
		List<TT> list =new ArrayList<>();
		list.add(new TT(20,"'java±à³ÌË¼Ïë'"));
		list.add(new TT(20,"'java'"));
		String s = om.writeValueAsString(list);
		String s2 = s.replaceAll("\"", "");
		System.out.println(s2);
	}

}
