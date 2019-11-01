/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 80017
Source Host           : localhost:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 80017
File Encoding         : 65001

Date: 2019-11-01 11:37:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `article_id` int(10) NOT NULL AUTO_INCREMENT,
  `article_user_id` int(10) NOT NULL,
  `article_title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `article_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `article_post_time` datetime NOT NULL,
  `look_count` int(10) NOT NULL,
  `comment_count` int(10) NOT NULL,
  PRIMARY KEY (`article_id`),
  KEY `user_id_fk` (`article_user_id`),
  CONSTRAINT `user_id_fk` FOREIGN KEY (`article_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('24', '26', 'HYA！', '123123123', '2019-10-30 20:38:22', '16', '3');
INSERT INTO `article` VALUES ('26', '25', '12434t', '发送到发送', '2019-10-31 10:20:33', '19', '3');
INSERT INTO `article` VALUES ('34', '27', '12321', '321321', '2019-10-31 16:20:12', '3', '1');
INSERT INTO `article` VALUES ('35', '24', '213213', '', '2019-10-31 16:21:47', '4', '1');
INSERT INTO `article` VALUES ('36', '24', 'as wq', ' wq ', '2019-10-31 16:24:17', '1', '0');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_user_id` int(11) NOT NULL,
  `comment_post_time` datetime NOT NULL,
  `comment_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `comment_article_id` int(11) NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comment_article_id_fk` (`comment_article_id`),
  KEY `comment_user_id_fk` (`comment_user_id`),
  CONSTRAINT `comment_article_id_fk` FOREIGN KEY (`comment_article_id`) REFERENCES `article` (`article_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comment_user_id_fk` FOREIGN KEY (`comment_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('9', '26', '2019-10-30 20:38:27', '12312312312312313', '24');
INSERT INTO `comment` VALUES ('13', '25', '2019-10-31 10:20:36', '是啊', '26');
INSERT INTO `comment` VALUES ('14', '27', '2019-10-31 15:30:52', '1231', '24');
INSERT INTO `comment` VALUES ('15', '27', '2019-10-31 15:31:04', '2q32q', '26');
INSERT INTO `comment` VALUES ('17', '27', '2019-10-31 16:20:17', '213', '26');
INSERT INTO `comment` VALUES ('18', '27', '2019-10-31 16:20:24', '123213', '24');
INSERT INTO `comment` VALUES ('19', '24', '2019-10-31 16:22:16', '111', '35');
INSERT INTO `comment` VALUES ('20', '24', '2019-10-31 16:22:57', '32131', '34');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `header` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `descri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('24', 'admin', '60cc650af1dbfa871755e44b5aa670b392ea4c7c21e092823b5ab2f892ece7f5', '保密', 'header-1572352023587.png', '123456');
INSERT INTO `user` VALUES ('25', 'admin2', '60cc650af1dbfa871755e44b5aa670b392ea4c7c21e092823b5ab2f892ece7f5', '男', 'header-1572352082884.png', '123456');
INSERT INTO `user` VALUES ('26', 'wzl123', 'e2deda51eadcdcaa8046154350d02dc0f69a48b6d198df0ea4311671185a5311', '男', 'header-1572439058250.jpg', '123123');
INSERT INTO `user` VALUES ('27', 'admin3', 'e6be0a97979f0859e7c0229cb3dff118b5849fefac925c06b81197e45af2814b', '保密', 'header-1572505549731.png', '111111');
