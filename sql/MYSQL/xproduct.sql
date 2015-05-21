/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : xproduct

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2015-04-29 12:55:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_log_login`
-- ----------------------------
DROP TABLE IF EXISTS `t_log_login`;
CREATE TABLE `t_log_login` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LOGIN_NAME` varchar(32) DEFAULT NULL,
  `OPERATOR_NAME` varchar(32) DEFAULT NULL,
  `OPERATOR_ID` bigint(20) DEFAULT NULL,
  `TYPE` int(2) DEFAULT NULL,
  `RESULT` int(2) DEFAULT NULL,
  `DESCRIPTION` text,
  `LOGIN_IP` varchar(32) DEFAULT NULL,
  `TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2235 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_log_login
-- ----------------------------

-- ----------------------------
-- Table structure for `t_log_operate`
-- ----------------------------
DROP TABLE IF EXISTS `t_log_operate`;
CREATE TABLE `t_log_operate` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LOGIN_NAME` varchar(32) DEFAULT NULL,
  `OPERATOR_NAME` varchar(32) DEFAULT NULL,
  `OPERATOR_ID` bigint(20) DEFAULT NULL,
  `OPERATE_TYPE` varchar(50) DEFAULT NULL,
  `OPERATE_RESULT` int(2) DEFAULT NULL,
  `OPERATE_OBJECT` varchar(32) DEFAULT NULL,
  `OPERATE_VALUE` text,
  `OPERATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3226 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_log_operate
-- ----------------------------

-- ----------------------------
-- Table structure for `t_operator`
-- ----------------------------
DROP TABLE IF EXISTS `t_operator`;
CREATE TABLE `t_operator` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `GENDER` int(11) DEFAULT NULL COMMENT '性别：1-男性；0-女性',
  `LOGIN_NAME` varchar(32) DEFAULT NULL,
  `PASSWORD` varchar(32) DEFAULT NULL,
  `REAL_NAME` varchar(32) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  `MOBILE` varchar(32) DEFAULT NULL,
  `FAX` varchar(32) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `MSN` varchar(32) DEFAULT NULL,
  `QQ` varchar(32) DEFAULT NULL,
  `ERROR_TIMES` int(2) DEFAULT '0' COMMENT '密码错误此时',
  `UPDATE_TIME` datetime DEFAULT NULL,
  `LOGIN_IP` varchar(15) DEFAULT NULL,
  `LOGIN_TIME` datetime DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `IS_PLATOPERATOR` int(11) DEFAULT NULL COMMENT '1:平台账号；2-企业账号',
  `STATUS` int(2) DEFAULT NULL COMMENT '状态：1-可用；0-不可用',
  `CP_CODE` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_operator
-- ----------------------------
INSERT INTO `t_operator` VALUES ('1', '1', 'admin', 'E10ADC3949BA59ABBE56E057F20F883E', '陈辰龙', '', '18282866249', '', 'chenwei.liu@163.com', null, '273244373', '0', '2015-04-26 13:12:16', '127.0.0.1', '2015-04-26 13:12:16', '2015-03-17 15:06:29', '1', '1', null);

-- ----------------------------
-- Table structure for `t_operator_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_operator_role`;
CREATE TABLE `t_operator_role` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OPERATOR_ID` bigint(20) DEFAULT NULL,
  `ROLE_IDS` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_operator_role
-- ----------------------------
INSERT INTO `t_operator_role` VALUES ('3', '1', '4');

-- ----------------------------
-- Table structure for `t_sysconfig`
-- ----------------------------
DROP TABLE IF EXISTS `t_sysconfig`;
CREATE TABLE `t_sysconfig` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PARAM_NAME` varchar(50) DEFAULT NULL COMMENT '名称',
  `PARAM_CODE` varchar(50) DEFAULT NULL COMMENT 'key',
  `PARAM_VALUE` varchar(255) DEFAULT NULL COMMENT 'value',
  `DESCRIPTION` text COMMENT '描述',
  `CREATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sysconfig
-- ----------------------------
INSERT INTO `t_sysconfig` VALUES ('1', 'md5密钥1', 'md5Key', 'check_null', 'md5密钥', '2015-03-18 13:54:25');

-- ----------------------------
-- Table structure for `t_sysmenu`
-- ----------------------------
DROP TABLE IF EXISTS `t_sysmenu`;
CREATE TABLE `t_sysmenu` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(64) DEFAULT NULL COMMENT '菜单代码',
  `NAME` varchar(128) DEFAULT NULL,
  `NAVIGATE_URL` varchar(256) DEFAULT NULL,
  `ICON` varchar(256) DEFAULT NULL,
  `PARENT_ID` bigint(20) DEFAULT NULL,
  `LEVEL` int(11) DEFAULT NULL COMMENT '菜单级别：1-一级菜单；2-二级菜单',
  `SEQUENCE` int(11) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `STATUS` int(2) DEFAULT NULL COMMENT '状态：1-启用；0-停用',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sysmenu
-- ----------------------------
INSERT INTO `t_sysmenu` VALUES ('16', null, '系统管理', null, null, null, '1', '10', '2015-03-18 16:41:28', '1');
INSERT INTO `t_sysmenu` VALUES ('17', 'TOperator', '操作员管理', 'TOperator/list.do', null, '16', '2', '20', '2015-03-18 16:42:33', '1');
INSERT INTO `t_sysmenu` VALUES ('18', 'TSysrole', '角色管理', 'TSysrole/list.do', null, '16', '2', '30', '2015-03-18 16:43:24', '1');
INSERT INTO `t_sysmenu` VALUES ('19', 'TSyspriv', '权限管理', 'TSyspriv/list.do', null, '16', '2', '40', '2015-03-18 16:44:06', '1');
INSERT INTO `t_sysmenu` VALUES ('20', 'TSysmenu', '菜单管理', 'TSysmenu/list.do', null, '16', '2', '50', '2015-03-18 16:44:37', '1');
INSERT INTO `t_sysmenu` VALUES ('21', 'TLogLogin', '登录日志', 'TLogLogin/list.do', null, '16', '2', '60', '2015-03-18 16:45:15', '1');
INSERT INTO `t_sysmenu` VALUES ('22', 'TLogOperate', '操作日志', 'TLogOperate/list.do', null, '16', '2', '70', '2015-03-18 16:45:58', '1');
INSERT INTO `t_sysmenu` VALUES ('23', 'TSysconfig', '系统配置', 'TSysconfig/list.do', null, '16', '2', '80', '2015-03-18 16:46:30', '1');

-- ----------------------------
-- Table structure for `t_syspriv`
-- ----------------------------
DROP TABLE IF EXISTS `t_syspriv`;
CREATE TABLE `t_syspriv` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(64) DEFAULT NULL COMMENT '权限代码',
  `NAME` varchar(128) DEFAULT NULL,
  `ICON_CLS` varchar(64) DEFAULT NULL,
  `METHOD` varchar(64) DEFAULT NULL,
  `MENU_ID` bigint(20) DEFAULT NULL,
  `SEQUENCE` int(11) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `STATUS` int(2) DEFAULT NULL COMMENT '状态：1-启用；0-停用',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_syspriv
-- ----------------------------
INSERT INTO `t_syspriv` VALUES ('59', 'view', '查看', 'icon-view-new', 'view()', '17', '10', '2015-03-18 16:47:37', '1');
INSERT INTO `t_syspriv` VALUES ('60', 'add', '新增', 'icon-add-new', 'add()', '17', '20', '2015-03-18 16:49:05', '1');
INSERT INTO `t_syspriv` VALUES ('61', 'modify', '修改', 'icon-edit-new', 'modify()', '17', '30', '2015-03-18 16:50:36', '1');
INSERT INTO `t_syspriv` VALUES ('62', 'remove', '删除', 'icon-remove-new', 'remove()', '17', '40', '2015-03-18 16:51:03', '1');
INSERT INTO `t_syspriv` VALUES ('63', 'on', '启用', 'icon-on-new', 'on()', '17', '50', '2015-03-18 16:51:51', '1');
INSERT INTO `t_syspriv` VALUES ('64', 'off', '停用', 'icon-off-new', 'off()', '17', '60', '2015-03-18 16:52:18', '1');
INSERT INTO `t_syspriv` VALUES ('65', 'resetPassword', '密码重置', 'icon-edit-new', 'resetPassword()', '17', '70', '2015-03-18 16:53:49', '1');
INSERT INTO `t_syspriv` VALUES ('66', 'view', '查看', 'icon-view-new', 'view()', '18', '10', '2015-03-18 16:54:16', '1');
INSERT INTO `t_syspriv` VALUES ('67', 'add', '新增', 'icon-add-new', 'add()', '18', '20', '2015-03-18 16:54:33', '1');
INSERT INTO `t_syspriv` VALUES ('68', 'modify', '修改', 'icon-edit-new', 'modify()', '18', '30', '2015-03-18 16:55:07', '1');
INSERT INTO `t_syspriv` VALUES ('69', 'remove', '删除', 'icon-remove-new', 'remove()', '18', '40', '2015-03-18 16:55:31', '1');
INSERT INTO `t_syspriv` VALUES ('70', 'on', '启用', 'icon-on-new', 'on()', '18', '50', '2015-03-18 16:55:57', '1');
INSERT INTO `t_syspriv` VALUES ('71', 'off', '停用', 'icon-off-new', 'off()', '18', '60', '2015-03-18 16:56:30', '1');
INSERT INTO `t_syspriv` VALUES ('72', 'view', '查看', 'icon-view-new', 'view()', '19', '10', '2015-03-18 16:56:52', '1');
INSERT INTO `t_syspriv` VALUES ('73', 'add', '新增', 'icon-add-new', 'add()', '19', '20', '2015-03-18 16:57:08', '1');
INSERT INTO `t_syspriv` VALUES ('74', 'modify', '修改', 'icon-edit-new', 'modify()', '19', '30', '2015-03-18 16:57:26', '1');
INSERT INTO `t_syspriv` VALUES ('75', 'remove', '删除', 'icon-remove-new', 'remove()', '19', '40', '2015-03-18 16:57:39', '1');
INSERT INTO `t_syspriv` VALUES ('76', 'on', '启用', 'icon-on-new', 'on()', '19', '50', '2015-03-18 16:58:03', '1');
INSERT INTO `t_syspriv` VALUES ('77', 'off', '停用', 'icon-off-new', 'off()', '19', '60', '2015-03-18 16:58:24', '1');
INSERT INTO `t_syspriv` VALUES ('78', 'view', '查看', 'icon-view-new', 'view()', '20', '10', '2015-03-18 16:58:48', '1');
INSERT INTO `t_syspriv` VALUES ('79', 'add', '新增', 'icon-add-new', 'add()', '20', '20', '2015-03-18 16:59:20', '1');
INSERT INTO `t_syspriv` VALUES ('80', 'modify', '修改', 'icon-edit-new', 'modify()', '20', '30', '2015-03-18 16:59:36', '1');
INSERT INTO `t_syspriv` VALUES ('81', 'remove', '删除', 'icon-remove-new', 'remove()', '20', '40', '2015-03-18 16:59:48', '1');
INSERT INTO `t_syspriv` VALUES ('82', 'on', '启用', 'icon-on-new', 'on', '20', '50', '2015-03-18 17:00:11', '1');
INSERT INTO `t_syspriv` VALUES ('83', 'off', '停用', 'icon-off-new', 'off()', '20', '60', '2015-03-18 17:00:24', '1');
INSERT INTO `t_syspriv` VALUES ('84', 'view', '查看', 'icon-view-new', 'view()', '21', '10', '2015-03-18 17:00:40', '1');
INSERT INTO `t_syspriv` VALUES ('85', 'remove', '删除', 'icon-remove-new', 'remove()', '21', '20', '2015-03-18 17:00:51', '1');
INSERT INTO `t_syspriv` VALUES ('86', 'view', '查看', 'icon-view-new', 'view()', '22', '10', '2015-03-18 17:01:05', '1');
INSERT INTO `t_syspriv` VALUES ('87', 'remove', '删除', 'icon-remove-new', 'remove()', '22', '20', '2015-03-18 17:01:14', '1');
INSERT INTO `t_syspriv` VALUES ('88', 'view', '查看', 'icon-view-new', 'view()', '23', '10', '2015-03-18 17:01:35', '1');
INSERT INTO `t_syspriv` VALUES ('89', 'add', '新增', 'icon-add-new', 'add()', '23', '20', '2015-03-18 17:01:53', '1');
INSERT INTO `t_syspriv` VALUES ('90', 'modify', '修改', 'icon-edit-new', 'modify()', '23', '30', '2015-03-18 17:02:20', '1');
INSERT INTO `t_syspriv` VALUES ('91', 'remove', '删除', 'icon-remove-new', 'remove()', '23', '40', '2015-03-18 17:02:31', '1');
INSERT INTO `t_syspriv` VALUES ('92', 'sort', '排序', 'icon-sort-new', 'sort()', '20', '70', '2015-03-31 16:50:08', '1');

-- ----------------------------
-- Table structure for `t_sysrole`
-- ----------------------------
DROP TABLE IF EXISTS `t_sysrole`;
CREATE TABLE `t_sysrole` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(128) DEFAULT NULL,
  `DESCRIPTION` text,
  `TYPE` int(2) DEFAULT NULL COMMENT '1:平台角色；2-企业角色',
  `CREATE_TIME` datetime DEFAULT NULL,
  `STATUS` int(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sysrole
-- ----------------------------
INSERT INTO `t_sysrole` VALUES ('4', '管理员角色', '', '1', '2015-03-17 15:01:33', '1');

-- ----------------------------
-- Table structure for `t_sysrole_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_sysrole_menu`;
CREATE TABLE `t_sysrole_menu` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` bigint(20) DEFAULT NULL,
  `MENU_IDS` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sysrole_menu
-- ----------------------------
INSERT INTO `t_sysrole_menu` VALUES ('4', '4', '16,17,18,19,20,21,22,23');

-- ----------------------------
-- Table structure for `t_sysrole_priv`
-- ----------------------------
DROP TABLE IF EXISTS `t_sysrole_priv`;
CREATE TABLE `t_sysrole_priv` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` bigint(20) DEFAULT NULL,
  `PRIV_IDS` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sysrole_priv
-- ----------------------------
INSERT INTO `t_sysrole_priv` VALUES ('4', '4', '59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,92,84,85,86,87,88,89,90,91');
