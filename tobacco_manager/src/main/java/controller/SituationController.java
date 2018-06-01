package controller;

import entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.SituationService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/3/23.
 */
@Controller
public class SituationController {

    @Autowired
    private SituationService situationService;
    //上传销售数据
    @ResponseBody
    @RequestMapping(value = "/uploadSellSituation",produces = "text/plain;charset=utf-8")
    public String uploadSellSituation(@RequestBody List<SituationDetail> details, HttpSession session){
        System.out.println(details);
        //获取用户名
        User user = (User) session.getAttribute("user");
        //要判断是新的Situation还是老的
        DataWrapper dataWrapper = situationService.ifAddSituation(user.getUsername());
        Situation situation  =null;
        if(!dataWrapper.isUploaded()){
             situation = new Situation();
            situation.setSituationDetails(details);
            situation.setUsername(user.getUsername());
        }else {//如果是老的，则新传过来的details没有id
            situation = dataWrapper.getSituation();
            int situationId = dataWrapper.getSituation().getSituationId();
            for(SituationDetail detail:details){
                detail.setSituationId(situationId);
            }
        }
        situationService.addSellSituation(situation,dataWrapper.isUploaded(),details);

        return "上传成功";
    }


    @ResponseBody
    @RequestMapping(value="/updateSituationDetail",produces = "text/plain;charset=utf-8")
    public String updateSituationDetail(SituationDetail situationDetail){
        System.out.println("SituationDetail==="+situationDetail);
        situationService.updateSituationDetail(situationDetail);
        return "修改成功";
    }

    //获取销售和利润柱状图的数据
    @ResponseBody
    @RequestMapping(value = "/getSaleAndProfitWrapper")
    public SaleAndProfitWrapper getSaleAndProfitWrapper(HttpSession session){
        User user = (User) session.getAttribute("user");
        String username = user.getUsername();
        SaleAndProfitWrapper saleAndProfitWrapper =situationService.getSaleAndProfitWrapper(username);
       return saleAndProfitWrapper;
    }

    //获取今天的销售细节，提供给饼图使用
    @ResponseBody
    @RequestMapping(value = "/getSituationDetailByDate")
    public List<SituationDetail> getSituationDetailByDate(HttpSession session, String date, HttpServletRequest request){
        User user = (User) session.getAttribute("user");
        String username= user.getUsername();
        List<SituationDetail> situationDetailList = situationService.getSituationDetailByDate(username,date);
        request.setAttribute("details",situationDetailList);
        return situationDetailList;
    }
}
