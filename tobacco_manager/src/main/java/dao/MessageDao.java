package dao;

import entity.Message;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2018/3/29.
 */
public interface MessageDao {
    List<Message> selectMessageByUsername(String name);

    void sellerSendMessageToAdmin(Message message);

    void updateOneKey(@Param("key") String key,@Param("value") String value,@Param("id")String id);
}
