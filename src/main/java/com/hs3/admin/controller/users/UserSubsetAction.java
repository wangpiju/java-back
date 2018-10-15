package com.hs3.admin.controller.users;

import com.hs3.admin.controller.HomeAction;
import com.hs3.dao.user.UserDao;
import com.hs3.dao.user.UserSubsetDao;
import com.hs3.entity.users.User;
import com.hs3.entity.users.UserSubset;
import com.hs3.utils.BaseBeanUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;

@Controller
@Scope("prototype")
@RequestMapping({"/user/subset"})
public class UserSubsetAction extends HomeAction {

    private static final ObjectMapper mapper = new ObjectMapper();

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserSubsetDao userSubsetDao;



    @ResponseBody
    @RequestMapping(value = {"/setUserSubset"}, method = {RequestMethod.POST})
    public JsonNode setUserSubset() {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {

            List<User> userList = userDao.list(null);
            for(User user: userList){
                String account = user.getAccount();
                UserSubset userSubset = null;
                for(User uz: userList) {
                    String uzAccount = uz.getAccount();
                    String uzParentList = uz.getParentList();
                    String[] uzParentArr = uzParentList.split(",");
                    for(String uzp: uzParentArr){
                        if(uzp.trim().equals(account)){
                            userSubset = new UserSubset();
                            userSubset.setAccount(account);
                            userSubset.setSubSetAccount(uzAccount);
                            userSubsetDao.save(userSubset);
                            break;
                        }
                    }

                }
            }

            HashMap<String, Object> obData = new HashMap<String, Object>();
            obData.put("message", "创建用户子集成功！");
            return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(obData));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }




}
