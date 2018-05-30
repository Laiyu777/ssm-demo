package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.json.JsonGeneratorImpl;
import com.fasterxml.jackson.core.json.UTF8JsonGenerator;
import com.fasterxml.jackson.core.json.WriterBasedJsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import dao.OrderDao;
import entity.Book;
import entity.Order;
import entity.Shop;
import entity.User;
import entity.vo.OrderDetail;
import service.BookService;
import service.ShopService;

@Controller
public class ShopController {
	@Autowired
	private ShopService shopService;
	@Autowired
	private BookService bookService;
	
	@Autowired
	private OrderDao orderDao;
	
	//开店操作
	@RequestMapping(path="/openshop.do",method=RequestMethod.POST)
	public String openShop(@RequestParam(value="pn",defaultValue="1")Integer pn,String name,String description,HttpSession session){
		User user = (User) session.getAttribute("user");
		String user_id = user.getId();
		//服务层完成，添加数据的店铺操作
		Shop shop1 = shopService.add(user_id, name, description);
		
		session.setAttribute("shop", shop1);
		//分页 2017.05.11
		PageHelper.startPage(pn,9);//每页显示9本书
		List<Book> list1 = bookService.selectByShopID(shop1.getId());
		PageInfo<Book> list=new PageInfo<>(list1,6);
		session.setAttribute("list", list);
				
		return "shop/shopmanager";
	}
	
	//跳转至更新店铺页面界面
	@RequestMapping(path="/updateshop.do",method=RequestMethod.GET)
	public String updateShopView(String id){
		return "shop/updateshop";
	}
	//进行更新店铺信息操作	
	@RequestMapping(path="/updateshop.do",method=RequestMethod.POST)
	public String updateShop(HttpSession session,String name,String description ){
		Shop shop = (Shop)session.getAttribute("shop");//UserController 228行
		shop.setName(name);
		shop.setDescription(description);
		shopService.updateShop(shop);
		return "shop/shopmanager";
	}
	
	@RequestMapping(path="addbook.do",method=RequestMethod.GET)
	public String addBookeView(HttpSession session){
		
		return "shop/addbook";
	}
	
	@RequestMapping(path="addbook.do",method=RequestMethod.POST)
	public String addBook(HttpServletResponse resp,HttpSession session,Book book) throws IOException{
		Shop shop=(Shop) session.getAttribute("shop");
		Integer shop_id = shop.getId();
		book.setShop_id(shop_id);
		if(book.getStock()<=0||book.getPrice()<=0){
			resp.setContentType("text/html;chartset=UTF-8");
			PrintWriter pw=resp.getWriter();
			pw.println("<script>alert('图书库存和价格都必须大于0！');</script>");
			pw.flush();
			return "shop/addbook";
		}
		
		//book.setId(50);
//		System.out.println(book);
//		System.out.println(bookService);
		bookService.addBook(book);
		
		//显示更新后的页面
		PageHelper.startPage(1,9);
		List<Book> list1 = bookService.selectByShopID(shop_id);
		PageInfo<Book> list = new PageInfo<>(list1,15);
		
		session.setAttribute("list", list);
		
		return "shop/shopmanager";
	}
	
	//显示店铺中秒杀商品
	@RequestMapping("showkillbookinshop.do")
	public String showKillBookInShop(HttpSession session,@RequestParam(value="pn",defaultValue="1")Integer pn){
		Shop shop  = (Shop) session.getAttribute("shop");
		PageHelper.startPage(pn,9);
		List<Book> killBookInShopList=bookService.getKillBooksInShop(shop.getId());
		PageInfo<Book> list = new PageInfo<>(killBookInShopList,15);
		if(killBookInShopList.size()==0){
			session.setAttribute("killmessage", "暂时没有秒杀商品");
		}else{
			session.setAttribute("list", list);
		}
		//显示导航条
		session.setAttribute("shopbook", "kill");//对应session.setAttribute("shopbook", "all");
		return "shop/shopmanager";
	}
	
	@RequestMapping(value="searchbookinshop.do",method=RequestMethod.POST)
	public String searchbookinshop(String key,HttpSession session,@RequestParam(value="pn",defaultValue="1")Integer pn){
		if(key.trim().length()==0){
			return "shop/shopmanager";
		}
		Shop shop=(Shop) session.getAttribute("shop");
		//select * from book where shop_id=#{id} and name like '%'#{key}'%';
		PageHelper.startPage(pn,9);
		List<Book> books = bookService.getBooksInShopByKey(shop.getId(),key);
		PageInfo<Book> list=new PageInfo<>(books,15);
		
		session.setAttribute("list", list);
		session.setAttribute("key", key);
		session.setAttribute("shopbook", "search");
		return "shop/shopmanager";
	}
	
	//为翻页做准备
	@RequestMapping(value="searchbookinshop.do",method=RequestMethod.GET)
	public String searchbookinshop2(@RequestParam(value="key",required=false)String key,HttpSession session,@RequestParam(value="pn",defaultValue="1")Integer pn){
		Shop shop=(Shop) session.getAttribute("shop");
		PageHelper.startPage(pn,9);
		List<Book> books = bookService.getBooksInShopByKey(shop.getId(),key);
		PageInfo<Book> list=new PageInfo<>(books,15);
		session.setAttribute("list", list);
		session.setAttribute("shopbook", "search");
		
		return "shop/shopmanager";
	}
	
	@RequestMapping("echart.do")
	public String getEchartView(HttpSession session) throws IOException{
		Shop shop = (Shop) session.getAttribute("shop");
		String user_id = shop.getUser_id();
		/*处理订单的曲线*/
		//List<Order> list = orderDao.getOrderBySellerId(user_id);
		//处理的是应该是订单完成的量
		List<Order> list = orderDao.getCompleteOrderBySellId(user_id);
		List<String> dayList = new ArrayList<>(); 
		for(Order o:list){
			int month=o.getDate().getMonth()+1;
			int day = o.getDate().getDate();
			String s=month+"-"+day;
			dayList.add(s);
		}
		//String message="11";
		LinkedHashSet<String> daySet=new LinkedHashSet<>();//订单销售趋势的x轴
		daySet.addAll(dayList);
		String[] ox=new String[daySet.size()];
		daySet.toArray(ox);
		ObjectMapper om=new ObjectMapper();
		String ox2=om.writeValueAsString(ox);
		
		//在订单表中数订单日期相同的个数
		List<Integer> orderCountSet = new ArrayList<>(); //订单销售的Y轴
		for(String s:daySet){
			int i = 0;
			for(String day:dayList){
				if(s.equals(day)){
					i+=1;
				}
			}
			orderCountSet.add(i);
		}
		Integer[] oy=new Integer[orderCountSet.size()];//放入每天订单的数量
		orderCountSet.toArray(oy);
		
		// int orderSumCount = 0;
		 //将日期和对应书目放入map中
//		 Map<Integer,String> maps=new HashMap<>();
//		 for(int i=0;i<oy.length;i++){
//			 maps.put(oy[i],ox[i]);
//		 }
		 //取出oy最大的
//		 int max = 0;
//		 for(int i=0;i<oy.length-1;i++){
//			 if(oy[i]<oy[i+1]){
//				 max=oy[i+1];
//			 }
//		 }
		// String maxDate = maps.get(max);
		 
		 
		 //获取这个店铺的订单总数
//		 for(int i:oy){
//			orderSumCount+=i;
//		}
		 //每天产生的订单平均数
//		 System.out.println("orderSumCount===>"+orderSumCount);
//		 System.out.println("ox.length===>"+ox.length);
//		double avaOrderCount = (double)orderSumCount/ox.length;
//		message+="您的店铺平均每天产生订单数目为<strong>"+avaOrderCount+"</strong>,其中量最大的是在"+maxDate+"日,"
//				+ "产生了"+max+"个订单。<br>";
		
		String oy2 = om.writeValueAsString(oy);
		
		//json数据不能为["1","2"]，而是要['1','2']这样的
		String ox3=ox2.replaceAll("\"","\'");
		String oy3=oy2.replaceAll("\"","\'");//订单曲线图
		
		session.setAttribute("daySet", ox3);
		session.setAttribute("orderCountSet", oy3);
		/*******************************************/
		/*处理销售图书的曲线*/
		List<OrderDetail> odList = orderDao.getShopOrderDetail(user_id);
		List<Integer> countList =  new ArrayList<>();
		for(String day:daySet){
			int count = 0;
			for(OrderDetail od:odList){
				String s=(od.getDate().getMonth()+1)+"-"+od.getDate().getDate();
				if(day.equals(s)){
					count +=od.getCount();
				}
			}
			countList.add(count);
		}
//		int sumBookCount = 0;
//		for(int i : countList){
//			sumBookCount+=i;
//		}
//		System.out.println("sumBookCount===>"+sumBookCount);
//		System.out.println("countList.size()===>"+countList.size());
//		message+="您的店铺平均每天销售图书本数为"+(double)sumBookCount/countList.size()+"本,";
		
//		Map<Integer,String> maps2=new HashMap<>();
//		for(int i=0;i<countList.size();i++){
//			maps2.put(countList.get(i),ox[i]);
//		}
//		//获取图书日销量中最大的
//		int max2=0;
//		for(int i =0;i<countList.size()-1;i++){
//			if(countList.get(i)<countList.get(i+1)){
//				max2=countList.get(i+1);
//			}
//		}
//		System.out.println("max2===>"+max2);
//		String date2=maps2.get(max2);
//		message+="其中图书日销量最大的是:"+date2+"日,销售了"+max2+"本";
		
		String bookCount = om.writeValueAsString(countList);
		session.setAttribute("bookCount", bookCount);
		/***********************************/
		//处理第二个图：x轴是图书名，y轴是销售的数量
		List<Book> books=bookService.selectByShopID(shop.getId());
		List<String> bookNames=new ArrayList<>();
		List<Integer> bookSale=new ArrayList<>();
		List<Integer> bookStock=new ArrayList<>();
		for(Book book:books){
			bookNames.add(book.getName());
			bookSale.add(book.getSalecount());
			bookStock.add(book.getStock());
		}
		
		String s1=om.writeValueAsString(bookNames);
		String s1a=s1.replaceAll("\"","\'");
		
		String s2=om.writeValueAsString(bookSale);
		
		String s3=om.writeValueAsString(bookStock);
		
		session.setAttribute("bookNames", s1a);
		session.setAttribute("bookSale", s2);
		session.setAttribute("bookStock", s3);
		
		//session.setAttribute("message", message);
		
		/**********************/
		//饼图销售图书占的比例
		List<VK> VKlist = new ArrayList();
		for(Book book:books){
			VKlist.add(new VK(book.getSalecount(),"'"+book.getName()+"'"));
		}
		String VKlist1=om.writeValueAsString(VKlist);
		String VKlist2=VKlist1.replaceAll("\"", "");
		System.out.println("VKlist2=======>"+VKlist2);
		session.setAttribute("VKlist2", VKlist2);
		
		//处理各类订单所占比例的饼图
		/***************************/
		List<VK> VKlist3 = new ArrayList();
		List<Order> orderList = orderDao.getOrderBySellerId(user_id);
		//['等待付款','已付款，等待发货','已经发货','订单完成','订单取消']
		int dengfukuan=0;int yifukuan=0;
		int yifahuo = 0;int wancheng=0;int quxiao=0;
		for(Order o:orderList){
			String state=o.getState();
			if(state.equals("等待付款")){
				 dengfukuan+=1;
			}
			if(state.equals("已付款，等待发货")){
				yifukuan+=1;
			}
			if(state.equals("已经发货")){
				yifahuo+=1;
			}
			if(state.equals("订单完成")){
				wancheng+=1;
			}
			if(state.equals("订单取消")){
				quxiao+=1;
			}
		}
		VKlist3.add(new VK(dengfukuan,"'等待付款'"));
		VKlist3.add(new VK(yifukuan,"'已付款，等待发货'"));
		VKlist3.add(new VK(yifahuo,"'已经发货'"));
		VKlist3.add(new VK(wancheng,"'订单完成'"));
		VKlist3.add(new VK(quxiao,"'订单取消'"));
		
		String stateString = om.writeValueAsString(VKlist3);
		String stateString2=stateString.replaceAll("\"", "");
		
		session.setAttribute("VKlist3", stateString2);
		
		/*****************************/
		return "shop/Echart";
	}
	
	private static  class VK{
		private Integer value;
		private String name;
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public VK( Integer value,String name) {
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
	
}
