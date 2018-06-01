package dao;

import entity.Cost;
import entity.Good;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/8.
 */
public interface GoodsDao extends BaseDao<Good>{

    List<Good> goodsByPage(Map<String,String> conditions);

    @Select("SELECT * FROM cost WHERE good_id=#{goodId}")
    List<Cost> getGoodsCost(@Param("goodId") Integer goodId);

    @Insert("insert into cost (good_id,role_id,cost_price) values(#{goodId},#{roleId},#{costPrice})")
    int addGoodCost(Cost cost);

    @Delete("delete from cost where good_id=#{id}")
    int deleteCostByGoodsId(int goodId);

    @Update("update cost set cost_price=#{costPrice} where good_id=#{goodId} and role_id=#{roleId}")
    int updateCost(Cost cost);
}
