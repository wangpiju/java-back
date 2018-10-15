package com.hs3.admin.controller.activity;

import com.hs3.service.quartz.QuartzService;

import java.io.PrintStream;
import java.util.Date;

import org.springframework.context.support.FileSystemXmlApplicationContext;

public class test {
    static FileSystemXmlApplicationContext applicationContext = new FileSystemXmlApplicationContext("/WebContent/WEB-INF/applicationContext.xml");

    public static void main(String[] args) {
        QuartzService quartzService = (QuartzService) applicationContext.getBean("quartzService");
        Date begin = new Date();
        System.out.println(begin);
        System.out.println(begin);
        quartzService.addJob("亏损佣金活动", "活动派发", null, begin, begin, 1, TestJob.class);
    }
}
