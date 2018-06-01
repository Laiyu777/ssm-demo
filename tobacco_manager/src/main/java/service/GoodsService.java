package service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dao.GoodsDao;
import entity.Cost;
import entity.Good;
import entity.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/8.
 */
@Service
public class GoodsService {
    @Autowired
    private GoodsDao goodsDao;

    public int addGoods(Good good){
        int row =  goodsDao.addOne(good);
        //要处理商品的价格表
        for(int i = 0;i<good.getCostList().size();i++){
            Cost cost = good.getCostList().get(i);
            cost.setGoodId(good.getGoodId());
            cost.setRoleId(i+1);
            //添加至cost表
            goodsDao.addGoodCost(cost);
        }
        return row;
    }

    public PageInfo getGoodsByPage(int page,int rows,Map<String,String> conditions) {
        PageHelper.startPage(page,rows);
        List<Good> goodList = goodsDao.goodsByPage(conditions);
        PageInfo pageInfo = new PageInfo(goodList);
        return pageInfo;
    }

    public Good getGoodsById(int goodId) {
        return goodsDao.getById(goodId);
    }

    public int update(Good good){
        return goodsDao.updateOne(good);
    }

    public int deleteGoods(int goodId){
        int row =  goodsDao.deleteOne(goodId);
        //删除价格表
        goodsDao.deleteCostByGoodsId(goodId);
        return row;
    }


    public int updateCost(Cost cost) {
        return goodsDao.updateCost(cost);
    }

    public List<Good> sortByCostDesc(List<Good> list, final Role role){
        Collections.sort(list, new Comparator<Good>() {
            public int compare(Good o1, Good o2) {
                double cost1 = o1.getCostList().get(role.getRoleId()-1).getCostPrice();
                double cost2 = o2.getCostList().get(role.getRoleId()-1).getCostPrice();
                return (int) (cost2-cost1);
            }
        });
        return list;
    }

    public List<Good> sortByCostASC(List<Good> list, final Role role){
        Collections.sort(list, new Comparator<Good>() {
            public int compare(Good o1, Good o2) {
                double cost1 = o1.getCostList().get(role.getRoleId()-1).getCostPrice();
                double cost2 = o2.getCostList().get(role.getRoleId()-1).getCostPrice();
                return (int) (cost1-cost2);
            }
        });
        return list;
    }
}
