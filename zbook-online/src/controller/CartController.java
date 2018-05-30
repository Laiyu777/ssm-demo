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
	
	
	//��ת���ﳵ����
	@RequestMapping("mycart.do")
	public String mycarView(HttpSession session,HttpServletResponse resp){
		User user =(User)session.getAttribute("user");
		if(user==null){
			MyUtils.box(resp, "���ȵ�¼��");
			return "user/login";
		}
		//System.out.println(user);
		//����
		cartBookHelpListIntoSession(user,session);
		return "cart/cart";
	}
	
	//���빺�ﳵ�İ�ť����booklistҳ��İ�ťĬ��������1����ͼ��������Ŀ��Ի�ȡ��������
	@RequestMapping("addcart.do")
	public String addCart(@RequestParam("id")String book_id,HttpSession session,HttpServletResponse resp,String count){
		User user =(User)session.getAttribute("user");
		Book book =bookService.getOne(Integer.valueOf(Integer.valueOf(book_id)));
		Shop shop=shopService.getOne(book.getShop_id());
		//��¼��֤
		if(user==null){
			MyUtils.box(resp, "���ȵ�¼��");
			return "user/login";
		}
		
		if(shop.getShopstate()==1){
			MyUtils.box(resp, "���̱���ͣʹ���ˣ����ܼ��빺�ﳵ");
			return "index";
		}
		
		//��������Լ�������ͼ��
		User seller = userService.getUserByShopId(shop.getId());
		if(user.getId().equals(seller.getId())){
			MyUtils.box(resp, "���ܽ��Լ�������ͼ����빺�ﳵ");
			return "book/booklist";
		}
		
		//�Ƿ�����ɱ��Ʒ
		if(book.getIfkill()==1){
			session.setAttribute("ifkill", true);
		}
		//�����µĹ�����Ŀ
		Cart cart =new Cart();
		cart.setUser_id(user.getId());
		cart.setBook_id(Integer.valueOf(book_id));
		
		//�ж��û����ﳵ���Ƿ�����ͬ����
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
		
		MyUtils.box(resp, "��ӹ��ﳵ�ɹ�");
		
		//ˢ��session�е�cartBookHelpList
		cartBookHelpListIntoSession(user, session);
		
		return "book/booklist";
	}

	
	
	//�õ��û��Ĺ��ﳵ���ͼ���б� ����session��
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
			//�����û�id��ͼ��id������cart�����������ͼ������� Ĭ��+1
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
		
		//���cart.jsp�еġ����ɶ���ȥ����İ�ť
		@RequestMapping("neworderfromcart.do")
		public String newOrderFromCart(HttpServletResponse resp,HttpSession session,int[] book_id,@RequestParam(value="address_id",required=false)Integer address_id) throws IOException{
			User buyer=(User) session.getAttribute("user");
			if(address_id==null){
				MyUtils.box(resp, "��ѡ���ַ");
				return "cart/cart";
			}
			
			
			@SuppressWarnings("unchecked")
			//����Ĭ��ȫ��ѡ�е��б�
			List<BookHelp> bookHelpList=(List<BookHelp>) session.getAttribute("cartBookHelpList");//userController�еĵ�96��
			System.out.println("bookHelpList=====>"+bookHelpList);
			//�����û���ѡ�е��б�
			List<BookHelp> bookHelpListOrder=new ArrayList<>();
			for(BookHelp bh:bookHelpList){
				//��ѡ�еĹ��ﳵ��Ŀ
				for(int bookid:book_id){
					if(bh.getId()==bookid){
						//��֤ͼ����
						Book book = bookService.getOne(bookid);
						if(book.getStock()<bh.getCount()){
							resp.setContentType("text/html;charset=UTF-8");
							PrintWriter pw=resp.getWriter();
							pw.print("<script>alert('ͼ���治�㣡')</script>");
							pw.flush();
							return "cart/cart";
						}
						bookHelpListOrder.add(bh);
					}
				}
			}
			double sum =0 ;
			for(BookHelp bh:bookHelpListOrder){
				sum+=bh.getTotal();//getTotal ������Ҫȡ�ĸ�price
			}
			session.setAttribute("amount", sum);//��neworderfromcart.jsp����ʾ
			session.setAttribute("bookHelpListOrder", bookHelpListOrder);//��neworderfromcart.jsp����ʾ
			
			Address address = adDao.selectOne(address_id);
			session.setAttribute("address", address);
			
		/*********book_id-->book-->shop_id--->seller_id*****************************/
			//����seller_id�Ĳ�ͬ�ֱ����ɲ�ͬ�Ķ���
			Set<String> sellerids=new HashSet<>();
			List<Integer> bookids=new ArrayList<>();
			Set<Integer> shopids =new HashSet<>();
			for(BookHelp bh:bookHelpListOrder){//�ǹ��ﳵ�Ѿ�ѡ�е�BookHelp��List
				bookids.add(bh.getBook().getId());//�ѹ��ﳵ���bookid����bookids��List��
			}
			for(int bookid : bookids){
				shopids.add(shopService.getShopIdByBookId(bookid)); 
			}
			for(int i:shopids){
				sellerids.add(userService.getUserIdByShopId(i));
			}
			//Ϊ����һ�����¶���״̬��׼������һ��OrderList����session��
			List<Order> orderList=new ArrayList<>();
			
			for(String i : sellerids){//seller�м���������Ҫ���뼸������
				Order order = new Order();
				order.setBuyerid(buyer.getId());
				order.setSeller_id(i);
				order.setState("�ȴ�����");
				order.setAddressid(address_id);
				
				//����orderlist
				orderList.add(order);
				//�����add�����û�ȡ���������� ��OrderMapper.xml�ļ���
				orderService.add(order);
				
			//����order_detail�Ĳ������ؼ���������ô�ڲ���detail�еĹ����зֱ��order_id�������Ȿ�������ĸ�����,�Ǳ��������ĸ�����
				//����sellerid�ҵ�shop_id
				Shop shop = shopService.getOneByUserId(i);
				//�ҵ�������̵��鼮
				List<Book> books=bookService.selectByShopID(shop.getId());
				//�������session�е�bookHelpListOrder
				for(BookHelp bh:bookHelpListOrder){//����Ҫ���뼸��order_detail
					//����������ҳ�����books
					for(Book book:books){
						//���������ҳ�����book��bh���bookid��ͬ�ˣ����¼��order_id����ӽ�order_detail����
						//��˼���������������ͼ��id��bookHelp�е�ͼ��id����ͬ������ζ������ͬһ�ҵ���ģ������Ķ���idӦ������ͬ��
						System.out.println(bh.getBook().getId()+"===="+book.getId());
						if(bh.getBook().getId().intValue()==book.getId().intValue()){
							orderService.addOrderDetail(order.getId(), book.getId(), bh.getCount());
						}
					}
				}//�����һ���������
				//����order��ammoutֵ
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
				//����amount
				Order order2=orderService.selectOne(order.getId());
				order2.setAmount(sum2);
				orderService.updateOrderAmount(order2);
				
			}
			
			
			
			session.setAttribute("orderList", orderList);
			
			//����ͼ��Ŀ��
			for(BookHelp bh:bookHelpListOrder){
				Book book=bookService.getOne(bh.getId());
				book.setStock(book.getStock()-bh.getCount());
				bookService.updateBook(book);
			}
			
			
			return "order/orderfromcart";
		}
		
		//Ϊ���ﳵ���ɵĶ��������Ӧorderfromcart.jsp�еĸ��ť
		@RequestMapping("payforcartorder.do")
		public String payForCartOrder(HttpServletResponse resp,HttpSession session){
			User user2 = (User)session.getAttribute("user");
			User user = userService.getOne(user2.getId());
			Double amount = (Double) session.getAttribute("amount");//182��
			System.out.println("amount=========>"+amount);
			if(user.getBlance()<amount){
				MyUtils.box(resp, "���㣬���ֵ��ɺ󵽹��򶩵��������Ľ��и��");
				return "user/addmoney";
			}
			//�����û����
			Double blance = user.getBlance()-amount;
			user.setBlance(blance);
			userService.updateUser(user);
			
			//���¶���״̬
			List<Order> ordrList=(List<Order>) session.getAttribute("orderList");
			for(Order o:ordrList){
				o.setState("�Ѹ���ȴ�����");
				orderService.updateOrder(o);
			}
			//ˢ��session�е�ֵ
//			List<Order> listOrder=orderService.selectList(user.getId());
//			List<OrderHelp> listOrderHelp=orderHelpListIntoSession(user, session,listOrder);
//			session.setAttribute("listOrderHelp", listOrderHelp);
			
			MyUtils.box(resp, "����ɹ�");
			session.setAttribute("user", user);
			return "forward:ordercenter.do";
		}
		//�õ��û�����Ķ����б�
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
			//ˢ��ҳ��		
			return "forward:mycart.do";
		}
		
}
