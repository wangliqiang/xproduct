USE [master]
GO
/****** Object:  Database [xproduct]    Script Date: 05/06/2015 20:36:14 ******/
CREATE DATABASE [xproduct] ON  PRIMARY 
( NAME = N'xproduct', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\xproduct.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'xproduct_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\xproduct_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [xproduct] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [xproduct].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [xproduct] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [xproduct] SET ANSI_NULLS OFF
GO
ALTER DATABASE [xproduct] SET ANSI_PADDING OFF
GO
ALTER DATABASE [xproduct] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [xproduct] SET ARITHABORT OFF
GO
ALTER DATABASE [xproduct] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [xproduct] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [xproduct] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [xproduct] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [xproduct] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [xproduct] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [xproduct] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [xproduct] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [xproduct] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [xproduct] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [xproduct] SET  DISABLE_BROKER
GO
ALTER DATABASE [xproduct] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [xproduct] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [xproduct] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [xproduct] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [xproduct] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [xproduct] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [xproduct] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [xproduct] SET  READ_WRITE
GO
ALTER DATABASE [xproduct] SET RECOVERY FULL
GO
ALTER DATABASE [xproduct] SET  MULTI_USER
GO
ALTER DATABASE [xproduct] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [xproduct] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'xproduct', N'ON'
GO
USE [xproduct]
GO
/****** Object:  Table [dbo].[t_sysrole_priv]    Script Date: 05/06/2015 20:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_sysrole_priv](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ROLE_ID] [bigint] NULL,
	[PRIV_IDS] [text] NULL,
 CONSTRAINT [PK_t_sysrole_priv] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[t_sysrole_priv] ON
INSERT [dbo].[t_sysrole_priv] ([ID], [ROLE_ID], [PRIV_IDS]) VALUES (4, 4, N'59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,92,84,85,86,87,88,89,90,91')
SET IDENTITY_INSERT [dbo].[t_sysrole_priv] OFF
/****** Object:  Table [dbo].[t_sysrole_menu]    Script Date: 05/06/2015 20:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_sysrole_menu](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ROLE_ID] [bigint] NULL,
	[MENU_IDS] [text] NULL,
 CONSTRAINT [PK_t_sysrole_menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[t_sysrole_menu] ON
INSERT [dbo].[t_sysrole_menu] ([ID], [ROLE_ID], [MENU_IDS]) VALUES (4, 4, N'16,17,18,19,20,21,22,23')
SET IDENTITY_INSERT [dbo].[t_sysrole_menu] OFF
/****** Object:  Table [dbo].[t_sysrole]    Script Date: 05/06/2015 20:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_sysrole](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[NAME] [nchar](10) NULL,
	[DESCRIPTION] [text] NULL,
	[TYPE] [int] NULL,
	[CREATE_TIME] [datetime] NULL,
	[STATUS] [int] NULL,
 CONSTRAINT [PK_t_sysrole] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[t_sysrole] ON
INSERT [dbo].[t_sysrole] ([ID], [NAME], [DESCRIPTION], [TYPE], [CREATE_TIME], [STATUS]) VALUES (4, N'管理员角色     ', N'', 1, CAST(0x0000A45E00F79E3C AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[t_sysrole] OFF
/****** Object:  Table [dbo].[t_syspriv]    Script Date: 05/06/2015 20:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[t_syspriv](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CODE] [varchar](64) NULL,
	[NAME] [varchar](128) NULL,
	[ICON_CLS] [varchar](64) NULL,
	[METHOD] [varchar](64) NULL,
	[MENU_ID] [bigint] NULL,
	[SEQUENCE] [int] NULL,
	[CREATE_TIME] [datetime] NULL,
	[STATUS] [int] NULL,
 CONSTRAINT [PK_t_syspriv] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[t_syspriv] ON
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (59, N'view', N'查看', N'icon-view-new', N'view()', 17, 10, CAST(0x0000A45F0114C00C AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (60, N'add', N'新增', N'icon-add-new', N'add()', 17, 20, CAST(0x0000A45F0115272C AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (61, N'modify', N'修改', N'icon-edit-new', N'modify()', 17, 30, CAST(0x0000A45F011591D0 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (62, N'remove', N'删除', N'icon-remove-new', N'remove()', 17, 40, CAST(0x0000A45F0115B174 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (63, N'on', N'启用', N'icon-on-new', N'on()', 17, 50, CAST(0x0000A45F0115E9B4 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (64, N'off', N'停用', N'icon-off-new', N'off()', 17, 60, CAST(0x0000A45F01160958 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (65, N'resetPassword', N'密码重置', N'icon-edit-new', N'resetPassword()', 17, 70, CAST(0x0000A45F011673FC AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (66, N'view', N'查看', N'icon-view-new', N'view()', 18, 10, CAST(0x0000A45F011693A0 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (67, N'add', N'新增', N'icon-add-new', N'add()', 18, 20, CAST(0x0000A45F0116A78C AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (68, N'modify', N'修改', N'icon-edit-new', N'modify()', 18, 30, CAST(0x0000A45F0116CF64 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (69, N'remove', N'删除', N'icon-remove-new', N'remove()', 18, 40, CAST(0x0000A45F0116EB84 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (70, N'on', N'启用', N'icon-on-new', N'on()', 18, 50, CAST(0x0000A45F011709FC AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (71, N'off', N'停用', N'icon-off-new', N'off()', 18, 60, CAST(0x0000A45F011730A8 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (72, N'view', N'查看', N'icon-view-new', N'view()', 19, 10, CAST(0x0000A45F01174A70 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (73, N'add', N'新增', N'icon-add-new', N'add()', 19, 20, CAST(0x0000A45F01175D30 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (74, N'modify', N'修改', N'icon-edit-new', N'modify()', 19, 30, CAST(0x0000A45F01177248 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (75, N'remove', N'删除', N'icon-remove-new', N'remove()', 19, 40, CAST(0x0000A45F01178184 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (76, N'on', N'启用', N'icon-on-new', N'on()', 19, 50, CAST(0x0000A45F01179DA4 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (77, N'off', N'停用', N'icon-off-new', N'off()', 19, 60, CAST(0x0000A45F0117B640 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (78, N'view', N'查看', N'icon-view-new', N'view()', 20, 10, CAST(0x0000A45F0117D260 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (79, N'add', N'新增', N'icon-add-new', N'add()', 20, 20, CAST(0x0000A45F0117F7E0 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (80, N'modify', N'修改', N'icon-edit-new', N'modify()', 20, 30, CAST(0x0000A45F01180AA0 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (81, N'remove', N'删除', N'icon-remove-new', N'remove()', 20, 40, CAST(0x0000A45F011818B0 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (82, N'on', N'启用', N'icon-on-new', N'on', 20, 50, CAST(0x0000A45F011833A4 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (83, N'off', N'停用', N'icon-off-new', N'off()', 20, 60, CAST(0x0000A45F011842E0 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (84, N'view', N'查看', N'icon-view-new', N'view()', 21, 10, CAST(0x0000A45F011855A0 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (85, N'remove', N'删除', N'icon-remove-new', N'remove()', 21, 20, CAST(0x0000A45F01186284 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (86, N'view', N'查看', N'icon-view-new', N'view()', 22, 10, CAST(0x0000A45F011872EC AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (87, N'remove', N'删除', N'icon-remove-new', N'remove()', 22, 20, CAST(0x0000A45F01187D78 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (88, N'view', N'查看', N'icon-view-new', N'view()', 23, 10, CAST(0x0000A45F01189614 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (89, N'add', N'新增', N'icon-add-new', N'add()', 23, 20, CAST(0x0000A45F0118AB2C AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (90, N'modify', N'修改', N'icon-edit-new', N'modify()', 23, 30, CAST(0x0000A45F0118CAD0 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (91, N'remove', N'删除', N'icon-remove-new', N'remove()', 23, 40, CAST(0x0000A45F0118D7B4 AS DateTime), 1)
INSERT [dbo].[t_syspriv] ([ID], [CODE], [NAME], [ICON_CLS], [METHOD], [MENU_ID], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (92, N'sort', N'排序', N'icon-sort-new', N'sort()', 20, 70, CAST(0x0000A46C01157100 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[t_syspriv] OFF
/****** Object:  Table [dbo].[t_sysmenu]    Script Date: 05/06/2015 20:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[t_sysmenu](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CODE] [varchar](64) NULL,
	[NAME] [varchar](128) NULL,
	[NAVIGATE_URL] [varchar](256) NULL,
	[ICON] [varchar](256) NULL,
	[PARENT_ID] [bigint] NULL,
	[LEVEL] [int] NULL,
	[SEQUENCE] [int] NULL,
	[CREATE_TIME] [datetime] NULL,
	[STATUS] [int] NULL,
 CONSTRAINT [PK_t_sysmenu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[t_sysmenu] ON
INSERT [dbo].[t_sysmenu] ([ID], [CODE], [NAME], [NAVIGATE_URL], [ICON], [PARENT_ID], [LEVEL], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (16, NULL, N'系统管理', NULL, NULL, NULL, 1, 10, CAST(0x0000A45F01130FA0 AS DateTime), 1)
INSERT [dbo].[t_sysmenu] ([ID], [CODE], [NAME], [NAVIGATE_URL], [ICON], [PARENT_ID], [LEVEL], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (17, N'TOperator', N'操作员管理', N'TOperator/list.do', NULL, 16, 2, 20, CAST(0x0000A45F01135BCC AS DateTime), 1)
INSERT [dbo].[t_sysmenu] ([ID], [CODE], [NAME], [NAVIGATE_URL], [ICON], [PARENT_ID], [LEVEL], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (18, N'TSysrole', N'角色管理', N'TSysrole/list.do', NULL, 16, 2, 30, CAST(0x0000A45F01139790 AS DateTime), 1)
INSERT [dbo].[t_sysmenu] ([ID], [CODE], [NAME], [NAVIGATE_URL], [ICON], [PARENT_ID], [LEVEL], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (19, N'TSyspriv', N'权限管理', N'TSyspriv/list.do', NULL, 16, 2, 40, CAST(0x0000A45F0113C8C8 AS DateTime), 1)
INSERT [dbo].[t_sysmenu] ([ID], [CODE], [NAME], [NAVIGATE_URL], [ICON], [PARENT_ID], [LEVEL], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (20, N'TSysmenu', N'菜单管理', N'TSysmenu/list.do', NULL, 16, 2, 50, CAST(0x0000A45F0113ED1C AS DateTime), 1)
INSERT [dbo].[t_sysmenu] ([ID], [CODE], [NAME], [NAVIGATE_URL], [ICON], [PARENT_ID], [LEVEL], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (21, N'TLogLogin', N'登录日志', N'TLogLogin/list.do', NULL, 16, 2, 60, CAST(0x0000A45F011419A4 AS DateTime), 1)
INSERT [dbo].[t_sysmenu] ([ID], [CODE], [NAME], [NAVIGATE_URL], [ICON], [PARENT_ID], [LEVEL], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (22, N'TLogOperate', N'操作日志', N'TLogOperate/list.do', NULL, 16, 2, 70, CAST(0x0000A45F01144C08 AS DateTime), 1)
INSERT [dbo].[t_sysmenu] ([ID], [CODE], [NAME], [NAVIGATE_URL], [ICON], [PARENT_ID], [LEVEL], [SEQUENCE], [CREATE_TIME], [STATUS]) VALUES (23, N'TSysconfig', N'系统配置', N'TSysconfig/list.do', NULL, 16, 2, 80, CAST(0x0000A45F01147188 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[t_sysmenu] OFF
/****** Object:  Table [dbo].[t_sysconfig]    Script Date: 05/06/2015 20:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[t_sysconfig](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PARAM_NAME] [varchar](50) NULL,
	[PARAM_CODE] [varchar](50) NULL,
	[PARAM_VALUE] [varchar](255) NULL,
	[DESCRIPTION] [text] NULL,
	[CREATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_t_sysconfig] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[t_sysconfig] ON
INSERT [dbo].[t_sysconfig] ([ID], [PARAM_NAME], [PARAM_CODE], [PARAM_VALUE], [DESCRIPTION], [CREATE_TIME]) VALUES (1, N'md5密钥1', N'md5Key', N'check_null', N'md5密钥', CAST(0x0000A45F00E52DEC AS DateTime))
SET IDENTITY_INSERT [dbo].[t_sysconfig] OFF
/****** Object:  Table [dbo].[t_operator_role]    Script Date: 05/06/2015 20:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_operator_role](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[OPERATOR_ID] [bigint] NULL,
	[ROLE_IDS] [text] NULL,
 CONSTRAINT [PK_t_operator_role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[t_operator_role] ON
INSERT [dbo].[t_operator_role] ([ID], [OPERATOR_ID], [ROLE_IDS]) VALUES (3, 1, N'4')
SET IDENTITY_INSERT [dbo].[t_operator_role] OFF
/****** Object:  Table [dbo].[t_operator]    Script Date: 05/06/2015 20:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[t_operator](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[GENDER] [int] NULL,
	[LOGIN_NAME] [varchar](32) NULL,
	[PASSWORD] [varchar](32) NULL,
	[REAL_NAME] [varchar](32) NULL,
	[PHONE] [varchar](32) NULL,
	[MOBILE] [varchar](32) NULL,
	[FAX] [varchar](32) NULL,
	[EMAIL] [varchar](32) NULL,
	[MSN] [varchar](32) NULL,
	[QQ] [varchar](32) NULL,
	[ERROR_TIMES] [int] NULL,
	[UPDATE_TIME] [datetime] NULL,
	[LOGIN_IP] [varchar](15) NULL,
	[LOGIN_TIME] [datetime] NULL,
	[CREATE_TIME] [datetime] NULL,
	[STATUS] [int] NULL,
	[CP_CODE] [bigint] NULL,
	[IS_PLATOPERATOR] [int] NULL,
 CONSTRAINT [PK_t_operator] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[t_operator] ON
INSERT [dbo].[t_operator] ([ID], [GENDER], [LOGIN_NAME], [PASSWORD], [REAL_NAME], [PHONE], [MOBILE], [FAX], [EMAIL], [MSN], [QQ], [ERROR_TIMES], [UPDATE_TIME], [LOGIN_IP], [LOGIN_TIME], [CREATE_TIME], [STATUS], [CP_CODE], [IS_PLATOPERATOR]) VALUES (1, 1, N'admin', N'E10ADC3949BA59ABBE56E057F20F883E', N'陈辰龙', N'', N'18282866249', N'', N'chenwei.liu@163.com', NULL, N'273244373', 0, CAST(0x0000A48D0187F99F AS DateTime), N'127.0.0.1', CAST(0x0000A48D0185A4D4 AS DateTime), CAST(0x0000A48D00F8F91C AS DateTime), 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[t_operator] OFF
/****** Object:  Table [dbo].[t_log_operate]    Script Date: 05/06/2015 20:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[t_log_operate](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[LOGIN_NAME] [varchar](32) NULL,
	[OPERATOR_NAME] [varchar](32) NULL,
	[OPERATOR_ID] [bigint] NULL,
	[OPERATE_TYPE] [varchar](50) NULL,
	[OPERATE_RESULT] [int] NULL,
	[OPERATE_OBJECT] [varchar](32) NULL,
	[OPERATE_VALUE] [text] NULL,
	[OPERATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_t_log_operate] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[t_log_operate] ON
INSERT [dbo].[t_log_operate] ([ID], [LOGIN_NAME], [OPERATOR_NAME], [OPERATOR_ID], [OPERATE_TYPE], [OPERATE_RESULT], [OPERATE_OBJECT], [OPERATE_VALUE], [OPERATE_TIME]) VALUES (1, N'admin', N'陈辰龙', 1, N'modify', 1, N'TSysrole', N'管理员角色', CAST(0x0000A48D0186562A AS DateTime))
INSERT [dbo].[t_log_operate] ([ID], [LOGIN_NAME], [OPERATOR_NAME], [OPERATOR_ID], [OPERATE_TYPE], [OPERATE_RESULT], [OPERATE_OBJECT], [OPERATE_VALUE], [OPERATE_TIME]) VALUES (2, N'admin', N'陈辰龙', 1, N'modify', 1, N'TOperator', N'admin', CAST(0x0000A48D018744A1 AS DateTime))
INSERT [dbo].[t_log_operate] ([ID], [LOGIN_NAME], [OPERATOR_NAME], [OPERATOR_ID], [OPERATE_TYPE], [OPERATE_RESULT], [OPERATE_OBJECT], [OPERATE_VALUE], [OPERATE_TIME]) VALUES (3, N'admin', N'陈辰龙', 1, N'resetPassword', 1, N'TOperator', N'1', CAST(0x0000A48D0187F9A1 AS DateTime))
SET IDENTITY_INSERT [dbo].[t_log_operate] OFF
/****** Object:  Table [dbo].[t_log_login]    Script Date: 05/06/2015 20:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[t_log_login](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[LOGIN_NAME] [varchar](32) NULL,
	[OPERATOR_NAME] [varchar](32) NULL,
	[OPERATOR_ID] [bigint] NULL,
	[TYPE] [int] NULL,
	[RESULT] [int] NULL,
	[DESCRIPTION] [text] NULL,
	[LOGIN_IP] [varchar](32) NULL,
	[TIME] [datetime] NULL,
 CONSTRAINT [PK_t_log_login] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[t_log_login] ON
INSERT [dbo].[t_log_login] ([ID], [LOGIN_NAME], [OPERATOR_NAME], [OPERATOR_ID], [TYPE], [RESULT], [DESCRIPTION], [LOGIN_IP], [TIME]) VALUES (1, N'admin', N'陈辰龙', 1, 1, 0, N'密码错误1次,错误5次将被锁定！', N'127.0.0.1', CAST(0x0000A48D01782759 AS DateTime))
INSERT [dbo].[t_log_login] ([ID], [LOGIN_NAME], [OPERATOR_NAME], [OPERATOR_ID], [TYPE], [RESULT], [DESCRIPTION], [LOGIN_IP], [TIME]) VALUES (2, N'admin', N'陈辰龙', 1, 1, 1, N'登陆成功', N'127.0.0.1', CAST(0x0000A48D0178CDF3 AS DateTime))
INSERT [dbo].[t_log_login] ([ID], [LOGIN_NAME], [OPERATOR_NAME], [OPERATOR_ID], [TYPE], [RESULT], [DESCRIPTION], [LOGIN_IP], [TIME]) VALUES (3, N'admin', N'陈辰龙', 1, 1, 1, N'登陆成功', N'127.0.0.1', CAST(0x0000A48D0178DD34 AS DateTime))
INSERT [dbo].[t_log_login] ([ID], [LOGIN_NAME], [OPERATOR_NAME], [OPERATOR_ID], [TYPE], [RESULT], [DESCRIPTION], [LOGIN_IP], [TIME]) VALUES (4, N'admin', N'陈辰龙', 1, 1, 1, N'登陆成功', N'127.0.0.1', CAST(0x0000A48D0183E521 AS DateTime))
INSERT [dbo].[t_log_login] ([ID], [LOGIN_NAME], [OPERATOR_NAME], [OPERATOR_ID], [TYPE], [RESULT], [DESCRIPTION], [LOGIN_IP], [TIME]) VALUES (5, N'admin', N'陈辰龙', 1, 1, 1, N'登陆成功', N'127.0.0.1', CAST(0x0000A48D01846773 AS DateTime))
INSERT [dbo].[t_log_login] ([ID], [LOGIN_NAME], [OPERATOR_NAME], [OPERATOR_ID], [TYPE], [RESULT], [DESCRIPTION], [LOGIN_IP], [TIME]) VALUES (6, N'admin', N'陈辰龙', 1, 1, 1, N'登陆成功', N'127.0.0.1', CAST(0x0000A48D0184A220 AS DateTime))
INSERT [dbo].[t_log_login] ([ID], [LOGIN_NAME], [OPERATOR_NAME], [OPERATOR_ID], [TYPE], [RESULT], [DESCRIPTION], [LOGIN_IP], [TIME]) VALUES (7, N'admin', N'陈辰龙', 1, 1, 1, N'登陆成功', N'127.0.0.1', CAST(0x0000A48D0185A572 AS DateTime))
SET IDENTITY_INSERT [dbo].[t_log_login] OFF
