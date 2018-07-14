package Aspect;

import Entity.User;
import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;


/**
 * Created by Administrator on 2018/6/3.
 */
@Aspect
@Component
public class LoginAspect {

    private static Logger logger = Logger.getLogger(LoginAspect.class);

    @Pointcut("@annotation(Aspect.Annotation.Login)")
    public void needLogin(){}

    @Around("needLogin()")
    public Object Login(ProceedingJoinPoint pj){
        System.out.println("进来了...");
        Object result = null;
        HttpSession session = null;
        logger.info("获取的方法名是："+pj.getSignature().getName());
        //获取目标参数
        for(Object param:pj.getArgs()){
            logger.info("获取的参数是:"+param);
            if(param instanceof HttpSession){
                session = (HttpSession)param;
            }
        }
        User user = (User)session.getAttribute("user");
        if(user!=null){
            try {
                logger.info("用户已经登录");
                result = pj.proceed();
                return result;
            } catch (Throwable throwable) {
                throwable.printStackTrace();
            }
        }else{
            logger.info("用户没有登录");
            return "redirect:index.jsp";
        }
        return null;
    }

//    @Before("needLogin()")
//    public void in(){
//        System.out.println("进来了");
//    }
}
