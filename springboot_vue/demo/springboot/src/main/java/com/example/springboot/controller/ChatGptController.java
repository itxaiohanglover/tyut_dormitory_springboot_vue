package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.manager.AiManager;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @author xh
 * @Date 2023/6/15
 */
@RestController
public class ChatGptController {

    @Resource
    private AiManager aiManager;

    @PostMapping("/sendMsg")
    public Result<String> sendMsg(@RequestBody String msg) {
        String answer = aiManager.doChat(1669210882330079234L, msg);
        System.out.println(answer);
//        String answer = "很高兴能够帮助你解决一些心理上的问题。请问你有什么需要咨询的问题吗？可能我可以为你提供一些帮助和建议。";
        return Result.success(answer);
    }
}
