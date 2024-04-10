package com.example.springboot.controller;

import com.arcsoft.face.*;
import com.arcsoft.face.enums.DetectMode;
import com.arcsoft.face.enums.DetectOrient;
import com.arcsoft.face.enums.ErrorInfo;
import com.arcsoft.face.toolkit.ImageInfo;
import com.example.springboot.common.Result;
import com.example.springboot.constant.FaceConfig;
import com.example.springboot.constant.UserRole;
import com.example.springboot.entity.*;
import com.example.springboot.service.AdminService;
import com.example.springboot.service.DormManagerService;
import com.example.springboot.service.StudentService;
import com.example.springboot.service.UserFaceInfoService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static com.arcsoft.face.toolkit.ImageFactory.getRGBData;
import static com.example.springboot.common.Result.error;
import static com.example.springboot.common.Result.success;

/**
 * @author xh
 * @Date 2022/12/9
 */
@RestController
@RequestMapping("/face")
public class FaceController {

    @Resource
    private UserFaceInfoService userFaceInfoService;

    @Resource
    private StudentService studentService;

    @Resource
    private DormManagerService dormManagerService;

    @Resource
    private AdminService adminService;
    /**
     * 搜集人脸
     */
    @PostMapping("/search")
    public Result<?> search(@RequestParam("file") MultipartFile file, HttpSession session) {
        FaceInfoVo faceInfoVo = verifyImg(file, session);
        System.out.println(faceInfoVo);
        if(faceInfoVo == null) {
            return error("202", "未检测到人脸");
        }
        if(faceInfoVo.isResult()) {
            return success(faceInfoVo);
        } else {
            return error("203", "人物捕捉模糊或数据库不存在此人");
        }
    }

    /**
     * 人脸验证
     */
    private FaceInfoVo verifyImg(MultipartFile file, HttpSession session) {
        // 引擎配置
        String appId = FaceConfig.APP_ID;
        String sdkKey = FaceConfig.APP_ID;
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
        //功能配置
        FunctionConfiguration functionConfiguration = new FunctionConfiguration();
        functionConfiguration.setSupportFaceDetect(true);
        functionConfiguration.setSupportFaceRecognition(true);
//        functionConfiguration.setSupportAge(true);
//        functionConfiguration.setSupportGender(true);
        functionConfiguration.setSupportIRLiveness(true);
        engineConfiguration.setFunctionConfiguration(functionConfiguration);


        //初始化引擎
        errorCode = faceEngine.init(engineConfiguration);

        if (errorCode != ErrorInfo.MOK.getValue()) {
            System.out.println("初始化引擎失败");
        }


        //
        ImageInfo imageInfo2 = null;
        try {
            imageInfo2 = getRGBData(file.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
        java.util.List<FaceInfo> faceInfoList2 = new ArrayList<FaceInfo>();
        errorCode = faceEngine.detectFaces(imageInfo2.getImageData(), imageInfo2.getWidth(), imageInfo2.getHeight(), imageInfo2.getImageFormat(), faceInfoList2);
        ;

        // 未检测到人脸
        if (faceInfoList2.size() <= 0) {
            return null;
        }

        //特征提取2
        FaceFeature faceFeature2 = new FaceFeature();
        errorCode = faceEngine.extractFaceFeature(imageInfo2.getImageData(), imageInfo2.getWidth(), imageInfo2.getHeight(), imageInfo2.getImageFormat(), faceInfoList2.get(0), faceFeature2);

        // 比对结果
        FaceInfoVo faceInfoVo = new FaceInfoVo();
        // 数据库拿到所有特征 TODO 小根堆排序，异步多线程优化 设计模式优化冗余代码
        List<UserFaceInfo> userFaceInfoList = userFaceInfoService.getUserFaceFeatureAll();
        for (UserFaceInfo userFaceInfo : userFaceInfoList) {
            // 得到面部特征
            FaceFeature faceFeature = new FaceFeature(userFaceInfo.getFaceFeature());
            //特征比对
            FaceFeature targetFaceFeature = new FaceFeature();
            targetFaceFeature.setFeatureData(faceFeature.getFeatureData());
            FaceFeature sourceFaceFeature = new FaceFeature();
            sourceFaceFeature.setFeatureData(faceFeature2.getFeatureData());
            FaceSimilar faceSimilar = new FaceSimilar();

            errorCode = faceEngine.compareFaceFeature(targetFaceFeature, sourceFaceFeature, faceSimilar);
            faceInfoVo.setSimilarity(faceSimilar.getScore());
            faceInfoVo.setResult(faceSimilar.getScore() > 0.8);
            if(faceSimilar.getScore() > 0.8) {
                // 匹配成功
                Integer userRole = userFaceInfo.getUserRole();
                if(userRole.equals(UserRole.STU)) {
                    String stuName = userFaceInfo.getUserName();
                    Student student = studentService.getById(stuName);
                    faceInfoVo.setUser(student);
                    faceInfoVo.setIdentity("stu");
                    //存入session
                    session.setAttribute("Identity", "stu");
                    session.setAttribute("User", student);
                } else if(userRole.equals(UserRole.DORM)) {
                    String dormName = userFaceInfo.getUserName();
                    DormManager dormManager = dormManagerService.getById(dormName);
                    faceInfoVo.setUser(dormManager);
                    faceInfoVo.setIdentity("stu");
                    //存入session
                    session.setAttribute("Identity", "dormManager");
                    session.setAttribute("User", dormManager);
                } else if(userRole.equals(UserRole.ADMIN)) {
                    String adminName = userFaceInfo.getUserName();
                    Admin admin = adminService.getById(adminName);
                    faceInfoVo.setUser(admin);
                    faceInfoVo.setIdentity("admin");
                    //存入session
                    session.setAttribute("Identity", "admin");
                    session.setAttribute("User", admin);
                }
                break;
            }
        }
        System.out.println("相似度：" + faceInfoVo.getSimilarity());
        //引擎卸载
        errorCode = faceEngine.unInit();
        return faceInfoVo;
    }

}
