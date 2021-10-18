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

 Date: 15/10/2021 19:17:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for album
-- ----------------------------
DROP TABLE IF EXISTS `album`;
CREATE TABLE `album`  (
  `id` int(0) NOT NULL COMMENT '相册id',
  `Album_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '相册名称',
  `Album_description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相册描述',
  `Album_addtime` datetime(0) NOT NULL COMMENT '创建时间',
  `Owner_id` int(0) NOT NULL COMMENT '创建者用户id',
  `Album_password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相册密码（暂时不用）',
  `Album_visible` binary(0) NOT NULL COMMENT '是否可见，1公开，0私密',
  `photo_count` int(0) NOT NULL DEFAULT 0 COMMENT '相片数量，默认为0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Owner_id`(`Owner_id`) USING BTREE,
  CONSTRAINT `album_ibfk_1` FOREIGN KEY (`Owner_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '类别id',
  `Category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类别名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `Category_name`(`Category_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
  `Photo_addtime` datetime(0) NOT NULL COMMENT '发布时间',
  `Photo_height` double NULL DEFAULT NULL COMMENT '相片高度',
  `Photo_width` double NULL DEFAULT NULL COMMENT '相片宽度',
  `Photo_link` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '相片链接',
  `thumb_count` int(0) NOT NULL DEFAULT 0 COMMENT '点赞量，默认为0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Album_id`(`Album_id`) USING BTREE,
  INDEX `Category_id`(`Category_id`) USING BTREE,
  CONSTRAINT `photo_ibfk_1` FOREIGN KEY (`Album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `photo_ibfk_2` FOREIGN KEY (`Category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'John', 'father001\r\nfather001\r\nfather001', 'john@163.com', '15748521036', '男', '2021-10-14 17:20:12', 0, 1, 0, 0);
INSERT INTO `user` VALUES (2, 'Eugenia', 'father002', 'eugenia@163.com', '18420553684', '女', '2021-10-14 17:58:00', 0, 1, 0, 0);
INSERT INTO `user` VALUES (3, 'Luna', 'dadie001', NULL, '18635058496', '女', '2021-10-14 18:00:43', 1, 1, 0, 0);
INSERT INTO `user` VALUES (4, 'Meave', 'dadie456', 'meave@qq.com', '18654892158', '女', '2021-10-14 23:42:58', 0, 0, 0, 0);

SET FOREIGN_KEY_CHECKS = 1;
