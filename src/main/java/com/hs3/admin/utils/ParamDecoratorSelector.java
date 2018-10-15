package com.hs3.admin.utils;

import com.hs3.utils.StrUtils;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;

import org.sitemesh.DecoratorSelector;
import org.sitemesh.content.Content;
import org.sitemesh.webapp.WebAppContext;


public class ParamDecoratorSelector
        implements DecoratorSelector<WebAppContext> {
    private DecoratorSelector<WebAppContext> defaultDecoratorSelector;

    public ParamDecoratorSelector(DecoratorSelector<WebAppContext> defaultDecoratorSelector) {
        this.defaultDecoratorSelector = defaultDecoratorSelector;
    }

    public String[] selectDecoratorPaths(Content content, WebAppContext context) throws IOException {
        HttpServletRequest request = context.getRequest();

        String decorator1 = request.getParameter("decorator");
        Object decorator2 = request.getAttribute("decorator");
        if (StrUtils.hasNotEmpty(new Object[]{decorator1, decorator2})) {
            return new String[0];
        }
        return this.defaultDecoratorSelector.selectDecoratorPaths(content, context);
    }
}
