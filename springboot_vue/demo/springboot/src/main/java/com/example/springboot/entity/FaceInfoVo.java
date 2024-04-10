package com.example.springboot.entity;

import lombok.Data;

/**
 * @author xh
 * @Date 2022/11/3
 */
@Data
public class FaceInfoVo {
    float similarity;
    boolean result;
    Integer sex;
    Integer age;

    private Object user;
    private String identity;
}
