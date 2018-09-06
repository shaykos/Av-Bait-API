
--create database AvBaitAdmin
--go

use AvBaitAdmin
go

/*
----- Tables -------
*/

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

create table Handymen
(
	[Id] int identity(900,1) primary key,
	[Name] nvarchar(max),
	[Color] varchar(max)
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

create table Orders
(
	[Id] int identity(4000,1) primary key,
	[ClaimNumber] nvarchar(max),
	[Type] int foreign key references [dbo].[OrderTypes]([Id]),
	[Status] int foreign key references [dbo].[OrderStatus]([Id]),
	[Name] nvarchar(max),
	[Deductible] float,
	[City] int foreign key references [dbo].[Cities]([Id]),
	[Street] nvarchar(max),
	[Appartment] int,
	[Phone] nvarchar(max),
	[CellPhone] nvarchar(max),
	[ProblemId] int foreign key references [dbo].[Problems]([Id]),
	[ETADate] datetime,
	[ETATime] int foreign key references [dbo].[HoursOfWork]([Id]),
	[HandymanId] int foreign key references [dbo].[Handymen]([Id]),
	[ArrivalDateTime] datetime,
	[Note] ntext,
	[Price] float,
	[DateCreated] datetime default getdate()
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
	[Price] float

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

/*
----- Types -------
*/

