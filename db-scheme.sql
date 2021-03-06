USE [master]
GO
/****** Object:  Database [DB_9FBCC4_avbaitFinal]    Script Date: 12-Jul-18 11:00:44 ******/
CREATE DATABASE [DB_9FBCC4_avbaitFinal]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'avBait', FILENAME = N'H:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DB_9FBCC4_avbaitFinal_data.mdf' , SIZE = 10240KB , MAXSIZE = 512000KB , FILEGROWTH = 5120KB )
 LOG ON 
( NAME = N'avBait_log', FILENAME = N'H:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DB_9FBCC4_avbaitFinal_log.ldf' , SIZE = 5120KB , MAXSIZE = 2048GB , FILEGROWTH = 5120KB )
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_9FBCC4_avbaitFinal].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET  MULTI_USER 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET QUERY_STORE = OFF
GO
USE [DB_9FBCC4_avbaitFinal]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [DB_9FBCC4_avbaitFinal]
GO
/****** Object:  UserDefinedFunction [dbo].[createSlugForTable]    Script Date: 12-Jul-18 11:00:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
use master
go
alter database avBait set single_user with rollback immediate
go
drop database avBait
go

use master 
go
create database avBait 
on 
(
	name = avBait,
	filename = 'P:\DB\avBait\avBait.mdf',
	size = 10,
	filegrowth = 5
)
log on
(
	name = avBait_log,
	filename = 'P:\DB\avBait\avBait_log.ldf',
	size = 5,
	filegrowth = 5
)
go
use avBait
go

*/
--create slug for table
create function [dbo].[createSlugForTable](@slug nvarchar(max), @count int)
returns nvarchar(max)
as
	begin
		declare @res nvarchar(max);
		if	(@count < 10 and @count = 1)
			set @res = @slug + '-' + convert(nvarchar(5), @count);
		else if(@count < 10 and @count <> 1)
			begin
				set @res = SUBSTRING(@slug, 2, LEN(@slug)-2)
				set @res = concat(@slug, '-', convert(varchar(5),@count))
			end
		else
			begin
				set @res = SUBSTRING(@slug, 2, LEN(@slug)-3)
				set @res = concat(@slug, '-', convert(varchar(5),@count))
			end
		if(right(@slug,1) = '-')
			set @res = SUBSTRING(@res, 1, LEN(@res)-1)
		return @res
	end
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12-Jul-18 11:00:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [ntext] NULL,
	[ViewOrder] [int] NULL,
	[IsQuickOrder] [bit] NULL,
	[Image] [ntext] NULL,
	[ShowInHomePage] [bit] NULL,
	[Slogan] [nvarchar](max) NULL,
	[BannerText] [nvarchar](max) NULL,
	[Slug] [nvarchar](max) NULL,
	[Article] [ntext] NULL,
 CONSTRAINT [pk_category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[CategoryInfo]    Script Date: 12-Jul-18 11:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CategoryInfo]
AS
SELECT        Id, Name, ISNULL(Description, '') AS Description, ISNULL(ViewOrder, 0) AS ViewOrder, ISNULL(IsQuickOrder, 0) AS IsQuickOrder, ISNULL(Image, '') AS Image, ISNULL(ShowInHomePage, 0) AS ShowInHomePage, 
                         ISNULL(BannerText, '') AS BannerText, ISNULL(Slogan, '') AS Slogan, ISNULL(Slug, '') AS Slug, ISNULL(Article, N'') AS Article
FROM            dbo.Category
GO
/****** Object:  View [dbo].[HomeCategories]    Script Date: 12-Jul-18 11:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[HomeCategories]
as
	select [Id], [Name], isnull([Description],'') as [Description], isnull([ViewOrder],0) as [ViewOrder], 
			isnull([IsQuickOrder],0) as [IsQuickOrder], isnull([Image],'') as [Image], 
			isnull([BannerText],'') as [BannerText], isnull([Slogan],'') as [Slogan], isnull([Slug],'') as [Slug]
	from Category
	where ShowInHomePage = 1
GO
/****** Object:  Table [dbo].[Rubric]    Script Date: 12-Jul-18 11:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rubric](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [ntext] NULL,
 CONSTRAINT [pk_rubric] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RubricInCategory]    Script Date: 12-Jul-18 11:00:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RubricInCategory](
	[CategoryId] [int] NOT NULL,
	[RubricId] [int] NOT NULL,
	[ViewOrder] [int] NULL,
 CONSTRAINT [pk_rubricInCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[RubricId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[RubricsView]    Script Date: 12-Jul-18 11:00:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[RubricsView]
as	
	SELECT        dbo.RubricInCategory.CategoryId, dbo.Rubric.Id, dbo.Rubric.Name, isnull(dbo.Rubric.Description, '') AS [Description], dbo.RubricInCategory.ViewOrder
	FROM            dbo.Rubric INNER JOIN
							 dbo.RubricInCategory ON dbo.Rubric.Id = dbo.RubricInCategory.RubricId INNER JOIN
							 dbo.Category ON dbo.RubricInCategory.CategoryId = dbo.Category.Id
GO
/****** Object:  Table [dbo].[Problems]    Script Date: 12-Jul-18 11:00:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Problems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[RubricId] [int] NOT NULL,
	[ViewOrder] [int] NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [ntext] NULL,
	[Price] [money] NULL,
	[ShowInHomePage] [bit] NULL,
	[GoToPage] [bit] NULL,
	[Slug] [nvarchar](max) NULL,
 CONSTRAINT [pk_problems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProblemsView]    Script Date: 12-Jul-18 11:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[ProblemsView]
as
	SELECT        [Id], [CategoryId], [RubricId], [ViewOrder], [Name], isnull([Description],'') as [Description], isnull([Price],0.0) as [Price], 
					isnull([ShowInHomePage], 0) as [ShowInHomePage], isnull([GoToPage],1) as [GoToPage], [Slug]
	FROM          dbo.Problems
GO
/****** Object:  Table [dbo].[Client]    Script Date: 12-Jul-18 11:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](120) NOT NULL,
	[Password] [nvarchar](120) NOT NULL,
	[RoleId] [int] NOT NULL,
	[MembershipId] [int] NOT NULL,
	[IsActive] [bit] NULL,
	[Name] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[Phone] [varchar](max) NULL,
	[Avatar] [ntext] NULL,
	[RegisterDate] [date] NULL,
	[Token] [nvarchar](30) NULL,
	[TokenUpdated] [datetime] NULL,
	[IsTokenValid] [bit] NULL,
	[Slug] [nvarchar](max) NULL,
 CONSTRAINT [pk_clientId] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[UserView]    Script Date: 12-Jul-18 11:00:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[UserView]
as
	SELECT        ClientId, Email, Password, RoleId, MembershipId, IsActive, ISNULL(Name, N'') as Name, 
					ISNULL(Address, N'') as Address, ISNULL(Phone, N'') as Phone, ISNULL(Avatar, N'') as Avatar, 
					RegisterDate, ISNULL(Token, N'') as Token, CONVERT(bit, IsTokenValid) as IsTokenValid, ISNULL(Slug, N'') as Slug
	FROM            dbo.Client
GO
/****** Object:  Table [dbo].[Page]    Script Date: 12-Jul-18 11:00:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Page](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Html] [ntext] NOT NULL,
	[Css] [ntext] NULL,
	[Js] [ntext] NULL,
	[Slug] [nvarchar](max) NULL,
	[IsPublished] [bit] NULL,
	[PublishDate] [datetime] NULL,
	[Type] [varchar](100) NULL,
 CONSTRAINT [pk_page] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PageCategory]    Script Date: 12-Jul-18 11:00:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageCategory](
	[pageId] [int] NOT NULL,
	[categoryId] [int] NOT NULL,
 CONSTRAINT [pk_pageCategory] PRIMARY KEY CLUSTERED 
(
	[pageId] ASC,
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ContentView]    Script Date: 12-Jul-18 11:00:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[ContentView] 
as
	SELECT        dbo.Page.Id, ISNULL(dbo.Page.Title, N'') AS Title, ISNULL(dbo.Page.KeyWords, N'') AS KeyWords, ISNULL(dbo.Page.Description, N'') AS Description, ISNULL(dbo.Page.Name, N'') AS Name, ISNULL(dbo.Page.Html, N'') AS Html, 
							 ISNULL(dbo.Page.Css, N'') AS Css, ISNULL(dbo.Page.Js, N'') AS Js, ISNULL(dbo.Page.Slug, N'') AS Slug, dbo.Page.IsPublished, dbo.Page.PublishDate, dbo.Page.Type, dbo.PageCategory.categoryId as CategoryId
	FROM            dbo.Page INNER JOIN
							 dbo.PageCategory ON dbo.Page.Id = dbo.PageCategory.pageId
GO
/****** Object:  Table [dbo].[Membership]    Script Date: 12-Jul-18 11:00:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Membership](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Price] [money] NOT NULL,
 CONSTRAINT [pk_membership] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 12-Jul-18 11:00:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [pk_role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Solutions]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solutions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProblemId] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Price] [money] NULL,
 CONSTRAINT [pk_solutions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[ProblemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT ((0)) FOR [IsQuickOrder]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT ((0)) FOR [ShowInHomePage]
GO
ALTER TABLE [dbo].[Client] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Client] ADD  DEFAULT (getdate()) FOR [RegisterDate]
GO
ALTER TABLE [dbo].[Client] ADD  DEFAULT ((0)) FOR [IsTokenValid]
GO
ALTER TABLE [dbo].[Page] ADD  DEFAULT ((0)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[Problems] ADD  DEFAULT ((0)) FOR [ShowInHomePage]
GO
ALTER TABLE [dbo].[Problems] ADD  DEFAULT ((1)) FOR [GoToPage]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [fk_client_membership] FOREIGN KEY([MembershipId])
REFERENCES [dbo].[Membership] ([Id])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [fk_client_membership]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [fk_client_role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [fk_client_role]
GO
ALTER TABLE [dbo].[PageCategory]  WITH CHECK ADD  CONSTRAINT [fk_pageCategory_category] FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[PageCategory] CHECK CONSTRAINT [fk_pageCategory_category]
GO
ALTER TABLE [dbo].[PageCategory]  WITH CHECK ADD  CONSTRAINT [fk_pageCategory_page] FOREIGN KEY([pageId])
REFERENCES [dbo].[Page] ([Id])
GO
ALTER TABLE [dbo].[PageCategory] CHECK CONSTRAINT [fk_pageCategory_page]
GO
ALTER TABLE [dbo].[Problems]  WITH CHECK ADD  CONSTRAINT [fk_problem_rubricInCategory] FOREIGN KEY([CategoryId], [RubricId])
REFERENCES [dbo].[RubricInCategory] ([CategoryId], [RubricId])
GO
ALTER TABLE [dbo].[Problems] CHECK CONSTRAINT [fk_problem_rubricInCategory]
GO
ALTER TABLE [dbo].[RubricInCategory]  WITH CHECK ADD  CONSTRAINT [fk_rubrucInCategory_category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[RubricInCategory] CHECK CONSTRAINT [fk_rubrucInCategory_category]
GO
ALTER TABLE [dbo].[RubricInCategory]  WITH CHECK ADD  CONSTRAINT [fk_rubrucInCategory_rubric] FOREIGN KEY([RubricId])
REFERENCES [dbo].[Rubric] ([Id])
GO
ALTER TABLE [dbo].[RubricInCategory] CHECK CONSTRAINT [fk_rubrucInCategory_rubric]
GO
ALTER TABLE [dbo].[Solutions]  WITH CHECK ADD  CONSTRAINT [fk_solutions_problems] FOREIGN KEY([ProblemId])
REFERENCES [dbo].[Problems] ([Id])
GO
ALTER TABLE [dbo].[Solutions] CHECK CONSTRAINT [fk_solutions_problems]
GO
ALTER TABLE [dbo].[Page]  WITH CHECK ADD CHECK  (([Type]='ar' OR [Type]='bl'))
GO
/****** Object:  StoredProcedure [dbo].[addCategory]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[addCategory] 
	@name nvarchar(max), 
	@image ntext,
	@showInHomePage bit,
	@slogan nvarchar(max), 
	@bannerText nvarchar(max),
	@description ntext,
	@article ntext
as
	begin tran
		insert into [dbo].[Category]([Name],[Image],[ShowInHomePage],[Slogan],[BannerText],[Description],[Article])
			values(@name, @image, @showInHomePage, @slogan, @bannerText,@description,@article)
	if @@error <> 0
	begin 
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[addPage]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[addPage]
	@keyWords nvarchar(max),
	@description nvarchar(max),
	@name nvarchar(max),
	@html ntext,
	@css ntext,
	@js ntext,
	@isPublished bit,
	@categoryId int
as
	begin tran
		 insert into [dbo].[Page]([KeyWords], [Description], [Name], [Html], [Css], [Js], [IsPublished], [PublishDate], [Type])
			values(@keyWords,@description,@name,@html,@css,@js,@isPublished,getdate(),'ar')
		if(@categoryId <> 0)
		begin
			declare @id int = (select top 1 [Id] from [dbo].[Page] order by [Id] desc);
			exec addPageCategory @id, @categoryId
		end
	if @@error <>0 
	begin
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[addPageCategory]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[addPageCategory]
	@pageId int,
	@categoryId int
as
	begin tran
		insert into [dbo].[PageCategory](pageId, categoryId)
			values(@pageId,@categoryId)
	if @@error<>0
	begin
		rollback tran
		return
	end 
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[addProblem]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[addProblem]
	@name nvarchar(max),
	@price money, 
	@showInHomePage bit,
	@rubricId int,
	@categoryId int
as
	begin tran
		declare @viewOrder int
		if exists(select [ViewOrder] from [dbo].[Problems] where [CategoryId] = @categoryId and [RubricId] = @rubricId)
			set @viewOrder = (select max([ViewOrder]) from [dbo].[Problems] where [CategoryId] = @categoryId and [RubricId] = @rubricId) +1 
		else
			set @viewOrder = 1
		insert into [dbo].[Problems]([CategoryId], [RubricId], [ViewOrder], [Name], [Price], [ShowInHomePage])
			values(@categoryId, @rubricId, @viewOrder, @name, @price, @showInHomePage)
	if @@error <> 0
	begin 
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[addRubric]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[addRubric]
	@name nvarchar(max),
	@categoryId int
as
	begin tran
		insert into [dbo].[Rubric]([Name]) values(@name)
		declare @id int = (select Id from [dbo].[Rubric] where [Name] = @name)
		declare @viewOrder int = (select max([ViewOrder]) from [dbo].[RubricInCategory] where [CategoryId] = @categoryId) +1
		insert into [dbo].[RubricInCategory]([CategoryId],[RubricId],[ViewOrder])
			values(@categoryId, @id, @viewOrder)
	if @@error <> 0
	begin 
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[addSolution]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[addSolution]	
	@problemId int,
	@name nvarchar(max),
	@price money 
as
	begin tran
		insert into [dbo].[Solutions]([ProblemId], [Name], [Price])
			values(@problemId, @name, @price)
	if @@error <> 0
		begin
			rollback tran
			return
		end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[backupDB]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[backupDB]
as
	declare @path nvarchar(max) = 'P:\DB\avBait_' + convert(nvarchar(50),GETDATE(),105) + '_' + cast(DATEPART(HOUR, getdate()) as nvarchar(2)) + '_' + cast(DATEPART(MINUTE, getdate()) as nvarchar(2)) + '.bak';
	BACKUP DATABASE avBait
		TO DISK = @path
GO
/****** Object:  StoredProcedure [dbo].[deleteCategory]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteCategory]
	@id int
as
	begin tran
		delete from [dbo].[Problems] where [CategoryId] = @id
		delete from [dbo].[RubricInCategory] where [CategoryId] = @id
		delete from [dbo].[Category] where [Id] = @id
	if @@error <> 0
	begin 
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[deletePage]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[deletePage]
	@id int
as
	begin tran	
		delete from [dbo].[PageCategory] where [pageId] = @id
		delete from [dbo].[Page] where [Id] = @id
	if @@error <>0 
	begin
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[deleteProblem]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteProblem]
	@id int
as
	begin tran
		delete from [dbo].[Problems] where [Id] = @id
	if @@error <> 0
	begin 
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[deleteRubric]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteRubric]
	@id int
as
	begin tran
		delete from [dbo].[Problems] where [RubricId] = @id
		delete from [dbo].[RubricInCategory] where [RubricId] = @id
		delete from [dbo].[Rubric] where [Id] = @id
	if @@error <> 0
	begin 
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[deleteSolution]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteSolution]
	@id int
as
	begin tran
		delete from [dbo].[Solutions] where [Id] = @id
	if @@error <>0
		begin
			rollback tran
			return
		end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[registerUser]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[registerUser]
	@email varchar(120),
	@password nvarchar(120)
as
	begin tran
		insert into [dbo].[Client]([Email],[Password],[RoleId],[MembershipId])
			values(@email,@password,1,1)
	if @@error <>0 
	begin
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[resetTokens]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[resetTokens]
as
	begin tran
		update [dbo].[Client]
			set [IsTokenValid] = 0
			where datediff(MINUTE,[dbo].[Client].[TokenUpdated],getdate())>(30)
	if @@error <>0 
	begin
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[updateCategory]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[updateCategory]
	@id int,
	@name nvarchar(max), 
	@image ntext,
	@showInHomePage bit,
	@slogan nvarchar(max), 
	@bannerText nvarchar(max),
	@description ntext,
	@article ntext
as
	begin tran
		update [dbo].[Category]
			set [Name] = @name,
				[Image] = @image,
				[ShowInHomePage] = @showInHomePage,
				[Slogan] = @slogan,
				[BannerText] = @bannerText,
				[Description] = @description, 
				[Article] = @article
			where [Id] = @id
	if @@error <> 0
	begin 
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[updatePage]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[updatePage]
	@id int,
	@keyWords nvarchar(max),
	@description nvarchar(max),
	@name nvarchar(max),
	@title nvarchar(max),
	@html ntext,
	@css ntext,
	@js ntext,
	@isPublished bit,
	@categoryId int
as
	begin tran
		update [dbo].[Page]
			set [KeyWords] = @keyWords, 
				[Description]= @description,
				[Name] = @name,
				[Title] = @title,
				[Html] = @html, 
				[Css] = @css, 
				[Js] = @js, 
				[IsPublished] = @isPublished
			where [Id] = @id
		if(@categoryId <> 0)
		begin
			update [dbo].[PageCategory] 
				set [categoryId] = @categoryId
				where [pageId] = @id
		end
	if @@error <>0 
	begin
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[updateProblem]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[updateProblem]
	@id int,
	@name nvarchar(max),
	@price money,
	@showInHomePage bit,
	@rubricId int,
	@categoryId int 
as
	begin tran
		update [dbo].[Problems]
			set [CategoryId] = @categoryId,
				[RubricId] = @rubricId,
				[Name] = @name,
				[Price] = @price,
				[ShowInHomePage] = @showInHomePage
			where [Id] = @id
	if @@error <> 0
	begin 
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[updateRubric]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[updateRubric]
	@id int,
	@name nvarchar(max),
	@categoryId int
as
	begin tran
		update [dbo].[Rubric]
			set [Name] = @name
			where [Id] = @id
		if((select [CategoryId] from [dbo].[RubricInCategory] where [RubricId] = @id) <> @categoryId)
		begin
			update [dbo].[RubricInCategory]
				set [CategoryId] = @categoryId
				where [RubricId] = @id
		end
	if @@error <> 0
	begin 
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[updateSolution]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[updateSolution]
	@id int,
	@problemId int,
	@name nvarchar(max),
	@price money
as
	begin tran
		update [dbo].[Solutions]
			set [ProblemId] = @problemId,
				[Name] = @name,
				[Price] = @price
			where [Id] = @id
	if @@error <> 0 
	begin
		rollback tran
		return
	end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[updateToken]    Script Date: 12-Jul-18 11:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[updateToken]
	@id int,
	@token nvarchar(30)
as
	begin tran
		update [dbo].[Client]
			set [Token] = @token, [TokenUpdated] = getdate(), [IsTokenValid] = 1
			where [ClientId] = @id
	if @@error <>0 
	begin
		rollback tran
		return
	end
	commit tran
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Category"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 282
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2610
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CategoryInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CategoryInfo'
GO
USE [master]
GO
ALTER DATABASE [DB_9FBCC4_avbaitFinal] SET  READ_WRITE 
GO
