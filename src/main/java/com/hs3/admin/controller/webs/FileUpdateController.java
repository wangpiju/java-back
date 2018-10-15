package com.hs3.admin.controller.webs;

import com.hs3.admin.controller.AdminController;
import com.hs3.utils.FileUtils;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/file"})
public class FileUpdateController
        extends AdminController {
    @ResponseBody
    @RequestMapping({"/update"})
    public Object update(MultipartFile imgFile) {
        Map<String, Object> rel = new HashMap();
        if (!imgFile.isEmpty()) {
            try {
                String webPath = FileUtils.save(getSession().getServletContext().getRealPath("/"), "res/upload/", imgFile);

                rel.put("error", Integer.valueOf(0));
                rel.put("url", "/" + webPath);
            } catch (Exception e) {
                rel.put("error", Integer.valueOf(1));
                rel.put("message", e.getMessage());
            }
        } else {
            rel.put("error", Integer.valueOf(1));
            rel.put("message", "no file");
        }
        return rel;
    }
}
