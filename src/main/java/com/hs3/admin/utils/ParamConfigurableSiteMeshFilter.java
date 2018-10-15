package com.hs3.admin.utils;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class ParamConfigurableSiteMeshFilter extends ConfigurableSiteMeshFilter {
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.setCustomDecoratorSelector(new ParamDecoratorSelector(builder.getDecoratorSelector()));
    }
}
