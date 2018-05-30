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


	
	
	//��ת�����ɶ����Ľ���(���һ����) session����user book shop,����Ĺ�������
	//bookdetail.jsp�еġ��������򡯰�ť
	@RequestMapping(value="buy.do",method=RequestMethod.POST)
	public String getOrderView(int count,HttpSession session,HttpServletResponse resp,String addressid){
		Book book = (Book)session.getAttribute("book");//bookController�е�169��
		User buyer = (User)session.getAttribute("user");
		Shop shop = (Shop)session.getAttribute("shop");//bookController�е�168��
		//System.out.println("shop is =====>"+shop);
		User seller=userService.getUserByShopId(shop.getId());
		//��֤�Ƿ��¼
		if(session.getAttribute("user")==null){
			MyUtils.box(resp, "���ȵ�¼");
			return "user/login";
		}
		//���ܹ����Լ��ķ�����ͼ��
		if(buyer.getId().equals(seller.getId())){
			MyUtils.box(resp, "���ܹ����Լ�������ͼ�飡");
			return "book/bookdetail";
		}
		//System.out.println("������������������"+Integer.valueOf(count));
		//��֤����������Ƿ����0
		if(Integer.valueOf(count)<=0){
			MyUtils.box(resp, "����������������0����Ϊ����");
			return "book/bookdetail";
		}
		//��֤��������Ƿ��㹻
		if(book.getStock()<Integer.valueOf(count)){
			MyUtils.box(resp, "����������㣬������ѡ������");
			return "book/bookdetail";
		}
		//���û����ջ���ַ����session��
		List<Address> adList = userService.getUserAddress(buyer.getId());
		session.setAttribute("adlist", adList);
		session.setAttribute("shop", shop);
		//�����ܼۺ͹�������
		//double amount =Integer.valueOf(count)*book.getPrice();
		double amount ;
		if(book.getIfkill()==1){
			amount = Integer.valueOf(count)*book.getPrice2();
		}else{
			amount = Integer.valueOf(count)*book.getPrice();
		}
		//����
		session.setAttribute("count", count);
		//�ܼ�
		session.setAttribute("amount", amount);
		
		
		if(amount>buyer.getBlance()){
			session.setAttribute("noenough", "���� ���ֵ");
		}
		
		return "order/neworder";
	}
	
	//��Ե���ͼ������ɶ�����ť
	@RequestMapping("orderandpay.do")
	public String orderAndPay(HttpSession session,String amount,String addressid,HttpServletResponse resp){
		User buyer = (User)session.getAttribute("user");
		Shop shop=(Shop)session.getAttribute("shop");
		//System.out.println("shop is =====>"+shop);
		Book book= (Book)session.getAttribute("book");
		User seller=userService.getUserByShopId(shop.getId());
		//��ַѡ���Ϊ�գ����� ��ʾ
		if(addressid==null){
			MyUtils.box(resp, "����ѡ���ջ���ַ��");
			return "order/neworder";
		}
		//���order�����Ϣ
		Order order = new Order();
		order.setBuyerid(buyer.getId());
		order.setSeller_id(seller.getId());
		//System.out.println("addressid:_______-------------"+addressid);
		order.setAddressid(Integer.valueOf(addressid));
		order.setState("�ȴ�����");
		order.setAmount(Double.valueOf(amount));
		orderService.add(order);
		session.setAttribute("order", order);
		//System.out.println(order);
		
		//��ѡ���address����session��
		Address address = userService.getOneUserAddressById(Integer.valueOf(addressid));
		session.setAttribute("address", address);
		//������ٱ�
		//int count = (int) (Double.valueOf(amount)/book.getPrice());
		System.out.println("2017-0506========>"+session.getAttribute("count"));
		int count = (int) session.getAttribute("count");
		//���order_detail�����Ϣ
		orderService.addOrderDetail(order.getId(), book.getId(),count);
		//System.out.println("�ɹ������order_detail�����Ϣ");
		//����book��Ŀ����Ϣ
		int nowStock=book.getStock()-count;
		book.setStock(nowStock);
		bookService.updateBook(book);
		//System.out.println(book);
		session.setAttribute("amount", Double.valueOf(amount));
		return "order/pay";
	}
	
	@RequestMapping("pay.do")//�����˻���������ת���û����򶩵���������
	public String pay(HttpSession session ,HttpServletResponse resp){
		User user = (User)session.getAttribute("user");
		Order order=(Order)session.getAttribute("order");//124��
		System.out.println("order---------------->"+order);
		//��֤�˻�����Ƿ��㹻
		Double amount1 = (Double) session.getAttribute("amount");//141��
		Double amount = (double)amount1;
		if(user.getBlance()<amount){
			MyUtils.box(resp, "���㣬���ȳ�ֵ");
			return "user/addmoney";
		}
		//����user���blance�ֶκ�order��state�ֶ�
		user.setBlance(user.getBlance()-amount);
		userService.updateUser(user);
		order.setState("�Ѹ���ȴ�����");
		orderService.updateOrder(order);
		MyUtils.box(resp, "����ɹ���Ϊ����ת����������");
		//�����û���������
		List<Order> listOrder=orderService.selectList(user.getId());
		List<OrderHelp> listOrderHelp=orderHelpListIntoSession(user, session, listOrder);		
		session.setAttribute("listOrderHelp", listOrderHelp);
		
		
		return "user/ordercenter";
	}
	
	//����û���������ҳ���еġ�ȥ���ť��
	@RequestMapping("gotoPay.do")
	public String gotoPay(HttpServletResponse resp,HttpSession session,@RequestParam("id")String order_id){
		User user=(User) session.getAttribute("user");
		Order order = orderService.selectOne(Integer.valueOf(order_id));
		//System.out.println("state:=========>"+order.getState());
		//��֤������Ϣ��������Ѿ������״̬ �򵯿�
		if(order.getState().equals("�Ѹ���ȴ�����")||order.getState().equals("�Ѿ�����")){
			MyUtils.box(resp, "�Ѿ����");
			return "user/ordercenter";
		}
		
		///double amount =orderService.getTotal(Integer.valueOf(order_id));
		session.setAttribute("amount", order.getAmount());
		session.setAttribute("blance", user.getBlance());
		session.setAttribute("order", order);
		
		return "order/pay2";
	}
	//���pay2.jsp�еġ�ȷ�ϸ����ť
	@RequestMapping("okpay.do")
	public String okpay(HttpSession session,HttpServletResponse resp){
		User user=(User)session.getAttribute("user");
		Order order = (Order) session.getAttribute("order");
		
		
		Double amount=(Double) session.getAttribute("amount");
		double blance=(double)session.getAttribute("blance");
		
		if(amount>blance){
			MyUtils.box(resp, "�������ֵ");
			return "user/addmoney";
		}
		//���¶������״̬��Ϣ
		order.setState("�Ѹ���ȴ�����");
		orderService.updateOrder(order);
		//�����û���������Ϣ
		blance=blance-amount;
		user.setBlance(blance);
		userService.updateUser(user);
		//ˢ�¹��򶩵�����
		orderHelpListIntoSession(user, session);
		MyUtils.box(resp, "����ɹ�");
		return "user/ordercenter";
	}
	
	//���¹��򶩵����ĵ�����
	private void orderHelpListIntoSession(User user, HttpSession session) {
		//��OrderHelplist����session��
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
	//���booklist.jsp�еĹ���ť
	@RequestMapping("buybookfromlist.do")
	public String buybookfromlist(HttpServletResponse resp,@RequestParam("id")String id,HttpSession session){
		Book book =bookService.getOne(Integer.valueOf(id));
		User buyer=(User)session.getAttribute("user");
		Shop shop=shopService.getOne(book.getShop_id());
		User seller = userService.getUserByShopId(shop.getId());
		session.setAttribute("shop", shop);
		//�Ƿ��¼
		if(buyer==null){
			MyUtils.box(resp, "���ȵ�¼");
			return "user/login";
		}
		//�Ƿ����Լ���ͼ��
		if(buyer.getId().equals(seller.getId())){
			MyUtils.box(resp, "���ܹ����Լ���ͼ��");
			return "book/booklist";
		}
		//ͼ��Ŀ���Ƿ����
		if(book.getStock()<=0){
			MyUtils.box(resp, "��治�㲻�ܹ���");
			return "book/booklist";
		}
		
		if(shop.getShopstate()==1){
			MyUtils.box(resp, "���̱���ͣʹ���ˣ����ܹ���");
			return "index";
		}
		
		
		session.setAttribute("book", book);
		return "order/neworder";
	}
	
	//sendgoods.do
	//������������
	@RequestMapping("sendgoods.do")
	public String sendgoods(HttpServletResponse resp,@RequestParam("id")String order_id,HttpSession session){
		User user = (User)session.getAttribute("user");
		Order order = orderService.selectOne(Integer.valueOf(order_id));
		//������Ѿ�������״̬���ܵ��
		if(order.getState().trim().equals("�Ѿ�����")){
			MyUtils.box(resp, "�ö����Ѿ������ˣ�");
			return "user/ordercenterseller";
		}
		order.setState("�Ѿ�����");
		orderService.updateOrder(order);
		MyUtils.box(resp, "�����ɹ���");
		
		//ˢ��ҳ��
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
			//����һ��order_id��ֵ��order_detail���л�ȡbook_id�ֶ�
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
	
	//ȷ���ջ�confirmget.do
	@RequestMapping("confirmget.do")
	public String confirmget(HttpServletResponse resp,@RequestParam("id")int order_id,HttpSession session){
		Order order = orderService.selectOne(order_id);
		order.setState("�������");
		orderService.updateOrder(order);
		MyUtils.box(resp, "�����ɹ�");
		
		//�û��Ļ��ֹ���
		//������һ���
		User buyer = userService.getOne(order.getBuyerid());
		buyer.setIntegral(buyer.getIntegral()+5);
		userService.updateUser(buyer);
		//�����������ҵĻ��ֺ����ҵ����
		User seller=userService.getOne(order.getSellerid());
		seller.setIntegral(seller.getIntegral()+5);
		seller.setBlance(seller.getBlance()+order.getAmount());
		
		System.out.println("201705016=========>"+seller);
		
		userService.updateUser(seller);
		
		//����ͼ������
			//�Ӷ����л�ȡͼ���ţ�����ͼ���ź����۵���������ͼ������
			List<OrderDetail> orderDetailList=orderService.getOrderDetailByOrderId(order_id);
			int count = 0;//һ����������ͼ����
			
			for(OrderDetail od:orderDetailList){
				Book book=bookService.getOne(od.getBook_id());
				book.setSalecount(book.getSalecount()+od.getCount());
				bookService.updateBook(book);
				count +=od.getCount();
			}
		//���������͵��̻���
		//���µ��̻���,���һ��������10��
			Shop shop= shopService.getOne(seller.getShop_id());
			shop.setIntegral(shop.getIntegral()+10);
			shop.setSalecount(shop.getSalecount()+count);
			shopService.updateShop(shop);
		
			
		return "forward:ordercenter.do";
	}
	
	//ȡ������ ֻ����δ���������²ſ���ȡ������
	@RequestMapping("cancelorder.do")
	public String cancelOrder(HttpServletResponse resp,@RequestParam("id")int order_id){
		Order order = orderService.selectOne(order_id);
		//���¶���״̬
		order.setState("����ȡ��");
		orderService.updateOrder(order);
		//����book�Ŀ����Ϣ
		List<OrderDetail> listOrderDetail = orderService.getOrderDetailByOrderId(order_id);
		for(OrderDetail od:listOrderDetail){
			Book book = bookService.getOne(od.getBook_id());
			book.setStock(book.getStock()+od.getCount());
			bookService.updateBook(book);
		}
		MyUtils.box(resp, "�����ɹ�");
		
		return "forward:ordercenter.do";
	}
	
}
