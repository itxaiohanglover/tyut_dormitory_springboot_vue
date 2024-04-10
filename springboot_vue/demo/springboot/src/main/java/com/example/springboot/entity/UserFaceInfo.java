package com.example.springboot.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;

/**
 * 用户面部信息表
 * @TableName user_face_info
 */
@Data
public class UserFaceInfo implements Serializable {
    /**
     * 人脸唯一Id
     */
    private Integer faceId;
    /**
     * 人脸特征
     */
    private byte[] faceFeature;
    /**
     * 用户角色
     */
    private Integer userRole;
    /**
     * 用户ID
     */
    private String userName;

    private static final long serialVersionUID = 1L;

}
