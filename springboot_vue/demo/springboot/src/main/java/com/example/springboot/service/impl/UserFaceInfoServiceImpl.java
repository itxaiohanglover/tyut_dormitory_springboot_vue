package com.example.springboot.service.impl;

import com.arcsoft.face.*;
import com.arcsoft.face.enums.DetectMode;
import com.arcsoft.face.enums.DetectOrient;
import com.arcsoft.face.enums.ErrorInfo;
import com.arcsoft.face.toolkit.ImageInfo;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.springboot.constant.FaceConfig;
import com.example.springboot.entity.UserFaceInfo;
import com.example.springboot.mapper.UserFaceInfoMapper;

import com.example.springboot.service.UserFaceInfoService;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import static com.arcsoft.face.toolkit.ImageFactory.getRGBData;


@Service
public class UserFaceInfoServiceImpl extends ServiceImpl<UserFaceInfoMapper, UserFaceInfo> implements UserFaceInfoService {

    /**
     * 获得人脸特征
     */
    @Override
    public FaceFeature getFaceFeature(byte[] imgByte) {
        // 引擎配置
        String appId = FaceConfig.APP_ID;
        String sdkKey = FaceConfig.SDK_KEY;
        String libPath = FaceConfig.LIB_PATH;
        FaceEngine faceEngine = new FaceEngine(libPath);
        //激活引擎
        int errorCode = faceEngine.activeOnline(appId, sdkKey);

        if (errorCode != ErrorInfo.MOK.getValue() && errorCode != ErrorInfo.MERR_ASF_ALREADY_ACTIVATED.getValue()) {
            System.out.println("引擎激活失败");
        }
        ActiveFileInfo activeFileInfo = new ActiveFileInfo();
        errorCode = faceEngine.getActiveFileInfo(activeFileInfo);
        if (errorCode != ErrorInfo.MOK.getValue() && errorCode != ErrorInfo.MERR_ASF_ALREADY_ACTIVATED.getValue()) {
            System.out.println("获取激活文件信息失败");
        }

        //引擎配置
        EngineConfiguration engineConfiguration = new EngineConfiguration();
        engineConfiguration.setDetectMode(DetectMode.ASF_DETECT_MODE_IMAGE);
        engineConfiguration.setDetectFaceOrientPriority(DetectOrient.ASF_OP_ALL_OUT);
        engineConfiguration.setDetectFaceMaxNum(10);
        engineConfiguration.setDetectFaceScaleVal(16);

        FunctionConfiguration functionConfiguration = new FunctionConfiguration();
        functionConfiguration.setSupportFaceDetect(true);
        functionConfiguration.setSupportFaceRecognition(true);
        functionConfiguration.setSupportIRLiveness(true);
        engineConfiguration.setFunctionConfiguration(functionConfiguration);


        //初始化引擎
        errorCode = faceEngine.init(engineConfiguration);

        if (errorCode != ErrorInfo.MOK.getValue()) {
            System.out.println("初始化引擎失败");
        }

        //图片检测并提取
        ImageInfo imageInfo = getRGBData(imgByte);
        java.util.List<FaceInfo> faceInfoList = new ArrayList<FaceInfo>();
        errorCode = faceEngine.detectFaces(imageInfo.getImageData(), imageInfo.getWidth(), imageInfo.getHeight(), imageInfo.getImageFormat(), faceInfoList);
        FaceFeature faceFeature = new FaceFeature();
        errorCode = faceEngine.extractFaceFeature(imageInfo.getImageData(), imageInfo.getWidth(), imageInfo.getHeight(), imageInfo.getImageFormat(), faceInfoList.get(0), faceFeature);
        ;

        //引擎卸载
        errorCode = faceEngine.unInit();
        return faceFeature;
    }

    @Override
    public int insertUserFaceInfo(UserFaceInfo userFaceInfo) {
        QueryWrapper<UserFaceInfo> queryWrapper = new QueryWrapper<UserFaceInfo>()
                .eq("user_role", userFaceInfo.getUserRole()
                ).eq("user_name", userFaceInfo.getUserName());
        UserFaceInfo userFaceInfoDB = baseMapper.selectOne(queryWrapper);
        if(userFaceInfoDB != null) {
            return baseMapper.update(userFaceInfo, queryWrapper);
        }
        return baseMapper.insert(userFaceInfo);
    }

    @Override
    public List<UserFaceInfo> getUserFaceFeatureAll() {
        return baseMapper.selectList(null);
    }

}
