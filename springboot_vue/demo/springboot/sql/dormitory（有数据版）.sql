/*
 Navicat Premium Data Transfer

 Source Server         : localhsot
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : dormitory

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 14/12/2022 18:28:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for adjust_room
-- ----------------------------
DROP TABLE IF EXISTS `adjust_room`;
CREATE TABLE `adjust_room`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `currentroom_id` int NOT NULL COMMENT '当前房间',
  `currentbed_id` int NOT NULL COMMENT '当前床位号',
  `towardsroom_id` int NOT NULL COMMENT '目标房间',
  `towardsbed_id` int NOT NULL COMMENT '目标床位号',
  `state` enum('未处理','通过','驳回') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未处理' COMMENT '申请状态',
  `apply_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '申请时间',
  `finish_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of adjust_room
-- ----------------------------
INSERT INTO `adjust_room` VALUES (2, 'stu1', '张三', 1101, 1, 1102, 4, '通过', '2022-12-17 14:35:02', '2022-12-19 23:07:21');
INSERT INTO `adjust_room` VALUES (5, 'stu2', '田田', 1101, 2, 1104, 1, '未处理', '2022-11-19 23:05:25', NULL);
INSERT INTO `adjust_room` VALUES (6, 'stu3', '吉安', 1101, 3, 1104, 2, '驳回', '2022-11-19 23:05:52', '2022-11-19 23:07:37');
INSERT INTO `adjust_room` VALUES (7, 'stu9', '德萨', 1103, 2, 1105, 1, '未处理', '2022-06-19 23:06:18', NULL);
INSERT INTO `adjust_room` VALUES (8, 'stu6', '泡泡', 1102, 2, 1104, 4, '未处理', '2022-08-19 23:06:52', NULL);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `gender` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `age` int NOT NULL COMMENT '年龄',
  `phone_num` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('admin', '123456', '刘宇航', '男', 22, '15234390329', '1531137510@qq.com', '984d9d8b24b949cb89f8f1dc21570ba1.jpg');

-- ----------------------------
-- Table structure for dorm_build
-- ----------------------------
DROP TABLE IF EXISTS `dorm_build`;
CREATE TABLE `dorm_build`  (
  `dormbuild_id` int NOT NULL COMMENT '宿舍楼号码',
  `dormbuild_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宿舍楼名称',
  `dormbuild_detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宿舍楼备注',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dorm_build
-- ----------------------------
INSERT INTO `dorm_build` VALUES (1, '一号楼', '男宿舍', 1);
INSERT INTO `dorm_build` VALUES (2, '二号楼', '女宿舍', 2);
INSERT INTO `dorm_build` VALUES (3, '三号楼', '男宿舍', 3);
INSERT INTO `dorm_build` VALUES (4, '四号楼', '女宿舍', 4);

-- ----------------------------
-- Table structure for dorm_manager
-- ----------------------------
DROP TABLE IF EXISTS `dorm_manager`;
CREATE TABLE `dorm_manager`  (
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '123456' COMMENT '密码',
  `dormbuild_id` int NOT NULL COMMENT '所管理的宿舍楼栋号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名字',
  `gender` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `age` int NOT NULL COMMENT '年龄',
  `phone_num` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dorm_manager
-- ----------------------------
INSERT INTO `dorm_manager` VALUES ('dorm1', '123456', 1, '张三', '男', 35, '15995917873', NULL, NULL);
INSERT INTO `dorm_manager` VALUES ('dorm2', '123456', 2, '李四', '女', 55, '15995917874', NULL, NULL);
INSERT INTO `dorm_manager` VALUES ('dorm3', '123456', 3, '王五', '男', 38, '15896875201', NULL, NULL);
INSERT INTO `dorm_manager` VALUES ('dorm4', '123456', 4, '赵花', '女', 40, '15877535247', NULL, NULL);

-- ----------------------------
-- Table structure for dorm_room
-- ----------------------------
DROP TABLE IF EXISTS `dorm_room`;
CREATE TABLE `dorm_room`  (
  `dormroom_id` int NOT NULL COMMENT '宿舍房间号',
  `dormbuild_id` int NOT NULL COMMENT '宿舍楼号',
  `floor_num` int NOT NULL COMMENT '楼层',
  `max_capacity` int NOT NULL DEFAULT 4 COMMENT '房间最大入住人数',
  `current_capacity` int NOT NULL DEFAULT 0 COMMENT '当前房间入住人数',
  `first_bed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一号床位',
  `second_bed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二号床位',
  `third_bed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '三号床位',
  `fourth_bed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '四号床位',
  PRIMARY KEY (`dormroom_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dorm_room
-- ----------------------------
INSERT INTO `dorm_room` VALUES (1101, 1, 1, 4, 4, '2020007694', 'stu2', 'stu3', 'stu4');
INSERT INTO `dorm_room` VALUES (1102, 1, 1, 4, 4, 'stu5', 'stu6', 'stu7', 'stu1');
INSERT INTO `dorm_room` VALUES (1103, 1, 1, 4, 4, 'stu8', 'stu9', 'stu10', 'stu11');
INSERT INTO `dorm_room` VALUES (1104, 1, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1105, 1, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1201, 1, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1202, 1, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1203, 1, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1204, 1, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1205, 1, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1301, 1, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1302, 1, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1303, 1, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1304, 1, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1305, 1, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2101, 2, 1, 4, 3, 'stu12', 'stu13', 'stu14', NULL);
INSERT INTO `dorm_room` VALUES (2102, 2, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2103, 2, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2104, 2, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2105, 2, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2201, 2, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2202, 2, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2203, 2, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2204, 2, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2205, 2, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2301, 2, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2302, 2, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2303, 2, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2304, 2, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2305, 2, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3101, 3, 1, 4, 3, 'stu15', 'stu16', 'stu16', NULL);
INSERT INTO `dorm_room` VALUES (3102, 3, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3103, 3, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3104, 3, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3105, 3, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3201, 3, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3202, 3, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3203, 3, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3204, 3, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3205, 3, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3301, 3, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3302, 3, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3303, 3, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3304, 3, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3305, 3, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4101, 4, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4102, 4, 1, 4, 3, 'stu17', 'stu18', 'stu19', NULL);
INSERT INTO `dorm_room` VALUES (4103, 4, 1, 4, 1, 'stu20', NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4104, 4, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4105, 4, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4201, 4, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4202, 4, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4203, 4, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4204, 4, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4205, 4, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4301, 4, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4302, 4, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4303, 4, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4304, 4, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4305, 4, 3, 4, 0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `release_time` datetime NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '本科生院关于疫情防控期间各项工作服务指南', 'http://jwc.tyut.edu.cn/info/1057/4463.htm', '太原理工大学', '2022-12-07 00:09:08');
INSERT INTO `notice` VALUES (3, '期末考试通知', '<p>学期末降至，本学期所教授的课程也接近尾声，同学们利用好最后一段时间，好好复习争取考个好成绩！</p>', '刘宇航', '2022-12-09 01:38:04');
INSERT INTO `notice` VALUES (18, '关于2021级本科生大类内转专业拟录名单公示', 'http://jwc.tyut.edu.cn/info/1057/4412.htm', '太原理工大学', '2022-10-06 00:01:00');
INSERT INTO `notice` VALUES (19, '太原理工大学关于2022年度校级“课程思政”示范课程建设立项结果的公示', 'http://jwc.tyut.edu.cn/info/1057/4390.htm', '太原理工大学', '2022-09-28 00:02:00');
INSERT INTO `notice` VALUES (20, '关于拟推荐申报2022年度省级一流本科课程的公示', 'http://jwc.tyut.edu.cn/info/1057/4385.htm', '太原理工大学', '2022-09-14 00:03:00');
INSERT INTO `notice` VALUES (21, '关于做好2021级本科生大类内转专业工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4384.htm', '太原理工大学', '2022-09-13 00:04:00');
INSERT INTO `notice` VALUES (22, '关于拟推荐2022年度山西省高等教育教学改革创新项目（思想政治理论课）的公示', 'http://jwc.tyut.edu.cn/info/1057/4382.htm', '太原理工大学', '2022-09-05 00:05:00');
INSERT INTO `notice` VALUES (23, '太原理工大学关于调整新生开学有关工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4377.htm', '太原理工大学', '2022-09-05 00:06:00');
INSERT INTO `notice` VALUES (24, '关于申报2022年教育部产学合作协同育人项目的通知', 'http://jwc.tyut.edu.cn/info/1057/4374.htm', '太原理工大学', '2022-08-29 00:07:00');
INSERT INTO `notice` VALUES (25, '关于开展2022年度校级一流课程认定及推荐参评省级一流课程工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4373.htm', '太原理工大学', '2022-08-27 00:08:00');
INSERT INTO `notice` VALUES (26, '关于本学期通识基础选修实体课的选课结课及开课通知', 'http://jwc.tyut.edu.cn/info/1057/4371.htm', '太原理工大学', '2022-08-26 00:09:00');
INSERT INTO `notice` VALUES (27, '关于2022-2023学年秋季学期2018-2021年级通识基础选修课的选课通知', 'http://jwc.tyut.edu.cn/info/1057/4363.htm', '太原理工大学', '2022-08-18 00:10:00');
INSERT INTO `notice` VALUES (28, '关于我校2022年度拟申请设置、撤销本科专业的公示', 'http://jwc.tyut.edu.cn/info/1057/4354.htm', '太原理工大学', '2022-07-21 00:11:00');
INSERT INTO `notice` VALUES (29, '关于开展我校2022年度本科专业设置工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4351.htm', '太原理工大学', '2022-07-07 00:12:00');
INSERT INTO `notice` VALUES (30, '本科生院2022年暑期服务指南', 'http://jwc.tyut.edu.cn/info/1057/4342.htm', '太原理工大学', '2022-07-02 00:13:00');
INSERT INTO `notice` VALUES (31, '关于开展2022年度太原理工大学“课程思政”示范课程建设工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4337.htm', '太原理工大学', '2022-06-24 00:14:00');

-- ----------------------------
-- Table structure for repair
-- ----------------------------
DROP TABLE IF EXISTS `repair`;
CREATE TABLE `repair`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `repairer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报修人',
  `dormbuild_id` int NOT NULL COMMENT '报修宿舍楼',
  `dormroom_id` int NOT NULL COMMENT '报修宿舍房间号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单内容',
  `state` enum('完成','未完成') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未完成' COMMENT '订单状态（是否维修完成）',
  `order_buildtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单创建时间',
  `order_finishtime` datetime NULL DEFAULT NULL COMMENT '订单完成时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1413525505 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of repair
-- ----------------------------
INSERT INTO `repair` VALUES (-12455934, '张三', 1, 1101, '阳台漏水', '阳台使用时会漏水请来修理', '未完成', '2022-12-09 20:37:35', NULL);
INSERT INTO `repair` VALUES (1, '强强', 1, 1101, '水龙头损坏', '水龙头损坏，请来1-1101宿舍修理', '完成', '2022-12-09 22:52:24', '2022-02-18 14:35:02');
INSERT INTO `repair` VALUES (2, '七七', 1, 1101, '门把手损坏', '门把手损坏，请来修理', '完成', '2022-12-09 23:11:13', '2022-12-16 14:31:14');
INSERT INTO `repair` VALUES (3, '丽丽', 2, 2102, '水池损坏', '水池损坏，请来修理', '完成', '2022-12-09 23:10:35', '2022-12-30 16:16:15');
INSERT INTO `repair` VALUES (4, '贝贝', 1, 1102, '阳台漏水', '宿舍阳台漏水，速来修理', '完成', '2022-12-09 23:12:16', '2022-12-30 14:32:38');
INSERT INTO `repair` VALUES (5, '哈哈', 1, 1101, '窗台损坏', '宿舍窗台损坏，速来修理', '未完成', '2022-12-09 22:35:37', NULL);
INSERT INTO `repair` VALUES (6, '张三', 1, 1101, '浴室天花板漏水', '浴室天花板漏水', '完成', '2022-12-09 21:00:21', '2022-12-17 14:39:10');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学号',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '123456' COMMENT '密码',
  `age` int UNSIGNED NOT NULL COMMENT '年龄',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `gender` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `phone_num` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `institute` varchar(75) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学院',
  `major` varchar(75) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '专业班级',
  PRIMARY KEY (`username`) USING BTREE,
  UNIQUE INDEX `stu_num`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2020007679', '101777', 20, '贺一凡', '女', '1383468****', '22546****@qq.com', NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('2020007680', '20810', 20, '张雨佳', '女', '15110****', '1443***@qq.com', NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('2020007694', 'sdskdhs', 22, '刘宇航', '男', '1523439****', '15311****@qq.com', NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('2020007696', '147258369', 21, '赵新浩', '男', '1770346****', '16054*****@qq.com', NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('2020007697', 'xcxcxc', 23, '杨帆', '男', '1770346****', '16054*****@qq.com', NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu1', '123456', 18, '张三', '男', '15875696511', NULL, '', '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu10', '123456', 19, '马克', '女', '15889635874', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu11', '123456', 16, '巧巧', '女', '18978431781', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu12', '123456', 17, '丽丽', '女', '17986573547', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu13', '123456', 18, '美美', '女', '15896475354', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu14', '123456', 20, '拉拉', '女', '14896527357', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu15', '123456', 18, '贝贝', '男', '15896745351', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu16', '123456', 18, '力力', '男', '14596475257', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu17', '123456', 18, '阿成', '男', '15896542147', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu18', '123456', 19, '阿达', '女', '14785635874', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu19', '123456', 19, '帕森斯', '男', '15889658475', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu2', '123456', 18, '田田', '男', '15875359641', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu20', '123456', 21, '柠檬', '男', '15874563558', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu21', '123456', 21, '面对', '男', '15889635874', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu22', '123456', 25, '等等', '男', '15589963321', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu3', '123456', 18, '吉安', '男', '15798657350', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu4', '123456', 22, '力力', '男', '15878965874', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu5', '123456', 19, '哦哦', '男', '15897535478', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu6', '123456', 18, '泡泡', '男', '18987554765', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu7', '123456', 15, '刚刚', '男', '15897543854', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu8', '123456', 18, '七七', '男', '12332143215', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu9', '123456', 20, '德萨', '男', '15889658741', NULL, NULL, '软件学院', '软件2029');

-- ----------------------------
-- Table structure for user_face_info
-- ----------------------------
DROP TABLE IF EXISTS `user_face_info`;
CREATE TABLE `user_face_info`  (
  `face_id` int NOT NULL AUTO_INCREMENT COMMENT '面部ID',
  `face_feature` blob NOT NULL COMMENT '人脸特征',
  `user_role` int NOT NULL COMMENT '用户角色',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  PRIMARY KEY (`face_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_face_info
-- ----------------------------
INSERT INTO `user_face_info` VALUES (5, 0x0080FA440000A04179EF2D3D1F65EABC091C14BD5B108FBD0D6729BD2310EEBB705A973D66AE0A3E86FFB1BDAE4FD5BC8A3AE23C4DFF6DBD71C300BE818E3BBE56A419BDADDA23BD6938293E63E4EBBD06AB19BC2290B9BD7B74933D91B9E93C26761DBD3E74B0BD651E86BDB1D86BBDF15885BD57A99E3B1CF9873DC5033FBDF263A6BC5D49463D87849EBA163AAB3B124A2FBD27D4F0BCD931883B26CECF3D8740EABDD43CBC3A378CF43DC0A235BD86AE03BD72BD97BC777A9BBC448752BD3277D03CE7AE44BD7C29B4BD3D10AA3BEE30E7BD9D513BBE9BABBD3DB66DC73C0CC3A23D31309BBD05DF133D59D7D8BD8DED06BD1685443C200849BD59AE5B3C3F651A3DB6CEF3BD99E133BDC92B20BB74428DBC2382BDBD057AEEBD4C3FC63D743BF63D174311BD3AFA1DBC53A9B23D2A75B73C6C21783C8E6AD83CEA1F5F3D1245D63D5E62573C0A1F323AD647C0BDB75DC53DCDA210BC413DAD3D6A0D19BCFB8F86BB009FF13D9D737DBDAAEEE73C3434BABD2089393D942515BDB748043D9691F1BCDC0D95BCAC056BBDF51821BD0B951A3CEA5D1EBCE5682ABB9C57EFBDFB61A63D8C0B843D0326B93D2351DCBCA2BBC63D4EE4593C5EA894BD8797753D9A928EBDB7052F3D47278ABD5CE37BBC638EC73DCF08F83C5E3F5D3CAE571EBD49984B3D2CD1F3BAC3B04B3D3A937EBCC551763C233B1DBC4C130A3DF75BB13D6C321DBD2E05873BCA07D83C8E87B93DAD0D5D3DF131A0BD2B78A53C0403D73D028D69BC6B5D1FBD8299473B42647F3D474EA1BC03BC7DBD3A83AABC2A85763D63A2C33BCB9A80BD1537C7BD5F0D853D3DE78E3B2E8D363CF16004BE1D1C26BDE08CCA3D35DA82BD2DD3DD3C162A163E0C6F32BD9A6A8CBCAEBB103D54CD89BD327202BD8E3A5B3C715A163D09C734BD9C7727BD6A4ED33DC23759BE1FA70E3DC320093E4BE1373B4E73E0BCDC3DB33C96E97C3C00AC3E3EFEB4EC3B51BB3EBD2BC6B8BC39F7E7BDA463013D0DF572BDC743F9BD5F37B43D2DC3163D44CCE73B00EF82BCFD4915BD701F4E3BF45D23BD6B27D43CD1A6C93DDB64A7BC8786BEBCE332FDBC395922BD9C6FB4BCD00F81BBADFD6D3DE31A133DC9FFD4BC626E01BD83BBCE3D84EACC3D532537BDCAFEDBBDC0996C3DB71E853DDF1C1CBDB51DA8BBC980183D0DAA253D54A598BB05AD643D7697813CAC3CB33D32305A3CC2E0CB3D762F56BDB673533DADD3A93C3BCDC03CB139A7BD0294C93DB3FB1B3C7FF78EBD6F06B1BC17D41DBEEBD184BDE6DE80BC72910F3D144545BD13A33ABDA07AF5BC3CE3893D82889ABDC0DD943B9F34863D1D0E3FBDF1029F3DB6D681BBFFFD9CBDD5CB9D3D05AE463D6754A43DC14356BD52E08ABC259EC73BB3B7B5BD1692A53D4BE4ECBDCBE8AEBD34E9723D852F85BD02F7263B3EB8543D8007CF3D90F4FABC570D173B2A37E53C, 3, 'admin');

-- ----------------------------
-- Table structure for visitor
-- ----------------------------
DROP TABLE IF EXISTS `visitor`;
CREATE TABLE `visitor`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `gender` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `phone_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `origin_city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '来源城市',
  `visit_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '来访时间',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '事情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visitor
-- ----------------------------
INSERT INTO `visitor` VALUES (1, '张三', '男', '14587896544', '运城', '2022-12-09 17:34:52', '探访孩子');
INSERT INTO `visitor` VALUES (2, '李四', '女', '15774147563', '吕梁', '2022-12-09 17:08:06', '运送快递');
INSERT INTO `visitor` VALUES (3, '啊啊', '男', '14588635774', '临汾', '2022-12-09 16:41:21', '运送食品');

SET FOREIGN_KEY_CHECKS = 1;
