package com.example.springboot.service;

import com.arcsoft.face.FaceFeature;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.springboot.entity.Admin;
import com.example.springboot.entity.UserFaceInfo;

import java.io.File;
import java.util.List;


public interface UserFaceInfoService extends IService<UserFaceInfo> {
    FaceFeature getFaceFeature(byte[] imgByte);

    int insertUserFaceInfo(UserFaceInfo userFaceInfo);

    List<UserFaceInfo> getUserFaceFeatureAll();
}
