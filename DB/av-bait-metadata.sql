USE [AvBaitAdmin]
GO
SET IDENTITY_INSERT [dbo].[Handymen] ON 
GO
INSERT [dbo].[Handymen] ([Id], [Name], [Color], [Email], [Password]) VALUES (900, N'כללי', NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Handymen] OFF
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
INSERT [dbo].[HandymenInArea] ([HandymanId], [AreaId]) VALUES (901, 100)
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
INSERT [dbo].[HandymenCategories] ([HandymanId], [CategoryId]) VALUES (901, 1)
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
SET IDENTITY_INSERT [dbo].[InsuranceCompanies] ON 
GO
INSERT [dbo].[InsuranceCompanies] ([Id], [Name], [Logo]) VALUES (1, N'אב הבית', NULL)
GO
INSERT [dbo].[InsuranceCompanies] ([Id], [Name], [Logo]) VALUES (2, N'הכשרה חברה לביטוח', NULL)
GO
INSERT [dbo].[InsuranceCompanies] ([Id], [Name], [Logo]) VALUES (3, N'שלמה ביטוח', NULL)
GO
SET IDENTITY_INSERT [dbo].[InsuranceCompanies] OFF
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
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (10, N'עבודה חדשה', N'יש הזמנה חדשה')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (20, N'עבודה אושרה', N'בעל המקצוע אישר את קבלת ההזמנה')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (30, N'עבודה בתהליך', N'בעל המקצוע אישר הגעה ללקוח')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (40, N'עבודת המשך', N'צריך עוד בעל מקצוע לסיום התקלה')
GO
INSERT [dbo].[OrderStatus] ([Id], [Name], [Note]) VALUES (50, N'עבודה סגורה', N'בעל המקצוע סיים את העבודה')
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Problems] ON 
GO
INSERT [dbo].[Problems] ([Id], [CategoryId], [Name]) VALUES (1, 1, N'נזילה מהניאגרה')
GO
SET IDENTITY_INSERT [dbo].[Problems] OFF
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
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([Id], [ClaimNumber], [Type], [Status], [Name], [Deductible], [City], [Street], [Appartment], [Phone], [CellPhone], [ProblemId], [ETADate], [ETATime], [HandymanId], [ArrivalDateTime], [Note], [Price], [DateCreated], [CreatedBy], [BusinessId]) VALUES (4000, N'123456', 1, 40, N'ישראל ישראלי', 800, 1, N'הנשיאים 12', 0, N'', N'054-5726662', 1, CAST(N'2018-09-20T00:00:00.000' AS DateTime), 1, 900, NULL, N'', NULL, CAST(N'2018-09-05T13:54:44.737' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
INSERT [dbo].[ContinuousOrders] ([OrderId], [CategoryId], [DateCreated], [HandymanId], [ETADate], [ETATime], [ArrivalDateTime], [Note], [Price]) VALUES (4000, 2, CAST(N'2018-09-05T15:47:07.203' AS DateTime), 900, NULL, NULL, NULL, NULL, NULL)
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
INSERT [dbo].[QuestionForContinuousOrder] ([OrderId], [QuestionId], [Answer]) VALUES (4000, 1, N'121212')
GO
INSERT [dbo].[QuestionForContinuousOrder] ([OrderId], [QuestionId], [Answer]) VALUES (4000, 2, N'answer 2')
GO
INSERT [dbo].[QuestionForContinuousOrder] ([OrderId], [QuestionId], [Answer]) VALUES (4000, 3, N'answer 3')
GO
