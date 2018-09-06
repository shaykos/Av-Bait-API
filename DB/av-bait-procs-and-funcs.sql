
use AvBaitAdmin
go

create proc AddOrder 
	@ClaimNumber nvarchar(max), 
	@Type int, 
	@Status int, 
	@Name nvarchar(max), 
	@Deductible float, 
	@City int, 
	@Street nvarchar(max), 
	@Appartment int, 
	@Phone nvarchar(max), 
	@CellPhone nvarchar(max), 
	@ProblemId int, 
	@ETADate datetime, 
	@ETATime int, 
	@HandymanId int, 
	@Note ntext
as
	begin tran
		insert into [dbo].[Orders]([ClaimNumber], [Type], [Status], [Name], [Deductible], [City], [Street], [Appartment], [Phone], [CellPhone], [ProblemId], [ETADate], [ETATime], [HandymanId], [Note])
			values(@ClaimNumber, @Type, @Status, @Name, @Deductible, @City, @Street, @Appartment, @Phone, @CellPhone, @ProblemId, @ETADate, @ETATime, @HandymanId, @Note)
		select @@IDENTITY as OrderId
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

create function GetHandymen(@City int, @ProblemId int, @ETADate datetime, @ETATime int)
returns table
as
	return (
		select [Id], [Name] from [dbo].[Handymen] where [Id] in (
			select [HandymanId] from [dbo].[HandymenCategories] where [CategoryId] = (select [CategoryId] from [dbo].[Problems] where [Id] = @ProblemId)
		)
		and [Id] in (
			select [HandymanId] from [dbo].[HandymenInArea] where [AreaId] = (select [AreaId] from [dbo].[Cities] where [Id] = @City)
		) 
		and [Id] not in (
			select [HandymanId] from OrdersView where [ETADate] = @ETADate and [ETATime] = @ETATime
		)
	)
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
