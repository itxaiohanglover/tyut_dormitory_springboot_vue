package com.example.springboot.entity;

import lombok.Data;

/**
 * @author xh
 * @Date 2022/12/9
 */
@Data
public class FaceLoginInfoVo {
    private FaceInfoVo faceInfoVo;
    private Object user;
    private String identity;
}
