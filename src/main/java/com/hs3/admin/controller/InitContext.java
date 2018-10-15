package com.hs3.admin.controller;

import com.hs3.service.lotts.PlayerService;
import com.hs3.web.utils.SpringContext;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Repository;

@Repository
public class InitContext implements org.springframework.context.ApplicationListener<ContextRefreshedEvent> {
    private static final Logger logger = Logger.getLogger(InitContext.class);

    public void onApplicationEvent(ContextRefreshedEvent event) {
        if (event.getApplicationContext().getParent() != null) {
            return;
        }
        logger.info("启动应用");

        PlayerService playerService = (PlayerService) SpringContext.getBean("playerService");
        playerService.saveNew();
    }
}
