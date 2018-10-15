package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.users.DailyData;
import com.hs3.entity.users.User;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.user.DailyDataService;
import com.hs3.service.user.UserService;
import com.hs3.utils.ListUtils;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/user/dailyData"})
public class DailyDataController
        extends AdminController {
    @Autowired
    private DailyDataService dailyDataService;
    @Autowired
    private UserService userService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/user/dailyData");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account, Integer isIncludeChildFlag, Date begin, Date end) {
        Page p = getPageWithParams();

        boolean isIncludeChild = (isIncludeChildFlag != null) && (isIncludeChildFlag.intValue() == 1);

        DailyData dailyData = new DailyData();
        if (!isIncludeChild) {
            dailyData.setAccount(account);
        }

        User user = this.userService.findByAccount(account);

        List<DailyData> list = this.dailyDataService.listByCond(dailyData, user == null ? null : user.getParentList(), begin, end, p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<DailyData> list = this.dailyDataService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(DailyData m) {
        this.dailyDataService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.dailyDataService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(DailyData m) {
        return Jsoner.getByResult(this.dailyDataService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.dailyDataService.delete(ListUtils.toIntList(id)) > 0);
    }
}
