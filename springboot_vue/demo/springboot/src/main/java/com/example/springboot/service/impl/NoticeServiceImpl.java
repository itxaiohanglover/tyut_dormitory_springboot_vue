package com.example.springboot.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.springboot.constant.ScheduleConstant;
import com.example.springboot.entity.Notice;
import com.example.springboot.mapper.NoticeMapper;
import com.example.springboot.service.NoticeService;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;


@Service
@Slf4j
public class NoticeServiceImpl extends ServiceImpl<NoticeMapper, Notice> implements NoticeService {


    /**
     * 注入DAO层对象
     */
    @Resource
    private NoticeMapper noticeMapper;

    /**
     * 公告添加
     */
    @Override
    public int addNewNotice(Notice notice) {
        int insert = noticeMapper.insert(notice);
        return insert;
    }

    /**
     * 公告查找
     */
    @Override
    public Page find(Integer pageNum, Integer pageSize, String search) {
        Page page = new Page<>(pageNum, pageSize);
        QueryWrapper<Notice> qw = new QueryWrapper<>();
        qw.like("title", search);
        Page noticePage = noticeMapper.selectPage(page, qw);
        return noticePage;
    }

    /**
     * 公告更新
     */
    @Override
    public int updateNewNotice(Notice notice) {
        int i = noticeMapper.updateById(notice);
        return i;
    }

    /**
     * 公告删除
     */
    @Override
    public int deleteNotice(Integer id) {
        int i = noticeMapper.deleteById(id);
        return i;
    }

    /**
     * 首页公告展示
     */
    @Override
    public List<?> homePageNotice() {
        QueryWrapper<Notice> qw = new QueryWrapper<>();
        qw.orderByDesc("release_time");
        List<Notice> noticeList = noticeMapper.selectList(qw);
        return noticeList;
    }

    @Override
    public boolean updateWebNotice() {
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
        // 如果未爬取到信息则停不需要查询数据库
        if(notices.size() == 0) {
            return false;
        }
        // 更新数据库文章
        // 判断数据库是否存在文章
        List<Notice> homePageNotice = (List<Notice>) (homePageNotice());
        // 作者信息筛选
        Set<String> titleSet = homePageNotice.stream()
                .filter(n -> ScheduleConstant.AUTHOR.equals(n.getAuthor()))
                .map(Notice::getTitle).collect(Collectors.toSet());
        log.info("数据库已有的：titleSet:{}", titleSet);
        List<Notice> noticeList = notices.stream()
                .filter(notice -> !titleSet.contains(notice.getTitle())
                ).collect(Collectors.toList());
        log.info("筛选后的：noticeList:{}", noticeList);
        if(noticeList.size() == 0) {
            return true;
        }
        // 批量插入数据
        return saveBatch(noticeList);
    }
}
