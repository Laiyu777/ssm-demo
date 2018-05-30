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
	
	//跳转到更新图书界面
	@RequestMapping(path="updatebook.do",method=RequestMethod.GET)
	public String updateBookView(@RequestParam("id") String bookid,HttpSession session){
		//System.out.println("！！！！！！！！！我进来了");
		int book_id = Integer.valueOf(bookid);
		Book book = bookService.getOne(book_id);
		System.out.println("==============>"+book);
		session.setAttribute("book", book);
		return "book/updatebook";
	}
	
	//更新图书
	@RequestMapping(path="updatebook.do",method=RequestMethod.POST)
	public String updateBook(HttpServletResponse resp,HttpSession session,Book book) throws IOException{
		//传递进来的book只有form中的值，没有id和shop_id
		//System.out.println("----------"+book);
		//session中的book是正确的
		//System.out.println((Book)session.getAttribute("book"));
		Book old = (Book) session.getAttribute("book");
		old.setName(book.getName());
		old.setDescription(book.getDescription());
		if(book.getStock()<=0||book.getPrice()<=0){
			resp.setContentType("text/html;chartset=UTF-8");
			PrintWriter pw=resp.getWriter();
			pw.println("<script>alert('图书库存和价格都必须大于0！');</script>");
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
		//准确显示分页条
		session.setAttribute("shopbook", "all");
		
		return "shop/shopmanager";
	}
	
	//下架图书
	@RequestMapping("bookdown.do")
	public String deleteBook(@RequestParam("id")String id1,HttpSession session){
		int id=Integer.valueOf(id1);
		bookService.bookdown(id);
		Shop shop=(Shop) session.getAttribute("shop");
		System.out.println(shop);
		//更新界面
		//刷新界面
		PageHelper.startPage(1,9);
		List<Book> list1 = bookService.selectByShopID(shop.getId());
		PageInfo<Book> list=new PageInfo<>(list1,6);
		session.setAttribute("list", list);
		//更新主页数据
		List<Book> list2 = bookDao.selectAll();
		session.getServletContext().setAttribute("indexbooks", list2);
		return "shop/shopmanager";
	}
	
	//下架图书
		@RequestMapping("bookup.do")
		public String upBook(@RequestParam("id")String id1,HttpSession session){
			int id=Integer.valueOf(id1);
			bookService.bookup(id);
			Shop shop=(Shop) session.getAttribute("shop");
			System.out.println(shop);
			//更新界面
			//刷新界面
			PageHelper.startPage(1,9);
			List<Book> list1 = bookService.selectByShopID(shop.getId());
			PageInfo<Book> list=new PageInfo<>(list1,6);
			session.setAttribute("list", list);
			//更新主页数据
			List<Book> list2 = bookDao.selectAll();
			session.getServletContext().setAttribute("indexbooks", list2);
			return "shop/shopmanager";
		}
		
		
	
	
	
	//显示图书详情
	@RequestMapping(path="bookdetail.do",method=RequestMethod.GET)
	public String bookDetail(HttpServletResponse resp,@RequestParam(value="pn",defaultValue="1")int pn,@RequestParam("id")String id1,HttpSession session){
		User user = (User)session.getAttribute("user");
		int id=Integer.valueOf(id1);
		Book book = bookService.getOne(id);
		//用户浏览量+1
		bookService.addClick(id);
		//是秒杀商品
		
		if(book.getIfkill()==1){
			session.setAttribute("ifkill", true);			
		}
		
		if(user!=null){
			//去除请多多使用我们系统字样
			session.setAttribute("please",false);
			//将图书关键字加入到userkey中，以便推荐
			userService.addUserKey(user.getId(), book.getKey());
			//判断是否可以评价
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
			MyUtils.box(resp, "该店铺已被暂停使用，不能购买该图书");
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
	

	
	
	//显示所有图书
	@RequestMapping("allbook.do")
	public String showAllBook(@RequestParam(value="pn",defaultValue="1")Integer pn,
			HttpSession session,
			@RequestParam(value="kind",required=false)String kind
			)
	{
		if (kind==null) {
			session.removeAttribute("kind");
			//控制是否显示搜索结果
			session.setAttribute("ifsearchbook", false);
			PageHelper.startPage(pn, 12);
			List<Book> list1 = bookService.getAll();//select * from book order by date ASC
			Iterator<Book> it = list1.iterator();
			//没有库存就不显示了或者已经下架就不显示
			while (it.hasNext()) {
				Book book = it.next();
				if (book.getStock() <= 0 || book.getBookdown() == 1) {
					it.remove();
				}
			}
			//将查询出来的全部图书放入pageinfo中
			PageInfo<Book> list = new PageInfo<>(list1, 15);
			session.setAttribute("list", list);
			session.setAttribute("showwhat", "all");
		}else{//按类别查询
			session.setAttribute("kind", kind);
			session.setAttribute("ifsearchbook", false);
			PageHelper.startPage(pn, 12);
			List<Book> list1 = bookService.getBookByKind(kind);
			Iterator<Book> it = list1.iterator();
			//没有库存就不显示了或者已经下架就不显示
			while (it.hasNext()) {
				Book book = it.next();
				if (book.getStock() <= 0 || book.getBookdown() == 1) {
					it.remove();
				}
			}
			//将查询出来的全部图书放入pageinfo中
			PageInfo<Book> list = new PageInfo<>(list1, 15);
			session.setAttribute("list", list);
			session.setAttribute("showwhat", "all");
		}
		return "book/booklist";
	}
	
	
	
	
	@RequestMapping("discount.do")
	public String discount(){
		//将选择到的BookList放入session中，显示折扣信息，session名为list
		return "book/booklist";
	}
	
	//‘成为秒杀商品的按钮’跳转至修改商品价格的页面
	@RequestMapping("addkillpriceview.do")
	public String addkillpriceview(@RequestParam("id") int bookid,HttpSession session,HttpServletResponse resp){
		Book book = bookService.getOne(bookid);
		if(book.getIfkill()==1){
			MyUtils.box(resp, "这个商品已经在秒杀中了！");
			return "shop/shopmanager";
		}
		session.setAttribute("book", book);
		return "book/addkillprice";
	}
	
	//针对‘成为秒杀商品’按钮
	@RequestMapping("beacomekill.do")
	public String beacomekill(HttpSession session,String price,HttpServletResponse resp){
		Book book = (Book) session.getAttribute("book");
		//判断字符串是否为空
		if(price.trim().length()==0||price==null){
			MyUtils.box(resp, "请输入秒杀价格");
			session.setAttribute("message","请输入秒杀价格");
			return "book/addkillprice";
		}
		//判断这个price是不是一个double
		Double d = null;
		try{
			 d = Double.parseDouble(price);
		}catch(Exception e){
			MyUtils.box(resp, "输入的价格格式不正确");
			session.setAttribute("message","输入的价格格式不正确");
			return "book/addkillprice";
		}
		//判断价格是否为当前价格的6折以下
		if(d>0.6*book.getPrice()){
			MyUtils.box(resp, "输入的价格必须小于六折");
			String message= "输入的价格必须小于6折(小于"+0.6*book.getPrice()+")";
			session.setAttribute("message",message);
			return "book/addkillprice";
		}else{
		session.removeAttribute("message");	}	
		bookService.discountPrice(book.getId(), d);
		MyUtils.box(resp, "添加秒杀商品成功");
		//刷新界面
		PageHelper.startPage(1,9);
		List<Book> list1 = bookService.getKillBooks();
		PageInfo<Book> list=new PageInfo<>(list1,6);
		session.setAttribute("list", list);
		
		return "book/booklist";
	}
	
	//显示秒杀商品
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
	
	//显示普通商品
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
		MyUtils.box(resp, "取消成功！");
		return "forward:openshopView.do";
	}
	
	
	//搜索图书
	@RequestMapping(value="searchbook.do",method=RequestMethod.POST)
	public String sesearchbook(@RequestParam(value="pn",defaultValue="1")Integer pn,String key,HttpSession session) throws UnsupportedEncodingException{
		String key1 = null;
		if (key!=null) {
			//System.out.println("key================>"+key);
			//验证输入的字符串
			if (key.trim().length() == 0) {
				//MyUtils.box(resp, "输入不合法");
				return "redirect:index.jsp";
			}
			key1 = key.trim();
			session.setAttribute("key1", key1);
		}
		//如果用户不为空 则增加关键字到数据库
		User user = (User) session.getAttribute("user");
		if(user!=null){
			userService.addUserKey(user.getId(), key1);
		}
		//为了去除点击普通图书，秒杀图书，所有图书当中的“关键字...搜索记录...”
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
			String m="没有找到关于'"+key1+"'的相关图书";
			session.setAttribute("result", m);
		}else{
			String message = "关键字："+key1+"，搜索结果："+results.getTotal()+"本";
			session.setAttribute("result",message );
			session.setAttribute("list", results);
			//决定了下面分页条显示是哪种 kill common search all
			session.setAttribute("showwhat", "search");
		}
		
		Set<UserKey> userKeys = null;
		if (user!=null) {
			//将用户搜索的关键词放入session中
			List<UserKey> userKeys2 = userService.getUserKeys(user.getId());
			userKeys = new LinkedHashSet<>();
			userKeys.addAll(userKeys2);
			session.setAttribute("userKeys", userKeys);
			
			
		}
		Set<Book> booksForUser = null;
		if (userKeys!=null) {
			//显示为用户定制的图书，根据前3个关键字来显示
			Iterator<UserKey> it = userKeys.iterator();
			//set中取出前三个关键字
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
		//在server.xml中设置<Connector URIEncoding="UTF-8" connectionTimeout="20000" port="8080" protocol="HTTP/1.1" redirectPort="8443"/>
		PageHelper.startPage(pn,9);
		List<Book> books=bookService.search(key);
		PageInfo<Book> result=new PageInfo<>(books,10);
		session.setAttribute("list", result);
		return "book/booklist";
	}
	
	//上传图片文件
	@RequestMapping("uploadimg.do")
	public String uploadimg(HttpServletRequest request,HttpServletResponse resp,HttpSession session,@RequestParam("file")MultipartFile file,@RequestParam("id")int book_id) throws IOException{
		Book book=(Book) session.getAttribute("book");
		//验证file是否为空
		if(file==null){
			MyUtils.box(resp, "文件不能为空 ");
		}
		//获取目标路径和上传文件的名字
		String targetPath=session.getServletContext().getRealPath("/static/images/bookimg");
		String filename=file.getOriginalFilename();
		//判断后缀名
		int i = filename.lastIndexOf(".");
		String dot=filename.substring(i+1);
		System.out.println("dot========>"+dot);
		if(!"jpg".equals(dot)){
			MyUtils.box(resp, "上传的文件格式不对");
			return "book/updatebook";
		}
		//重命名上传的文件
		String newFileName=book.getId()+"."+dot;
		//新建文件
		File newFile = new File(targetPath,newFileName);
		//文件上传
		//File newFile  = new File(targetPath);
		FileUtils.copyInputStreamToFile(file.getInputStream(), newFile);
		MyUtils.box(resp, "上传成功");
		return "shop/shopmanager";
	}
	
	private boolean ifUserBuy(Book book,String user_id){
		//订单细节表中获取用户是否购买
		//select book_id from `order_detail` 
		//where order_id in (select id from `order` where buyerid=#{id})
		List<Integer> list = odao.getBookIdIfUserBuy(user_id);
		for(int i : list){
			//两个Integer比较用equals
			if(bookService.getOne(i).getId().equals(book.getId())){
				return true;
			}
		}
		return false;
	}
	
	@RequestMapping(value="addcomment.do",method=RequestMethod.POST)
	public String addComment(HttpSession session,String comment){
		if(comment.trim().length()==0 || comment ==null){
			session.setAttribute("message", "评论不能为空");
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
		//没有库存就不显示了
		while(it.hasNext()){
			Book book = it.next();
			if(book.getStock()<=0||book.getBookdown()==1){
				it.remove();
			}
			
		}
		//将查询出来的全部图书放入pageinfo中
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
		//没有库存就不显示了
		while(it.hasNext()){
			Book book = it.next();
			if(book.getStock()<=0||book.getBookdown()==1){
				it.remove();
			}
			
		}
		//将查询出来的全部图书放入pageinfo中
		PageInfo<Book> list=new PageInfo<>(list1,15);
		//List<Book> list= new ArrayList<>();
		
		session.setAttribute("list", list);
		session.setAttribute("showwhat","allbysalecount");
		return "book/booklist";
	}
	
	
}
