# dormitory 数据库文档
### 基础信息
| 数据库名称 | 版本 | 字符集 | 排序规则 |
| ---- | ---- | ---- | ---- |
| dormitory | 8.0.28 | utf8mb4 | utf8mb4_0900_ai_ci |
### 数据库表目录
| 序号 | 表名 | 描述 |
| ---- | ---- | ---- |
| 1 | adjust_room | adjust_room |
| 2 | admin | admin |
| 3 | dorm_build | dorm_build |
| 4 | dorm_manager | dorm_manager |
| 5 | dorm_room | dorm_room |
| 6 | notice | notice |
| 7 | repair | repair |
| 8 | student | student |
| 9 | user_face_info | user_face_info |
| 10 | visitor | visitor |
### 数据库表信息
#### adjust_room(adjust_room)
| 列名 | 类型 | KEY | 可否为空 | 默认值 | 注释 |
| ---- | ---- | ---- | ---- | ---- | ----  |
| apply_time | varchar(255) |  | NO |  | 申请时间 |
| currentbed_id | int |  | NO |  | 当前床位号 |
| currentroom_id | int |  | NO |  | 当前房间 |
| finish_time | varchar(255) |  | YES |  | 处理时间 |
| id | int | PRI | NO |  |  |
| name | varchar(255) |  | NO |  | 姓名 |
| state | enum('未处理','通过','驳回') |  | NO | 未处理 | 申请状态 |
| towardsbed_id | int |  | NO | 未处理 | 目标床位号 |
| towardsroom_id | int |  | NO | 未处理 | 目标房间 |
| username | varchar(255) |  | NO | 未处理 | 账号 |

#### admin(admin)
| 列名 | 类型 | KEY | 可否为空 | 默认值 | 注释 |
| ---- | ---- | ---- | ---- | ---- | ----  |
| age | int |  | NO |  | 年龄 |
| avatar | varchar(255) |  | YES |  | 头像 |
| email | varchar(255) |  | YES |  | 邮箱 |
| gender | enum('男','女') |  | NO | 男 | 性别 |
| name | varchar(255) |  | NO | 男 | 姓名 |
| password | varchar(32) |  | NO | 男 | 密码 |
| phone_num | varchar(11) |  | YES | 男 | 手机号 |
| username | varchar(255) | PRI | NO | 男 | 用户名 |

#### dorm_build(dorm_build)
| 列名 | 类型 | KEY | 可否为空 | 默认值 | 注释 |
| ---- | ---- | ---- | ---- | ---- | ----  |
| dormbuild_detail | varchar(255) |  | NO |  | 宿舍楼备注 |
| dormbuild_id | int |  | NO |  | 宿舍楼号码 |
| dormbuild_name | varchar(255) |  | NO |  | 宿舍楼名称 |
| id | int | PRI | NO |  | 主键 |

#### dorm_manager(dorm_manager)
| 列名 | 类型 | KEY | 可否为空 | 默认值 | 注释 |
| ---- | ---- | ---- | ---- | ---- | ----  |
| age | int |  | NO |  | 年龄 |
| avatar | varchar(255) |  | YES |  | 头像 |
| dormbuild_id | int |  | NO |  | 所管理的宿舍楼栋号 |
| email | varchar(255) |  | YES |  | 邮箱 |
| gender | enum('男','女') |  | NO | 男 | 性别 |
| name | varchar(255) |  | NO | 男 | 名字 |
| password | varchar(32) |  | NO | 123456 | 密码 |
| phone_num | varchar(11) |  | YES | 123456 | 手机号 |
| username | varchar(255) | PRI | NO | 123456 | 用户名 |

#### dorm_room(dorm_room)
| 列名 | 类型 | KEY | 可否为空 | 默认值 | 注释 |
| ---- | ---- | ---- | ---- | ---- | ----  |
| current_capacity | int |  | NO | 0 | 当前房间入住人数 |
| dormbuild_id | int |  | NO | 0 | 宿舍楼号 |
| dormroom_id | int | PRI | NO | 0 | 宿舍房间号 |
| first_bed | varchar(255) |  | YES | 0 | 一号床位 |
| floor_num | int |  | NO | 0 | 楼层 |
| fourth_bed | varchar(255) |  | YES | 0 | 四号床位 |
| max_capacity | int |  | NO | 4 | 房间最大入住人数 |
| second_bed | varchar(255) |  | YES | 4 | 二号床位 |
| third_bed | varchar(255) |  | YES | 4 | 三号床位 |

#### notice(notice)
| 列名 | 类型 | KEY | 可否为空 | 默认值 | 注释 |
| ---- | ---- | ---- | ---- | ---- | ----  |
| author | varchar(255) |  | NO |  | 作者 |
| content | longtext |  | NO |  | 内容 |
| id | int | PRI | NO |  | 主键 |
| release_time | datetime |  | NO |  | 发布时间 |
| title | varchar(255) |  | NO |  | 主题 |

#### repair(repair)
| 列名 | 类型 | KEY | 可否为空 | 默认值 | 注释 |
| ---- | ---- | ---- | ---- | ---- | ----  |
| content | longtext |  | NO |  | 表单内容 |
| dormbuild_id | int |  | NO |  | 报修宿舍楼 |
| dormroom_id | int |  | NO |  | 报修宿舍房间号 |
| id | int | PRI | NO |  | 订单编号 |
| order_buildtime | datetime |  | NO | CURRENT_TIMESTAMP | 订单创建时间 |
| order_finishtime | datetime |  | YES | CURRENT_TIMESTAMP | 订单完成时间 |
| repairer | varchar(255) |  | NO | CURRENT_TIMESTAMP | 报修人 |
| state | enum('完成','未完成') |  | NO | 未完成 | 订单状态（是否维修完成） |
| title | varchar(255) |  | NO | 未完成 | 表单标题 |

#### student(student)
| 列名 | 类型 | KEY | 可否为空 | 默认值 | 注释 |
| ---- | ---- | ---- | ---- | ---- | ----  |
| age | int unsigned |  | NO |  | 年龄 |
| avatar | varchar(255) |  | YES |  | 头像 |
| email | varchar(255) |  | YES |  | 邮箱 |
| gender | enum('男','女') |  | NO | 男 | 性别 |
| institute | varchar(75) |  | NO | 男 | 学院 |
| major | varchar(75) |  | NO | 男 | 专业班级 |
| name | varchar(255) |  | NO | 男 | 姓名 |
| password | varchar(32) |  | NO | 123456 | 密码 |
| phone_num | varchar(11) |  | YES | 123456 | 手机号 |
| username | varchar(255) | PRI | NO | 123456 | 学号 |

#### user_face_info(user_face_info)
| 列名 | 类型 | KEY | 可否为空 | 默认值 | 注释 |
| ---- | ---- | ---- | ---- | ---- | ----  |
| face_feature | blob |  | NO |  | 人脸特征 |
| face_id | int | PRI | NO |  | 面部ID |
| user_name | varchar(255) |  | NO |  | 用户名 |
| user_role | int |  | NO |  | 用户角色 |

#### visitor(visitor)
| 列名 | 类型 | KEY | 可否为空 | 默认值 | 注释 |
| ---- | ---- | ---- | ---- | ---- | ----  |
| content | varchar(255) |  | NO |  | 事情 |
| gender | enum('男','女') |  | NO | 男 | 性别 |
| id | int | PRI | NO | 男 |  |
| name | varchar(255) |  | NO | 男 | 姓名 |
| origin_city | varchar(255) |  | NO | 男 | 来源城市 |
| phone_num | varchar(255) |  | NO | 男 | 电话 |
| visit_time | datetime |  | NO | CURRENT_TIMESTAMP | 来访时间 |
