package com.example.springboot;

import com.example.springboot.constant.ScheduleConstant;
import com.example.springboot.entity.Notice;
import com.example.springboot.manager.AiManager;
import com.example.springboot.service.NoticeService;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;
import org.junit.jupiter.api.Test;
import org.springframework.boot.autoconfigure.web.ResourceProperties;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;


@SpringBootTest
@Slf4j
class AiTests {

    @Test
    void contextLoads() {
    }


    @Resource
    private AiManager aiManager;

    @Test
    void testChatgpt() {
        String answer = aiManager.doChat(1669210882330079234L,"我现在学习压力有点大，如何缓解自己的压力呢?");
        System.out.println(answer);
    }

}
