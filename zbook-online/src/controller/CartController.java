package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import common.MyUtils;
import dao.AddressDao;
import dao.CartDao;
import entity.Address;
import entity.Book;
import entity.Order;
import entity.Shop;
import entity.User;
import entity.vo.BookHelp;
import entity.vo.Cart;
import entity.vo.OrderDetail;
import entity.vo.OrderHelp;
import service.BookService;
import service.OrderService;
import service.ShopService;
import service.UserService;

@Controller
public class CartController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private UserService userService;
	@Autowired
	private BookService bookService;
	@Autowired
	private AddressDao adDao;
	@Autowired
	private ShopService shopService;
	@Autowired
	private CartDao cartdao;
	
	
	//跳转购物车界面
	@RequestMapping("mycart.do")
	public String mycarView(HttpSession session,HttpServletResponse resp){
		User user =(User)session.getAttribute("user");
		if(user==null){
			MyUtils.box(resp, "请先登录！");
			return "user/login";
		}
		//System.out.println(user);
		//更新
		cartBookHelpListIntoSession(user,session);
		return "cart/cart";
	}
	
	//加入购物车的按钮，在booklist页面的按钮默认数量是1，在图书详情里的可以获取数量参数
	@RequestMapping("addcart.do")
	public String addCart(@RequestParam("id")String book_id,HttpSession session,HttpServletResponse resp,String count){
		User user =(User)session.getAttribute("user");
		Book book =bookService.getOne(Integer.valueOf(Integer.valueOf(book_id)));
		Shop shop=shopService.getOne(book.getShop_id());
		//登录验证
		if(user==null){
			MyUtils.box(resp, "请先登录！");
			return "user/login";
		}
		
		if(shop.getShopstate()==1){
			MyUtils.box(resp, "店铺被暂停使用了，不能加入购物车");
			return "index";
		}
		
		//不能添加自己发布的图书
		User seller = userService.getUserByShopId(shop.getId());
		if(user.getId().equals(seller.getId())){
			MyUtils.box(resp, "不能将自己发布的图书加入购物车");
			return "book/booklist";
		}
		
		//是否是秒杀商品
		if(book.getIfkill()==1){
			session.setAttribute("ifkill", true);
		}
		//插入新的购物条目
		Cart cart =new Cart();
		cart.setUser_id(user.getId());
		cart.setBook_id(Integer.valueOf(book_id));
		
		//判断用户购物车里是否有相同的书
		List<Cart> cartList=userService.getCartList(user.getId());
		//System.out.println(cartList.size()==0||!cartList.contains(cart));
		if(cartList.size()==0||!cartList.contains(cart)){
			cart.setCount(1);
			cartdao.add(cart);
		}else{
				Cart c=cartdao.getOneByUserIdAndBookId(cart.getUser_id(), cart.getBook_id());
				if(count==null){
					c.setCount(c.getCount()+1);
					cartdao.update(c);
				}else{
					c.setCount(c.getCount()+Integer.valueOf(count));
					cartdao.update(c);
			}
		}
		
		MyUtils.box(resp, "添加购物车成功");
		
		//刷新session中的cartBookHelpList
		cartBookHelpListIntoSession(user, session);
		
		return "book/booklist";
	}

	
	
	//得到用户的购物车里的图书列表 放入session中
		private void cartBookHelpListIntoSession(User user, HttpSession session) {
			List<Cart> listCart=userService.getCartList(user.getId());
			List<BookHelp> cartBookHelpList=new ArrayList<>();
			double amount = 0;
			for(Cart cart:listCart){
				Integer book_id=cart.getBook_id();
				Book book = bookService.getOne(book_id);
				BookHelp bookHelp=new BookHelp();
				bookHelp.setId(book.getId());
				bookHelp.setBook(book);
				bookHelp.setCount(cart.getCount());
				cartBookHelpList.add(bookHelp);
				amount+=bookHelp.getTotal();
			}
			//System.out.println("cartBookHelpList===>"+cartBookHelpList);
			session.setAttribute("cartBookHelpList", cartBookHelpList);
			session.setAttribute("cartTotal", amount);
		}
		
		
		
		
		@RequestMapping("addcount.do")
		public String addcount(HttpSession session,@RequestParam("book_id")Integer book_id){
			User user=(User)session.getAttribute("user");
			//根据用户id和图书id来增加cart表的数量，即图书的数量 默认+1
			cartdao.addcount(user.getId(), book_id);
			cartBookHelpListIntoSession(user, session);
			return "cart/cart";
		}
		
		@RequestMapping("reducecount.do")
		public String reducecount(HttpSession session,@RequestParam("book_id")Integer book_id){
			User user=(User)session.getAttribute("user");
			cartdao.reducecount(user.getId(), book_id);
			cartBookHelpListIntoSession(user, session);
			return "cart/cart";
		}
		
		//针对cart.jsp中的‘生成订单去付款’的按钮
		@RequestMapping("neworderfromcart.do")
		public String newOrderFromCart(HttpServletResponse resp,HttpSession session,int[] book_id,@RequestParam(value="address_id",required=false)Integer address_id) throws IOException{
			User buyer=(User) session.getAttribute("user");
			if(address_id==null){
				MyUtils.box(resp, "请选择地址");
				return "cart/cart";
			}
			
			
			@SuppressWarnings("unchecked")
			//这是默认全部选中的列表
			List<BookHelp> bookHelpList=(List<BookHelp>) session.getAttribute("cartBookHelpList");//userController中的第96行
			System.out.println("bookHelpList=====>"+bookHelpList);
			//这是用户勾选中的列表
			List<BookHelp> bookHelpListOrder=new ArrayList<>();
			for(BookHelp bh:bookHelpList){
				//勾选中的购物车条目
				for(int bookid:book_id){
					if(bh.getId()==bookid){
						//验证图书库存
						Book book = bookService.getOne(bookid);
						if(book.getStock()<bh.getCount()){
							resp.setContentType("text/html;charset=UTF-8");
							PrintWriter pw=resp.getWriter();
							pw.print("<script>alert('图书库存不足！')</script>");
							pw.flush();
							return "cart/cart";
						}
						bookHelpListOrder.add(bh);
					}
				}
			}
			double sum =0 ;
			for(BookHelp bh:bookHelpListOrder){
				sum+=bh.getTotal();//getTotal 决定了要取哪个price
			}
			session.setAttribute("amount", sum);//在neworderfromcart.jsp中显示
			session.setAttribute("bookHelpListOrder", bookHelpListOrder);//在neworderfromcart.jsp中显示
			
			Address address = adDao.selectOne(address_id);
			session.setAttribute("address", address);
			
		/*********book_id-->book-->shop_id--->seller_id*****************************/
			//根据seller_id的不同分别生成不同的订单
			Set<String> sellerids=new HashSet<>();
			List<Integer> bookids=new ArrayList<>();
			Set<Integer> shopids =new HashSet<>();
			for(BookHelp bh:bookHelpListOrder){//是购物车已经选中的BookHelp的List
				bookids.add(bh.getBook().getId());//把购物车里的bookid放入bookids的List中
			}
			for(int bookid : bookids){
				shopids.add(shopService.getShopIdByBookId(bookid)); 
			}
			for(int i:shopids){
				sellerids.add(userService.getUserIdByShopId(i));
			}
			//为了下一步更新订单状态做准备创建一个OrderList放入session中
			List<Order> orderList=new ArrayList<>();
			
			for(String i : sellerids){//seller有几个，决定要插入几个订单
				Order order = new Order();
				order.setBuyerid(buyer.getId());
				order.setSeller_id(i);
				order.setState("等待付款");
				order.setAddressid(address_id);
				
				//加入orderlist
				orderList.add(order);
				//这里的add有设置获取主键的配置 在OrderMapper.xml文件中
				orderService.add(order);
				
			//关于order_detail的操作：关键点在于怎么在插入detail中的过程中分辨出order_id，就是这本书属于哪个订单,那本书属于哪个订单
				//根据sellerid找到shop_id
				Shop shop = shopService.getOneByUserId(i);
				//找到这个店铺的书籍
				List<Book> books=bookService.selectByShopID(shop.getId());
				//遍历这个session中的bookHelpListOrder
				for(BookHelp bh:bookHelpListOrder){//决定要插入几条order_detail
					//遍历这个查找出来的books
					for(Book book:books){
						//如果这个查找出来的book和bh里的bookid相同了，则记录下order_id，添加进order_detail表中
						//意思是如果这个店铺里的图书id和bookHelp中的图书id是相同，则意味着是在同一家店买的，则插入的订单id应该是相同的
						System.out.println(bh.getBook().getId()+"===="+book.getId());
						if(bh.getBook().getId().intValue()==book.getId().intValue()){
							orderService.addOrderDetail(order.getId(), book.getId(), bh.getCount());
						}
					}
				}//插入第一个订单完成
				//更新order的ammout值
				double sum2=0;
				List<OrderDetail> listOrderDetail=orderService.getOrderDetailByOrderId(order.getId());
				for(OrderDetail od:listOrderDetail){
					Book book = bookService.getOne(od.getBook_id());
					if(book.getIfkill()==1){
						sum2+=book.getPrice2()*od.getCount();
					}else{
						sum2+=book.getPrice()*od.getCount();
					}
				}
				//更新amount
				Order order2=orderService.selectOne(order.getId());
				order2.setAmount(sum2);
				orderService.updateOrderAmount(order2);
				
			}
			
			
			
			session.setAttribute("orderList", orderList);
			
			//更新图书的库存
			for(BookHelp bh:bookHelpListOrder){
				Book book=bookService.getOne(bh.getId());
				book.setStock(book.getStock()-bh.getCount());
				bookService.updateBook(book);
			}
			
			
			return "order/orderfromcart";
		}
		
		//为购物车生成的订单付款，对应orderfromcart.jsp中的付款按钮
		@RequestMapping("payforcartorder.do")
		public String payForCartOrder(HttpServletResponse resp,HttpSession session){
			User user2 = (User)session.getAttribute("user");
			User user = userService.getOne(user2.getId());
			Double amount = (Double) session.getAttribute("amount");//182行
			System.out.println("amount=========>"+amount);
			if(user.getBlance()<amount){
				MyUtils.box(resp, "余额不足，请充值完成后到购买订单管理中心进行付款！");
				return "user/addmoney";
			}
			//更新用户余额
			Double blance = user.getBlance()-amount;
			user.setBlance(blance);
			userService.updateUser(user);
			
			//更新订单状态
			List<Order> ordrList=(List<Order>) session.getAttribute("orderList");
			for(Order o:ordrList){
				o.setState("已付款，等待发货");
				orderService.updateOrder(o);
			}
			//刷新session中的值
//			List<Order> listOrder=orderService.selectList(user.getId());
//			List<OrderHelp> listOrderHelp=orderHelpListIntoSession(user, session,listOrder);
//			session.setAttribute("listOrderHelp", listOrderHelp);
			
			MyUtils.box(resp, "付款成功");
			session.setAttribute("user", user);
			return "forward:ordercenter.do";
		}
		//得到用户购买的订单列表
		private  List<OrderHelp> orderHelpListIntoSession(User user, HttpSession session,List<Order> listOrder) {
			//System.out.println("listOrder--------->"+listOrder);
			List<OrderHelp> listOrderHelp=new ArrayList<>();
			for(Order order:listOrder){
				System.out.println("order.getSellerid()"+order.getSellerid());
				System.out.println("shopService==>"+shopService);
				Shop shop = shopService.getOneByUserId(order.getSellerid());
				
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
			System.out.println("listOrderHelp====>"+listOrderHelp);
			//session.setAttribute("listOrderHelp", listOrderHelp);
			return listOrderHelp;
		}
		
		@RequestMapping("removecart.do")
		public String removeCart(@RequestParam("bookid")int bookid,@RequestParam("userid")String userid){
			cartdao.removeCart(bookid,userid);
			//刷新页面		
			return "forward:mycart.do";
		}
		
}
