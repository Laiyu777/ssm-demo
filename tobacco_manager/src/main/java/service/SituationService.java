package service;

import dao.SituationDao;
import entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import util.Utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2018/3/23.
 */
@Service
public class SituationService {
    @Autowired
    private SituationDao situationDao;

    //添加到销售情况表和细节表中,添加一条销售记录
     public void addSellSituation(Situation situation,boolean isUploaded,List<SituationDetail> details){
         if(!isUploaded){//如果今天没有上传，就要新插入一条新的记录到sell_situation表,为每一个detail设置一个id
             situationDao.addSellSituation(situation);
             for(SituationDetail detail : details){
                 detail.setSituationId(situation.getSituationId());
             }

         }else {//已经上传就更新sell_situation表的时间
             situationDao.updateLastTime(new Timestamp(System.currentTimeMillis()),situation.getSituationId());
         }
         situationDao.addSellSituationDetail(details);
     }



     //判断用户今天是否在sell_situation表中插入过信息
    //包装situation和isUploaded的理由：判断是否要向sell_situation表中插入信息，并且要知道具体是哪一个situation对象（获取situation_id）,给表格中的details设置situation_id
    public DataWrapper ifAddSituation(String username){
         SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Timestamp now = new Timestamp(System.currentTimeMillis());
        String nowStr = simpleDateFormat.format(new Date(System.currentTimeMillis()));
        List<Situation> situationList = situationDao.getSituationsByUsername(username);
        DataWrapper wrapper = new DataWrapper();

        if(situationList.size()!=0){//如果重来没有创建过
            for(Situation situation1 : situationList){
                String date = simpleDateFormat.format(situation1.getCreateTime());
                if(date.equals(nowStr)){//如果找到今天的日期，就说明今天已经上传过了。
                    wrapper.setUploaded(true);
                    wrapper.setSituation(situation1);
                }
            }
        }else{
            wrapper.setUploaded(false);
        }
        return wrapper;
    }

    //获取今天销售的具体对象
    public Situation getSituationToday(String username) {
        List<Situation> situationList = situationDao.getSituationsByUsername(username);
        String today = Utils.DateToString(System.currentTimeMillis());
        for(Situation situation : situationList){
            if(Utils.DateToString(situation.getCreateTime()).equals(today)){
               return situation;
            }
        }
        return null;
    }

    //零售商修改已经存在的细节条目
    public void updateSituationDetail(SituationDetail situationDetail) {
        System.out.println("======"+situationDetail);
        situationDao.updateSituationDetail(situationDetail);
    }

    //返回SituationList根据用户名，Echarts使用
    public List<Situation> getSituationByUserName(String username){
        return situationDao.getSituationsByUsername(username);
    }

    //返回一个用户的时间横轴,Echarts使用
    public SaleAndProfitWrapper getSaleAndProfitWrapper(String username){
        List<Situation> situationList = situationDao.getSituationsByUsername(username);
        List<String> dateList = new ArrayList<String>();
        List<Double> saleList = new ArrayList<Double>();
        List<Double> profitList = new ArrayList<Double>();
        for(Situation situation : situationList){
            //处理X轴的信息
            String date = Utils.DateToString(situation.getCreateTime());
            dateList.add(date);
            //处理当天的销售额和利润
            double saleSum = 0;
            double profitSum = 0;
            for(SituationDetail detail : situation.getSituationDetails()){
                int count = detail.getSellCount();
                saleSum += detail.getSellPrice()*count;//每个detail的条目销售额*数量，然后叠加就是当天的销售额
                profitSum += (detail.getSellPrice()-detail.getSellCost())*count;//利润=(销售价格-成本)*数量
            }
            saleList.add(saleSum);
            profitList.add(profitSum);
        }
        SaleAndProfitWrapper saleAndProfitWrapper = new SaleAndProfitWrapper();
        saleAndProfitWrapper.setDate(dateList);
        saleAndProfitWrapper.setSale(saleList);
        saleAndProfitWrapper.setProfit(profitList);

        return saleAndProfitWrapper;
    }

    //根据用户名和日期，返回指定日期的situationDetail的list
    public List<SituationDetail> getSituationDetailByDate(String username,String date){
        List<Situation> situationList = getSituationByUserName(username);
        for(Situation situation:situationList){
            String situationDate = Utils.DateToString(situation.getCreateTime());
            if(date.equals(situationDate)){
                return situation.getSituationDetails();
            }
        }
        return null;
    }
}

