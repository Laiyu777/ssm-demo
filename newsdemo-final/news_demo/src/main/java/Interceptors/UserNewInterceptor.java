package Interceptors;

import Entity.User;
import Help.Utils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2018/6/12.
 */
public class UserNewInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user!=null){
            if(user.getRole().getRoleId() == 0 || user.getRole().getRoleId()==1){
                return true;
            }
        }
        Utils.invaildRequestBox(response,"您没有权限发布文章");
        return false;
    }
}
