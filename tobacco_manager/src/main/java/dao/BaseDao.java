package dao;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/6.
 */
public interface BaseDao<T> {
    //查询一个实体
    T getById(Integer id);
    //增加一个实体
    int addOne(T t);
    //删除一个实体
    int deleteOne(Integer id);
    //更新一个实体
    int updateOne(T t);

}
