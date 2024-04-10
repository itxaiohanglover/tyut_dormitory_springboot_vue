package com.example.springboot.entity;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 学生
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
// 告诉Mybatis-plus，这个类与数据库中的哪张表有关
@TableName(value = "student")
public class Student implements Serializable {
    // 告诉Mybatis-plus, 属性对应表中的字段
    @TableId(value = "username")
    @ExcelProperty("学号")
    private String username;

    @TableField("password")
    @ExcelProperty("密码")
    private String password;

    @TableField("name")
    @ExcelProperty("姓名")
    private String name;

    @TableField("age")
    @ExcelProperty("年龄")
    private int age;

    @TableField("gender")
    @ExcelProperty("性别")
    private String gender;

    @TableField("phone_num")
    @ExcelProperty("电话号码")
    private String phoneNum;

    @TableField("email")
    @ExcelProperty("邮箱")
    private String email;

    @TableField("avatar")
    @ExcelIgnore
    private String avatar;

    @TableField("institute")
    @ExcelProperty("学院")
    private String institute;

    @TableField("major")
    @ExcelProperty("专业班级")
    private String major;
}
