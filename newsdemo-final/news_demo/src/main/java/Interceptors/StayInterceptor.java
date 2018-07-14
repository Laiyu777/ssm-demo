package Interceptors;

import Entity.User;
import Help.Utils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2018/6/9.
 */
public class StayInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User user = (User) request.getSession().getAttribute("user");

        if(user!=null){
            if(user.getRole().getRoleId()==0 || user.getRole().getRoleId()==1){
                return true;
            }
        }
        Utils.invaildRequestBox(response);
        return false;
    }


}
