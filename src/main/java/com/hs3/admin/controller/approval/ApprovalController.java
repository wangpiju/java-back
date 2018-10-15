package com.hs3.admin.controller.approval;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.approval.Approval;
import com.hs3.entity.users.Manager;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.approval.ApprovalService;
import com.hs3.service.finance.FinanceChangeService;
import com.hs3.service.finance.RechargeService;
import com.hs3.service.user.UserService;
import com.hs3.utils.StrUtils;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/approval"})
public class ApprovalController extends AdminController {
    @Autowired
    private ApprovalService approvalService;
    @Autowired
    private FinanceChangeService financeChangeService;
    @Autowired
    private RechargeService rechargeService;
    @Autowired
    private UserService userService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/approval/index");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Approval approval, String startTime, String endTime, Integer status) {
        Page p = getPageWithParams();
        List<Approval> list = this.approvalService.list(p, approval, startTime, endTime, status);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/agree"})
    public Object agree(Integer id, String remark) {
        Approval m = this.approvalService.getEntity(id);
        boolean flag = false;
        if (m != null) {
            m.setStatus(Integer.valueOf(2));
            m.setHandleTime(new Date());
            m.setRemark(remark);
            m.setOperator(((Manager) getLogin()).getAccount());
            if ((m.getApplyType().intValue() == 0) || (m.getApplyType().intValue() == 1)) {
                flag = this.approvalService.saveAndUpdate(m) > 0;
            } else {
                try {
                    if (m.getApplyType().intValue() == 99) {
                        this.rechargeService.updateByAuditSuccess(m);
                    } else if (m.getApplyType().intValue() == 98) {
                        this.userService.updatePrivateRebateByApproval(m);
                    } else {
                        this.financeChangeService.saveByApproval(m);
                    }
                    flag = true;
                } catch (BaseCheckException e) {
                    return Jsoner.error(e.getMessage());
                }
            }
        }
        return Jsoner.getByResult(flag);
    }

    @ResponseBody
    @RequestMapping({"/refuse"})
    public Object refuse(Integer id, String remark) {
        if (StrUtils.hasEmpty(new Object[]{remark})) {
            return Jsoner.error("备注不能为空！");
        }
        Approval m = this.approvalService.getEntity(id);
        m.setStatus(Integer.valueOf(1));
        m.setHandleTime(new Date());
        m.setRemark(remark);
        m.setOperator(((Manager) getLogin()).getAccount());
        if (m.getApplyType().intValue() == 99) {
            try {
                this.rechargeService.updateByAuditReject(m);
                return Jsoner.success();
            } catch (BaseCheckException e) {
                return Jsoner.error(e.getMessage());
            }
        }
        return Jsoner.getByResult(this.approvalService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping({"/updateRemark"})
    public Object updateRemark(Integer id, String remark) {
        Approval m = this.approvalService.getEntity(id);
        m.setRemark(remark);
        return Jsoner.getByResult(this.approvalService.updateRemark(m) > 0);
    }

    @ResponseBody
    @RequestMapping({"/edit"})
    public Object edit(Integer id) {
        Approval m = new Approval();
        m.setId(id);
        return m;
    }
}
