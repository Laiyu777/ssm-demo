package dao;

import entity.Situation;
import entity.SituationDetail;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2017/12/7.
 */
public interface SituationDao extends BaseDao<Situation> {
    //根据用户名返回对应的销售情况
    List<Situation> getSituationsByUsername(String name);

    //根据销售情况的id（自增）返回对应的销售细节
    List<SituationDetail> getSituationDetailById(Integer id);

    //插入到销售情况表中
    int addSellSituation(Situation situation);

    //插入到销售情况细节表中
    int addSellSituationDetail(List<SituationDetail> list);

    //更新最后插入时间
    void updateLastTime(@Param("createTime") Timestamp now, @Param("id") Integer situationId);

    //根据id和商品名字更新sell_detail表
    void updateSituationDetail(SituationDetail situationDetail);
}
