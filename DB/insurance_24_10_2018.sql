
CREATE function [dbo].[GetCityName](@OrderId int)
returns nvarchar(max)
as
	begin	
		declare @res nvarchar(max)
		if ((select [IsSameAddress] from [dbo].[Orders] where [Id] = @OrderId) = 0)
			set @res = (select [Name] from [dbo].[Cities] where [Id] = (select [City] from [dbo].[Orders] where [Id] = @OrderId))
		else
			set @res = (select [Name] from [dbo].[Cities] where [Id] = (select [City] from [dbo].[Clients] where [Id] = (select [ClientId] from [dbo].[Orders] where [Id] = @OrderId)))
		return @res
	end
GO
/****** Object:  UserDefinedFunction [dbo].[GetEntrace]    Script Date: 25-Oct-2018 02:04:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetEntrace](@OrderId int)
returns int
as
	begin
		declare @res int
		if ((select [IsSameAddress] from [dbo].[Orders] where [Id] = @OrderId) = 0)
			set @res = (select [Entrance] from [dbo].[Orders] where [Id] = @OrderId)
		else
			set @res = (select [Entrance] from [dbo].[Clients] where [Id] = (select [ClientId] from [dbo].[Orders] where [Id] = @OrderId))
		return @res
	end
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrderAddress]    Script Date: 25-Oct-2018 02:04:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetOrderAddress](@OrderId int)
returns nvarchar(max)
as
	begin
		declare @res nvarchar(max)
		--if((select [IsSameAddress] from [dbo].[Orders] where [Id] = @OrderId) = 0)
			set @res = concat(dbo.GetOrderStreet(@OrderId),' ',dbo.GetOrderStreetNumber(@OrderId), ', ', dbo.GetCityName(@OrderId))
		--	begin
		--		set @res = (select Street + ' ' + CONVERT(nvarchar(255), StreetNumber) + ', ' + CityName from ClientDetails where [Id] = (select [ClientId] from [dbo].[Orders] where [Id] = @OrderId))
		--	end
		--else
		--	set @res = (select [Street] + ' ' + CONVERT(nvarchar(255), StreetNumber) + ', ' + dbo.GetCityName([City]) from [dbo].[Orders] where [Id] = @OrderId)
		return @res
	end
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrderAppartment]    Script Date: 25-Oct-2018 02:04:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[GetOrderAppartment](@OrderId int)
returns int
as
	begin
		return (
			isnull((select [Appartment] from [dbo].[Orders] where [Id] = @OrderId), (select [Appartment] from [dbo].[Clients] where [Id] = (select [ClientId] from [dbo].[Orders] where [Id] = @OrderId)))
		)
	end
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrderCategoryId]    Script Date: 25-Oct-2018 02:04:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetOrderCategoryId](@OrderId int)
returns int
as	
	begin
		declare @res int
		if((select [Status] from [dbo].[Orders] where [Id] = @OrderId) <> 40)
			set @res = (select [CategoryId] from [dbo].[Problems] where [Id] = (select [ProblemId] from [dbo].[Orders] where [Id] = @OrderId))
		else
			set @res = (select [CategoryId] from [dbo].[ContinuousOrders] where [OrderId] = @OrderId)
		return @res 
	end
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrderCategoryName]    Script Date: 25-Oct-2018 02:04:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetOrderCategoryName](@OrderId int)
returns nvarchar(max)
as	
	begin
		declare @res nvarchar(max)
		if((select [Status] from [dbo].[Orders] where [Id] = @OrderId) <> 40)
			set @res = (
				select [Name] from [dbo].[Categories] where [Id] = (
					select [CategoryId] from [dbo].[Problems] where [Id] = (
						select [ProblemId] from [dbo].[Orders] where [Id] = @OrderId 
					)
				)
			)
		else
			set @res = (
				select [Name] from [dbo].[Categories] where [Id] = (
					select [CategoryId] from [dbo].[ContinuousOrders] where [OrderId] = @OrderId
				) 
			)
		return @res 
	end
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrderCityCode]    Script Date: 25-Oct-2018 02:04:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[GetOrderCityCode](@OrderId int)
returns int 
as
	begin
		return (
			isnull((select [City] from [dbo].[Orders] where [Id] = @OrderId), (select [City] from [dbo].[Clients] where [Id] = (select [ClientId] from [dbo].[Orders] where [Id] = @OrderId)))
		)
	end
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrderStreet]    Script Date: 25-Oct-2018 02:04:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[GetOrderStreet](@OrderId int)
returns nvarchar(max)
as
	begin
		declare @res nvarchar(max)
		if((select [Street] from [dbo].[Orders] where [Id] = @OrderId) is null)
			begin
				set @res = (select Street from ClientDetails where [Id] = (select [ClientId] from [dbo].[Orders] where [Id] = @OrderId))
			end
		else
			set @res = (select [Street] from [dbo].[Orders] where [Id] = @OrderId)
		return @res
	end
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrderStreetNumber]    Script Date: 25-Oct-2018 02:04:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[GetOrderStreetNumber](@OrderId int)
returns int
as
	begin
		return (
			isnull((select [StreetNumber] from [dbo].[Orders] where [Id] = @OrderId), (select [StreetNumber] from [dbo].[Clients] where [Id] = (select [ClientId] from [dbo].[Orders] where [Id] = @OrderId)))
		)
	end
GO
/****** Object:  UserDefinedFunction [dbo].[GetUserHashPassword]    Script Date: 25-Oct-2018 02:04:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetUserHashPassword](@UserName varchar(max)) 
returns nvarchar(max)
as
	begin
		return(select [Password] from [Users] where [UserName] = @UserName and [IsActive] = 1)
	end	
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 25-Oct-2018 02:04:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(4000,1) NOT NULL,
	[ClaimNumber] [nvarchar](max) NULL,
	[PolicyNumber] [nvarchar](max) NULL,
	[ClientId] [char](9) NULL,
	[Type] [int] NULL,
	[Status] [int] NULL,
	[IsSameAddress] [bit] NULL,
	[City] [int] NULL,
	[Street] [nvarchar](max) NULL,
	[StreetNumber] [int] NULL,
	[Appartment] [int] NULL,
	[Entrance] [varchar](10) NULL,
	[Deductible] [float] NULL,
	[ProblemId] [int] NULL,
	[ETADate] [datetime] NULL,
	[ETATime] [int] NULL,
	[BusinessId] [int] NULL,
	[HandymanId] [int] NULL,
	[ArrivalDateTime] [datetime] NULL,
	[Note] [ntext] NULL,
	[Price] [float] NULL,
	[DateCreated] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[PTest] [bit] NULL,
	[BTest] [bit] NULL,
	[TTest] [bit] NULL,
	[OTest] [bit] NULL,
	[OtherTestNote] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[CheckDateAvailable]    Script Date: 25-Oct-2018 02:04:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[CheckDateAvailable](@OrderId int)
returns table
as
	return (
		SELECT HandymanId FROM dbo.Orders 
		GROUP BY ETADate, HandymanId 
		HAVING (COUNT(HandymanId) > 4) and 
			(ETADate = (select [ETADate] from [dbo].[Orders] where [Id] = @OrderId)) 
	)
GO
/****** Object:  Table [dbo].[SystemMessages]    Script Date: 25-Oct-2018 02:04:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemMessages](
	[Code] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Note] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSystemMessage]    Script Date: 25-Oct-2018 02:04:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[GetSystemMessage](@Code int)
returns table
as
	return (select * from SystemMessages where [Code] = @Code)
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 25-Oct-2018 02:04:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AreaId] [int] NULL,
	[Name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Handymen]    Script Date: 25-Oct-2018 02:04:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Handymen](
	[Id] [int] IDENTITY(900,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Color] [varchar](max) NULL,
	[BackgroundColor] [nvarchar](20) NULL,
	[Email] [varchar](max) NULL,
	[Password] [varchar](max) NULL,
	[IsEmployee] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HandymanInBusieness]    Script Date: 25-Oct-2018 02:04:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HandymanInBusieness](
	[BusinessId] [int] NOT NULL,
	[HandymanId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BusinessId] ASC,
	[HandymanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HandymenInArea]    Script Date: 25-Oct-2018 02:04:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HandymenInArea](
	[HandymanId] [int] NOT NULL,
	[AreaId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HandymanId] ASC,
	[AreaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetHandymen]    Script Date: 25-Oct-2018 02:04:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[GetHandymen](@OrderId int)
returns table
as
	return(
		select [Id], [Name], [IsEmployee] from [dbo].[Handymen] where [Id] in ( --filter by company
			select [HandymanId] from [dbo].[HandymanInBusieness] where [BusinessId] = (select [BusinessId] from [dbo].[Orders] where [Id] = @OrderId)
		)
		and [Id] in( --filter by area
			select [HandymanId] from [dbo].[HandymenInArea] where [AreaId] = (select [AreaId] from [dbo].[Cities] where [Id] = dbo.GetOrderCityCode(@OrderId)) 
		)
		and [Id] not in ( --filter by date and number of events per day
			select * from dbo.CheckDateAvailable(@OrderId)
		) 
		and [Id] not in ( --filter by time
			select [HandymanId] from [dbo].[Orders] where [ETATime] = (select [ETATime] from [dbo].[Orders] where [Id] = @OrderId)
		)
	)
GO
/****** Object:  Table [dbo].[OrderTypes]    Script Date: 25-Oct-2018 02:04:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 25-Oct-2018 02:04:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[Id] [int] IDENTITY(10,10) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Note] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 25-Oct-2018 02:04:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Problems]    Script Date: 25-Oct-2018 02:04:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Problems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[Name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoursOfWork]    Script Date: 25-Oct-2018 02:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoursOfWork](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [nvarchar](max) NULL,
	[EndTime] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Business]    Script Date: 25-Oct-2018 02:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Business](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 25-Oct-2018 02:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[Id] [char](9) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[City] [int] NULL,
	[Street] [nvarchar](max) NULL,
	[StreetNumber] [int] NULL,
	[Appartment] [int] NULL,
	[Entrance] [varchar](10) NULL,
	[Phone] [nvarchar](max) NULL,
	[CellPhone] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrdersView]    Script Date: 25-Oct-2018 02:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[OrdersView]
as
	SELECT        dbo.Orders.Id AS Id, dbo.Orders.ClaimNumber, dbo.Orders.PolicyNumber, dbo.Orders.Type AS [Type], dbo.OrderTypes.Name AS TypeName, dbo.Orders.Status AS 'Status', dbo.OrderStatus.Name AS StatusName, dbo.Clients.Name AS ClientName, 
                         dbo.Orders.Deductible, dbo.GetOrderCityCode(dbo.Orders.Id) AS CityCode, dbo.GetOrderAddress(dbo.Orders.Id) AS 'Address', dbo.GetOrderAppartment(dbo.Orders.Id) AS 'Appartment', dbo.Clients.Phone, dbo.Clients.CellPhone, 
                         dbo.Orders.ProblemId, dbo.Problems.Name AS ProblemName, dbo.GetOrderCategoryId(dbo.Orders.Id) AS CategoryId, dbo.GetOrderCategoryName(dbo.Orders.Id) AS CategoryName, dbo.Orders.ETADate, dbo.Orders.ETATime, 
                         dbo.HoursOfWork.EndTime + ' - ' + dbo.HoursOfWork.StartTime AS 'ETA', dbo.Orders.HandymanId, dbo.Handymen.Name AS HandymanName, dbo.Orders.ArrivalDateTime, dbo.Orders.Note, dbo.Orders.Price, 
                         dbo.Orders.DateCreated, dbo.Clients.Id AS ClientId, dbo.Business.Id AS BusinessId, dbo.Business.Name AS BusinessName, dbo.GetOrderStreetNumber(dbo.Orders.Id) as 'StreetNumber', dbo.GetEntrace(dbo.Orders.Id) as 'Entrance', 
						 dbo.GetOrderStreet(dbo.Orders.Id) as 'Street', dbo.Orders.IsSameAddress, dbo.GetCityName(dbo.Orders.Id) as 'CityName', dbo.Orders.OtherTestNote, dbo.Orders.PTest, dbo.Orders.BTest, dbo.Orders.TTest,dbo.Orders.OTest
	FROM            dbo.Orders INNER JOIN
                         dbo.OrderStatus ON dbo.Orders.Status = dbo.OrderStatus.Id INNER JOIN
                         dbo.OrderTypes ON dbo.Orders.Type = dbo.OrderTypes.Id INNER JOIN
                         dbo.Problems ON dbo.Orders.ProblemId = dbo.Problems.Id INNER JOIN
                         dbo.Handymen ON dbo.Orders.HandymanId = dbo.Handymen.Id INNER JOIN
                         dbo.HoursOfWork ON dbo.Orders.ETATime = dbo.HoursOfWork.Id INNER JOIN
                         dbo.Categories ON dbo.Problems.CategoryId = dbo.Categories.Id INNER JOIN
                         dbo.Clients ON dbo.Orders.ClientId = dbo.Clients.Id INNER JOIN
                         dbo.Cities ON dbo.Clients.City = dbo.Cities.Id INNER JOIN
                         dbo.Business ON dbo.Orders.BusinessId = dbo.Business.Id
GO
/****** Object:  Table [dbo].[QuestionsForCategory]    Script Date: 25-Oct-2018 02:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionsForCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[Title] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContinuousOrders]    Script Date: 25-Oct-2018 02:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContinuousOrders](
	[OrderId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[HandymanId] [int] NULL,
	[ETADate] [date] NULL,
	[ETATime] [int] NULL,
	[ArrivalDateTime] [datetime] NULL,
	[Note] [ntext] NULL,
	[Price] [float] NULL,
	[IsClose] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[CategoryId] ASC,
	[DateCreated] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[QuestionsForOrder]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[QuestionsForOrder]
as
	SELECT        dbo.QuestionsForCategory.Id, dbo.QuestionsForCategory.CategoryId, dbo.QuestionsForCategory.Title
	FROM            dbo.Orders INNER JOIN
							 dbo.ContinuousOrders ON dbo.Orders.Id = dbo.ContinuousOrders.OrderId INNER JOIN
							 dbo.QuestionsForCategory ON dbo.ContinuousOrders.CategoryId = dbo.QuestionsForCategory.CategoryId
	WHERE        (dbo.Orders.Status = 40)
GO
/****** Object:  Table [dbo].[InsuranceCompanies]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InsuranceCompanies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Logo] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(10,1) NOT NULL,
	[Email] [varchar](120) NULL,
	[Password] [varchar](max) NULL,
	[RoleId] [int] NULL,
	[InsuraceCompanyId] [int] NULL,
	[Name] [nvarchar](max) NULL,
	[Token] [varchar](max) NULL,
	[IsActive] [bit] NULL,
	[UserName] [varchar](120) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[UserDetails]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[UserDetails] 
as
	SELECT        dbo.Users.Id, dbo.Users.Email, dbo.Users.UserName, dbo.Users.RoleId, dbo.Users.InsuraceCompanyId, dbo.Users.Name, 
					dbo.Users.Token, dbo.Users.IsActive, dbo.InsuranceCompanies.Id AS InsuranceCompanyId, 
                         dbo.InsuranceCompanies.Name AS InsuranceCompanyName, dbo.InsuranceCompanies.Logo
	FROM            dbo.InsuranceCompanies INNER JOIN
                         dbo.Users ON dbo.InsuranceCompanies.Id = dbo.Users.InsuraceCompanyId
GO
/****** Object:  View [dbo].[ClientDetails]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[ClientDetails]
as
	SELECT        dbo.Clients.Id, dbo.Clients.Name, dbo.Clients.City AS CityId, dbo.Cities.Name AS CityName, dbo.Clients.Street, dbo.Clients.StreetNumber, dbo.Clients.Appartment, dbo.Clients.Entrance, dbo.Clients.Phone, 
                         dbo.Clients.CellPhone
	FROM            dbo.Cities INNER JOIN
                         dbo.Clients ON dbo.Cities.Id = dbo.Clients.City
GO
/****** Object:  View [dbo].[AllEvents]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[AllEvents]
as
	SELECT        dbo.Orders.Id, CONVERT(datetime, LEFT(CONVERT(VARCHAR, dbo.Orders.ETADate, 120), 10) + ' ' + dbo.HoursOfWork.StartTime) AS Start, CONVERT(datetime, LEFT(CONVERT(VARCHAR, dbo.Orders.ETADate, 120), 10) 
                         + ' ' + dbo.HoursOfWork.EndTime) AS [End], dbo.Problems.Name AS Title, dbo.Handymen.Color AS TextColor, dbo.Handymen.BackgroundColor, dbo.Handymen.Id AS HandymanId, dbo.Handymen.Name AS HandymanName 
	FROM            dbo.Handymen INNER JOIN
                         dbo.Orders ON dbo.Handymen.Id = dbo.Orders.HandymanId INNER JOIN
                         dbo.HoursOfWork ON dbo.Orders.ETATime = dbo.HoursOfWork.Id INNER JOIN
                         dbo.Problems ON dbo.Orders.ProblemId = dbo.Problems.Id
GO
/****** Object:  Table [dbo].[Areas]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Areas](
	[Id] [int] IDENTITY(100,100) NOT NULL,
	[Name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HandymenCategories]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HandymenCategories](
	[HandymanId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HandymanId] ASC,
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderNotes]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderNotes](
	[OrderId] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[Results] [ntext] NULL,
	[Actions] [ntext] NULL,
	[Summary] [ntext] NULL,
	[Others] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[DateCreated] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionForContinuousOrder]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionForContinuousOrder](
	[OrderId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[Answer] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 25-Oct-2018 02:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](80) NULL,
	[Note] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Areas] ON 
GO
INSERT [dbo].[Areas] ([Id], [Name]) VALUES (100, N'מרכז')
GO
INSERT [dbo].[Areas] ([Id], [Name]) VALUES (200, N'שפלה')
GO
INSERT [dbo].[Areas] ([Id], [Name]) VALUES (300, N'שרון')
GO
INSERT [dbo].[Areas] ([Id], [Name]) VALUES (400, N'חיפה')
GO
INSERT [dbo].[Areas] ([Id], [Name]) VALUES (500, N'צפון')
GO
INSERT [dbo].[Areas] ([Id], [Name]) VALUES (600, N'דרום')
GO
INSERT [dbo].[Areas] ([Id], [Name]) VALUES (700, N'ירושלים')
GO
SET IDENTITY_INSERT [dbo].[Areas] OFF
GO
SET IDENTITY_INSERT [dbo].[Business] ON 
GO
INSERT [dbo].[Business] ([Id], [Name]) VALUES (1, N'אב הבית')
GO
INSERT [dbo].[Business] ([Id], [Name]) VALUES (2, N'יצאת גדול')
GO
INSERT [dbo].[Business] ([Id], [Name]) VALUES (3, N'שרברבים באחריות')
GO
INSERT [dbo].[Business] ([Id], [Name]) VALUES (4, N'אחים כהן שיפוצים ואינסטלציה')
GO
INSERT [dbo].[Business] ([Id], [Name]) VALUES (5, N'משה משה ')
GO
INSERT [dbo].[Business] ([Id], [Name]) VALUES (6, N'אורן רדה')
GO
INSERT [dbo].[Business] ([Id], [Name]) VALUES (7, N'גולן ברקת')
GO
SET IDENTITY_INSERT [dbo].[Business] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (1, N'נזק מים')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (2, N'ריצוף')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (3, N'צבע')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (4, N'איטום')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (5, N'ביובית')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (6, N'בובקט')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (7, N'חשמל')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (8, N'נגר')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (9, N'גבס')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (10, N'עליה קפילרית')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (11, N'פרקטים')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (12, N'מאתר נזילות')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (13, N'שמאי')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (14, N'נזק לצד ג')
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Cities] ON 
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (1, 100, N'תל אביב')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (2, 100, N'רמת גן')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (3, 100, N'גבעתיים')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (4, 100, N'בני ברק')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (5, 100, N'קרית אונו')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (6, 100, N'פתח תקווה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (7, 100, N'חולון')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (8, 100, N'בת ים')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (9, 200, N'מודיעין')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (10, 200, N'רמלה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (11, 200, N'לוד')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (12, 200, N'גדרה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (13, 200, N'רחובות')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (14, 200, N'ראשון לציון')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (15, 200, N'אשדוד')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (16, 200, N'יבנה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (17, 300, N'זכרון יעקב')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (18, 300, N'חדרה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (19, 300, N'אור עקיבא')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (20, 300, N'נתניה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (21, 300, N'הרצליה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (22, 300, N'רמת השרון')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (23, 300, N'רעננה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (24, 300, N'כפר סבא')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (25, 300, N'הוד הרון')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (26, 400, N'חיפה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (27, 400, N'טירת הכרמל')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (28, 400, N'קריות')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (29, 400, N'עכו')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (30, 400, N'נהריה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (31, 400, N'מעלות')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (32, 500, N'טבריה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (33, 500, N'מגדל העמק')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (34, 500, N'בית שאן')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (35, 500, N'עפולה')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (36, 600, N'אשקלון')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (37, 600, N'קרית גת')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (38, 600, N'באר שבע')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (39, 600, N'אופקים')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (40, 600, N'שדרות')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (41, 600, N'נתיבות')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (42, 600, N'ערד')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (43, 600, N'אילת')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (44, 700, N'ירושלים')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (45, 700, N'מעלה אדומים')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (46, 700, N'מבשרת')
GO
INSERT [dbo].[Cities] ([Id], [AreaId], [Name]) VALUES (47, 700, N'בית שמש')
GO
SET IDENTITY_INSERT [dbo].[Cities] OFF
GO
INSERT [dbo].[Clients] ([Id], [Name], [City], [Street], [StreetNumber], [Appartment], [Entrance], [Phone], [CellPhone]) VALUES (N'123456789', N'ישראל ישראלי', 23, N'אחוזה', 100, 1, N'0', N'050111111', NULL)
GO
INSERT [dbo].[ContinuousOrders] ([OrderId], [CategoryId], [DateCreated], [HandymanId], [ETADate], [ETATime], [ArrivalDateTime], [Note], [Price], [IsClose]) VALUES (4001, 13, CAST(N'2018-10-24T16:11:46.330' AS DateTime), 900, NULL, NULL, NULL, NULL, NULL, 0)
GO
INSERT [dbo].[HandymanInBusieness] ([BusinessId], [HandymanId]) VALUES (1, 901)
GO
SET IDENTITY_INSERT [dbo].[Handymen] ON 
GO
INSERT [dbo].[Handymen] ([Id], [Name], [Color], [BackgroundColor], [Email], [Password], [IsEmployee]) VALUES (900, N'כללי', N'#fff', N'#f00', NULL, NULL, 1)
GO
INSERT [dbo].[Handymen] ([Id], [Name], [Color], [BackgroundColor], [Email], [Password], [IsEmployee]) VALUES (901, N'אלי השרברב', N'#000', N'yellow', NULL, NULL, 1)
GO
INSERT [dbo].[Handymen] ([Id], [Name], [Color], [BackgroundColor], [Email], [Password], [IsEmployee]) VALUES (902, N'יוסי', N'#000', N'#39c', NULL, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[Handymen] OFF
GO
INSERT [dbo].[HandymenCategories] ([HandymanId], [CategoryId]) VALUES (901, 1)
GO
INSERT [dbo].[HandymenInArea] ([HandymanId], [AreaId]) VALUES (901, 100)
GO
INSERT [dbo].[HandymenInArea] ([HandymanId], [AreaId]) VALUES (901, 300)
GO
SET IDENTITY_INSERT [dbo].[HoursOfWork] ON 
GO
INSERT [dbo].[HoursOfWork] ([Id], [StartTime], [EndTime]) VALUES (1, N'9:00', N'11:00')
GO
INSERT [dbo].[HoursOfWork] ([Id], [StartTime], [EndTime]) VALUES (2, N'11:00', N'13:00')
GO
INSERT [dbo].[HoursOfWork] ([Id], [StartTime], [EndTime]) VALUES (3, N'13:00', N'15:00')
GO
INSERT [dbo].[HoursOfWork] ([Id], [StartTime], [EndTime]) VALUES (4, N'15:00', N'17:00')
GO
SET IDENTITY_INSERT [dbo].[HoursOfWork] OFF
GO
SET IDENTITY_INSERT [dbo].[InsuranceCompanies] ON 
GO
INSERT [dbo].[InsuranceCompanies] ([Id], [Name], [Logo]) VALUES (1, N'אב הבית', N'/assets/images/logo.png')
GO
INSERT [dbo].[InsuranceCompanies] ([Id], [Name], [Logo]) VALUES (2, N'הכשרה חברה לביטוח', N'/assets/images/ha.png')
GO
INSERT [dbo].[InsuranceCompanies] ([Id], [Name], [Logo]) VALUES (3, N'שלמה ביטוח', NULL)
GO
SET IDENTITY_INSERT [dbo].[InsuranceCompanies] OFF
GO
INSERT [dbo].[OrderNotes] ([OrderId], [DateCreated], [Results], [Actions], [Summary], [Others]) VALUES (4001, CAST(N'2018-10-24T16:11:27.080' AS DateTime), N'<p>24-10-2018 16:10:</p>
<p>dgh dfh&nbsp;</p>
<p>fgfg</p>', N'<p>24-10-2018 16:10:</p>
<p>awrtety&nbsp;</p>
<p>wrtrwt</p>', N'<p>24-10-2018 16:10:</p>
<p>rdyj tj rtuj&nbsp;</p>
<p>rtrtr tr rt&nbsp;</p>', NULL)
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([Id], [ClaimNumber], [PolicyNumber], [ClientId], [Type], [Status], [IsSameAddress], [City], [Street], [StreetNumber], [Appartment], [Entrance], [Deductible], [ProblemId], [ETADate], [ETATime], [BusinessId], [HandymanId], [ArrivalDateTime], [Note], [Price], [DateCreated], [CreatedBy], [PTest], [BTest], [TTest], [OTest], [OtherTestNote]) VALUES (4001, N'1111', N'22222', N'123456789', 2, 40, 0, 1, N'המייסדים', 12, 3, N'2', 800, 1, CAST(N'2018-12-30T00:00:00.000' AS DateTime), 1, 4, 900, NULL, N'', 1200, CAST(N'2018-09-28T19:36:13.243' AS DateTime), 10, 1, 0, 0, 0, N'בדיקת קיר')
GO
INSERT [dbo].[Orders] ([Id], [ClaimNumber], [PolicyNumber], [ClientId], [Type], [Status], [IsSameAddress], [City], [Street], [StreetNumber], [Appartment], [Entrance], [Deductible], [ProblemId], [ETADate], [ETATime], [BusinessId], [HandymanId], [ArrivalDateTime], [Note], [Price], [DateCreated], [CreatedBy], [PTest], [BTest], [TTest], [OTest], [OtherTestNote]) VALUES (4002, N'222', N'333', N'123456789', 1, 10, 0, 3, N'המייסדים', 12, 3, N'2', 780, 1, CAST(N'2018-12-30T00:00:00.000' AS DateTime), 3, 3, 900, NULL, N'', NULL, CAST(N'2018-09-28T19:38:13.623' AS DateTime), 10, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClaimNumber], [PolicyNumber], [ClientId], [Type], [Status], [IsSameAddress], [City], [Street], [StreetNumber], [Appartment], [Entrance], [Deductible], [ProblemId], [ETADate], [ETATime], [BusinessId], [HandymanId], [ArrivalDateTime], [Note], [Price], [DateCreated], [CreatedBy], [PTest], [BTest], [TTest], [OTest], [OtherTestNote]) VALUES (4003, N'999', N'2020', N'123456789', 1, 10, 1, 10, N'המייסדים', 12, 3, N'2', 0, 1, CAST(N'2018-01-30T00:00:00.000' AS DateTime), 3, 1, 900, NULL, N'', NULL, CAST(N'2018-09-28T19:40:18.377' AS DateTime), 10, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClaimNumber], [PolicyNumber], [ClientId], [Type], [Status], [IsSameAddress], [City], [Street], [StreetNumber], [Appartment], [Entrance], [Deductible], [ProblemId], [ETADate], [ETATime], [BusinessId], [HandymanId], [ArrivalDateTime], [Note], [Price], [DateCreated], [CreatedBy], [PTest], [BTest], [TTest], [OTest], [OtherTestNote]) VALUES (4004, N'8585', N'1010', N'123456789', 1, 10, 1, 12, N'המייסדים', 12, 3, N'2', 780, 1, CAST(N'2018-09-30T00:00:00.000' AS DateTime), 4, 1, 900, NULL, N'', NULL, CAST(N'2018-09-28T19:44:05.320' AS DateTime), 10, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClaimNumber], [PolicyNumber], [ClientId], [Type], [Status], [IsSameAddress], [City], [Street], [StreetNumber], [Appartment], [Entrance], [Deductible], [ProblemId], [ETADate], [ETATime], [BusinessId], [HandymanId], [ArrivalDateTime], [Note], [Price], [DateCreated], [CreatedBy], [PTest], [BTest], [TTest], [OTest], [OtherTestNote]) VALUES (4005, N'818285', N'56324', N'123456789', 1, 20, 1, NULL, NULL, NULL, NULL, NULL, 500, 1, CAST(N'2018-10-26T00:00:00.000' AS DateTime), 1, 1, 901, NULL, N'', NULL, CAST(N'2018-10-25T01:07:07.823' AS DateTime), 10, 0, 0, 0, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (10, N'קריאה חדשה לפני שיבוץ', N'יש הזמנה חדשה')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (20, N'בעל מקצוע שובץ', N'בעל המקצוע אישר את קבלת ההזמנה')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (30, N'הערכת נזק בטיפול', N'בעל המקצוע אישר הגעה ללקוח')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (40, N'יש עבודת המשך', N'צריך עוד בעל מקצוע לסיום התקלה')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (50, N'סיימתי עבודה
', N'בעל המקצוע סיים את העבודה')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (60, N'הסתיים ושולם', N'התקלה תוקנה והתשלום בוצע בהצלחה')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (70, N'טיפול הסתיים', N'הטיפול בתקלה הסתיים. ממתינים לתשלום')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (80, N'הצעת מחיר', N'יש לשלוח הצעת מחיר לביטוח')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (90, N'ממתין לשמאי/מפקח/מנה', N'יש להמתין לבדיקות אנשי מקצוע')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (100, N'תומחר ונשלח לביטוח', N'העבודה תומחרה ונשלחה לחברת הביטוח')
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderTypes] ON 
GO
INSERT [dbo].[OrderTypes] ([Id], [Name]) VALUES (1, N'הכשרה ביטוח')
GO
INSERT [dbo].[OrderTypes] ([Id], [Name]) VALUES (2, N'שלמה ביטוח')
GO
INSERT [dbo].[OrderTypes] ([Id], [Name]) VALUES (3, N'ביטוח שרשרב פרטי')
GO
INSERT [dbo].[OrderTypes] ([Id], [Name]) VALUES (4, N'פרטי')
GO
INSERT [dbo].[OrderTypes] ([Id], [Name]) VALUES (5, N'שמאי')
GO
SET IDENTITY_INSERT [dbo].[OrderTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Problems] ON 
GO
INSERT [dbo].[Problems] ([Id], [CategoryId], [Name]) VALUES (1, 1, N'נזילה מהניאגרה')
GO
SET IDENTITY_INSERT [dbo].[Problems] OFF
GO
SET IDENTITY_INSERT [dbo].[QuestionsForCategory] ON 
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (1, 2, N'סוג המרצפה')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (2, 2, N'גודל')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (3, 2, N'צבע')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (4, 2, N'כמות')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (5, 3, N'היכן')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (6, 3, N'מה יש לעשות')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (7, 3, N'גודל')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (8, 3, N'גוון')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (9, 12, N'הסיבה')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (10, 12, N'תיאור מקרה')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (11, 14, N'תיאור הנזק')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (12, 14, N'מה יש לעשות')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (13, 14, N'מידה')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (14, 14, N'גוון')
GO
INSERT [dbo].[QuestionsForCategory] ([Id], [CategoryId], [Title]) VALUES (15, 13, N'הערות')
GO
SET IDENTITY_INSERT [dbo].[QuestionsForCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([Id], [Name], [Note]) VALUES (1, N'A', N'מנהל המערכת ')
GO
INSERT [dbo].[Roles] ([Id], [Name], [Note]) VALUES (2, N'IA', N'מנהל חברת ביטוח')
GO
INSERT [dbo].[Roles] ([Id], [Name], [Note]) VALUES (3, N'U', N'משתמש אב הבית')
GO
INSERT [dbo].[Roles] ([Id], [Name], [Note]) VALUES (4, N'IU', N'משתמש חברת ביטוח')
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[SystemMessages] ON 
GO
INSERT [dbo].[SystemMessages] ([Code], [Title], [Note]) VALUES (1, N'משתמש לא קיים', N'מצטערים אך לא הצלחנו לאתר את פרטי המשתמש שלך')
GO
INSERT [dbo].[SystemMessages] ([Code], [Title], [Note]) VALUES (2, N'פרטי התחברות שגויים', N'פרטי ההתחברות שהזנת לא תואמים את הרשומות שלנו. ')
GO
SET IDENTITY_INSERT [dbo].[SystemMessages] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [Email], [Password], [RoleId], [InsuraceCompanyId], [Name], [Token], [IsActive], [UserName]) VALUES (10, N'shaykos@gmail.com', N'$2a$11$2.pTFSPVT1V6CUT/2A4OCeu3jxCSsyDot3.A5IAwrm.Prelew3hWS', 1, 1, N'שי אברהם', N'3598EA24-A5AE-4DA2-87F2-987A5A13A2D6', 1, N'shay')
GO
INSERT [dbo].[Users] ([Id], [Email], [Password], [RoleId], [InsuraceCompanyId], [Name], [Token], [IsActive], [UserName]) VALUES (11, N'menashe@3144.co.il', N'$2a$11$2.pTFSPVT1V6CUT/2A4OCeu3jxCSsyDot3.A5IAwrm.Prelew3hWS', 1, 1, N'מנשה נוריאל', NULL, 1, N'menashe')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534B76912EF]    Script Date: 25-Oct-2018 02:04:12 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__C9F2845622CB3A1A]    Script Date: 25-Oct-2018 02:04:12 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContinuousOrders] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ContinuousOrders] ADD  DEFAULT ((900)) FOR [HandymanId]
GO
ALTER TABLE [dbo].[ContinuousOrders] ADD  DEFAULT ((0)) FOR [IsClose]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((1)) FOR [IsSameAddress]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [PTest]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [BTest]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [TTest]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [OTest]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD FOREIGN KEY([AreaId])
REFERENCES [dbo].[Areas] ([Id])
GO
ALTER TABLE [dbo].[Clients]  WITH CHECK ADD FOREIGN KEY([City])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[ContinuousOrders]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[ContinuousOrders]  WITH CHECK ADD FOREIGN KEY([ETATime])
REFERENCES [dbo].[HoursOfWork] ([Id])
GO
ALTER TABLE [dbo].[ContinuousOrders]  WITH CHECK ADD FOREIGN KEY([HandymanId])
REFERENCES [dbo].[Handymen] ([Id])
GO
ALTER TABLE [dbo].[ContinuousOrders]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[HandymanInBusieness]  WITH CHECK ADD FOREIGN KEY([BusinessId])
REFERENCES [dbo].[Business] ([Id])
GO
ALTER TABLE [dbo].[HandymanInBusieness]  WITH CHECK ADD FOREIGN KEY([HandymanId])
REFERENCES [dbo].[Handymen] ([Id])
GO
ALTER TABLE [dbo].[HandymenCategories]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[HandymenCategories]  WITH CHECK ADD FOREIGN KEY([HandymanId])
REFERENCES [dbo].[Handymen] ([Id])
GO
ALTER TABLE [dbo].[HandymenInArea]  WITH CHECK ADD FOREIGN KEY([AreaId])
REFERENCES [dbo].[Areas] ([Id])
GO
ALTER TABLE [dbo].[HandymenInArea]  WITH CHECK ADD FOREIGN KEY([HandymanId])
REFERENCES [dbo].[Handymen] ([Id])
GO
ALTER TABLE [dbo].[OrderNotes]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([BusinessId])
REFERENCES [dbo].[Business] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([ETATime])
REFERENCES [dbo].[HoursOfWork] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([HandymanId])
REFERENCES [dbo].[Handymen] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([ProblemId])
REFERENCES [dbo].[Problems] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Status])
REFERENCES [dbo].[OrderStatus] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Type])
REFERENCES [dbo].[OrderTypes] ([Id])
GO
ALTER TABLE [dbo].[Problems]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[QuestionForContinuousOrder]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[QuestionForContinuousOrder]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[QuestionsForCategory] ([Id])
GO
ALTER TABLE [dbo].[QuestionsForCategory]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([InsuraceCompanyId])
REFERENCES [dbo].[InsuranceCompanies] ([Id])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[AddOrder]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--use AvBaitAdmin
--go

create proc [dbo].[AddOrder]
	@ClaimNumber nvarchar(max),
	@PolicyNumber nvarchar(max),
	@ClientId char(9),
	@Type int,
	@IsSameAddress bit,
	@City int,
	@Street nvarchar(max),
	@StreetNumber int,
	@Appartment int,
	@Entrance varchar(10),
	@Deductible float,
	@ProblemId int,
	@ETADate datetime,
	@ETATime int,
	@BusinessId int,
	@Note ntext,
	@CreatedBy int
as
	begin tran
		if (@IsSameAddress = '1')
			insert into [dbo].[Orders]([ClaimNumber], [PolicyNumber], [ClientId], [Type], [Status], [IsSameAddress], [Deductible], [ProblemId],[ETADate], [ETATime], [BusinessId], [HandymanId], [Note], [CreatedBy])
				values(@ClaimNumber,@PolicyNumber,@ClientId,@Type,10,@IsSameAddress,@Deductible,@ProblemId,@ETADate,@ETATime,@BusinessId,900,@Note,@CreatedBy)
		else
			insert into [dbo].[Orders]([ClaimNumber], [PolicyNumber], [ClientId], [Type], [Status], [IsSameAddress], [City], [Street], [StreetNumber], [Appartment], [Entrance], [Deductible], [ProblemId],[ETADate], [ETATime], [BusinessId], [HandymanId], [Note], [CreatedBy])
				values(@ClaimNumber,@PolicyNumber,@ClientId,@Type,10,@IsSameAddress,@City,@Street,@StreetNumber,@Appartment,@Entrance,@Deductible,@ProblemId,@ETADate,@ETATime,@BusinessId,900,@Note,@CreatedBy)
		select @@IDENTITY as OrderId
		if @@error <> 0
			begin
				rollback tran
				return
			end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[addOrderNotes]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[addOrderNotes]	
	@OrderId int, 
	@DateCreated datetime,
	@Results ntext,
	@Actions ntext,
	@Summary ntext
as
	begin tran
		if not exists (select [OrderId] from [dbo].[OrderNotes] where [OrderId] = @OrderId)
			insert into [dbo].[OrderNotes](OrderId, DateCreated, Results, Actions, Summary)
				values(@OrderId, @DateCreated, @Results, @Actions, @Summary)
		else
			update [OrderNotes]
				set [Results] = @Results,
					[Actions] = @Actions,
					[Summary] = @Summary
				where [OrderId] = @OrderId 
	if @@error <> 0
		begin
			rollback tran
			return
		end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[AddToContinuousOrders]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[AddToContinuousOrders] 
	@OrderId int,
	@CategoryId int
as
	begin tran
		update Orders 
			set [Status] = 40 
			where [Id] = @OrderId
		insert into ContinuousOrders(OrderId, CategoryId)
			values(@OrderId,@CategoryId)
		if @@error <> 0
			begin
				rollback tran
				return
			end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[AnswerQuestion]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[AnswerQuestion]
	@OrderId int,
	@QuestionId int,
	@Answer ntext
as
	begin tran
		insert into QuestionForContinuousOrder(OrderId, QuestionId, Answer)
			values(@OrderId, @QuestionId, @Answer)
		if @@error <> 0
			begin
				rollback tran
				return 
			end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[GetUserDetails]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetUserDetails] 
	@UserName varchar(max)
as
	begin tran
		declare @token uniqueidentifier = newid()
		declare @pass nvarchar(max) = (select dbo.GetUserHashPassword(@UserName))
		update [Users]	
			set [Token] = CONVERT(varchar(255), @token)
			where [UserName] = @UserName and [Password] = @pass
		select * from UserDetails where [UserName] = @UserName
	if @@error <> 0  
		begin
			rollback tran
			return
		end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[Logout]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[Logout]
	@UserId int
as
	begin tran
		update [dbo].[Users]
			set [Token] = ''
			where [Id] = @UserId
	if @@error <> 0
		begin 
			rollback tran
			return
		end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[saveHandymanUpdate]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[saveHandymanUpdate]
	@OrderId int,
	@PTest bit,
	@BTest bit,
	@TTest bit,
	@OTest bit,
	@OtherTestNote nvarchar(max),
	@Price float
as
	begin tran
		update [dbo].[Orders]
			set [PTest] = @PTest,
				[BTest] = @BTest,
				[TTest] = @TTest,
				[OTest] = @OTest,
				[OtherTestNote] = @OtherTestNote,
				[Price] = @Price 
			where [Id] = @OrderId
	if @@error <> 0
		begin
			rollback tran
			return
		end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[setHandymanToOrder]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[setHandymanToOrder]
	@OrderId int,
	@HandymanId int
as
	begin tran
		update [dbo].[Orders]
			set [HandymanId] = @HandymanId,
				[Status] = 20
			where [Id] = @OrderId
	if @@error <> 0
		begin
			rollback tran
			return
		end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[UpdateClientAddress]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UpdateClientAddress]
	@OrderId int,
	@ClientId int, 
	@IsSameAddress bit, 
	@City int, 
	@Street nvarchar(max), 
	@StreetNumber int, 
	@Appartment int, 
	@Entrance int
as
	begin tran
		if @IsSameAddress = 1
			update [dbo].[Clients]	
				set [City] = @City,
					[Street] = @Street,
					[StreetNumber] = @StreetNumber,
					[Appartment] = @Appartment,
					[Entrance] = @Entrance
				where [Id] = @ClientId
		else
			update 	[dbo].[Orders]
				set [City] = @City,
					[Street] = @Street,
					[StreetNumber] = @StreetNumber,
					[Appartment] = @Appartment,
					[Entrance] = @Entrance
				where [ClientId] = @ClientId and [Id] = @OrderId
		update [dbo].[Orders]
			set [IsSameAddress] = @IsSameAddress
			where [Id] = @OrderId
	if @@error <> 0
		begin
			rollback tran
			return
		end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[updateOrder]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[updateOrder]
	@OrderId int,
	@OrderType int,
	@OrderStatus int,
	@ProblemId int,
	@ETADate datetime,
	@ETATime int,
	@BusinessId int,
	@Deductible float
as
	begin tran
		update [dbo].[Orders]
			set [Status] = @OrderStatus,
				[Type] = @OrderType,
				[ProblemId] = @ProblemId,
				[ETADate] = @ETADate,
				[ETATime] = @ETATime,
				[BusinessId] = @BusinessId,
				[Deductible] = @Deductible
			where [Id] = @OrderId
	if @@error <> 0
		begin
			rollback tran
			return
		end
	commit tran
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderStatus]    Script Date: 25-Oct-2018 02:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UpdateOrderStatus]
	@OrderId int,
	@OrderStatus int,
	@CategoryId int
as
	begin tran
		if @OrderStatus = 40
			if not exists (select [OrderId] from [dbo].[ContinuousOrders] where [OrderId] = @OrderId and [IsClose] = 0)
			exec AddToContinuousOrders @OrderId, @CategoryId
		else	
			update [Orders]	
				set [Status] = @OrderStatus
				where [Id] = @OrderId
		if @@error <> 0
			begin
				rollback tran
				return
			end
	commit tran
GO
USE [master]
GO
ALTER DATABASE [DB_9FBCC4_insurance] SET  READ_WRITE 
GO
