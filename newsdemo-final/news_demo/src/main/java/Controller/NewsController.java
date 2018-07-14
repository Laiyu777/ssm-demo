package Controller;

import Entity.Menu;
import Entity.New;
import Entity.NewFile;
import Entity.User;
import Help.Message;
import Help.Utils;
import Service.MenuService;
import Service.NewsService;
import com.github.pagehelper.PageInfo;
import net.sf.json.JSONArray;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by Administrator on 2018/5/28.
 */
@Controller
@RequestMapping("/user/news")
public class NewsController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private NewsService newsService;




//    @ResponseBody
//    @RequestMapping(value = "/publishNews", method = RequestMethod.POST)
//    public String get(@RequestParam("files")CommonsMultipartFile[] files, Map<String,String> map, New _new, String content){
//        System.out.println("文件:"+ files);
//        for(int i = 0; i< files.length; i++){
//            System.out.println("文件名："+ files[i].getOriginalFilename());
//        }
//       // System.out.println("文件名："+fileNames);
//        System.out.println("map:"+map);
//        System.out.println("new:"+_new);
//        System.out.println("内容是:"+content);
//        return "发布成功";
//    }

    //跳转到修改菜单界面
    @RequestMapping(value = "/manageColumns",method = RequestMethod.GET)
    public String gotoManageNewsColumnsJsp(HttpServletRequest request){
        request.setAttribute("menus",menuService.getAllMenus());
        return "admin/manageColumns";
    }

    //修改菜单
    @RequestMapping(value ="/manageColumns",method = RequestMethod.POST,produces = "application/json")
    @ResponseBody
    public Message modifyColumns(HttpSession session, @RequestBody List<Menu> menus){
        System.out.println("菜单是："+menus);
        try {
            menuService.updateMenu(menus);
            //更新session中的菜单值
            session.setAttribute("menuList",menus);
            return new Message(200,"修改成功");
        }catch (Exception e){
            return new Message(400,"修改失败，请稍后再试");
        }
    }

    @RequestMapping(value = "/publishNews",method = RequestMethod.GET)
    public String gotoPublishNewsJsp(HttpServletRequest  request){
        //构建菜单
        List<Menu> menuList = menuService.getAllMenus();
        JSONArray jsonArray = JSONArray.fromObject(menuList);
        request.setAttribute("menuList",jsonArray);
        return "admin/publishNews";
    }

    @ResponseBody
    @RequestMapping(value = "/publishNews",method = RequestMethod.POST)
    public Message publishNews(New _new,
                               HttpSession session,HttpServletRequest request,
                               @RequestParam("files")CommonsMultipartFile[] files){
        try {
            User user = (User) session.getAttribute("user");
            long id = System.currentTimeMillis();
            _new.setId(id);
            _new.setUser(user);
            _new.setCreateTime(new Timestamp(id));
            _new.setLastTime(new Timestamp(id));
            //System.out.println("前台传过来的new："+_new);
            //处理文件上传
            processFileUpload(request,files);
            //处理new中文件列表的问题
            fillNewsMap(_new,files);
            //处理文章状态
            processNewsStatus(_new,user);

            newsService.insertOneNew(_new);

            return new Message(200,"发布成功,文章编号是:"+id);
        }catch(Exception e){
            e.printStackTrace();
            return new Message(400,e.getMessage());
        }
    }

    //处理form中文件的上传
    public void processFileUpload(HttpServletRequest request,CommonsMultipartFile[] files) throws Exception {
        String realPath = request.getServletContext().getRealPath("/static/news_files/");
        for(CommonsMultipartFile file : files){
            String fileName = file.getOriginalFilename();
           if(!fileName.equals("")){
               File file1 = new File(realPath,fileName);
               try {
                   if(!file1.exists()){
                       file.transferTo(file1);
                   }else {
                       throw new Exception("发布失败，文件已经存在，请重新命名文件");
                   }
               } catch (IOException e) {
                   e.printStackTrace();
               }
           }
        }
    }

    //处理new中文件列表的问题
    public void fillNewsMap(New _new,CommonsMultipartFile[] files){
        List<NewFile> list = new ArrayList<NewFile>();
        for(CommonsMultipartFile file : files){
           if(file.getSize()>0){
               String fileName = file.getOriginalFilename();
               NewFile newFile = new NewFile();
               newFile.setFileName(fileName);
               newFile.setNewId(_new.getId());
               list.add(newFile);
           }
        }
        _new.setNewFileList(list);
    }

    //处理管理员和部门用户发表文章的时候 文章的状态
    public void processNewsStatus(New _new,User user){
        int roleId = user.getRole().getRoleId();
        if(roleId == 0){//如果是管理员
            _new.setStatus(1);
        }else {//如果是部门用户
            _new.setStatus(0);
        }
    }


    //处理summernote文章中的图片
    @ResponseBody
    @RequestMapping(value = "/uploadNewsImage",method = RequestMethod.POST)
    public List<Map<String,String>> processImage(@RequestParam("files") CommonsMultipartFile[] files,HttpServletRequest request){
        //本机H盘的路径
        String path = request.getServletContext().getRealPath("/static/news_images/");
        System.out.println("文件夹路径是:"+path);
        //服务器上的路径
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()
                +request.getContextPath()+"/static/news_images/";
        List<Map<String,String>> list = new ArrayList<Map<String, String>>();
        for(int i = 0;i<files.length;i++){
            Map<String,String> map = new HashMap<String, String>();
            String fileName = files[i].getOriginalFilename();
            System.out.println("文件名是："+fileName);
            File file1 = new File(path,fileName);
            try {
                files[i].transferTo(file1);
            } catch (IOException e) {
                e.printStackTrace();
            }
            map.put("file"+i,basePath+fileName);
            list.add(map);
        }
        return list;
    }

    //处理编辑框中删除图片按钮，删除的时候要把图片文件在目录里面一起删除
    @ResponseBody
    @RequestMapping(value = "/deleteImage",method = RequestMethod.POST)
    public Message deleteImage(HttpServletRequest request,@RequestParam("path") String path){
       try {
           String fileName  = path.substring(path.lastIndexOf("/")+1);
           System.out.println("要删除的文件名是："+fileName);
           String realPath = request.getServletContext().getRealPath("/static/news_images/");
           File file = new File(realPath,fileName);
           file.delete();
           return new Message(200,"删除成功");
       }catch (Exception e){
           return new Message(400,"删除失败");
       }
    }

    //跳转到管理新闻界面
    @RequestMapping(value = "/manageNews",method = RequestMethod.GET)
    public String gotoManageNewsJsp(HttpSession session,
                                    HttpServletRequest request,
                                    @RequestParam(value = "pageNum",defaultValue = "1",required = false)int pageNum,
                                    @RequestParam(value = "pageSize",defaultValue = "10",required = false)int pageSize,
                                    @RequestParam(value = "keyword",required = false) String keyword){
        System.out.println("传进来的keyword是："+keyword);
        //判断角色是什么
        PageInfo<New> pageInfo = null;
        User user = (User) session.getAttribute("user");
        String username = user.getUsername();
        if(user.getRole().getRoleId()==0){//如果是管理员
            pageInfo = newsService.getAllNews(pageNum,pageSize);
            //显示菜单
            JSONArray jsonArray = JSONArray.fromObject(session.getAttribute("menuList"));
            request.setAttribute("menuList",jsonArray);
        }else{//如果是部门用户
            pageInfo = newsService.getNewsByUsername(pageNum,pageSize,username);
        }
        request.setAttribute("pageInfo",pageInfo);
        return "admin/manageNews";
    }


    //根据新闻内容或者标题的关键字检索内容
    @RequestMapping(value = {"/searchNewsByKeyword","/searchNewsByStatus"},method = RequestMethod.GET)
    public String checkNews(HttpSession session,
                            HttpServletRequest request,
                            @RequestParam(value = "pageNum",defaultValue = "1",required = false)int pageNum,
                            @RequestParam(value = "pageSize",defaultValue = "10",required = false)int pageSize,
                            @RequestParam(value = "keyword",required = false) String keyword,
                            @RequestParam(value = "status",required = false) String status){
        User user = (User) session.getAttribute("user");
        PageInfo<New> pageInfo = null ;
        if(keyword !=null && !keyword.equals("")){
            if(user.getRole().getRoleId()==0){
                pageInfo = newsService.getNewsByNewsKeyword(keyword,"",pageNum,pageSize);
            }else{
                pageInfo = newsService.getNewsByNewsKeyword(keyword,user.getUsername(),pageNum,pageSize);
            }
        }
        if(status !=null && !status.equals("")){
            if(user.getRole().getRoleId()==0){
                pageInfo = newsService.getNewsByStatus(status,"",pageNum,pageSize);
            }else{
                pageInfo = newsService.getNewsByStatus(status,user.getUsername(),pageNum,pageSize);
            }
        }
        request.setAttribute("pageInfo",pageInfo);
        return "admin/manageNews";
    }






    //去往修改文章的界面
    @RequestMapping(value = "/modifyNews",method = RequestMethod.GET)
    public String gotoModifyNewsJsp(HttpSession session,
                                    HttpServletRequest request,HttpServletResponse response,
                                    @RequestParam("news_id")Long newsId) throws IOException {
        User user = (User) session.getAttribute("user");
        //如果是部门用户点击编辑，要阻止链接的弹出
        New _new = newsService.getNewsById(newsId);
        if(user.getRole().getRoleId()==1&&_new.getStatus()==1){
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = response.getWriter();
            writer.println("<script>alert('文章已经被管理员锁定，不能修改');window.close();</script>");
            writer.flush();
            return "admin/manageNews";
        }
        request.setAttribute("menuList",JSONArray.fromObject(menuService.getAllMenus()));
        System.out.println("查询的到的new是："+_new);
        request.setAttribute("news",_new);
        return "news/modifyNews";
    }

    //修改文章
    @ResponseBody
    @RequestMapping(value = "/modifyNews",method = RequestMethod.POST)
    public Message modifyNews(HttpSession session,
                                HttpServletRequest request,
                                New _new,
                              @RequestParam("files")CommonsMultipartFile[] files){
        try {
            System.out.println("后台传过来的 new是："+_new);
            processFileUpload(request,files);
            _new.setLastTime(new Timestamp(System.currentTimeMillis()));
            fillNewsMap(_new,files);
            newsService.modifyNews(_new);
            return new Message(200,"修改成功,新闻编号是："+_new.getId());
        } catch (Exception e) {
            e.printStackTrace();
            return new Message(400,e.getMessage());
        }
    }

    //修改文章的时候，删除文章中原来拥有的文件，1.删除news_files表中的记录 2.删除实际的文件
    @ResponseBody
    @RequestMapping(value = "/removeNewsFile",method = RequestMethod.GET)
    public void deleteNewFile(HttpServletRequest request, String id,String fileName){
        delNewFileInTableAndInLocal(request, id, fileName);

        //System.out.println("请求进来了");
        //return new Message(200,"删除成功");
        //return "redirect:modifyNews?news_id="+id;
    }

    //针对一条记录,一个文件
    private void delNewFileInTableAndInLocal(HttpServletRequest request, String id, String fileName) {
        String realPath = request.getServletContext().getRealPath("/static/news_files/");
        //删除数据库
        newsService.deleteNewFile(id,fileName);
        //删除本地文件
        File file = new File(realPath,fileName);
        if(file.exists()){
            file.delete();
        }
    }

    //删除新闻 1.数据库中删除 2.相关的附件也要删除
    @ResponseBody
    @RequestMapping(value = "/deleteNews",method = RequestMethod.GET)
    public void deleteNews(@RequestParam("news_id") String id,HttpServletRequest request){
        String realPath = request.getServletContext().getRealPath("/static/news_files/");
        newsService.deleteOneRecord(id,realPath);
    }

    //更新新闻状态
    @ResponseBody
    @RequestMapping(value="/updateNewStatus",method = RequestMethod.POST)
    public Message updateNewStatus(String status,Long id,HttpSession session,HttpServletResponse response){
        System.out.println("map是："+status+"=="+id);
        User user = (User) session.getAttribute("user");
        if(user.getRole().getRoleId()!=0){
            try {
                Utils.invaildRequestBox(response,"您没有权限批改文章");
                return new Message(400,"您没有权限批改文章");
            } catch (IOException e) {
                e.printStackTrace();
                return new Message(400,"服务器出了点小问题，请稍后再试");
            }
        }else {
            newsService.updateNewStatus(id,status);
        }
        return new Message(200,"成功");
    }

    //高级检索
    @RequestMapping(value="/advancedSearchNews",method = RequestMethod.POST)
    public String advancedSearchNews(HttpSession session,HttpServletRequest request,
                                    @RequestParam Map<String,String> conditions,
                                     @RequestParam(value = "pageNum",defaultValue = "1",required = false)int pageNum,
                                     @RequestParam(value = "pageSize",defaultValue = "10",required = false)int pageSize){
        //System.out.println("条件:"+conditions);
        PageInfo<New> pageInfo = newsService.advancedSearchNews(conditions,pageNum,pageSize);
        request.setAttribute("pageInfo",pageInfo);
       // System.out.println("查询："+pageInfo);
        return "admin/manageNews";
    }

    //添加子菜单
    @RequestMapping(value = "/addSubmenu",method = RequestMethod.POST)
    public String addSubmenu(String submenuName,String menuId){
        menuService.addSubMenu(submenuName,menuId);
        return "redirect:manageColumns";
    }
    //修改子菜单
    @ResponseBody
    @RequestMapping(value = "/modifySubmenu",method = RequestMethod.POST)
    public Object modifySubmenu(String submenuName,String submenuId){
        menuService.modifySubmenu(submenuName,submenuId);
        return new Message(200,"修改成功");
    }

    //删除子菜单
    @ResponseBody
    @RequestMapping(value = "/delSubmenu",method = RequestMethod.POST)
    public Object delSubmenu(String submenuId) throws IOException {
        if(menuService.delSubmenu(submenuId)){
            return new Message(200,"删除成功");
        }else {
            return new Message(200,"该子菜单下有新闻，无法删除");
        }
    }

    //修改主菜单的名字
    @ResponseBody
    @RequestMapping(value = "/modifyMenuName",method = RequestMethod.POST)
    public Object modifyMenuName(String menuName,String menuId) throws IOException {
        if(menuService.modifyMenuvName(menuName,menuId)){
            return new Message(200,"修改成功");
        }else {
            return new Message(200,"修改失败");
        }
    }
 }
