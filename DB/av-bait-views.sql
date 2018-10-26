
--use AvBaitAdmin
--go

create view OrdersView
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
go

create view QuestionsForOrder
as
	SELECT        dbo.QuestionsForCategory.Id, dbo.QuestionsForCategory.CategoryId, dbo.QuestionsForCategory.Title
	FROM            dbo.Orders INNER JOIN
							 dbo.ContinuousOrders ON dbo.Orders.Id = dbo.ContinuousOrders.OrderId INNER JOIN
							 dbo.QuestionsForCategory ON dbo.ContinuousOrders.CategoryId = dbo.QuestionsForCategory.CategoryId
	WHERE        (dbo.Orders.Status = 40)
go

create view UserDetails 
as
	SELECT        dbo.Users.Id, dbo.Users.Email, dbo.Users.UserName, dbo.Users.RoleId, dbo.Users.InsuraceCompanyId, dbo.Users.Name, 
					dbo.Users.Token, dbo.Users.IsActive, dbo.InsuranceCompanies.Id AS InsuranceCompanyId, 
                         dbo.InsuranceCompanies.Name AS InsuranceCompanyName, dbo.InsuranceCompanies.Logo
	FROM            dbo.InsuranceCompanies INNER JOIN
                         dbo.Users ON dbo.InsuranceCompanies.Id = dbo.Users.InsuraceCompanyId
go

create view ClientDetails
as
	SELECT        dbo.Clients.Id, dbo.Clients.Name, dbo.Clients.City AS CityId, dbo.Cities.Name AS CityName, dbo.Clients.Street, dbo.Clients.StreetNumber, dbo.Clients.Appartment, dbo.Clients.Entrance, dbo.Clients.Phone, 
                         dbo.Clients.CellPhone
	FROM            dbo.Cities INNER JOIN
                         dbo.Clients ON dbo.Cities.Id = dbo.Clients.City
go

create view AllEvents
as
	SELECT        dbo.Orders.Id, CONVERT(datetime, LEFT(CONVERT(VARCHAR, dbo.Orders.ETADate, 120), 10) + ' ' + dbo.HoursOfWork.StartTime) AS Start, CONVERT(datetime, LEFT(CONVERT(VARCHAR, dbo.Orders.ETADate, 120), 10) 
                         + ' ' + dbo.HoursOfWork.EndTime) AS [End], dbo.Problems.Name AS Title, dbo.Handymen.Color AS TextColor, dbo.Handymen.BackgroundColor, dbo.Handymen.Id AS HandymanId, dbo.Handymen.Name AS HandymanName 
	FROM            dbo.Handymen INNER JOIN
                         dbo.Orders ON dbo.Handymen.Id = dbo.Orders.HandymanId INNER JOIN
                         dbo.HoursOfWork ON dbo.Orders.ETATime = dbo.HoursOfWork.Id INNER JOIN
                         dbo.Problems ON dbo.Orders.ProblemId = dbo.Problems.Id
go

