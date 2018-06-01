package controller;

import com.github.pagehelper.PageInfo;
import entity.Cost;
import entity.Good;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import service.GoodsService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * Created by Administrator on 2017/12/8.
 */
@Controller
public class GoodsController {

    @Autowired
    private GoodsService goodsService;
    @RequestMapping("/admin/addGoods")
    public String addGoods(HttpServletRequest request, Good good,@RequestParam("file") MultipartFile file){
        String path = request.getRealPath("/static/images/goods");
        //保存商品的基本信息
        System.out.println("商品："+good);
        goodsService.addGoods(good);
        //处理商品图片的上传
       if(file!=null||file.getOriginalFilename().equals("")){
           File file1 = new File(path,good.getGoodId()+".jpg");
           try {
               file.transferTo(file1);
           } catch (IOException e) {
               e.printStackTrace();
           }
       }
        return "redirect:/admin/managerGoods?page="+good.getGoodId();
    }

//    @ResponseBody
//    @RequestMapping("/getGoods")
//    public PageInfo<Good> getGoodsByPage(){
//       List<Good> goods = goodsService.getGoodsByPage();
//        PageInfo pageInfo = new PageInfo(goods);
//        return pageInfo;
//    }

    @RequestMapping({"/admin/getGoods","/getGoods"})
    @ResponseBody
    public Good getGoodsById( int goodId){
        Good good =goodsService.getGoodsById(goodId);
        return good;
    }

    @RequestMapping("/admin/updateGoods")
    public String updateGoods(Good good,HttpSession session,@RequestParam("file")MultipartFile file){
        PageInfo pageInfo = (PageInfo) session.getAttribute("pageInfo");
        System.out.println("商品："+good);
        //为了回到当前页码
        int page = pageInfo.getPageNum();
        //goodsService.updateCost
        for(int i=0;i<good.getCostList().size();i++){
            Cost cost = good.getCostList().get(i);
            cost.setGoodId(good.getGoodId());
            cost.setRoleId(i+1);
            goodsService.updateCost(cost);
        }

        //处理文件上传
        if(file!=null&&!file.getOriginalFilename().equals("")){
            String path = session.getServletContext().getRealPath("/static/images/goods");
            File file1 = new File(path+"/"+good.getGoodId()+".jpg");
            try {
                file.transferTo(file1);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "redirect:/admin/managerGoods?page="+page;
    }

    @RequestMapping("/admin/delGoods")
    public String delGoods(int goodId,HttpSession session){
        PageInfo pageInfo = (PageInfo) session.getAttribute("pageInfo");
        int page = pageInfo.getPageNum();

        goodsService.deleteGoods(goodId);

        return "redirect:/admin/managerGoods?page="+page;
    }
}
