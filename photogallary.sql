/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : photogallary

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 22/10/2021 23:39:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for album
-- ----------------------------
DROP TABLE IF EXISTS `album`;
CREATE TABLE `album`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '相册id',
  `Album_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '相册名称',
  `Album_description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相册描述',
  `Album_addtime` datetime(0) NOT NULL COMMENT '创建时间',
  `Owner_id` int(0) NOT NULL COMMENT '创建者用户id',
  `Album_password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相册密码（暂时不用）',
  `Album_visible` int(0) NOT NULL DEFAULT 0 COMMENT '是否可见，1公开，0私密，默认为0',
  `photo_count` int(0) NOT NULL DEFAULT 0 COMMENT '相片数量，默认为0',
  `cover` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'cover.jpg' COMMENT '相册封面',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Owner_id`(`Owner_id`) USING BTREE,
  CONSTRAINT `album_ibfk_1` FOREIGN KEY (`Owner_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of album
-- ----------------------------
INSERT INTO `album` VALUES (1, 'Scenery', '美丽的风景我最爱', '2021-10-20 19:05:17', 12, NULL, 0, 5, 'cover.jpg');
INSERT INTO `album` VALUES (2, 'Family', '和家人一起很快乐', '2021-10-20 19:06:40', 2, NULL, 0, 10, 'cover.jpg');
INSERT INTO `album` VALUES (3, 'Food', '太好吃了！', '2021-10-20 19:07:20', 12, NULL, 0, 5, 'cover.jpg');
INSERT INTO `album` VALUES (4, 'Animal', '好可爱的小动物啊！', '2021-10-20 19:07:56', 2, NULL, 0, 5, 'cover.jpg');
INSERT INTO `album` VALUES (5, 'Idol', '拍照了', '2021-10-20 19:08:20', 12, NULL, 0, 5, 'cover.jpg');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '类别id',
  `Category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类别名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `Category_name`(`Category_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (4, 'Animal');
INSERT INTO `category` VALUES (2, 'Family');
INSERT INTO `category` VALUES (3, 'Food');
INSERT INTO `category` VALUES (5, 'Idol');
INSERT INTO `category` VALUES (1, 'Scenery');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `Comment_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `Comment_time` datetime(0) NOT NULL COMMENT '评论时间',
  `Photo_id` int(0) NOT NULL COMMENT '评论相片id',
  `Commentators_id` int(0) NOT NULL COMMENT '评论发表者id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comment_ibfk_1`(`Photo_id`) USING BTREE,
  INDEX `Commentators_id`(`Commentators_id`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`Photo_id`) REFERENCES `photo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`Commentators_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'sessions', '0001_initial', '2021-10-18 21:36:15.100234');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('03kpgfb6rl8f17krn71pap0gl5yfbrlj', 'OGE3NTQ1YjA0OGQwOTU3Mjc3N2EwNTE2ODk5ODE0ZmYyZDNhNjA2Nzp7InZlcmlmeWNvZGUiOiIwOTMzIiwiYWRtaW51c2VyIjp7ImlkIjozLCJVc2VyX25hbWUiOiJMdW5hIiwiVXNlcl9wYXNzd29yZCI6ImRhZGllMDAxIiwiVXNlcl9lbWFpbCI6ImNoZW56aXl1YW4yMjJAMTYzLmNvbSIsIlVzZXJfcGhvbmUiOiIxODYzNTA1ODQ5NiIsIlVzZXJfZ2VuZGVyIjoiXHU1OTczIiwiZGF0ZV9qb2luZWQiOiIyMDIxLTEwLTE0IDE4OjAwOjQzIiwiVXNlcl9zdGF0dXMiOjEsIlVzZXJfY2hlY2siOjEsImFsYnVtX2NvdW50IjowLCJwaG90b19jb3VudCI6MH0sImdhbGxlcnl1c2VyIjp7ImlkIjozLCJVc2VyX25hbWUiOiJMdW5hIiwiVXNlcl9wYXNzd29yZCI6ImRhZGllMDAxIiwiVXNlcl9lbWFpbCI6ImNoZW56aXl1YW4yMjJAMTYzLmNvbSIsIlVzZXJfcGhvbmUiOiIxODYzNTA1ODQ5NiIsIlVzZXJfZ2VuZGVyIjoiXHU1OTczIiwiZGF0ZV9qb2luZWQiOiIyMDIxLTEwLTE0IDE4OjAwOjQzIiwiVXNlcl9zdGF0dXMiOjEsIlVzZXJfY2hlY2siOjEsImFsYnVtX2NvdW50IjowLCJwaG90b19jb3VudCI6MH0sInVzZXJpbmZvIjp7ImlkIjozLCJVc2VyX25hbWUiOiJMdW5hIiwiVXNlcl9wYXNzd29yZCI6ImRhZGllMDAxIiwiVXNlcl9lbWFpbCI6ImNoZW56aXl1YW4yMjJAMTYzLmNvbSIsIlVzZXJfcGhvbmUiOiIxODYzNTA1ODQ5NiIsIlVzZXJfZ2VuZGVyIjoiXHU1OTczIiwiZGF0ZV9qb2luZWQiOiIyMDIxLTEwLTE0IDE4OjAwOjQzIiwiVXNlcl9zdGF0dXMiOjEsIlVzZXJfY2hlY2siOjEsImFsYnVtX2NvdW50IjowLCJwaG90b19jb3VudCI6MH19', '2021-11-05 23:25:04.784820');
INSERT INTO `django_session` VALUES ('o2sro7uyg2ylc4uixgbg5tkutdjiha74', 'YTdmMmQ5NTQ4N2ZlY2MwNDA4N2Q4MTIwYTZmMzM4NjY3OWM4OTEwOTp7InZlcmlmeWNvZGUiOiI3MTEyIiwiYWRtaW51c2VyIjp7ImlkIjozLCJVc2VyX25hbWUiOiJMdW5hIiwiVXNlcl9wYXNzd29yZCI6ImRhZGllMDAxIiwiVXNlcl9lbWFpbCI6ImNoZW56aXl1YW4yMjJAMTYzLmNvbSIsIlVzZXJfcGhvbmUiOiIxODYzNTA1ODQ5NiIsIlVzZXJfZ2VuZGVyIjoiXHU1OTczIiwiZGF0ZV9qb2luZWQiOiIyMDIxLTEwLTE0IDE4OjAwOjQzIiwiVXNlcl9zdGF0dXMiOjEsIlVzZXJfY2hlY2siOjEsImFsYnVtX2NvdW50IjowLCJwaG90b19jb3VudCI6MH19', '2021-11-02 23:13:25.746477');
INSERT INTO `django_session` VALUES ('sxvn0sk38am3ypcpdrczo1k0m6ht43f1', 'MjEzZDZhODM3ODBiNGU3ZDQwZTJhYjZhNDFmZjJiZDE3ZDUzNGEyZjp7InZlcmlmeWNvZGUiOiIyMjE4IiwiZ2FsbGVyeXVzZXIiOnsiaWQiOjMsIlVzZXJfbmFtZSI6Ikx1bmEiLCJVc2VyX3Bhc3N3b3JkIjoiZGFkaWUwMDEiLCJVc2VyX2VtYWlsIjoiY2hlbnppeXVhbjIyMkAxNjMuY29tIiwiVXNlcl9waG9uZSI6IjE4NjM1MDU4NDk2IiwiVXNlcl9nZW5kZXIiOiJcdTU5NzMiLCJkYXRlX2pvaW5lZCI6IjIwMjEtMTAtMTQgMTg6MDA6NDMiLCJVc2VyX3N0YXR1cyI6MSwiVXNlcl9jaGVjayI6MSwiYWxidW1fY291bnQiOjAsInBob3RvX2NvdW50IjowfX0=', '2021-11-05 20:39:03.359182');

-- ----------------------------
-- Table structure for favorites
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites`  (
  `Collect_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '收藏id',
  `Collector_id` int(0) NOT NULL COMMENT '收藏者用户id',
  `Collect_date` datetime(0) NOT NULL COMMENT '收藏时间',
  `Photo_id` int(0) NOT NULL COMMENT '收藏相片id',
  PRIMARY KEY (`Collect_id`) USING BTREE,
  INDEX `Collector_id`(`Collector_id`) USING BTREE,
  INDEX `Photo_id`(`Photo_id`) USING BTREE,
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`Collector_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`Photo_id`) REFERENCES `photo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for photo
-- ----------------------------
DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '相片id',
  `Album_id` int(0) NOT NULL COMMENT '相册id',
  `Photo_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '相片名称',
  `Photo_description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相片描述',
  `Category_id` int(0) NULL DEFAULT NULL COMMENT '类别id',
  `Photo_addtime` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `Photo_height` double NULL DEFAULT NULL COMMENT '相片高度',
  `Photo_width` double NULL DEFAULT NULL COMMENT '相片宽度',
  `Photo_link` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '相片链接',
  `thumb_count` int(0) NOT NULL DEFAULT 0 COMMENT '点赞量，默认为0',
  `Photo_visible` int(0) NOT NULL DEFAULT 0 COMMENT '相片是否可见，0私密，1公开',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Category_id`(`Category_id`) USING BTREE,
  INDEX `Album_id`(`Album_id`) USING BTREE,
  CONSTRAINT `photo_ibfk_2` FOREIGN KEY (`Category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `photo_ibfk_3` FOREIGN KEY (`Album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of photo
-- ----------------------------
INSERT INTO `photo` VALUES (1, 1, '水', '有意境了', 1, '2021-10-20 19:10:10', NULL, NULL, '1.jpg', 0, 0);
INSERT INTO `photo` VALUES (2, 1, '景', '爱了', 1, '2021-10-20 19:11:00', NULL, NULL, '2.jpg', 0, 0);
INSERT INTO `photo` VALUES (3, 1, '3.jpg', NULL, 1, '2021-10-20 19:11:20', NULL, NULL, '3.jpg', 0, 0);
INSERT INTO `photo` VALUES (4, 1, '4.jpg', NULL, 1, '2021-10-20 19:12:05', NULL, NULL, '4.jpg', 0, 0);
INSERT INTO `photo` VALUES (5, 1, '5.jpg', NULL, 1, '2021-10-20 19:12:29', NULL, NULL, '5.jpg', 0, 0);
INSERT INTO `photo` VALUES (6, 2, '6.jpg', NULL, 2, '2021-10-20 19:13:04', NULL, NULL, '6.jpg', 0, 0);
INSERT INTO `photo` VALUES (7, 2, '7.jpg', NULL, 2, '2021-10-20 19:13:29', NULL, NULL, '7.jpg', 0, 0);
INSERT INTO `photo` VALUES (8, 2, '8.jpg', NULL, 2, '2021-10-20 19:13:55', NULL, NULL, '8.jpg', 0, 0);
INSERT INTO `photo` VALUES (9, 2, '9.jpg', NULL, 2, '2021-10-20 19:14:18', NULL, NULL, '9.jpg', 0, 0);
INSERT INTO `photo` VALUES (10, 2, '10.jpg', NULL, 2, '2021-10-20 19:14:41', NULL, NULL, '10.jpg', 0, 0);
INSERT INTO `photo` VALUES (11, 2, '11.jpg', NULL, 2, '2021-10-20 19:15:03', NULL, NULL, '11.jpg', 0, 0);
INSERT INTO `photo` VALUES (12, 2, '12.jpg', NULL, 2, '2021-10-20 19:15:29', NULL, NULL, '12.jpg', 0, 0);
INSERT INTO `photo` VALUES (13, 2, '13.jpg', NULL, 2, '2021-10-20 19:15:56', NULL, NULL, '13.jpg', 0, 0);
INSERT INTO `photo` VALUES (14, 2, '14.jpg', NULL, 2, '2021-10-20 19:16:16', NULL, NULL, '14.jpg', 0, 0);
INSERT INTO `photo` VALUES (15, 2, '15.jpg', NULL, 2, '2021-10-20 19:16:37', NULL, NULL, '15.jpg', 0, 0);
INSERT INTO `photo` VALUES (16, 5, '16.jpg', NULL, 5, '2021-10-20 19:17:29', NULL, NULL, '16.jpg', 0, 0);
INSERT INTO `photo` VALUES (17, 5, '17.jpg', NULL, 5, '2021-10-20 19:17:50', NULL, NULL, '17.jpg', 0, 0);
INSERT INTO `photo` VALUES (18, 5, '18.jpg', NULL, 5, '2021-10-20 19:18:10', NULL, NULL, '18.jpg', 0, 0);
INSERT INTO `photo` VALUES (19, 2, '19.jpg', NULL, 2, '2021-10-20 19:18:49', NULL, NULL, '19.jpg', 0, 0);
INSERT INTO `photo` VALUES (20, 2, '20.jpg', NULL, 2, '2021-10-20 19:19:09', NULL, NULL, '20.jpg', 0, 0);
INSERT INTO `photo` VALUES (21, 3, '21.jpg', NULL, 3, '2021-10-20 19:19:39', NULL, NULL, '21.jpg', 0, 0);
INSERT INTO `photo` VALUES (22, 3, '22.jpg', NULL, 3, '2021-10-20 19:20:01', NULL, NULL, '22.jpg', 0, 0);
INSERT INTO `photo` VALUES (23, 3, '23.jpg', NULL, 3, '2021-10-20 19:20:22', NULL, NULL, '23.jpg', 0, 0);
INSERT INTO `photo` VALUES (24, 3, '24.jpg', NULL, 3, '2021-10-20 19:20:44', NULL, NULL, '24.jpg', 0, 0);
INSERT INTO `photo` VALUES (25, 3, '25.jpg', NULL, 3, '2021-10-20 19:21:08', NULL, NULL, '25.jpg', 0, 0);
INSERT INTO `photo` VALUES (26, 4, '26.jpg', NULL, 4, '2021-10-20 19:21:34', NULL, NULL, '26.jpg', 0, 0);
INSERT INTO `photo` VALUES (27, 4, '27.jpg', NULL, 4, '2021-10-20 19:21:58', NULL, NULL, '27.jpg', 0, 0);
INSERT INTO `photo` VALUES (28, 4, '28.jpg', NULL, 4, '2021-10-20 19:22:17', NULL, NULL, '28.jpg', 0, 0);
INSERT INTO `photo` VALUES (29, 4, '29.jpg', NULL, 4, '2021-10-20 19:22:40', NULL, NULL, '29.jpg', 0, 0);
INSERT INTO `photo` VALUES (30, 4, '30.jpg', NULL, 4, '2021-10-20 19:23:02', NULL, NULL, '30.jpg', 0, 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `User_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `User_password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `User_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `User_phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `User_gender` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `date_joined` datetime(0) NOT NULL COMMENT '注册时间',
  `User_status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '用户身份，0为用户，1为管理员，默认为0',
  `User_check` tinyint(0) NOT NULL DEFAULT 0 COMMENT '审核状态，0为未通过，1为已通过，默认为0',
  `album_count` int(0) NOT NULL DEFAULT 0 COMMENT '相册数量，默认为0',
  `photo_count` int(0) NOT NULL DEFAULT 0 COMMENT '相片数量，默认为0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `User_name`(`User_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (2, 'Eugenia', 'father002', 'eugenia@163.com', '18420553684', '女', '2021-10-14 17:58:00', 0, 1, 0, 0);
INSERT INTO `user` VALUES (3, 'Luna', 'dadie001', 'chenziyuan222@163.com', '18635058496', '女', '2021-10-14 18:00:43', 1, 1, 0, 0);
INSERT INTO `user` VALUES (4, 'Meave', 'dadie456', 'meave@qq.com', '18654892158', '女', '2021-10-14 23:42:58', 0, 0, 0, 0);
INSERT INTO `user` VALUES (5, 'Alex', 'haha000', 'alex@126.com', 'None', '男', '2021-10-15 20:13:02', 0, 0, 0, 0);
INSERT INTO `user` VALUES (12, 'Mary', 'mama555', 'mary11@163.com', '15786352148', '女', '2021-10-17 17:24:30', 0, 0, 0, 0);
INSERT INTO `user` VALUES (17, 'John', 'father001', 'John@qq.com', '15748259684', '男', '2021-10-20 13:47:43', 0, 1, 0, 0);
INSERT INTO `user` VALUES (49, 'Alice', 'alala888', 'None', '18563254785', NULL, '2021-10-21 15:29:56', 0, 1, 0, 0);

SET FOREIGN_KEY_CHECKS = 1;
