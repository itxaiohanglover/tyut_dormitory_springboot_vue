package com.example.springboot;

import com.example.springboot.constant.ScheduleConstant;
import com.example.springboot.entity.Notice;
import com.example.springboot.manager.AiManager;
import com.example.springboot.service.NoticeService;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;
import org.junit.jupiter.api.Test;
import org.springframework.boot.autoconfigure.web.ResourceProperties;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;


@SpringBootTest
@Slf4j
class SpringbootApplicationTests {

    @Test
    void contextLoads() {
    }

    @Test
    void getInfo() throws IOException {
        //Content封装结果对象
        List<ResourceProperties.Content> list = new ArrayList<ResourceProperties.Content>();
        //获取html文档对象
        //connect链接url
        String URL = "http://jwc.tyut.edu.cn/tzgg.htm";
        String keyword = "";
        //userAgent设置请求头,模拟浏览器访问url
        //timeout设置超时时间,单位是毫秒
        //get获取结果集
        Document document = Jsoup.connect(URL+keyword)
                .userAgent("Mozilla/5.0 (Windows NT 5.1; zh-CN) AppleWebKit/535.12 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/535.12")
                .timeout(60000).get();
        //通过组合选择器获取新闻列表
        List<Notice> notices = new ArrayList<>();
        Elements ul = document.getElementsByClass("listMainRContent clear").first().select("ul > li");
        for (int i = 0; i < ul.size(); i++) {
            // 获取li
            List<Node> li = ul.get(i).childNodes();
            Notice notice = new Notice();
            notice.setAuthor("太原理工大学本科生院");
            // a标签
            Node aNode = li.get(0);
            // 获取绝对路径链接、标题
            String content = aNode.attr("abs:href");
            notice.setContent(content);
            String title = aNode.attr("title");
            notice.setTitle(title);
            // span标签
            Node spanNode = li.get(1);
            // 提取时间并修改格式
            String releaseTime = spanNode.childNode(0).outerHtml() + " 00:" + String.format("%02d", i) + ":00";
            String format = releaseTime.replaceAll("/", "-");
            notice.setReleaseTime(format);
            notices.add(notice);
        }
        System.out.println(notices);
    }


    @Resource
    NoticeService noticeService;



    @Resource
    private AiManager aiManager;

    @Test
    void testChatgpt() {
        String answer = aiManager.doChat(1656998206799732737L,"请问如何治疗嗓子疼");
        System.out.println(answer);
    }


    @Test
    void testDBInfo() {
        //获取html文档对象
        //userAgent设置请求头,模拟浏览器访问url
        //timeout设置超时时间,单位是毫秒
        //get获取结果集
        Document document = null;
        try {
            document = Jsoup.connect(ScheduleConstant.TYUT_URL)
                    .userAgent("Mozilla/5.0 (Windows NT 5.1; zh-CN) AppleWebKit/535.12 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/535.12")
                    .timeout(60000).get();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 断言文档非空
        assert document != null;
        // 封装信息
        List<Notice> notices = new ArrayList<>();
        //通过组合选择器获取新闻列表
        Elements ul = document.getElementsByClass("listMainRContent clear")
                .first()
                .select("ul > li");
        for (int i = 0; i < ul.size(); i++) {
            // 获取li
            List<Node> li = ul.get(i).childNodes();
            Notice notice = new Notice();
            notice.setAuthor(ScheduleConstant.AUTHOR);
            // a标签
            Node aNode = li.get(0);
            // 获取绝对路径链接、标题
            String content = aNode.attr("abs:href");
            notice.setContent(content);
            String title = aNode.attr("title");
            notice.setTitle(title);
            // span标签
            Node spanNode = li.get(1);
            // 提取时间并修改格式
            String releaseTime = spanNode.childNode(0).outerHtml() + " 00:" + String.format("%02d", i) + ":00";
            String format = releaseTime.replaceAll("/", "-");
            notice.setReleaseTime(format);
            notices.add(notice);
        }
        log.info("notices:{}", notices);
        // 更新数据库文章
        // 判断数据库是否存在文章
        List<Notice> homePageNotice = (List<Notice>) noticeService.homePageNotice();
        // 作者信息筛选
        Set<String> titleSet = homePageNotice.stream()
                .filter(n -> ScheduleConstant.AUTHOR.equals(n.getAuthor()))
                .map(Notice::getTitle).collect(Collectors.toSet());
        log.info("titleSet:{}", titleSet);
        List<Notice> noticeList = notices.stream()
                .filter(notice -> !titleSet.contains(notice.getTitle())
        ).collect(Collectors.toList());
        log.info("noticeList:{}", noticeList);
        // 批量插入数据
        boolean isSave = noticeService.saveBatch(noticeList);
        log.info("存储结果：{}", isSave);
    }

}
