package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import common.MyUtils;
import dao.AddressDao;
import entity.Address;
import entity.Book;
import entity.Order;
import entity.Shop;
import entity.User;
import entity.vo.BookHelp;
import entity.vo.OrderDetail;
import entity.vo.OrderHelp;
import service.BookService;
import service.OrderService;
import service.ShopService;
import service.UserService;


@Controller
public class OrderController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private AddressDao adDao;
	@Autowired
	private ShopService shopService;
	@Autowired
	private BookService bookService;


	
	
	//跳转至生成订单的界面(针对一本书) session中有user book shop,表单里的购买数量
	//bookdetail.jsp中的‘立即购买’按钮
	@RequestMapping(value="buy.do",method=RequestMethod.POST)
	public String getOrderView(int count,HttpSession session,HttpServletResponse resp,String addressid){
		Book book = (Book)session.getAttribute("book");//bookController中的169行
		User buyer = (User)session.getAttribute("user");
		Shop shop = (Shop)session.getAttribute("shop");//bookController中的168行
		//System.out.println("shop is =====>"+shop);
		User seller=userService.getUserByShopId(shop.getId());
		//验证是否登录
		if(session.getAttribute("user")==null){
			MyUtils.box(resp, "请先登录");
			return "user/login";
		}
		//不能购买自己的发布的图书
		if(buyer.getId().equals(seller.getId())){
			MyUtils.box(resp, "不能购买自己发布的图书！");
			return "book/bookdetail";
		}
		//System.out.println("数量：》》》》》》"+Integer.valueOf(count));
		//验证输入的数量是否大于0
		if(Integer.valueOf(count)<=0){
			MyUtils.box(resp, "输入的数量必须大于0而且为整数");
			return "book/bookdetail";
		}
		//验证库存数量是否足够
		if(book.getStock()<Integer.valueOf(count)){
			MyUtils.box(resp, "库存数量不足，请重新选择数量");
			return "book/bookdetail";
		}
		//将用户的收货地址放入session中
		List<Address> adList = userService.getUserAddress(buyer.getId());
		session.setAttribute("adlist", adList);
		session.setAttribute("shop", shop);
		//计算总价和购买数量
		//double amount =Integer.valueOf(count)*book.getPrice();
		double amount ;
		if(book.getIfkill()==1){
			amount = Integer.valueOf(count)*book.getPrice2();
		}else{
			amount = Integer.valueOf(count)*book.getPrice();
		}
		//数量
		session.setAttribute("count", count);
		//总价
		session.setAttribute("amount", amount);
		
		
		if(amount>buyer.getBlance()){
			session.setAttribute("noenough", "余额不足 请充值");
		}
		
		return "order/neworder";
	}
	
	//针对单个图书的生成订单按钮
	@RequestMapping("orderandpay.do")
	public String orderAndPay(HttpSession session,String amount,String addressid,HttpServletResponse resp){
		User buyer = (User)session.getAttribute("user");
		Shop shop=(Shop)session.getAttribute("shop");
		//System.out.println("shop is =====>"+shop);
		Book book= (Book)session.getAttribute("book");
		User seller=userService.getUserByShopId(shop.getId());
		//地址选择框为空，弹窗 提示
		if(addressid==null){
			MyUtils.box(resp, "请您选择收货地址！");
			return "order/neworder";
		}
		//添加order表的信息
		Order order = new Order();
		order.setBuyerid(buyer.getId());
		order.setSeller_id(seller.getId());
		//System.out.println("addressid:_______-------------"+addressid);
		order.setAddressid(Integer.valueOf(addressid));
		order.setState("等待付款");
		order.setAmount(Double.valueOf(amount));
		orderService.add(order);
		session.setAttribute("order", order);
		//System.out.println(order);
		
		//将选择的address放入session中
		Address address = userService.getOneUserAddressById(Integer.valueOf(addressid));
		session.setAttribute("address", address);
		//购买多少本
		//int count = (int) (Double.valueOf(amount)/book.getPrice());
		System.out.println("2017-0506========>"+session.getAttribute("count"));
		int count = (int) session.getAttribute("count");
		//添加order_detail表的信息
		orderService.addOrderDetail(order.getId(), book.getId(),count);
		//System.out.println("成功：添加order_detail表的信息");
		//更新book表的库存信息
		int nowStock=book.getStock()-count;
		book.setStock(nowStock);
		bookService.updateBook(book);
		//System.out.println(book);
		session.setAttribute("amount", Double.valueOf(amount));
		return "order/pay";
	}
	
	@RequestMapping("pay.do")//更新账户的余额和跳转至用户购买订单管理中心
	public String pay(HttpSession session ,HttpServletResponse resp){
		User user = (User)session.getAttribute("user");
		Order order=(Order)session.getAttribute("order");//124行
		System.out.println("order---------------->"+order);
		//验证账户余额是否足够
		Double amount1 = (Double) session.getAttribute("amount");//141行
		Double amount = (double)amount1;
		if(user.getBlance()<amount){
			MyUtils.box(resp, "余额不足，请先充值");
			return "user/addmoney";
		}
		//更新user表的blance字段和order的state字段
		user.setBlance(user.getBlance()-amount);
		userService.updateUser(user);
		order.setState("已付款，等待发货");
		orderService.updateOrder(order);
		MyUtils.box(resp, "付款成功，为您跳转至订单中心");
		//更新用户订单界面
		List<Order> listOrder=orderService.selectList(user.getId());
		List<OrderHelp> listOrderHelp=orderHelpListIntoSession(user, session, listOrder);		
		session.setAttribute("listOrderHelp", listOrderHelp);
		
		
		return "user/ordercenter";
	}
	
	//针对用户订单管理页面中的‘去付款按钮’
	@RequestMapping("gotoPay.do")
	public String gotoPay(HttpServletResponse resp,HttpSession session,@RequestParam("id")String order_id){
		User user=(User) session.getAttribute("user");
		Order order = orderService.selectOne(Integer.valueOf(order_id));
		//System.out.println("state:=========>"+order.getState());
		//验证订单信息，如果是已经付款的状态 则弹框
		if(order.getState().equals("已付款，等待发货")||order.getState().equals("已经发货")){
			MyUtils.box(resp, "已经付款！");
			return "user/ordercenter";
		}
		
		///double amount =orderService.getTotal(Integer.valueOf(order_id));
		session.setAttribute("amount", order.getAmount());
		session.setAttribute("blance", user.getBlance());
		session.setAttribute("order", order);
		
		return "order/pay2";
	}
	//针对pay2.jsp中的‘确认付款’按钮
	@RequestMapping("okpay.do")
	public String okpay(HttpSession session,HttpServletResponse resp){
		User user=(User)session.getAttribute("user");
		Order order = (Order) session.getAttribute("order");
		
		
		Double amount=(Double) session.getAttribute("amount");
		double blance=(double)session.getAttribute("blance");
		
		if(amount>blance){
			MyUtils.box(resp, "余额不足请充值");
			return "user/addmoney";
		}
		//更新订单表的状态信息
		order.setState("已付款，等待发货");
		orderService.updateOrder(order);
		//更新用户表的余额信息
		blance=blance-amount;
		user.setBlance(blance);
		userService.updateUser(user);
		//刷新购买订单中心
		orderHelpListIntoSession(user, session);
		MyUtils.box(resp, "付款成功");
		return "user/ordercenter";
	}
	
	//更新购买订单中心的内容
	private void orderHelpListIntoSession(User user, HttpSession session) {
		//将OrderHelplist放入session中
		List<Order> listOrder=orderService.selectList(user.getId());
		//System.out.println("listOrder--------->"+listOrder);
		List<OrderHelp> listOrderHelp=new ArrayList<>();
		for(Order order:listOrder){
			Shop shop=shopService.getOneByUserId(order.getSellerid());
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
			//double total=orderHelp.getTotal();
			orderHelp.setTotal(order.getAmount());
			listOrderHelp.add(orderHelp);
		}
//		System.out.println("listOrderHelp====>"+listOrderHelp);
//		System.out.println("listOrderHelp Count====>"+listOrderHelp.size());
		session.setAttribute("listOrderHelp", listOrderHelp);
	}
	//针对booklist.jsp中的购买按钮
	@RequestMapping("buybookfromlist.do")
	public String buybookfromlist(HttpServletResponse resp,@RequestParam("id")String id,HttpSession session){
		Book book =bookService.getOne(Integer.valueOf(id));
		User buyer=(User)session.getAttribute("user");
		Shop shop=shopService.getOne(book.getShop_id());
		User seller = userService.getUserByShopId(shop.getId());
		session.setAttribute("shop", shop);
		//是否登录
		if(buyer==null){
			MyUtils.box(resp, "请先登录");
			return "user/login";
		}
		//是否购买自己的图书
		if(buyer.getId().equals(seller.getId())){
			MyUtils.box(resp, "不能购买自己的图书");
			return "book/booklist";
		}
		//图书的库存是否充足
		if(book.getStock()<=0){
			MyUtils.box(resp, "库存不足不能购买");
			return "book/booklist";
		}
		
		if(shop.getShopstate()==1){
			MyUtils.box(resp, "店铺被暂停使用了，不能购买");
			return "index";
		}
		
		
		session.setAttribute("book", book);
		return "order/neworder";
	}
	
	//sendgoods.do
	//订单发货处理
	@RequestMapping("sendgoods.do")
	public String sendgoods(HttpServletResponse resp,@RequestParam("id")String order_id,HttpSession session){
		User user = (User)session.getAttribute("user");
		Order order = orderService.selectOne(Integer.valueOf(order_id));
		//如果是已经发货的状态则不能点击
		if(order.getState().trim().equals("已经发货")){
			MyUtils.box(resp, "该订单已经发货了！");
			return "user/ordercenterseller";
		}
		order.setState("已经发货");
		orderService.updateOrder(order);
		MyUtils.box(resp, "操作成功！");
		
		//刷新页面
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
	
	//确认收货confirmget.do
	@RequestMapping("confirmget.do")
	public String confirmget(HttpServletResponse resp,@RequestParam("id")int order_id,HttpSession session){
		Order order = orderService.selectOne(order_id);
		order.setState("订单完成");
		orderService.updateOrder(order);
		MyUtils.box(resp, "操作成功");
		
		//用户的积分管理
		//更新买家积分
		User buyer = userService.getOne(order.getBuyerid());
		buyer.setIntegral(buyer.getIntegral()+5);
		userService.updateUser(buyer);
		//更新卖家卖家的积分和卖家的余额
		User seller=userService.getOne(order.getSellerid());
		seller.setIntegral(seller.getIntegral()+5);
		seller.setBlance(seller.getBlance()+order.getAmount());
		
		System.out.println("201705016=========>"+seller);
		
		userService.updateUser(seller);
		
		//更新图书销量
			//从订单中获取图书编号，根据图书编号和销售的数量更新图书销量
			List<OrderDetail> orderDetailList=orderService.getOrderDetailByOrderId(order_id);
			int count = 0;//一个订单的总图书量
			
			for(OrderDetail od:orderDetailList){
				Book book=bookService.getOne(od.getBook_id());
				book.setSalecount(book.getSalecount()+od.getCount());
				bookService.updateBook(book);
				count +=od.getCount();
			}
		//店铺销量和店铺积分
		//更新店铺积分,完成一个订单加10分
			Shop shop= shopService.getOne(seller.getShop_id());
			shop.setIntegral(shop.getIntegral()+10);
			shop.setSalecount(shop.getSalecount()+count);
			shopService.updateShop(shop);
		
			
		return "forward:ordercenter.do";
	}
	
	//取消订单 只有在未付款的情况下才可以取消订单
	@RequestMapping("cancelorder.do")
	public String cancelOrder(HttpServletResponse resp,@RequestParam("id")int order_id){
		Order order = orderService.selectOne(order_id);
		//更新订单状态
		order.setState("订单取消");
		orderService.updateOrder(order);
		//更新book的库存信息
		List<OrderDetail> listOrderDetail = orderService.getOrderDetailByOrderId(order_id);
		for(OrderDetail od:listOrderDetail){
			Book book = bookService.getOne(od.getBook_id());
			book.setStock(book.getStock()+od.getCount());
			bookService.updateBook(book);
		}
		MyUtils.box(resp, "操作成功");
		
		return "forward:ordercenter.do";
	}
	
}
