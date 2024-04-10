package com.example.springboot.common;

import com.example.springboot.constant.ScheduleConstant;
import com.example.springboot.entity.Notice;
import com.example.springboot.service.NoticeService;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author xh
 * @Date 2022/12/10
 */
@Component
@Slf4j
public class ScheduleService {

    @Resource
    NoticeService noticeService;

    /**
     * 每天中午12:00更新
     */
    @Scheduled(cron = "0 0 12 * * ?")
    public void scheduled() {
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        Date date = new Date(System.currentTimeMillis());
        log.info("开始执行定时任务，当前时间：{}", formatter.format(date));
        boolean isUpdate = noticeService.updateWebNotice();
        log.info("存储结果：{}", isUpdate);
    }
}
