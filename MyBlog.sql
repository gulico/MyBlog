USE [MyBlog]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 2018/4/13 11:34:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminID] [int] NOT NULL,
	[AdminName] [varchar](30) NOT NULL,
	[AdminPassword] [varchar](30) NOT NULL,
	[AdminGradeID] [int] NOT NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdminGrade]    Script Date: 2018/4/13 11:34:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminGrade](
	[AdminGradeID] [int] NOT NULL,
	[AdminGradeName] [nvarchar](20) NULL,
 CONSTRAINT [PK_AdminGrade] PRIMARY KEY CLUSTERED 
(
	[AdminGradeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Article]    Script Date: 2018/4/13 11:34:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[ArticleID] [int] NOT NULL,
	[ArticleCategoryID] [int] NOT NULL,
	[ArticleCategoryName] [nchar](10) NOT NULL,
	[ArticleTitle] [nvarchar](30) NOT NULL,
	[ArticleAuthor] [nvarchar](30) NOT NULL,
	[PicturePath] [nvarchar](100) NULL,
	[ArticleContent] [nvarchar](max) NOT NULL,
	[CreatorID] [int] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[IsPass] [bit] NOT NULL,
	[AuditorID] [int] NOT NULL,
	[AuditDateTime] [datetime] NOT NULL,
	[ShowPageCount] [int] NOT NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[ArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 2018/4/13 11:34:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [nchar](10) NOT NULL,
	[CategorySort] [int] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 2018/4/13 11:34:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserID] [int] NOT NULL,
	[UserName] [varchar](30) NOT NULL,
	[UserPassword] [varchar](30) NOT NULL,
	[UserGender] [nvarchar](2) NOT NULL,
	[UserEmail] [varchar](30) NOT NULL,
	[CreatedDateTime] [datetime] NULL,
	[IsPass] [bit] NULL,
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserLogin]    Script Date: 2018/4/13 11:34:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserLogin](
	[UserLoginID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[LoginDateTime] [smalldatetime] NULL,
	[LoginIP] [char](20) NULL,
 CONSTRAINT [PK_UserLogin] PRIMARY KEY CLUSTERED 
(
	[UserLoginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRebiew]    Script Date: 2018/4/13 11:34:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserRebiew](
	[UserRebiewID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[UserRebiewContent] [nvarchar](200) NOT NULL,
	[ArticleID] [int] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[LoginIP] [char](20) NOT NULL,
 CONSTRAINT [PK_UserRebiew] PRIMARY KEY CLUSTERED 
(
	[UserRebiewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Admin]  WITH CHECK ADD  CONSTRAINT [FK_Admin_AdminGrade] FOREIGN KEY([AdminGradeID])
REFERENCES [dbo].[AdminGrade] ([AdminGradeID])
GO
ALTER TABLE [dbo].[Admin] CHECK CONSTRAINT [FK_Admin_AdminGrade]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_Category] FOREIGN KEY([ArticleCategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_Category]
GO
ALTER TABLE [dbo].[UserInfo]  WITH CHECK ADD  CONSTRAINT [FK_UserInfo_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[UserInfo] CHECK CONSTRAINT [FK_UserInfo_UserInfo]
GO
ALTER TABLE [dbo].[UserLogin]  WITH CHECK ADD  CONSTRAINT [FK_UserLogin_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[UserLogin] CHECK CONSTRAINT [FK_UserLogin_UserInfo]
GO
ALTER TABLE [dbo].[UserRebiew]  WITH CHECK ADD  CONSTRAINT [FK_UserRebiew_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[UserRebiew] CHECK CONSTRAINT [FK_UserRebiew_UserInfo]
GO
ALTER TABLE [dbo].[UserRebiew]  WITH CHECK ADD  CONSTRAINT [FK_UserRebiew_UserRebiew] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Article] ([ArticleID])
GO
ALTER TABLE [dbo].[UserRebiew] CHECK CONSTRAINT [FK_UserRebiew_UserRebiew]
GO
