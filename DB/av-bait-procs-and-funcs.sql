
--use AvBaitAdmin
--go

create proc AddOrder
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
go

create proc updateOrder
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
go

create proc saveHandymanUpdate
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
go


create proc UpdateOrderStatus
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
go

create proc addOrderNotes	
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
go

create proc AddToContinuousOrders 
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
go

create function CheckDateAvailable(@OrderId int)
returns table
as
	return (
		SELECT HandymanId FROM dbo.Orders 
		GROUP BY ETADate, HandymanId 
		HAVING (COUNT(HandymanId) > 4) and 
			(ETADate = (select [ETADate] from [dbo].[Orders] where [Id] = @OrderId)) 
	)
go

create proc setHandymanToOrder
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
go

create proc AnswerQuestion
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
go

create function GetUserHashPassword(@UserName varchar(max)) 
returns nvarchar(max)
as
	begin
		return(select [Password] from [Users] where [UserName] = @UserName and [IsActive] = 1)
	end	
go

create function GetSystemMessage(@Code int)
returns table
as
	return (select * from SystemMessages where [Code] = @Code)
go

create proc GetUserDetails 
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
go

create proc Logout
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
go

create function GetOrderCityCode(@OrderId int)
returns int 
as
	begin
		return (
			isnull((select [City] from [dbo].[Orders] where [Id] = @OrderId), (select [City] from [dbo].[Clients] where [Id] = (select [ClientId] from [dbo].[Orders] where [Id] = @OrderId)))
		)
	end
go

create function GetCityName(@OrderId int)
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
go

create function GetEntrace(@OrderId int)
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
go

create function GetOrderAddress(@OrderId int)
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
go

create function GetOrderStreet(@OrderId int)
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
go

create function GetOrderStreetNumber(@OrderId int)
returns int
as
	begin
		return (
			isnull((select [StreetNumber] from [dbo].[Orders] where [Id] = @OrderId), (select [StreetNumber] from [dbo].[Clients] where [Id] = (select [ClientId] from [dbo].[Orders] where [Id] = @OrderId)))
		)
	end
go

create function GetOrderAppartment(@OrderId int)
returns int
as
	begin
		return (
			isnull((select [Appartment] from [dbo].[Orders] where [Id] = @OrderId), (select [Appartment] from [dbo].[Clients] where [Id] = (select [ClientId] from [dbo].[Orders] where [Id] = @OrderId)))
		)
	end
go

create function GetOrderCategoryId(@OrderId int)
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
go

create function GetOrderCategoryName(@OrderId int)
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
go

create function GetHandymen(@OrderId int)
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
go

create proc UpdateClientAddress
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
go


