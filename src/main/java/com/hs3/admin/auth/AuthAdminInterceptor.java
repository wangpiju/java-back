package com.hs3.admin.auth;

import com.hs3.entity.users.Manager;
import com.hs3.models.Jsoner;
import com.hs3.service.sys.LoginIpWhiteService;
import com.hs3.service.user.ManagerService;
import com.hs3.utils.auth.AuthUtils;
import com.hs3.web.auth.Auth;
import com.hs3.web.auth.AuthInterceptor;
import com.hs3.web.utils.RequestResponseContext;
import com.hs3.web.utils.SpringContext;
import com.hs3.web.utils.WebUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;

public class AuthAdminInterceptor
        extends AuthInterceptor {
    private static final Logger logger = Logger.getLogger(AuthAdminInterceptor.class);

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        RequestResponseContext.set(request, response);

        if (!handler.getClass().isAssignableFrom(HandlerMethod.class)) {
            return true;
        }
        Auth auth = (Auth) ((HandlerMethod) handler).getMethodAnnotation(Auth.class);
        ResponseBody body = (ResponseBody) ((HandlerMethod) handler).getMethodAnnotation(ResponseBody.class);


        if ((auth != null) && (!auth.validate()))
            return true;
        String context = request.getContextPath();
        String loginURL = context + "/admin/login";


        LoginIpWhiteService loginIpWhiteService = (LoginIpWhiteService) SpringContext.getBean("loginIpWhiteService");
        if (!loginIpWhiteService.vaild(WebUtils.getIP(request))) {
            if (body != null) {
                WriteJson(response, Jsoner.error("您的IP已被禁止访问"));
            } else {
                response.sendRedirect(loginURL);
            }
            return false;
        }


        Object manager = request.getSession().getAttribute("ADMIN_SESSION");

        boolean isLogin = false;
        boolean hasVery = false;
        boolean isDoubleLogin = false;
        if ((manager != null) && (manager.getClass().equals(Manager.class))) {
            isLogin = true;
            Manager man = (Manager) manager;
            hasVery = AuthUtils.hasAuth(request);

            ManagerService managerService = (ManagerService) SpringContext.getBean("managerService");
            String sess = null;
            try {
                sess = managerService.getSessionId(man.getAccount());
            } catch (Exception e) {
                logger.error("检查重复登录时数据库异常：" + e.getMessage(), e);
            }

            if (sess != null) {
                String sessionId = request.getSession().getId();

                isDoubleLogin = !sess.equals(sessionId);
            }
        }
        if ((!isLogin) || (isDoubleLogin)) {
            request.getSession().invalidate();
            if (body != null) {
                if (!isLogin) {
                    return WriteJson(response, Jsoner.noLogin());
                }
                return WriteJson(response, Jsoner.noLogin("您已在别处登录,请勿重复登录,如果不是您本人操作.请尽快修改密码"));
            }
            response.sendRedirect(loginURL);

            return false;
        }
        if (!hasVery) {
            if (body != null) {
                WriteJson(response, Jsoner.error("您没有访问权限"));
            } else {
                response.sendRedirect(context + "/admin/none");
            }
            return false;
        }

        return true;
    }

    public void afterCompletion(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse, Object obj, Exception exception)
            throws Exception {
    }
}
