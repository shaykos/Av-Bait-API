
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
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [Email], [Password], [RoleId], [InsuraceCompanyId], [Name], [Token], [IsActive], [UserName]) VALUES (10, N'shaykos@gmail.com', N'$2a$11$2.pTFSPVT1V6CUT/2A4OCeu3jxCSsyDot3.A5IAwrm.Prelew3hWS', 1, 1, N'שי אברהם', N'3598EA24-A5AE-4DA2-87F2-987A5A13A2D6', 1, N'shay')
GO
INSERT [dbo].[Users] ([Id], [Email], [Password], [RoleId], [InsuraceCompanyId], [Name], [Token], [IsActive], [UserName]) VALUES (11, N'menashe@3144.co.il', N'$2a$11$2.pTFSPVT1V6CUT/2A4OCeu3jxCSsyDot3.A5IAwrm.Prelew3hWS', 1, 1, N'מנשה נוריאל', NULL, 1, N'menashe')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
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
SET IDENTITY_INSERT [dbo].[Problems] ON 
GO
INSERT [dbo].[Problems] ([Id], [CategoryId], [Name]) VALUES (1, 1, N'נזילה מהניאגרה')
GO
SET IDENTITY_INSERT [dbo].[Problems] OFF
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
INSERT [dbo].[HandymenCategories] ([HandymanId], [CategoryId]) VALUES (901, 1)
GO
INSERT [dbo].[ContinuousOrders] ([OrderId], [CategoryId], [DateCreated], [HandymanId], [ETADate], [ETATime], [ArrivalDateTime], [Note], [Price], [IsClose]) VALUES (4001, 13, CAST(N'2018-10-24T16:11:46.330' AS DateTime), 900, NULL, NULL, NULL, NULL, NULL, 0)
GO
INSERT [dbo].[HandymenInArea] ([HandymanId], [AreaId]) VALUES (901, 100)
GO
INSERT [dbo].[HandymenInArea] ([HandymanId], [AreaId]) VALUES (901, 300)
GO
INSERT [dbo].[HandymanInBusieness] ([BusinessId], [HandymanId]) VALUES (1, 901)
GO
INSERT [dbo].[OrderNotes] ([OrderId], [DateCreated], [Results], [Actions], [Summary], [Others]) VALUES (4001, CAST(N'2018-10-24T16:11:27.080' AS DateTime), N'<p>24-10-2018 16:10:</p>
<p>dgh dfh&nbsp;</p>
<p>fgfg</p>', N'<p>24-10-2018 16:10:</p>
<p>awrtety&nbsp;</p>
<p>wrtrwt</p>', N'<p>24-10-2018 16:10:</p>
<p>rdyj tj rtuj&nbsp;</p>
<p>rtrtr tr rt&nbsp;</p>', NULL)
GO
SET IDENTITY_INSERT [dbo].[SystemMessages] ON 
GO
INSERT [dbo].[SystemMessages] ([Code], [Title], [Note]) VALUES (1, N'משתמש לא קיים', N'מצטערים אך לא הצלחנו לאתר את פרטי המשתמש שלך')
GO
INSERT [dbo].[SystemMessages] ([Code], [Title], [Note]) VALUES (2, N'פרטי התחברות שגויים', N'פרטי ההתחברות שהזנת לא תואמים את הרשומות שלנו. ')
GO
SET IDENTITY_INSERT [dbo].[SystemMessages] OFF
GO
