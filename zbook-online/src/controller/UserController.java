package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import common.MyException;
import common.MyUtils;
import dao.AddressDao;
import dao.BookDao;
import entity.Address;
import entity.Book;
import entity.Order;
import entity.Shop;
import entity.User;
import entity.vo.BookHelp;
import entity.vo.Cart;
import entity.vo.OrderHelp;
import entity.vo.UserKey;
import service.BookService;
import service.OrderService;
import service.ShopService;
import service.UserService;

@Controller
public class UserController {
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
	private BookDao bookDao;
	//������ҳ
	@RequestMapping("/index.do")
	public String index(HttpServletRequest req){
		//bookdetail.jsp�е��ұߵ����а���и���
		ServletContext sc  = req.getServletContext();
		List<Book> list = bookDao.selectAll();
		sc.setAttribute("indexbooks", list);
		
		List<Book> salelist = bookDao.getRankBook();
		sc.setAttribute("rightsale", salelist);
		
		List<Book> clicklist = bookDao.getBookByClick();
		sc.setAttribute("rightclick", clicklist);
		//���Ƽ���Ŀ���и��� session�е�"booksForUser"
		User user = (User) req.getSession().getAttribute("user");
		if(user!=null){
			List<UserKey> uks = userService.getUserKeys(user.getId());
			LinkedHashSet<UserKey> ts =new  LinkedHashSet<UserKey>();
			for(UserKey uk:uks){
				ts.add(uk);
			}
			LinkedHashSet<Book> books =new  LinkedHashSet<Book>();
			for(UserKey uk:ts){
				List<Book> book = bookService.search(uk.getUser_key());
				books.addAll(book);
			}
			req.getSession().setAttribute("booksForUser", books);
		}
		//�����������
		List<Book> rankbook = bookDao.getRankBook();
		sc.setAttribute("rankbook", rankbook);
		
		return "redirect:index.jsp";
	}
	
	@RequestMapping("/loginout.do")
	public String loginOut(HttpServletRequest req,HttpSession se){
		req.removeAttribute("user");
		se.removeAttribute("user");
		return "redirect:index.jsp";
	}
	//��¼��ͼ
	@RequestMapping(path="/login.do",method=RequestMethod.GET)
	public String loginView(){
		return "user/login";
	}
	
	//��¼����
	@RequestMapping(path="/login.do",method=RequestMethod.POST)
	public String login(String id,String password,HttpServletRequest request) {
		//System.out.println("----"+id+":"+password);
		try {
			User user = userService.login(id, password);
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			//�õ��û����򶩵�,���ҷ���session��
			List<Order> listOrder=orderService.selectList(user.getId());
			List<OrderHelp> listOrderHelp=orderHelpListIntoSession(user, session,listOrder);
			session.setAttribute("listOrderHelp", listOrderHelp);
			//�õ��û����̵����۶���,���ҷ���session��
			List<Order> listOrderSeller=orderService.selectListSeller(user.getId());
			List<OrderHelp> listOrderHelpSeller=orderHelpListIntoSession(user,session,listOrderSeller);
			session.setAttribute("listOrderHelpSeller", listOrderHelpSeller);
			//�õ��û��Ĺ��ﳵ���ͼ���б� ����session��
			cartBookHelpListIntoSession(user, session);
			//��List<Address>����session��
			List<Address> addressList=adDao.selectList(user.getId());
			session.setAttribute("adlist", addressList);
			//���û������Ĺؼ��ʷ���session��
			List<UserKey> userKeys2=userService.getUserKeys(user.getId());
			Set<UserKey> userKeys=new LinkedHashSet<>();
			userKeys.addAll(userKeys2);
			session.setAttribute("userKeys", userKeys);
			//��ʾΪ�û����Ƶ�ͼ�飬����ǰ3���ؼ�������ʾ
			Iterator<UserKey> it = userKeys.iterator();
			//set��ȡ��ǰ�����ؼ���
			String[] keys=new String[3];
			for(int i=0;i<3;i++){
				if(it.hasNext()){
					keys[i]=it.next().getUser_key();
				}
			}
			Set<Book> booksForUser=new LinkedHashSet<>();
			for(String key:keys){
				List<Book> tempList=bookService.search(key);
				booksForUser.addAll(tempList);
			}
			if(booksForUser.size()==0){
				session.setAttribute("please", true);
			}else{
				session.setAttribute("please", false);
			}
			session.setAttribute("booksForUser", booksForUser);
			
			return "redirect:/index.jsp";
		} catch (MyException e) {
			request.setAttribute("message", e.getMessage());
			return "user/login";
		}
		
	}
	
	//�õ��û��Ĺ��ﳵ���ͼ���б� ����session��
	private void cartBookHelpListIntoSession(User user, HttpSession session) {
		List<Cart> listCart=userService.getCartList(user.getId());
		List<BookHelp> cartBookHelpList=new ArrayList<>();
		double amount = 0;
		if(listCart!=null){
			for(Cart cart:listCart){
				Integer book_id=cart.getBook_id();
				Book book = bookService.getOne(book_id);
				BookHelp bookHelp=new BookHelp();
				bookHelp.setBook(book);
				bookHelp.setId(book.getId());
				bookHelp.setCount(cart.getCount());
				cartBookHelpList.add(bookHelp);
				amount+=bookHelp.getTotal();
			}
		}
		System.out.println("cartBookHelpList===>"+cartBookHelpList);
		session.setAttribute("cartBookHelpList", cartBookHelpList);
		session.setAttribute("cartTotal", amount);
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
			listOrderHelp.add(orderHelp);
		}
		System.out.println("listOrderHelp====>"+listOrderHelp);
		//session.setAttribute("listOrderHelp", listOrderHelp);
		return listOrderHelp;
	}
	
	
	
	
	@RequestMapping(path="/register.do",method=RequestMethod.GET)
	public String registerView(){
		return "user/register";
	}
	
	//ע���û�
	@RequestMapping(path="/register.do",method=RequestMethod.POST)
	public String register(HttpServletResponse resp,HttpServletRequest req,User user,String password2) throws IOException {
		HttpSession session = null;
		try {
			session = req.getSession();
			userService.add(user,password2);//userService���add���������������֤
			//�������user������û�л��ֺ�ע��ʱ���,Ҫ����һ����������Ҫ�ڲ�ѯ��ȡһ��user����
			User user1 = userService.getOne(user.getId());
			//session.setAttribute("user", user1);
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter pw=resp.getWriter();
			pw.print("<script>alert('ע��ɹ��������µ�¼');window.location.href='http://localhost:8080/zbook-online/index.jsp';</script>");
			pw.flush();
			return "index";
		} catch (MyException e) {
			//���û�����������д
			//req.setAttribute("user", user);
			req.setAttribute("message", e.getMessage());
			return "user/register";
		}
		
	}
	
	//��ת�û��������
	@RequestMapping(path="/openshopView.do",method=RequestMethod.GET)
	public String openShopView(@RequestParam(value="pn",defaultValue="1")Integer pn,HttpServletRequest req,HttpServletResponse resp) throws Exception {
		HttpSession session = req.getSession();
		User user1 = (User) session.getAttribute("user");
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out=resp.getWriter();
		//��֤�Ƿ��¼
		if(user1==null){		
			out.print("<script>alert('���Ƚ��е�¼');</script>");
			req.setAttribute("message", "���ȵ�¼���ڿ���");
			out.flush();
			return "user/login";
		}
		User user = userService.getOne(user1.getId());
		//��֤�û��Ƿ񿪹�����
		String id = user.getId();
		if(userService.validateIfShop(id)){
			
			Shop shop1 = shopService.getOne(user.getShop_id());
			if(shop1.getShopstate()==1){
				MyUtils.box(resp, "��ĵ����ѱ���ͣʹ����");
				return "index";
			}
			
			session.setAttribute("shop", userService.getShop(id));
			
			//����֮ǰҪ��ȡҪ������̷�����ͼ��
			Shop shop = (Shop) session.getAttribute("shop");
			Integer shop_id = shop.getId();
			//��ҳ
			PageHelper.startPage(pn,9);
			List<Book> list1 = bookService.selectByShopID(shop_id);
			PageInfo<Book> list = new PageInfo<>(list1,15);
			//System.out.println("list1===============>"+list1.size());//9
			session.setAttribute("list", list);
			//׼ȷ��ʾ��ҳ��
			session.setAttribute("shopbook", "all");
			return "shop/shopmanager";
		}
		
		return "user/openshop";
	}
	
	//��ת�û���������
	@RequestMapping("userinfo.do")
	public String userInfo(String id,HttpSession session ){
		//��֤�û��Ƿ��¼
		User user = (User) session.getAttribute("user");
		if(user==null){
			return "user/login";
		}
		User user1 = userService.getOne(user.getId());
		session.setAttribute("user", user1);
		return "user/userinfo";
	}
	
	//��ת�û��޸ĸ�����Ϣҳ��
	@RequestMapping(value="updateuser.do",method=RequestMethod.GET)
	public String updateUserView(){
		return "user/updateuser";
	}
	
	//�޸��û���Ϣ
	@RequestMapping(value="updateuser.do",method=RequestMethod.POST)
	public String updateUser(HttpSession session,String name,String age,String email,HttpServletResponse resp) throws IOException{
		
		User user=(User) session.getAttribute("user");
		user.setName(name);
		user.setAge(Integer.valueOf(age));
		user.setEmail(email);
		userService.updateUser(user);
		//����
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out=resp.getWriter();
		out.print("<script>alert('�޸ĳɹ�');</script>");
		out.flush();
		return "user/userinfo";
	}
	
	//��ת�����ջ���ַ����
	@RequestMapping(value="address.do",method=RequestMethod.GET)
	public String addressView(HttpServletResponse resp,HttpSession session){
		User user = (User) session.getAttribute("user");
		if(user==null){
			MyUtils.box(resp, "���ȵ�¼");
			return "user/login";
		}
		List<Address> list = adDao.selectList(user.getId());
		session.setAttribute("adlist", list);
		return "user/address";
	}
	
	
	//�޸�����
	@RequestMapping("updatepassword.do")
	public String modifyPassword(HttpSession session,
			HttpServletResponse resp,
			String oldPassword,String newPassword1,String newPassword2){
		User user = (User)session.getAttribute("user");
		String id = user.getId();
		//��֤��ԭ�����Ƿ�һ��
		if(!user.getPassword().equals(oldPassword)){
			session.setAttribute("message", "��һ���޸�ʧ��ԭ����ԭ���벻һ��");
			MyUtils.box(resp,"ԭ���벻��ȷ");
			return "user/updateuser";
		}
		if(!newPassword1.equals(newPassword2)){
			session.setAttribute("message", "��һ���޸�ʧ��ԭ��������������벻һ��");
			MyUtils.box(resp,"������������벻һ��");
			return "user/updateuser";
		}
		userService.updatePassword(id, newPassword1);
		session.removeAttribute("message");
		MyUtils.box(resp,"�޸ĳɹ�,�����µ�¼");
		return "user/login";
	}
	
	//����ջ���ַ
	@RequestMapping(value="addAddress.do",method=RequestMethod.POST)
	public String addAdderss(HttpServletResponse resp,Address address,HttpSession session){
		User user = (User)session.getAttribute("user");
		System.out.println(user);
		String id=user.getId();
		address.setUser_id(id);
		System.out.println(address);
		adDao.add(address);
		MyUtils.box(resp, "��ӳɹ���");
		//����ˢ���б�
		List<Address> list = adDao.selectList(id);
		session.setAttribute("adlist", list);
		return "user/address";
	}
	
	//��ת�޸��ջ���ַ����
	@RequestMapping(value="updateaddress.do",method=RequestMethod.GET)
	public String updateAddressView(HttpSession session,String id){
		Address ad=adDao.selectOne(Integer.valueOf(id));
		session.setAttribute("ad", ad);
		return "user/addressupdate";
	}
	
	//�޸��ջ���ַ
	@RequestMapping(value="updateaddress.do",method=RequestMethod.POST)
	public String updateAddress(Address in ,HttpSession session,HttpServletResponse resp){
		Address ad=(Address) session.getAttribute("ad");
		User user = (User) session.getAttribute("user");
		System.out.println(in);
		
		ad.setRealname(in.getRealname());
		ad.setAddressdetail(in.getAddressdetail());
		ad.setPhone(in.getPhone());
		
		userService.updateAddress(ad);
		
		//����ˢ���б�
		List<Address> list = adDao.selectList(user.getId());
		session.setAttribute("adlist", list);
			//����
		MyUtils.box(resp, "�޸ĳɹ�");
		
		return "user/address";
	}
	
	//ɾ���ջ���ַ
	@RequestMapping("deleteAddress.do")
	public String deleteAddress(HttpSession session,HttpServletResponse resp,@RequestParam("id")String id){
		User user = (User) session.getAttribute("user");
		userService.deleAddress(Integer.valueOf(id));
		
		//����ˢ���б�
		List<Address> list = adDao.selectList(user.getId());
		session.setAttribute("adlist", list);
		
		MyUtils.box(resp, "ɾ���ɹ�");
		return "user/address";
	}
	
	//��ֵ���
	@RequestMapping("addmoney.do")
	public String addMoney(HttpServletResponse resp,HttpSession session ,Integer money){
		User user = (User)session.getAttribute("user");
		if(user==null){
			MyUtils.box(resp, "���ȵ�¼");
			return "user/login";
		}
		System.out.println("user---->"+user);
		double blance = (double)money;
		user.setBlance(blance+user.getBlance());
		userService.updateUser(user);
		return "user/userinfo";
	}
	
	
	
}
