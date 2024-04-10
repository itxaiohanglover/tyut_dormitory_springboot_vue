package com.example.springboot.controller;

import cn.hutool.core.io.FileUtil;
import com.arcsoft.face.FaceFeature;
import com.example.springboot.common.Result;
import com.example.springboot.common.UID;
import com.example.springboot.constant.FileConfig;
import com.example.springboot.constant.UserRole;
import com.example.springboot.entity.Admin;
import com.example.springboot.entity.DormManager;
import com.example.springboot.entity.Student;
import com.example.springboot.entity.UserFaceInfo;
import com.example.springboot.service.AdminService;
import com.example.springboot.service.DormManagerService;
import com.example.springboot.service.StudentService;
import com.example.springboot.service.UserFaceInfoService;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;

@RestController
@RequestMapping("/files")
public class FileController {

    static String rootFilePath = "";
    static String originalFilename = "";

    @PostConstruct
    private void init() {
        rootFilePath = FileConfig.ROOT_FILE_PATH;
        originalFilename = FileConfig.ORIGINAL_FILENAME;
    }

    @Resource
    private StudentService studentService;

    @Resource
    private AdminService adminService;

    @Resource
    private DormManagerService dormManagerService;

    @Resource
    private UserFaceInfoService userFaceInfoService;

    /**
     * 将上传的头像写入本地 rootFilePath
     */
    @PostMapping("/upload")
    public Result<?> upload(MultipartFile file) throws IOException {
        //获取文件名
        originalFilename = file.getOriginalFilename();
        System.out.println(originalFilename);
        //获取文件尾缀
        String fileType = originalFilename.substring(originalFilename.lastIndexOf("."), originalFilename.length());

        //重命名
        String uid = new UID().produceUID();
        originalFilename = uid + fileType;
        System.out.println(originalFilename);
        //存储位置
        String targetPath = rootFilePath + originalFilename;
        System.out.println(targetPath);
        //获取字节流
        FileUtil.writeBytes(file.getBytes(), targetPath);

        return Result.success("上传成功");
    }

    /**
     * 将头像名称更新到数据库中
     * 开启事务回滚
     */
    @PostMapping("/uploadAvatar/stu")
    @Transactional
    public Result<?> uploadStuAvatar(@RequestBody Student student) throws IOException {
        if (originalFilename != null) {
            student.setAvatar(originalFilename);
            System.out.println(student);
            // 更新学生头像信息并更新人脸库
            int i = studentService.updateNewStudent(student);
            if (i == 1 && updateUserFaceInfo(UserRole.STU, student.getUsername())) {
                return Result.success(originalFilename);
            }
        } else {
            return Result.error("-1", "rootFilePath为空");
        }
        return Result.error("-1", "设置头像失败");
    }

    private boolean updateUserFaceInfo(Integer type, String username) throws IOException {
        // 更新人脸库
        UserFaceInfo userFaceInfo = new UserFaceInfo();
        // 1.得到人脸特征
        FaceFeature faceFeature = userFaceInfoService.getFaceFeature(imgToByteByPath(rootFilePath + originalFilename));
        userFaceInfo.setFaceFeature(faceFeature.getFeatureData());
        // 2.设置其他信息
        userFaceInfo.setUserName(username);
        userFaceInfo.setUserRole(type);
        int j = userFaceInfoService.insertUserFaceInfo(userFaceInfo);
        return j == 1;
    }

    @PostMapping("/uploadAvatar/admin")
    public Result<?> uploadAdminAvatar(@RequestBody Admin admin) throws IOException {
        if (originalFilename != null) {
            admin.setAvatar(originalFilename);
            int i = adminService.updateAdmin(admin);
            if (i == 1 && updateUserFaceInfo(UserRole.ADMIN, admin.getUsername())) {
                return Result.success(originalFilename);
            }
        } else {
            return Result.error("-1", "rootFilePath为空");
        }
        return Result.error("-1", "设置头像失败");
    }

    @PostMapping("/uploadAvatar/dormManager")
    public Result<?> uploadDormManagerAvatar(@RequestBody DormManager dormManager) throws IOException {
        if (originalFilename != null) {
            dormManager.setAvatar(originalFilename);
            int i = dormManagerService.updateNewDormManager(dormManager);
            if (i == 1 && updateUserFaceInfo(UserRole.DORM, dormManager.getUsername())) {
                return Result.success(originalFilename);
            }
        } else {
            return Result.error("-1", "rootFilePath为空");
        }
        return Result.error("-1", "设置头像失败");
    }

    /**
     * 前端调用接口，后端查询存储与本地的头像，进行Base64编码 发送到前端
     */
    @GetMapping("/initAvatar/{filename}")
    public Result<?> initAvatar(@PathVariable String filename) throws IOException {
        System.out.println(filename);
        String path = rootFilePath + filename;
        System.out.println(path);
        return Result.success(getImage(path));
    }

    /**
     * 根据路径得到图片字节数组
     */
    private byte[] imgToByteByPath(String path) throws IOException {
        //读取图片变成字节数组
        FileInputStream fileInputStream = new FileInputStream(path);

        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        byte[] b = new byte[1024];
        int len = -1;
        while ((len = fileInputStream.read(b)) != -1) {
            bos.write(b, 0, len);
        }
        fileInputStream.close();
        bos.close();
        return bos.toByteArray();
    }

    private Result<?> getImage(String path) throws IOException {
        byte[] fileByte = imgToByteByPath(path);
        //进行base64编码
        BASE64Encoder encoder = new BASE64Encoder();
        String data = encoder.encode(fileByte);
        return Result.success(data);
    }

}
