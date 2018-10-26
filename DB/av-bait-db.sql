
--create database AvBaitAdmin
--go

--use AvBaitAdmin
--go

/*
----- Tables -------
*/

create table Roles
(
	[Id] int identity(1,1) primary key,
	[Name] nvarchar(80),
	[Note] nvarchar(max)
)
go

create table InsuranceCompanies
(
	[Id] int identity(1,1) primary key,
	[Name] nvarchar(max),
	[Logo] nvarchar(max)
) 
go

create table Users
(
	[Id] int identity(10,1) primary key,
	[Email] varchar(120) unique,
	[UserName] varchar(120) unique,
	[Password] varchar(max),
	[RoleId] int foreign key references [dbo].[Roles]([Id]),
	[InsuraceCompanyId] int foreign key references [dbo].[InsuranceCompanies]([Id]),
	[Name] nvarchar(max),
	[Token] varchar(max),
	[IsActive] bit
)
go

create table OrderTypes
(
	[Id] int identity(1,1) primary key,
	[Name] nvarchar(max)
)
go

create table OrderStatus
(
	[Id] int identity(10,10) primary key,
	[Name] nvarchar(max),
	[Note] nvarchar(max)
)
go

create table Categories
(
	[Id] int identity(1,1) primary key,
	[Name] nvarchar(max)
)
go

create table Problems
(
	[Id] int identity(1,1) primary key,
	[CategoryId] int foreign key references [dbo].[Categories]([Id]),
	[Name] nvarchar(max)
)
go

create table QuestionsForCategory
(
	[Id] int identity(1,1) primary key,
	[CategoryId] int foreign key references [dbo].[Categories]([Id]),
	[Title] nvarchar(max)
)
go

create table Areas
(
	[Id] int identity(100,100) primary key,
	[Name] nvarchar(max)
)
go

create table Cities
(
	[Id] int identity(1,1) primary key,
	[AreaId] int foreign key references [dbo].[Areas]([Id]),
	[Name] nvarchar(max)
) 
go

create table HoursOfWork
(
	[Id] int identity(1,1) primary key,
	[StartTime] nvarchar(max),
	[EndTime] nvarchar(max)
)
go

create table [Business]
(
	[Id] int identity (1,1) primary key,
	[Name] nvarchar(max)
)
go

create table Handymen
(
	[Id] int identity(900,1) primary key,
	[Name] nvarchar(max),
	[Color] varchar(max),
	[BackgroundColor] nvarchar(20),
	[Email] varchar(max),
	[Password] varchar(max),
	[IsEmployee] bit
)
go

create table HandymanInBusieness
(
	[BusinessId] int foreign key references [dbo].[Business]([Id]),
	[HandymanId] int foreign key references [dbo].[Handymen]([Id]),

	primary key([BusinessId],[HandymanId])
)
go

create table HandymenInArea
(
	[HandymanId] int foreign key references [dbo].[Handymen]([Id]),
	[AreaId] int foreign key references [dbo].[Areas]([Id]),

	primary key([HandymanId],[AreaId])
) 
go

create table HandymenCategories
(
	[HandymanId] int foreign key references [dbo].[Handymen]([Id]),
	[CategoryId] int foreign key references [dbo].[Categories]([Id]),

	primary key([HandymanId],[CategoryId])
)
go

create table [Clients]
(
	[Id] char(9) primary key,
	[Name] nvarchar(max),
	[City] int foreign key references [dbo].[Cities]([Id]),
	[Street] nvarchar(max),
	[StreetNumber] int,
	[Appartment] int,
	[Entrance] varchar(10),
	[Phone] nvarchar(max),
	[CellPhone] nvarchar(max)
)
go

create table [Orders]
(
	[Id] int identity(4000,1) primary key,
	[ClaimNumber] nvarchar(max),
	[PolicyNumber] nvarchar(max),
	[ClientId] char(9) foreign key references [dbo].[Clients]([Id]),
	[Type] int foreign key references [dbo].[OrderTypes]([Id]),
	[Status] int foreign key references [dbo].[OrderStatus]([Id]),
	[IsSameAddress] bit default 1,
	[City] int,
	[Street] nvarchar(max),
	[StreetNumber] int,
	[Appartment] int,
	[Entrance] varchar(10),
	[Deductible] float,
	[ProblemId] int foreign key references [dbo].[Problems]([Id]),
	[ETADate] datetime,
	[ETATime] int foreign key references [dbo].[HoursOfWork]([Id]),
	[BusinessId] int foreign key references [dbo].[Business]([Id]),
	[HandymanId] int foreign key references [dbo].[Handymen]([Id]),
	[ArrivalDateTime] datetime,
	[Note] ntext,
	[Price] float,
	[DateCreated] datetime default getdate(),
	[CreatedBy] int foreign key references [dbo].[Users]([Id]),
	[PTest] bit default 0,
	[BTest] bit default 0,
	[TTest] bit default 0,
	[OTest] bit default 0,
	[OtherTestNote] nvarchar(max) 
) 
go

create table OrderNotes
(
	[OrderId] int foreign key references [dbo].[Orders]([Id]),
	[DateCreated] datetime,
	[Results] ntext,
	[Actions] ntext,
	[Summary] ntext,
	[Others] ntext

	primary key([OrderId],[DateCreated])
)
go


create table ContinuousOrders
(
	[OrderId] int foreign key references [dbo].[Orders]([Id]),
	[CategoryId] int foreign key references [dbo].[Categories]([Id]), 
	[DateCreated] datetime default getdate(),
	[HandymanId] int foreign key references [dbo].[Handymen]([Id]) default 900,
	[ETADate] date,
	[ETATime] int foreign key references [dbo].[HoursOfWork]([Id]),
	[ArrivalDateTime] datetime,
	[Note] ntext,
	[Price] float,
	[IsClose] bit default 0

	primary key([OrderId],[CategoryId],[DateCreated])
)
go

create table QuestionForContinuousOrder
(
	[OrderId] int foreign key references [dbo].[Orders]([Id]),
	[QuestionId] int foreign key references [dbo].[QuestionsForCategory]([Id]),
	[Answer] ntext

	primary key([OrderId],[QuestionId])
)
go

create table [SystemMessages]
(
	[Code] int identity(1,1),
	[Title] nvarchar(max),
	[Note] ntext
)
go


