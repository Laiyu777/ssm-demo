package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import common.MyUtils;
import dao.BookDao;
import dao.OrderDao;
import entity.Book;
import entity.Shop;
import entity.User;
import entity.vo.BookComment;
import entity.vo.UserKey;
import service.BookService;
import service.ShopService;
import service.UserService;

@Controller
public class BookController {
	@Autowired
	private BookService bookService;
	
	@Autowired
	private BookDao bookDao;
	
	@Autowired
	private ShopService shopService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private OrderDao odao;
	
	//��ת������ͼ�����
	@RequestMapping(path="updatebook.do",method=RequestMethod.GET)
	public String updateBookView(@RequestParam("id") String bookid,HttpSession session){
		//System.out.println("�������������������ҽ�����");
		int book_id = Integer.valueOf(bookid);
		Book book = bookService.getOne(book_id);
		System.out.println("==============>"+book);
		session.setAttribute("book", book);
		return "book/updatebook";
	}
	
	//����ͼ��
	@RequestMapping(path="updatebook.do",method=RequestMethod.POST)
	public String updateBook(HttpServletResponse resp,HttpSession session,Book book) throws IOException{
		//���ݽ�����bookֻ��form�е�ֵ��û��id��shop_id
		//System.out.println("----------"+book);
		//session�е�book����ȷ��
		//System.out.println((Book)session.getAttribute("book"));
		Book old = (Book) session.getAttribute("book");
		old.setName(book.getName());
		old.setDescription(book.getDescription());
		if(book.getStock()<=0||book.getPrice()<=0){
			resp.setContentType("text/html;chartset=UTF-8");
			PrintWriter pw=resp.getWriter();
			pw.println("<script>alert('ͼ����ͼ۸񶼱������0��');</script>");
			pw.flush();
			return "book/updatebook";
		}
		old.setPrice(book.getPrice());
		old.setStock(book.getStock());
		old.setKind(book.getKind());
		old.setKey(book.getKey());
		bookService.updateBook(old);
		
		PageHelper.startPage(1,9);
		List<Book> list1 = bookService.selectByShopID(old.getShop_id());
		PageInfo<Book> list2 = new PageInfo<>(list1,15);
		session.setAttribute("list", list2);
		//׼ȷ��ʾ��ҳ��
		session.setAttribute("shopbook", "all");
		
		return "shop/shopmanager";
	}
	
	//�¼�ͼ��
	@RequestMapping("bookdown.do")
	public String deleteBook(@RequestParam("id")String id1,HttpSession session){
		int id=Integer.valueOf(id1);
		bookService.bookdown(id);
		Shop shop=(Shop) session.getAttribute("shop");
		System.out.println(shop);
		//���½���
		//ˢ�½���
		PageHelper.startPage(1,9);
		List<Book> list1 = bookService.selectByShopID(shop.getId());
		PageInfo<Book> list=new PageInfo<>(list1,6);
		session.setAttribute("list", list);
		//������ҳ����
		List<Book> list2 = bookDao.selectAll();
		session.getServletContext().setAttribute("indexbooks", list2);
		return "shop/shopmanager";
	}
	
	//�¼�ͼ��
		@RequestMapping("bookup.do")
		public String upBook(@RequestParam("id")String id1,HttpSession session){
			int id=Integer.valueOf(id1);
			bookService.bookup(id);
			Shop shop=(Shop) session.getAttribute("shop");
			System.out.println(shop);
			//���½���
			//ˢ�½���
			PageHelper.startPage(1,9);
			List<Book> list1 = bookService.selectByShopID(shop.getId());
			PageInfo<Book> list=new PageInfo<>(list1,6);
			session.setAttribute("list", list);
			//������ҳ����
			List<Book> list2 = bookDao.selectAll();
			session.getServletContext().setAttribute("indexbooks", list2);
			return "shop/shopmanager";
		}
		
		
	
	
	
	//��ʾͼ������
	@RequestMapping(path="bookdetail.do",method=RequestMethod.GET)
	public String bookDetail(HttpServletResponse resp,@RequestParam(value="pn",defaultValue="1")int pn,@RequestParam("id")String id1,HttpSession session){
		User user = (User)session.getAttribute("user");
		int id=Integer.valueOf(id1);
		Book book = bookService.getOne(id);
		//�û������+1
		bookService.addClick(id);
		//����ɱ��Ʒ
		
		if(book.getIfkill()==1){
			session.setAttribute("ifkill", true);			
		}
		
		if(user!=null){
			//ȥ������ʹ������ϵͳ����
			session.setAttribute("please",false);
			//��ͼ��ؼ��ּ��뵽userkey�У��Ա��Ƽ�
			userService.addUserKey(user.getId(), book.getKey());
			//�ж��Ƿ��������
			if(ifUserBuy(book,user.getId())){
				session.setAttribute("ifbuy", true);
			}else{
				session.setAttribute("ifbuy", false);
			}
		}
		//System.out.println("book====>"+book);
		int shop_id = book.getShop_id();
		Shop shop  = shopService.getOne(shop_id);
		if(shop.getShopstate()==1){
			MyUtils.box(resp, "�õ����ѱ���ͣʹ�ã����ܹ����ͼ��");
			return "book/booklist";
		}
		//System.out.println("shop====>"+shop);
		session.setAttribute("shop", shop);
		session.setAttribute("book", book);
		
		PageHelper.startPage(pn, 4);
		List<BookComment> listComment2 = bookService.getCommentByBookID(book.getId());
		PageInfo<BookComment> listComment = new PageInfo<>(listComment2,5);
		session.setAttribute("listComment", listComment);
		
		return "book/bookdetail";
	}
	

	
	
	//��ʾ����ͼ��
	@RequestMapping("allbook.do")
	public String showAllBook(@RequestParam(value="pn",defaultValue="1")Integer pn,
			HttpSession session,
			@RequestParam(value="kind",required=false)String kind
			)
	{
		if (kind==null) {
			session.removeAttribute("kind");
			//�����Ƿ���ʾ�������
			session.setAttribute("ifsearchbook", false);
			PageHelper.startPage(pn, 12);
			List<Book> list1 = bookService.getAll();//select * from book order by date ASC
			Iterator<Book> it = list1.iterator();
			//û�п��Ͳ���ʾ�˻����Ѿ��¼ܾͲ���ʾ
			while (it.hasNext()) {
				Book book = it.next();
				if (book.getStock() <= 0 || book.getBookdown() == 1) {
					it.remove();
				}
			}
			//����ѯ������ȫ��ͼ�����pageinfo��
			PageInfo<Book> list = new PageInfo<>(list1, 15);
			session.setAttribute("list", list);
			session.setAttribute("showwhat", "all");
		}else{//������ѯ
			session.setAttribute("kind", kind);
			session.setAttribute("ifsearchbook", false);
			PageHelper.startPage(pn, 12);
			List<Book> list1 = bookService.getBookByKind(kind);
			Iterator<Book> it = list1.iterator();
			//û�п��Ͳ���ʾ�˻����Ѿ��¼ܾͲ���ʾ
			while (it.hasNext()) {
				Book book = it.next();
				if (book.getStock() <= 0 || book.getBookdown() == 1) {
					it.remove();
				}
			}
			//����ѯ������ȫ��ͼ�����pageinfo��
			PageInfo<Book> list = new PageInfo<>(list1, 15);
			session.setAttribute("list", list);
			session.setAttribute("showwhat", "all");
		}
		return "book/booklist";
	}
	
	
	
	
	@RequestMapping("discount.do")
	public String discount(){
		//��ѡ�񵽵�BookList����session�У���ʾ�ۿ���Ϣ��session��Ϊlist
		return "book/booklist";
	}
	
	//����Ϊ��ɱ��Ʒ�İ�ť����ת���޸���Ʒ�۸��ҳ��
	@RequestMapping("addkillpriceview.do")
	public String addkillpriceview(@RequestParam("id") int bookid,HttpSession session,HttpServletResponse resp){
		Book book = bookService.getOne(bookid);
		if(book.getIfkill()==1){
			MyUtils.box(resp, "�����Ʒ�Ѿ�����ɱ���ˣ�");
			return "shop/shopmanager";
		}
		session.setAttribute("book", book);
		return "book/addkillprice";
	}
	
	//��ԡ���Ϊ��ɱ��Ʒ����ť
	@RequestMapping("beacomekill.do")
	public String beacomekill(HttpSession session,String price,HttpServletResponse resp){
		Book book = (Book) session.getAttribute("book");
		//�ж��ַ����Ƿ�Ϊ��
		if(price.trim().length()==0||price==null){
			MyUtils.box(resp, "��������ɱ�۸�");
			session.setAttribute("message","��������ɱ�۸�");
			return "book/addkillprice";
		}
		//�ж����price�ǲ���һ��double
		Double d = null;
		try{
			 d = Double.parseDouble(price);
		}catch(Exception e){
			MyUtils.box(resp, "����ļ۸��ʽ����ȷ");
			session.setAttribute("message","����ļ۸��ʽ����ȷ");
			return "book/addkillprice";
		}
		//�жϼ۸��Ƿ�Ϊ��ǰ�۸��6������
		if(d>0.6*book.getPrice()){
			MyUtils.box(resp, "����ļ۸����С������");
			String message= "����ļ۸����С��6��(С��"+0.6*book.getPrice()+")";
			session.setAttribute("message",message);
			return "book/addkillprice";
		}else{
		session.removeAttribute("message");	}	
		bookService.discountPrice(book.getId(), d);
		MyUtils.box(resp, "�����ɱ��Ʒ�ɹ�");
		//ˢ�½���
		PageHelper.startPage(1,9);
		List<Book> list1 = bookService.getKillBooks();
		PageInfo<Book> list=new PageInfo<>(list1,6);
		session.setAttribute("list", list);
		
		return "book/booklist";
	}
	
	//��ʾ��ɱ��Ʒ
	@RequestMapping("showkillbook.do")
	public  String showkillbook(@RequestParam(value="pn",defaultValue="1")Integer pn,HttpSession session){
		session.setAttribute("ifsearchbook", false);
		PageHelper.startPage(pn,9);
		List<Book> list1 = bookService.getKillBooks();
		Iterator<Book> it = list1.iterator();
		while(it.hasNext()){
			Book book=it.next();
			if(book.getStock()<=0||book.getBookdown()==1){
				it.remove();
			}
		}
		PageInfo<Book> list = new PageInfo<>(list1,6);
		session.setAttribute("list", list);
		session.setAttribute("showwhat", "kill");
		return "book/booklist";
	}
	
	//��ʾ��ͨ��Ʒ
	@RequestMapping("showcommonbook.do")
	public  String showcommonbook(@RequestParam(value="pn",defaultValue="1")Integer pn,HttpSession session){
		session.setAttribute("ifsearchbook", false);
		PageHelper.startPage(pn,9);
		List<Book> list1 = bookService.getCommonBooks();
		Iterator<Book> it = list1.iterator();
		while(it.hasNext()){
			Book book=it.next();
			if(book.getStock()<=0||book.getBookdown()==1){
				it.remove();
			}
		}
		PageInfo<Book> list=new PageInfo<>(list1,6);
		session.setAttribute("showwhat","common");
		session.setAttribute("list", list);
		return "book/booklist";
	}
	@RequestMapping("cancelkill.do")
	public String cancelkill(HttpServletResponse resp,@RequestParam("id")int book_id){
		Book book = bookService.getOne(book_id);
		bookService.cancelKill(book.getId());
		MyUtils.box(resp, "ȡ���ɹ���");
		return "forward:openshopView.do";
	}
	
	
	//����ͼ��
	@RequestMapping(value="searchbook.do",method=RequestMethod.POST)
	public String sesearchbook(@RequestParam(value="pn",defaultValue="1")Integer pn,String key,HttpSession session) throws UnsupportedEncodingException{
		String key1 = null;
		if (key!=null) {
			//System.out.println("key================>"+key);
			//��֤������ַ���
			if (key.trim().length() == 0) {
				//MyUtils.box(resp, "���벻�Ϸ�");
				return "redirect:index.jsp";
			}
			key1 = key.trim();
			session.setAttribute("key1", key1);
		}
		//����û���Ϊ�� �����ӹؼ��ֵ����ݿ�
		User user = (User) session.getAttribute("user");
		if(user!=null){
			userService.addUserKey(user.getId(), key1);
		}
		//Ϊ��ȥ�������ͨͼ�飬��ɱͼ�飬����ͼ�鵱�еġ��ؼ���...������¼...��
		session.setAttribute("ifsearchbook", true);
		
		PageHelper.startPage(pn,9);
		List<Book> results1=bookService.search(key1);
		Iterator<Book> it1 = results1.iterator();
		while(it1.hasNext()){
			Book book = it1.next();
			if(book.getStock()<=0 || book.getBookdown()==1){
				it1.remove();
			}
		}
		
		PageInfo<Book> results=new PageInfo<>(results1,10);
		
		if(results.getList().size()==0){
			String m="û���ҵ�����'"+key1+"'�����ͼ��";
			session.setAttribute("result", m);
		}else{
			String message = "�ؼ��֣�"+key1+"�����������"+results.getTotal()+"��";
			session.setAttribute("result",message );
			session.setAttribute("list", results);
			//�����������ҳ����ʾ������ kill common search all
			session.setAttribute("showwhat", "search");
		}
		
		Set<UserKey> userKeys = null;
		if (user!=null) {
			//���û������Ĺؼ��ʷ���session��
			List<UserKey> userKeys2 = userService.getUserKeys(user.getId());
			userKeys = new LinkedHashSet<>();
			userKeys.addAll(userKeys2);
			session.setAttribute("userKeys", userKeys);
			
			
		}
		Set<Book> booksForUser = null;
		if (userKeys!=null) {
			//��ʾΪ�û����Ƶ�ͼ�飬����ǰ3���ؼ�������ʾ
			Iterator<UserKey> it = userKeys.iterator();
			//set��ȡ��ǰ�����ؼ���
			String[] keys = new String[3];
			for (int i = 0; i < 3; i++) {
				if (it.hasNext()) {
					keys[i] = it.next().getUser_key();
					System.out.println("keys=====>"+keys[i]);
				}
			}
			booksForUser = new LinkedHashSet<>();
			for (String key2 : keys) {
				List<Book> tempList = bookService.search(key2);
				booksForUser.addAll(tempList);
			}
			if (booksForUser.size() == 0) {
				session.setAttribute("please", true);
			} else {
				session.setAttribute("please", false);
			} 
		}
		session.setAttribute("booksForUser", booksForUser);
		
		return "book/booklist";
	}
	
	@RequestMapping(value="searchbook.do",method=RequestMethod.GET)
	public String searchBookPage(HttpServletRequest req,@RequestParam(value="pn",defaultValue="1")Integer pn,@RequestParam("key")String key , HttpSession session) throws UnsupportedEncodingException{
		//URIEncoding="UTF-8"
		//��server.xml������<Connector URIEncoding="UTF-8" connectionTimeout="20000" port="8080" protocol="HTTP/1.1" redirectPort="8443"/>
		PageHelper.startPage(pn,9);
		List<Book> books=bookService.search(key);
		PageInfo<Book> result=new PageInfo<>(books,10);
		session.setAttribute("list", result);
		return "book/booklist";
	}
	
	//�ϴ�ͼƬ�ļ�
	@RequestMapping("uploadimg.do")
	public String uploadimg(HttpServletRequest request,HttpServletResponse resp,HttpSession session,@RequestParam("file")MultipartFile file,@RequestParam("id")int book_id) throws IOException{
		Book book=(Book) session.getAttribute("book");
		//��֤file�Ƿ�Ϊ��
		if(file==null){
			MyUtils.box(resp, "�ļ�����Ϊ�� ");
		}
		//��ȡĿ��·�����ϴ��ļ�������
		String targetPath=session.getServletContext().getRealPath("/static/images/bookimg");
		String filename=file.getOriginalFilename();
		//�жϺ�׺��
		int i = filename.lastIndexOf(".");
		String dot=filename.substring(i+1);
		System.out.println("dot========>"+dot);
		if(!"jpg".equals(dot)){
			MyUtils.box(resp, "�ϴ����ļ���ʽ����");
			return "book/updatebook";
		}
		//�������ϴ����ļ�
		String newFileName=book.getId()+"."+dot;
		//�½��ļ�
		File newFile = new File(targetPath,newFileName);
		//�ļ��ϴ�
		//File newFile  = new File(targetPath);
		FileUtils.copyInputStreamToFile(file.getInputStream(), newFile);
		MyUtils.box(resp, "�ϴ��ɹ�");
		return "shop/shopmanager";
	}
	
	private boolean ifUserBuy(Book book,String user_id){
		//����ϸ�ڱ��л�ȡ�û��Ƿ���
		//select book_id from `order_detail` 
		//where order_id in (select id from `order` where buyerid=#{id})
		List<Integer> list = odao.getBookIdIfUserBuy(user_id);
		for(int i : list){
			//����Integer�Ƚ���equals
			if(bookService.getOne(i).getId().equals(book.getId())){
				return true;
			}
		}
		return false;
	}
	
	@RequestMapping(value="addcomment.do",method=RequestMethod.POST)
	public String addComment(HttpSession session,String comment){
		if(comment.trim().length()==0 || comment ==null){
			session.setAttribute("message", "���۲���Ϊ��");
		}else{
			session.removeAttribute("message");
		}
		Book book = (Book) session.getAttribute("book");
		User user = (User)session.getAttribute("user");
		bookService.addBookComment(user.getId(), book.getId(), comment);
		return "redirect:bookdetail.do?id="+book.getId();
	}
	
	@RequestMapping("getbookbyclick.do")
	public String getbookbydate(HttpSession session,@RequestParam(value="pn",defaultValue="1")Integer pn){
		session.setAttribute("ifsearchbook", false);
		PageHelper.startPage(pn, 12);
		List<Book> list1 = bookService.getBookClick();//select * from book order by date ASC
		Iterator<Book> it = list1.iterator();
		//û�п��Ͳ���ʾ��
		while(it.hasNext()){
			Book book = it.next();
			if(book.getStock()<=0||book.getBookdown()==1){
				it.remove();
			}
			
		}
		//����ѯ������ȫ��ͼ�����pageinfo��
		PageInfo<Book> list=new PageInfo<>(list1,15);
		//List<Book> list= new ArrayList<>();
		
		session.setAttribute("list", list);
		session.setAttribute("showwhat","allbyclick");
		return "book/booklist";
	}
	
	@RequestMapping("getbookbysalecount.do")
	public String getbookbysalecount(HttpSession session,@RequestParam(value="pn",defaultValue="1")Integer pn){
		session.setAttribute("ifsearchbook", false);
		PageHelper.startPage(pn, 12);
		List<Book> list1 = bookService.getBookBySaleCount();//select * from book order by date ASC
		Iterator<Book> it = list1.iterator();
		//û�п��Ͳ���ʾ��
		while(it.hasNext()){
			Book book = it.next();
			if(book.getStock()<=0||book.getBookdown()==1){
				it.remove();
			}
			
		}
		//����ѯ������ȫ��ͼ�����pageinfo��
		PageInfo<Book> list=new PageInfo<>(list1,15);
		//List<Book> list= new ArrayList<>();
		
		session.setAttribute("list", list);
		session.setAttribute("showwhat","allbysalecount");
		return "book/booklist";
	}
	
	
}
