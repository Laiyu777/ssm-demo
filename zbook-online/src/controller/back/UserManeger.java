package controller.back;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import common.MyUtils;
import dao.AddressDao;
import dao.AdminDao;
import dao.BookDao;
import dao.CartDao;
import dao.OrderDao;
import dao.ShopDao;
import dao.UserDao;
import entity.Address;
import entity.Admin;
import entity.Book;
import entity.Order;
import entity.Shop;
import entity.User;
import entity.vo.BookHelp;
import entity.vo.OrderDetail;

@Controller
@RequestMapping("/admin/")
public class UserManeger {
	@Autowired
	private AdminDao adao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private BookDao bookDao;
	@Autowired
	private ShopDao shopDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private CartDao cartDao;
	@Autowired
	private AddressDao addressDao;
	
	@RequestMapping("backindex.do")
	public String index(HttpSession session){
		getWebData(session);
		return "back/backindex";
	}
	
	@RequestMapping("login.do")
	public String login(HttpSession session,HttpServletResponse resp,String id,String password){
		Admin admin=adao.login(id, password);
		if(admin==null){
			//MyUtils.box(resp, "��¼ʧ��");
			session.setAttribute("message", "��¼ʧ�ܣ�");
			return "redirect:../backlogin.jsp";
		}
		if(admin.getId().equals(id)&&admin.getPassword().equals(password)){
			//��ȡ��ǰʱ�� ��ȡ��վ��������   ��ȡͼ������ ��ȡע���û� ��ȡ�м����û�������� 
			getWebData(session);
			return "back/backindex";
		}
		
		
		return "redirect:../backlogin.jsp";
	}
	
	private void getWebData(HttpSession session){
		//��ǰʱ��
		DateFormat format= new SimpleDateFormat("yyyy��MM��dd�� HHʱmm��ss��");
		String time= format.format(MyUtils.getNowTime());
		session.setAttribute("time", time);
		//ע���û�
		session.setAttribute("usercount", adao.showAllUser().size());
		//��������
		session.setAttribute("shopcount",shopDao.showAll().size());
		//ͼ������
		session.setAttribute("bookcount", bookDao.selectAll().size());
		//��������
		session.setAttribute("ordercount", orderDao.showAll().size());
		
		
	}
	
	@RequestMapping("user.do")
	public String showAllUsers(HttpServletRequest req,@RequestParam(value="key",required=false)String key,@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) throws UnsupportedEncodingException{
		req.setCharacterEncoding("UTF-8");
		if(key==null){
			req.removeAttribute("key");
			PageHelper.startPage(pn, 10);
			List<User> users=adao.showAllUser();
			PageInfo<User> page=new PageInfo<>(users,6);
			usePage(model, page);
		}else{
			req.setAttribute("key", key);
			PageHelper.startPage(pn, 10);
			List<User> users=userDao.getUserByInputUserId(key);
			PageInfo<User> page = new PageInfo<>(users,6);
			usePage(model, page);
		}
		return "back/userManager";
	}
	
	@RequestMapping("stopuser.do")//�����û�
	public String deleteUser(@RequestParam("id")String id){
		adao.delete(id);
		return "forward:user.do";
	}
	
	@RequestMapping("cancelstop.do")
	public String cancelStop(@RequestParam("id")String id){
		adao.cancelstop(id);
		return "forward:user.do";
	}
	
	@RequestMapping("updateview.do")
	public String updateUser(@RequestParam("id")String user_id,Model model){
		User user = userDao.selectOne(user_id);
		model.addAttribute("user", user);
		return "back/modifyuser";
	}
	

	//ҳ��ʹ�÷�ҳ
	private <T> void usePage(Model model, PageInfo<T> page) {
		model.addAttribute("page", page.getList());
		int[] i = page.getNavigatepageNums();
		model.addAttribute("pagenavigatepages", i);
		model.addAttribute("pagetotal", page.getTotal());
		model.addAttribute("pageNum",page.getPageNum());
		model.addAttribute("pages",page.getPages());
	}
	
	@RequestMapping("updateUser.do")
	public String updateUser(User user){//������ݻ��Ե�ʱ�����õ���idΪ��δ���衯����������user����shopid��Integer�����������һ��string
		User user2=user;
		if(null==user.getShop_id()){
			user2.setShop_id(null);
		}
		userDao.update(user2);
		return "forward:user.do";
	}
	
	@RequestMapping("shop.do")
	public String shopView(HttpServletRequest req,@RequestParam(value="key",required=false)String key,@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) throws UnsupportedEncodingException{
		req.setCharacterEncoding("UTF-8");
		
			PageHelper.startPage(pn, 10);
			List<Shop> list = shopDao.showAll();
			PageInfo<Shop> shops=new PageInfo<>(list,15);
			usePage(model,shops);
			return "back/shopmanager";
			
	}
	
	@RequestMapping("searchshop.do")
	public String serchShopByname(String key,Model model){
		List<Shop> list=shopDao.getShopsByName(key);
		PageInfo<Shop> shops=new PageInfo<>(list,5);
		usePage(model,shops);
		return "back/shopmanager";
	}
		
	
	
	@RequestMapping("deleteshop.do")
	public String deleteShop(HttpServletResponse resp,@RequestParam("id")Integer id){
		Shop shop=shopDao.selectById(id);
		
		//���µ��̵�shopstate�ֶ�Ϊ1
		shopDao.stopShop(shop.getId());
		
		
		return "forward:shop.do";
	}
	
	@RequestMapping("regainshop.do")
	public String regainShop(@RequestParam("id")Integer id){
		Shop shop=shopDao.selectById(id);
		
		//���µ��̵�shopstate�ֶ�Ϊ1
		shopDao.regainShop(shop.getId());
		
		
		return "forward:shop.do";
	}
	
	@RequestMapping("updateshopview.do")
	public String updateshopview(@RequestParam("id")Integer id,Model model){
		Shop shop = shopDao.selectById(id);
		model.addAttribute("shop",shop);
		User user = userDao.getUserByShopId(id);
		model.addAttribute("username", user.getName());
		return "back/modifyshop";
	}
	
	@RequestMapping("updateShop.do")
	public String updateShop(Integer id,String name ,String description){
		Shop shop = shopDao.selectById(id);
		shop.setName(name);
		shop.setDescription(description);
		shopDao.update(shop);
		return "forward:shop.do";
	}
	
	@RequestMapping("order.do")
	public String orderView(HttpServletRequest req,@RequestParam(value="key",required=false)String key,
			@RequestParam(value="pn",defaultValue="1")Integer pn,
			Model model) throws UnsupportedEncodingException{
		req.setCharacterEncoding("UTF-8");
		
			PageHelper.startPage(pn, 8);
			List<Order> list = orderDao.showAll();
			PageInfo<Order> orders=new PageInfo<>(list,5);
			usePage(model,orders);
			return "back/ordermanager";
	}
	
	//���ݶ���id��������
	@RequestMapping("searchorder.do")
	public String serchOrder(String key,Model model,@RequestParam(value="pn",defaultValue="1")Integer pn){
		
		//"select * from `order` where id like concat('%',#{key},'%')"
		List<Order> list=orderDao.selectOrderByKeyUserId(key);
		PageInfo<Order> shops=new PageInfo<>(list);
		usePage(model,shops);
		return "back/ordermanager";
	}
	
	//����ͼ�������������ͼ��
	@RequestMapping("searchorderbybookname.do")
	public String serchOrderByBookName(String key,Model model,@RequestParam(value="pn",defaultValue="1")Integer pn){
		
		List<Order> list=orderDao.serchOrderByBookName(key);
		PageInfo<Order> shops=new PageInfo<>(list);
		usePage(model,shops);
		return "back/ordermanager";
	}
	
	
	@RequestMapping("deleteorder.do")
	public String delete(@RequestParam("id")Integer id){
		orderDao.deleteDetailByOrderId(id);
		orderDao.delete(id);
		return "forward:order.do";
	}
	
	@RequestMapping("book.do")
	public String bookView(HttpServletRequest req,@RequestParam(value="key",required=false)String key,
			@RequestParam(value="pn",defaultValue="1")Integer pn,
			Model model) throws UnsupportedEncodingException{
		req.setCharacterEncoding("UTF-8");
		
			PageHelper.startPage(pn, 8);
			List<Book> list = bookDao.selectAll();
			PageInfo<Book> books=new PageInfo<>(list,15);
			usePage(model,books);
			return "back/bookmanager";
	}
	
	@RequestMapping("searchbook.do")
	public String serchBook(String key,Model model,@RequestParam(value="pn",defaultValue="1")Integer pn){
		
		List<Book> list=bookDao.search(key);
		PageInfo<Book> books=new PageInfo<>(list);
		usePage(model,books);
		return "back/bookmanager";
	}
	
	@RequestMapping("deletebook.do")
	public String deleteBook(HttpServletResponse resp,@RequestParam("id")Integer id){
		//�ж϶������Ƿ�����Ӧ��ͼ�飬�еĻ��Ͳ���ɾ��
		List<Integer> list = orderDao.getBookIdListInOrderDetail(id);
		if(list.contains(id)){
			MyUtils.box(resp, "����������Ӧͼ�飬�޷�ɾ��");
			return "back/bookmanager";
		}
		
		//ɾ�����ﳵ������
		cartDao.deleteByBookId(id);
		//ɾ������ϸ�ڵ�����
		orderDao.deleteDetailByBookId(id);
		
		//ɾ��ͼ������
		bookDao.deleteBookCommentByBookId(id);
		//ɾ��ͼ��
		bookDao.deleteBook(id);
		return "forward:book.do";
	}
	
	//�༭ͼ��
	@RequestMapping("updatebookview.do")
	public String updateBookView(@RequestParam("id")Integer id,Model model){
		Book book=bookDao.selectOne(id);
		model.addAttribute("book", book);
		Shop shop=shopDao.selectById(book.getShop_id());
		model.addAttribute("shop_id", shop.getId());
		return "back/modifybook";
	}
	
	@RequestMapping("updateBook.do")
	public String updateBook(Book book,Model model){
		bookDao.updateBook(book);
		return "forward:book.do";
	}
	
	
	@RequestMapping("backorderdetail.do")
	public String backorderdetail(Integer id,Model model){
		Order order = orderDao.selectOne(id);
		model.addAttribute("order", order);
		//��ȡ������Ŀ
		List<OrderDetail> odList = orderDao.getOrderDetailByOrderId(order.getId());
		List<BookHelp> bhList = new ArrayList<>();
		for(OrderDetail od:odList){
			BookHelp bh=new BookHelp();
			Book book = bookDao.selectOne(od.getBook_id());
			bh.setBook(book);
			bh.setCount(od.getCount());
			bhList.add(bh);
		}
		model.addAttribute("orderitems", bhList);
		//��ȡ�����ջ�����Ϣ
		Address address = addressDao.selectOne(order.getAddressid());
		model.addAttribute("address",address);
		return "back/orderdetail";
	}
}
