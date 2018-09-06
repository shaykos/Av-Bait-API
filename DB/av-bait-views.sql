
use AvBaitAdmin
go

create view OrdersView
as
	SELECT        dbo.Orders.Id AS OrderId, dbo.Orders.ClaimNumber, dbo.Orders.Type AS TypeId, dbo.OrderTypes.Name AS TypeName, dbo.Orders.Status AS StatusId, dbo.OrderStatus.Name AS StatusName, dbo.Orders.Name AS ClientName, 
                         dbo.Orders.Deductible, dbo.Orders.City AS CityCode, dbo.Cities.Name + ' ' + dbo.Orders.Street as 'Address', dbo.Orders.Appartment, dbo.Orders.Phone, dbo.Orders.CellPhone, dbo.Orders.ProblemId, 
                         dbo.Problems.Name AS ProblemName, dbo.Categories.Id AS CategoryId, dbo.Categories.Name AS CategoryName, dbo.Orders.ETADate, dbo.Orders.ETATime, dbo.HoursOfWork.StartTime + ' - ' + dbo.HoursOfWork.EndTime as 'ETA', 
                         dbo.Orders.HandymanId, dbo.Handymen.Name AS HandymanName, dbo.Orders.ArrivalDateTime, dbo.Orders.Note, dbo.Orders.Price, dbo.Orders.DateCreated
	FROM            dbo.Orders INNER JOIN
                         dbo.OrderStatus ON dbo.Orders.Status = dbo.OrderStatus.Id INNER JOIN
                         dbo.OrderTypes ON dbo.Orders.Type = dbo.OrderTypes.Id INNER JOIN
                         dbo.Problems ON dbo.Orders.ProblemId = dbo.Problems.Id INNER JOIN
                         dbo.Handymen ON dbo.Orders.HandymanId = dbo.Handymen.Id INNER JOIN
                         dbo.HoursOfWork ON dbo.Orders.ETATime = dbo.HoursOfWork.Id INNER JOIN
                         dbo.Cities ON dbo.Orders.City = dbo.Cities.Id INNER JOIN
                         dbo.Categories ON dbo.Problems.CategoryId = dbo.Categories.Id
go

create view QuestionsForOrder
as
	SELECT        dbo.QuestionsForCategory.Id, dbo.QuestionsForCategory.CategoryId, dbo.QuestionsForCategory.Title
	FROM            dbo.Orders INNER JOIN
							 dbo.ContinuousOrders ON dbo.Orders.Id = dbo.ContinuousOrders.OrderId INNER JOIN
							 dbo.QuestionsForCategory ON dbo.ContinuousOrders.CategoryId = dbo.QuestionsForCategory.CategoryId
	WHERE        (dbo.Orders.Status = 40)
go
