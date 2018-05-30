package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import common.MyUtils;
import dao.AddressDao;
import entity.Address;
import entity.Book;
import entity.Order;
import entity.Shop;
import entity.User;
import entity.vo.BookHelp;
import entity.vo.OrderHelp;
import service.BookService;
import service.OrderService;
import service.ShopService;

@Controller
public class IndexController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private BookService bookService;
	@Autowired
	private AddressDao adDao;
	@RequestMapping("ordercenter.do")
	public String ordercenter(HttpServletResponse resp,HttpSession session){
		User user=(User)session.getAttribute("user");
		if(user==null){
			MyUtils.box(resp, "请先登录！");
			return "user/login";
		}
		orderHelpListIntoSession(user,session);
		return "user/ordercenter";
	}
	
	//更新订单中心的内容
		public void orderHelpListIntoSession(User user, HttpSession session) {
			//将OrderHelplist放入session中
			List<Order> listOrder=orderService.selectList(user.getId());
			//System.out.println("listOrder--------->"+listOrder);
			List<OrderHelp> listOrderHelp=new ArrayList<>();
			for(Order order:listOrder){
				Shop shop=shopService.getOneByUserId(order.getSellerid());
				//select book_id from order_detail where order_id=?
				List<Integer> bookIdList=bookService.getBookIdList(order.getId());
				List<BookHelp> listBookHelp=new ArrayList<>();
				for(int bookid :bookIdList){
					//从图书表中获取图书
					Book book=bookService.getOne(bookid);
					//从订单细节表中获取数量i
					int i = orderService.getCount(order.getId(), bookid);
					//用BookHelp(id,Book,count)
					BookHelp bookHelp=new BookHelp(book.getId(),book,i);
					//System.out.println("book====>"+book);
					listBookHelp.add(bookHelp);
				}
				Address address = adDao.selectOne(order.getAddressid());
				OrderHelp orderHelp=new OrderHelp(order,address,listBookHelp,shop);
				//2017-05-03 加入订单总价
				//double total=orderHelp.getTotal();
				//System.out.println("orderHelp.getTatol()====>"+total);
				orderHelp.setTotal(order.getAmount());
				listOrderHelp.add(orderHelp);
			}
//			System.out.println("listOrderHelp====>"+listOrderHelp);
			//System.out.println("listOrderHelp Count====>"+listOrderHelp.size());
			session.setAttribute("listOrderHelp", listOrderHelp);
		}
	
	//index.jsp的个人中心中跳转充值中心
	@RequestMapping("addmoneyview.do")
	public String addMoneyView(HttpServletResponse resp,HttpSession session){
		User user=(User)session.getAttribute("user");
		if(user==null){
			MyUtils.box(resp, "请先登录！");
			return "user/login";
		}
		return "user/addmoney";
	}
	//index.jsp中查看店铺订单
	@RequestMapping("ordercenterseller.do")
	public String ordercenterseller(HttpServletResponse resp,HttpSession session){
		User user=(User)session.getAttribute("user");
		if(user==null){
			MyUtils.box(resp, "请先登录！");
			return "user/login";
		}
		
		List<Order> listOrderSeller=orderService.selectListSeller(user.getId());
		List<OrderHelp> listOrderHelpSeller=orderHelpListIntoSession(user, session, listOrderSeller); 
		session.setAttribute("listOrderHelpSeller", listOrderHelpSeller);
		
		
		return "user/ordercenterseller";
	}
		
	private  List<OrderHelp> orderHelpListIntoSession(User user, HttpSession session,List<Order> listOrder) {
		List<OrderHelp> listOrderHelp=new ArrayList<>();
		//order:seller_id-->shop_id-->
		for(Order order:listOrder){
			Shop shop = shopService.getOneByUserId(order.getSellerid());
			//根据一个order_id的值在order_detail表中获取book_id字段
			List<Integer> bookIdList=bookService.getBookIdList(order.getId());
			List<BookHelp> listBookHelp=new ArrayList<>();
			for(int bookid :bookIdList){
				Book book=bookService.getOne(bookid);
				int i = orderService.getCount(order.getId(), bookid);
				BookHelp bookHelp=new BookHelp(book.getId(),book,i);
				//System.out.println("book====>"+book);
				listBookHelp.add(bookHelp);
			}
			Address address = adDao.selectOne(order.getAddressid());
			OrderHelp orderHelp=new OrderHelp(order,address,listBookHelp,shop);
			orderHelp.setTotal(order.getAmount());
			listOrderHelp.add(orderHelp);
		}
		//session.setAttribute("listOrderHelp", listOrderHelp);
		return listOrderHelp;
	}
	
	@ResponseBody
	@RequestMapping(value = "/autoDown.do",produces = "application/json;charset=utf-8")
	public String getDownAuto(HttpServletResponse resp,String key) throws JsonGenerationException, JsonMappingException, IOException{
		List<String> list = getData(key);
		for(String s:list){
			System.out.println("======>"+s);
		}
		ObjectMapper om = new ObjectMapper();
		String result = om.writeValueAsString(list);
		//resp.setContentType("text/javascript;charset=UTF-8");
		//System.out.println("===================>>"+list);
		return result;
	}
	
	private List<String> getData(String key){
		List<String> list = bookService.getBookNameList();
		List<String> command = new ArrayList<>();
		for(String s : list){
			//忽略大小写
			if(s.contains(key.toLowerCase())||s.contains(key.toUpperCase())){
				command.add(s);
			}
		}
		return command;
	}
	
}
