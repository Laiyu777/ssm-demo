package service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dao.MessageDao;
import entity.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2018/3/29.
 */
@Service
public class MessageService {

    @Autowired
    private MessageDao messageDao;

    public void SellerSendMessageToAdmin(Message message){
        messageDao.sellerSendMessageToAdmin(message);
    }

    public PageInfo<Message> selectMessage(String username,int pageNum,int pageSize) {
        List<Message> messageList = messageDao.selectMessageByUsername(username);
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<Message> messagePageInfo = new PageInfo<Message>(messageList);
        return messagePageInfo;
    }

    //标识用户已经读
    public void markUserAlreadyRead(String id,String role) {
        if(role.equals("0")){
            messageDao.updateOneKey("admin_if_read","1",id);
        }else {
            messageDao.updateOneKey("user_if_read","1",id);
        }
    }

    public int getNoReadMsgByUserName(String username, boolean ifAdmin) {
        //由于管理员和零售商用户字段的不一样，要判断这个用户是不是管理员
        List<Message> messageList = messageDao.selectMessageByUsername(username);
        int count = 0;
        for(Message message:messageList){
            if(ifAdmin && message.getAdminIfRead()==0){
                count += 1;
            }else if(!ifAdmin && message.getUserIfRead()==0){
                count += 1;
            }
        }
        return count;
    }
}
