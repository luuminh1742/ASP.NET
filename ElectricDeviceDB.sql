/*
Created		14/06/2021
Modified		14/06/2021
Project		
Model			
Company		
Author		
Version		
Database		MS SQL 2005 
*/

USE master
GO

IF(EXISTS(SELECT * FROM SYSDATABASES WHERE NAME='ElectronicDevice'))
	DROP DATABASE ElectronicDevice
GO

CREATE DATABASE ElectronicDevice
GO

USE ElectronicDevice
GO
Create table [Category]
(
	[ID_Category] Integer Identity NOT NULL,
	[Name] Nvarchar(255) NOT NULL,
	[Icon] Nvarchar(255) NOT NULL,
	[Status] Bit NOT NULL,
Primary Key ([ID_Category])
) 
go

Create table [Product]
(
	[ID_Product] [int] IDENTITY NOT NULL,
	[ID_Category] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Price] [money] NOT NULL,
	[Model] [nvarchar](255) NOT NULL,
	[Amount] [int] NOT NULL,
	[Guarantee] [int] NOT NULL,
	[Origin] [nvarchar](255) NULL,
	[Discount] [smallint] NULL,
	[ShortDescription] [nvarchar](255) NULL,
	[Detail] [ntext] NULL,
	[Image] [nvarchar](255) NOT NULL,
	[CreatedDate] [date] NULL,
	[Status] [bit] NOT NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [date] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
Primary Key ([ID_Product])
) 
go

Create table [Account]
(
	[ID_Account] Integer Identity NOT NULL,
	[ID_Role] Integer NOT NULL,
	[UserName] Varchar(255) NOT NULL, UNIQUE ([UserName]),
	[Password] Varchar(255) NOT NULL,
	[FullName] Nvarchar(255) NOT NULL,
	[Phone] Char(20) NULL,
	[Address] Nvarchar(255) NULL,
	[Email] Varchar(50) NULL,
	[Status] Bit NOT NULL,
	[Avatar] Nvarchar(255) NULL,
Primary Key ([ID_Account])
) 
go

Create table [Role]
(
	[ID_Role] Integer Identity NOT NULL,
	[Name] Nvarchar(255) NOT NULL,
	[Code] Varchar(50) NOT NULL,
	Primary Key ([ID_Role])
) 
go

Create table [Cart]
(
	[ID_Product] Integer NOT NULL,
	[ID_Account] Integer NOT NULL,
	[Amount] Integer NOT NULL,
	Primary Key ([ID_Product],[ID_Account])
) 
go

Create table [Bill]
(
	[ID_Bill] [int] IDENTITY NOT NULL,
	[ID_Account] [int] NOT NULL,
	[ReceiverName] [nvarchar](50) NOT NULL,
	[ReceiverAddress] [nvarchar](255) NOT NULL,
	[ReceiverEmail] [varchar](255) NOT NULL,
	[ReceiverPhone] [char](20) NOT NULL,
	[Note] [ntext] NULL,
	[PayType] [nvarchar](255) NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [date] NULL,
	[ModifiedDate] [date] NULL,
Primary Key ([ID_Bill])
) 
go

Create table [BillDetail]
(
	[ID_Product] Integer NOT NULL,
	[ID_Bill] Integer NOT NULL,
	[Amount] Integer NOT NULL,
	[CurrentlyPrice] Money NOT NULL,
Primary Key ([ID_Product],[ID_Bill])
) 
go

Alter table [Product] add  foreign key([ID_Category]) references [Category] ([ID_Category])  on update no action on delete no action 
go
Alter table [Cart] add  foreign key([ID_Product]) references [Product] ([ID_Product])  on update no action on delete no action 
go
Alter table [BillDetail] add  foreign key([ID_Product]) references [Product] ([ID_Product])  on update no action on delete no action 
go
Alter table [Cart] add  foreign key([ID_Account]) references [Account] ([ID_Account])  on update no action on delete no action 
go
Alter table [Bill] add  foreign key([ID_Account]) references [Account] ([ID_Account])  on update no action on delete no action 
go
Alter table [Account] add  foreign key([ID_Role]) references [Role] ([ID_Role])  on update no action on delete no action 
go
Alter table [BillDetail] add  foreign key([ID_Bill]) references [Bill] ([ID_Bill])  on update no action on delete no action 
go


Set quoted_identifier on
go


Set quoted_identifier off
go

SET IDENTITY_INSERT [dbo].[Category] ON 
INSERT [dbo].[Category] ([ID_Category], [Name], [Icon], [Status]) VALUES (3, N'Điều hòa nhiệt độ', N'icon_dieu_hoa.png', 1)
INSERT [dbo].[Category] ([ID_Category], [Name], [Icon], [Status]) VALUES (4, N'Tivi, loa - âm thanh', N'icon-tivi-loa-am-thanh.png', 1)
INSERT [dbo].[Category] ([ID_Category], [Name], [Icon], [Status]) VALUES (5, N'Máy giặt, máy sấy quần áo', N'icon-may-giat-may-say.png', 1)
INSERT [dbo].[Category] ([ID_Category], [Name], [Icon], [Status]) VALUES (6, N'Tủ lạnh, tủ đông, tủ mát', N'icon-tu-lanh-tu-dong-tu-mat.png', 1)
INSERT [dbo].[Category] ([ID_Category], [Name], [Icon], [Status]) VALUES (8, N'Quạt mát các loại', N'icon-quat-mat-cac-loai.png', 1)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, 6, N'Tủ lạnh Samsung RT19M300BGS - 208L Digital Inverter', 6990000.0000, N'RT19M300BGS/SV', 45, 1, N'Việt Nam', 0, N'Luồng khí lạnh đa chiều cho hơi mát lan tỏa đều đến mọi ngóc ngách trong tủ.', N'Bao quát bởi tông màu xám bạc cực kỳ sang trọng, tủ lạnh Samsung RT19M300BGS/SV sẽ góp phần mang đến vẻ đẹp hiện đại cho bất kỳ không gian nội thất nào.', N'-SKqdne.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (2, 6, N'Tủ lạnh Hitachi R-B330PGV8(BSL) - 275 lít Inverter', 23000000.0000, N'R-B330PGV8(BSL)', 12, 1, N' Thái Lan', 0, N'Kháng khuẩn, khử mùi hiệu quả nhờ màng lọc Nano Titanium.', N'Tủ lạnh Hitachi R-B330PGV8 (BSL) là dòng tủ lạnh mới vừa được Hitachi giới thiệu tới người tiêu dùng Việt Nam trong năm 2018', N'-20e28c.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (3, 6, N'Tủ lạnh Samsung RT38K5982DX/SV - 380 Lít, Inverter, 2 dàn lạnh độc lập', 45990000.0000, N' RT38K5982DX/SV', 35, 1, N' Thái Lan', 0, N'Công Nghệ Digital Inverter hoạt động bền bỉ', N'Nhờ hai dàn lạnh hoạt động độc lập, hai ngăn tủ của tủ lạnh Twin Cooling Plus hoàn toàn tách biệt, ngăn việc mất độ ẩm từ ngăn mát sang ngăn đông do sự trao đổi khí giữa hai ngăn', N'-FZYft8.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (4, 6, N'Tủ lạnh 165 Lít Inverter SHARP SJ-X176E-SL', 5190000.0000, N'SJ-X176E-SL', 12, 1, N'Thái Lan', 0, N'J-Tech Inverter tiết kiệm 30% điện năng', N'Tủ lạnh Sharp Inverter 165 lít SJ-X176E-SL với thiết kế màu bạc tinh tế, kích thước nhỏ gọn sẽ dễ dàng kết hợp với bất kì kiểu không gian nội thất nào của gia đình, đồng thời bạn cũng sẽ không phải lo lắng tủ chiếm quá nhiều diện tích.', N'-MhgN4N.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, 6, N'Tủ lạnh Samsung RT35K5982BS/SV - 360 Lít, Inverter, 2 dàn lạnh độc lập', 14490000.0000, N'RT35K5982BS/SV', 10, 1, N'Thái Lan', 0, N'Hai dàn lạnh độc lập ngăn lẫn mùi giữ thực phẩm tươi ngon', N'Tủ lạnh Samsung Inverter 360 lít RT35K5982BS/SV là sản phẩm được ra mắt trong năm 2018 với thiết kế ngăn đá trên và ngăn lạnh bên dưới khá quen thuộc với thị trường Việt Nam', N'-EQJ940.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, 6, N'Tủ lạnh Aqua 143L AQR-T150FA(BS)', 3990000.0000, N'AQR-T150FA(BS)', 78, 1, N'Việt Nam', 0, N'Dung tích: 143 Lít', N'Tủ lạnh Aqua 143 lít AQR-T150FA(BS) sở hữu gam màu đen huyền bí, sang trọng, kiểu dáng khá nhỏ gọn, tiết kiệm diện tích, cho phép bạn dễ dàng bố trí ở bất kì đâu trong nhà', N'tu-lanh-aqua-143l-aqrt150fabs-Om67OR.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, 6, N'Tủ lạnh Aqua Inverter 205L AQR-T219FA(PB)', 5190000.0000, N'AQR-T219FA(PB)', 54, 1, N'Việt Nam', 0, N'Dung tích: 205 Lít', N'Tủ lạnh Aqua Inverter 205L AQR-T219FA(PB) mang gam màu đen huyền bí, mạnh mẽ sẽ là điểm nhấn mang đến sự sang trọng cho không gian nội thất', N'-u3154j.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, 6, N'Tủ lạnh Aqua AQR-IG248EN - 249L Inverter', 24900000.0000, N'AQR-IG248EN', 12, 1, N'Việt Nam', 0, N'Chức năng diệt khuẩn và khử mùi DEO Fresh', N'Mặt kính dễ vệ sinh, viền cửa độc đáo. Tay cầm ẩn tiện lợi, tiết kiệm tối đa diện tích nhà bạn. ', N'-Mt86xJ.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (9, 6, N'Tủ lạnh 4 cánh Inverter AQUA AQR-IG525AM/GB - 516 Lít', 21000000.0000, N'AQR-IG525AM/GB', 123, 1, N'Trung Quốc', 0, N'Dung tích sử dụng lớn 456 lít thích hợp cho không gian bếp rộng thoáng', N'Tủ lạnh Aqua Inverter 516 lít AQR-IG525AM GB sở hữu thiết kế sang trọng tinh tế với bề mặt phẳng bằng chất liệu kính sáng bóng tạo nên sự lịch lãm cho không gian bếp nhà bạn.', N'-sAyvRe.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (10, 6, N'Tủ lạnh Hitachi FG480PGV8 (GBW) - 366L Inverter', 10900000.0000, N'FG480PGV8 (GBW)', 40, 1, N'Việt Nam', 0, N'Chế độ tiết kiệm điện: Cảm biến nhiệt kép ECO', N'Tủ lạnh Hitachi R-FG480PGV8 (GBW) 366L có thiết kế hiện đại với cửa tủ mặt gương sang trọng, đẹp mắt cùng tay cầm được mạ sáng bóng', N'tu-lanh-hitachi-fg480pgv8-gbw-366l-inverter-Nkc54n.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (11, 6, N'Tủ lạnh LG Side by side 613 lít GR-B247JDS Inverter Linear', 24500000.0000, N'GR-B247JDS', 78, 1, N'Trung Quốc', 0, N'Công nghệ làm lạnh đa chiều giúp khí lạnh đến từng ngóc ngách bên trong tủ.', N'Tủ lạnh LG GR-B247JDS đến từ thương hiệu LG là một chiếc tủ lạnh dòng side by side 2 cửa lớn, với thiết kế sang trọng, đẳng cấp sẽ làm nổi bật không gian nội thất của gia đình bạn', N'-l5r2wP.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (12, 6, N'Tủ lạnh Side by side Midea MRC-690GS 584 Lít', 17990000.0000, N'MRC-690GS', 12, 1, N'Trung Quốc', 0, N'Hệ thống làm lạnh mới cho hơi lạnh lan tỏa đều khắp tủ.', N'Tủ lạnh Midea 530 lít MRC-690GS có thiết kế mặt gương màu đen sáng bóng, sang trọng', N'-no9HX0.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (13, 6, N'Tủ lạnh 4 cánh Sharp SJ-FX631V-SL 626 Lít, J-Tech Inverter', 30000000.0000, N'SJ-FX631V-SL', 75, 1, N'Trung Quốc', 0, N'Khử mùi Nano Bạc - Đồng', N'Tủ Lạnh SHARP Inverter 626 Lít SJ-FX631V-SL Với thiết kế sản phẩm tủ lạnh 4 cửa tinh tế và hiện đại, màu sắc thể hiện trang nhã, không gian nội thất nhà bạn sẽ trở nên sang trọng và đẳng cấp hơn bao giờ hết.', N'-cwVNea.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (14, 6, N'Tủ lạnh Hitachi FG450PGV8 (GBK) - 339L Inverter', 14200000.0000, N'FG450PGV8 (GBK)', 91, 1, N'Trung Quốc', 0, N'Làm lạnh nhanh chóng, đồng đều với công nghệ làm lạnh Air Jet Flow', N'Tủ lạnh Hitachi Inverter 339 lít R-FG450PGV8 GBK mang kiểu dáng 2 cửa, ngăn đá trên truyền thống kết hợp cùng gam màu đen lịch lãm sẽ làm hài lòng những vị gia chủ yêu thích nét đẹp cổ điển nhưng không kém phần sang trọng', N'tu-lanh-hitachi-fg450pgv8-gbk-339l-inverter-T668l5.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (15, 6, N'Tủ lạnh LG 187 lít GN-L205WB Smart Inverter', 5690000.0000, N'GN-L205WB', 12, 1, N'Indodesia', 0, N'Hệ thống khí lạnh đa chiều giúp thực phẩm tươi ngon', N'Kiểu tủ lạnh ngăn đá trên LG Inverter 187L GN-L205WB sở hữu những đường nét được thiết kế tinh tế cùng với gam màu đen sang trọng, ắt hẳn sẽ trở thành điểm nhấn trong không gian nhà bạn.', N'tu-lanh-lg-inverter-187l-gnl205wb-bb0ais.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (16, 6, N'Tủ lạnh LG 209 lít GN-B222WB Smart Inverter', 15000000.0000, N'GN-B222WBK', 35, 1, N'Indodesia', 0, N'Tủ lạnh Inverter tăng cường khả năng tiết kiệm điện cho gia đình.', N'Kiểu tủ lạnh ngăn đá trên LG Inverter 209L GN-B222WB sở hữu những đường nét được thiết kế tinh tế cùng với gam màu đen sang trọng, ắt hẳn sẽ trở thành điểm nhấn trong không gian nhà bạn', N'tu-lanh-lg-inverter-209l-gnb222wb-ETzEhB.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (17, 6, N'Tủ lạnh LG GN-M255PS- 255 Lít Linear Inverter', 15590000.0000, N'RGN-M255PS', 43, 1, N'Indodesia', 0, N'DoorCooling+', N'Tủ lạnh LG Inverter 255 lít GN-M255PS có thiết kế ngăn đá trên đơn giản, truyền thống đi kèm quen thuộc với người tiêu dùng Việt Nam.', N'tu-lanh-lg-gnm255ps-255-lit-linear-inverter-hh7VMS.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (18, 6, N'Tủ lạnh Midea HF-122TTY - 98 Lít', 20000000.0000, N'ZHF-122TTY', 78, 1, N'Trung Quốc', 0, N'Tổng dung tích: 93 lít', N'Tủ lạnh Midea HS-122TTY có thiết kế nhỏ gọn, đơn giản nhưng không kém phần hiện đại', N'-xHA5I9.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (19, 6, N'Tủ lạnh Toshiba 180L Inverter GR-B22VU(UKG)', 16590000.0000, N'SGR-B22VU(UKG)', 123, 1, N'Thái Lan', 0, N'Tiết kiệm điện, tủ êm ái với công nghệ biến tần Inverter', N'Với kiểu tủ ngăn đá trên, chiếc tủ lạnh Toshiba Inverter 180 lít GR-B22VU UKG được thiết kế nhỏ gọn nhưng vẫn toát lên vẻ đẹp hiện đại bởi tông màu đen tuyền sang trọng. Dễ dàng đặt ở bất kì vị trí nào trong nhà, từ phòng khách đến phòng bếp.', N'-Oj0NeV.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (20, 6, N'Tủ lạnh Toshiba 253L Inverter GR-B31VU(UKG)', 19990000.0000, N'GR-B31VU(UKG)', 123, 1, N'Thái Lan', 0, N'Kháng khuẩn và khử mùi mạnh mẽ với công nghệ Ag+ Bio', N'Thuộc dòng tủ lạnh ngăn đá trên, kết hợp với gam màu đen đậm sang trọng, huyền bí, chiếc tủ lạnh Toshiba Inverter 253 lít GR-B31VU UKG hứa hẹn sẽ trở thành điểm nhấn nổi bật, tinh tế cho không gian nội thất của gia đình.', N'-1acEuA.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (21, 3, N'Điều hòa LG Inverter 1 chiều 9000BTU (1HP) V10ENW DUALCOOL', 8890000.0000, N'CS-N9WKH-8M', 10, 12, N'Thái Lan', 0, N'Công nghệ Dual Cool Inverter Tiết kiệm điện năng', N'Điều hòa LG Inverter V10ENW có thiết kế bên ngoài đơn giản, đi cùng sắc trắng trung tính sẽ dễ dàng kết hợp với bất kỳ không gian nội thất nào. Với công suất làm lạnh hơn 9000 BTU, máy lạnh là sự lựa chọn lý tưởng cho phòng dưới 15 m2.', N'-42IrR0.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (22, 3, N'Điều hòa Daikin 1 chiều Inverter 8.500BTU FTKA25VMVMV', 7990000.0000, N'SC-12TL32', 20, 12, N'Malaysia', 0, N'Lọc sạch không khí với màng lọc Enzymblue hoặc PM 2.5 (tuỳ chọn).', N'Tấm lưới lọc Enzyme blue được trang bị sẵn trên dòng FTKA NĂM 2021 (tùy chọn) giúp loại bỏ mùi khó chịu, chất gây dị ứng, ức chế sự phát triển của một số virus và vi khuẩn, mang đến bầu không khí mát lành và thoáng sạch trong khi sử dụng.', N'dieu-hoa-daikin-1-chieu-inverter-8500btu-ftka25vmvmv-d94QaV.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (23, 3, N'Điều hòa Samsung 1 chiều Inverter 12000BTU AR13TYHYCWKNSV', 7000000.0000, N'GWC09PB-K3D0P4', 10, 12, N'Trung Quốc', 0, N'Công suất: 12000BTU, Công nghệ Inverter', N'Công nghệ Digital Inverter Boost ưu việt giúp tiết kiệm điện năng hiệu quả lên đến 77%* và duy trì ổn định nhiệt độ mong muốn. Với nam châm neodymium và bộ giảm âm kép Twin Tube Muffler, máy hoạt động yên tĩnh, êm ái và bền lâu.', N'dieu-hoa-samsung-1-chieu-inverter-12000btu-ar13tyhycwknsv-CR4Or3.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (24, 3, N'Điều hòa Daikin 1 chiều Inverter 11.900BTU FTKA35VMVMV', 8000000.0000, N'MSMA3-10CRN1', 20, 36, N'Việt Nam', 0, N'Luồng gió thoải mái Coanda mang đến sự mát lạnh dễ chịu.', N'Máy lạnh Daikin Inverter 1.5 HP FTKA35VMVMV có thiết kế độc đáo với một góc cong ở cửa thổi gió, tạo ra những luồng gió theo hiệu ứng Coanda mang lại sự thoải mái dễ chịu.', N'dieu-hoa-daikin-1-chieu-inverter-11900btu-ftka35vmvmv-ZIWTv2.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (25, 3, N'Điều hòa Midea 1 chiều 9000BTU MSAFC-10CRN8', 9000000.0000, N'AMSAFC-10CRN8', 10, 24, N'Thái Lan', 0, N'Công suất: 9000BTU', N'Máy lạnh Midea 1 HP MSAF-10CRN8 có thiết kế nhỏ gọn nhưng không kém phần thanh lịch và tinh tế, hứa hẹn sẽ làm hài lòng bất kì vị gia chủ khó tính nào. Bên cạnh đó, chiếc máy lạnh Midea 1 HP này còn là sự lựa chọn vô cùng lý tưởng cho những căn phòng dưới 15 m2', N'dieu-hoa-midea-1-chieu-9000btu-msafc10crn8-mxj6Qb.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (26, 3, N'Điều hòa Samsung 1 chiều Inverter 9400BTU AR10TYHYCWKNSV', 9000000.0000, N'AR10TYHYCWKNSV', 10, 24, N'Thái Lan', 0, N'Công suất: 9400BTU, Công nghệ Inverter', N'Điều hòa Samsung 1 chiều Inverter 9400BTU AR10TYHYCWKNSV sở hữu công nghệ Digital Inverter Boost ưu việt giúp tiết kiệm điện năng hiệu quả lên đến 73%* và duy trì ổn định nhiệt độ mong muốn', N'dieu-hoa-samsung-1-chieu-inverter-9400btu-ar10tyhycwknsv-x5p3EH.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (27, 3, N'Điều hòa Samsung Wind-Free 1 chiều Inverter 12000BTU AR13TYGCDWKNSV', 9000000.0000, N'AR13TYGCDWKNSV', 10, 24, N'Thái Lan', 0, N'Công suất:  12000BTU, Công nghệ Inverter', N'Hơn hẳn điều hòa thông thường, ngoài hiệu quả làm lạnh nhanh chóng, điều hòa Samsung WindFree™ còn có thêm lựa chọn chế độ làm lạnh WindFree™ không gió buốt thổi trực tiếp.', N'dieu-hoa-samsung-windfree-1-chieu-inverter-12000btu-ar13tygcdwknsv-8CN26y.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (28, 3, N'Điều hòa Gree 1 chiều Inverter 9000BTU GWC09PB-K3D0P4', 9000000.0000, N'AGWC09PB-K3D0P4', 10, 24, N'Trung Quốc', 0, N'Công suất: 9000BTU', N'Lấy tông màu tổng thể trắng tinh tế đi cùng điểm nhấn thiết kế truyền thống, vuông vắn nhưng lại nhỏ gọn, chiếc điều hòa Gree 9000btu Inverter GWC09PB-K3D0P4 hứa hẹn sẽ mang lại vẻ tươi mới cho không gian nội thất.', N'-YhjWlK.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (29, 3, N'Điều hòa Gree 1 chiều 9000BTU GWC09KB-K6N0C4', 9000000.0000, N'AGWC09KB-K6N0C4', 10, 24, N'Trung Quốc', 0, N'Làm lạnh căn phòng tức thì với chế độ làm lạnh nhanh Turbo.', N'Điều hòa Gree 9000 btu GWC09KB-K6N0C4 là một thiết kế mới của Gree vừa được ra mắt năm đầu 2020', N'-9ZWE58.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (30, 3, N'Điều hòa Samsung Wind-Free 1 chiều Inverter 9400BTU AR10TYGCDWKNSV', 9000000.0000, N'AR10TYGCDWKNSV', 10, 24, N'Thái Lan', 0, N'Công nghệ Kháng khuẩn, lọc bụi mịn và virus 99%, chống nấm mốc hiệu quả cùng bộ lọc TriCare.', N'Chỉ với 1 thao tác trên remote đơn giản, phòng sẽ nhanh chóng đạt nhiệt độ mát lạnh tối ưu hoặc thổi khí lạnh nhẹ nhàng qua 23.000 lỗ nhỏ, hạn chế gió thổi trực tiếp mà vẫn duy trì nhiệt độ mong muốn của người dùng.', N'dieu-hoa-samsung-windfree-1-chieu-inverter-9400btu-ar10tygcdwknsv-J2o7n5.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (31, 3, N'Điều hòa Gree 1 chiều 12000BTU GWC12KC-K6N0C4', 9000000.0000, N'AGWC12KC-K6N0C4', 10, 24, N'Trung Quốc', 0, N'Công suất: 12000BTU', N'Điều hòa Gree 1C 12000BTU GWC12KC-K6N0C4 là một thiết kế mới của Gree vừa được ra mắt năm đầu 2020', N'-wsqGqV.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (32, 3, N'Điều hòa Sharp 1 chiều Inverter 12000BTU AH-X12XEW', 9000000.0000, N'AAH-X12XEW', 10, 24, N'Thái Lan', 0, N'Công suất: 12000BTU, Công nghệ Inverter', N'Máy lạnh Sharp Inverter 1.5 HP AH-X12XEW sở hữu cho những nét thiết kế cứng cáp mạnh mẽ, cùng với tông màu trắng thanh lịch tinh tế', N'-7oiE1K.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (33, 3, N'Điều hòa 1 chiều Inverter 12000BTU Panasonic CS-PU12WKH-8M', 9000000.0000, N'ACS-PU12WKH-8M', 10, 24, N'Malaysia', 0, N'Công nghệ Inverter và eco tích hợp AI giúp tiết kiệm điện tối đa và hơi lạnh lan tỏa đều.', N'Hệ thống lọc không khí Nanoe-G độc quyền của máy lạnh Panasonic Inverter có hiệu quả vượt trội đáng mong đợi', N'dieu-hoa-1-chieu-inverter-12000btu-panasonic-cspu12wkh8m-Z1di8P.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (34, 3, N'Điều hòa 1 chiều Inverter Sharp AH-XP10WMW 9.000BTU', 9000000.0000, N'AAH-XP10WMW', 10, 24, N'Thái Lan', 0, N'Tiết kiệm điện lên đến 65% nhờ công nghệ J-Tech Inverter và chế độ Eco.', N'Điều hòa Sharp Inverter 9000BTU AH-XP10WMW có thiết kế truyền thống với màu trắng quen thuộc nhưng vẫn tạo nên sức hút nhờ những đường cắt góc  cạnh mạnh mẽ. Công suất 9000BTU phù hợp với những căn phòng có diện tích từ dưới 15m2', N'-SuqEgV.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (35, 3, N'Điều hòa Daikin 1 chiều 9000BTU ATF25UV1V', 9000000.0000, N'AATF25UV1V', 10, 24, N'Thái Lan', 0, N'Làm mát nhanh giúp nhanh chóng mang đến không khí mát lạnh.', N'Điều hòa Daikin 1 chiều 9000BTU ATF25UV1V được lắp ráp tại Thái Lan, với thiết kế nhỏ gọn cộng với tông màu trắng tạo sự sang trọng tinh tế. Làm nổi bật lên nội thất không gian phòng.', N'-leFDVW.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (36, 3, N'Điều hòa Panasonic 1 chiều 9000BTU CS-N9WKH-8M', 9000000.0000, N'ACS-N9WKH-8M', 10, 24, N'Malaysia', 0, N'Công suất: 9000BTU', N'Nhờ có bộ lọc Nanoe - G, máy lạnh Panasonic CU/CS-N9WKH-8M có khả năng loại bỏ bụi mịn (PM2.5) giúp không khí trong lành hơn, bảo vệ sức khỏe cho bạn và cả gia đình trong suốt thời gian sử dụng', N'dieu-hoa-panasonic-1-chieu-9000btu-csn9wkh8m-wH2k4X.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (37, 3, N'Điều hòa Daikin 1 chiều 12.000BTU ATF35UV1V', 9000000.0000, N'ATF35UV1V', 10, 24, N'Thái Lan', 0, N'Chế độ hoạt động ban đêm hạn chế tình trạng quá lạnh, giúp bạn ngủ sâu, ngon giấc.', N'Điều hòa Daikin 1 chiều 12.000BTU ATF35UV1V là sản phẩm mới nhất từ thương hiệu máy lạnh nổi tiếng của Nhật Bản, được thiết kế đơn giản, mang sắc trắng tinh tế phù hợp với mọi không gian nội thất.', N'-RbIWBJ.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (38, 3, N'Điều hòa LG Inverter 2 chiều 9000BTU (1HP) B10END DUALCOOL', 9000000.0000, N'AB10END', 10, 24, N'Thái Lan', 0, N'Dual Inverter Compressor - làm lạnh nhanh hơn 40%, vận hành siêu êm, siêu tiết kiệm điện.', N'Điều hòa 2 chiều LG Inverter 9.200 BTU B10END không chỉ sở hữu thiết kế thanh lịch, tinh tế đặc trưng của LG mà còn được trang bị màn hình hiển thị nhiệt độ trên dàn lạnh giúp bạn dễ dàng biết được nhiệt độ phòng hiện đang là bao nhiêu.', N'-10U4Z8.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (39, 3, N'Điều hòa 2 chiều Midea MSMA1-10HRN1 9.000 BTU', 9000000.0000, N'AMSMA1-10HRN1', 10, 24, N'Việt Nam', 0, N'2 chiều - 9.000BTU (1HP) - gas R410a', N'Máy điều hòa Midea 2 chiều 9000BTU MSMA1-10HRN1 sản phẩm mới năm 2018 với thiết kế và kiểu dáng hoàn toàn mới mang lại sự tinh tế và sang trọng cho người tiêu dùng.', N'-3y83fS.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (40, 3, N'Điều hòa Asanzo 1 chiều 12000BTU S12N66', 9000000.0000, N'S12N66A', 10, 24, N'Việt Nam', 0, N'Công suất: 12000BTU, Điều hòa thường', N'Điều hòa Asanzo 1 chiều 12000BTU S12N66 sở hữu những đường nét thiết kế mạnh mẽ và tông màu trắng sang trọng phù hợp với nhiều phong cách nội thất khác nhau, đi kèm với đó là công suất 1 HP phù hợp với những căn phòng có diện tích 15-20m2.', N'dieu-hoa-asanzo-1-chieu-12000btu-s12n66-nX3zy6.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (41, 8, N'Quạt cây cao cấp 5 cánh Coex CF-7315', 690000.0000, N'CW-7210', 100, 24, N'Trung Quốc', 0, N'Quạt làm mát nhanh, ít tốn điện với công suất 50 W.', N'Thiết kế nhỏ gọn, sang trọng và đẹp mắt. Quạt mang đến sự an toàn khi sử dụng và giúp tiết kiệm không gian sinh hoạt cho gia đình bạn.', N'-262lC5.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (42, 8, N'Quạt cây cao cấp 5 cánh Coex CF-7455', 700000.0000, N'CW-7211', 45, 12, N'Trung Quốc', 0, N'Công suất 50W kết hợp 5 cánh quạt, đường kính 50cm cho gió mát, thổi xa hơn.', N'Quạt cây là sản phẩm không thể thiếu trong mỗi gia đình, nhất là mùa hè. ', N'quat-cay-cao-cap-coex-cf7115-MxIz14.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (43, 8, N'Quạt treo tường Coex CW-7210', 500000.0000, N'CW-7212', 12, 12, N'Malaysia', 0, N'5 cánh quạt đường kính 40cm, làm mát nhanh', N'Quạt treo tường Coex CW-7210 có thiết kế nhỏ gọn, sang trọng và đẹp mắt. Quạt mang đến sự an toàn khi sử dụng và giúp tiết kiệm không gian sinh hoạt cho gia đình bạn.', N'quat-treo-tuong-coex-cw7210-17XRkL.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (44, 8, N'Quạt treo tường Coex CW-7210A - Điều khiển từ xa', 400000.0000, N'CW-7213', 32, 12, N'Trung Quốc', 0, N'Quạt làm mát nhanh, ít tốn điện với công suất 50 W.', N'Quạt treo tường Coex CW-7210A có thiết kế nhỏ gọn, sang trọng và đẹp mắt. Quạt mang đến sự an toàn khi sử dụng và giúp tiết kiệm không gian sinh hoạt cho gia đình bạn.', N'-Oem2Fj.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (45, 8, N'Quạt cây Midea FS40-11V 50W', 650000.0000, N'CW-7214', 43, 24, N'Thái Lan', 0, N'Công suất 50W, 3 cánh quạt sải dài 38 cm có khả năng làm mát cao.', N'Quạt đứng Midea FS40-11V sở hữu thiết kế hiện đại, màu sắc trang nhã, chất liệu nhựa cao cấp ít bám bụi, dễ lau chùi, vệ sinh.', N'quat-cay-midea-fs4011v-l3j80T.jpg', CAST(N'2021-07-26' AS Date), 0, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (46, 8, N'Quạt trần 5 cánh Mitsubishi C56-RW5 SF xám nhạt', 750000.0000, N'CW-7215', 54, 12, N'Trung Quốc', 0, N' 5 cấp độ vận hành, Chế độ gió tự nhiên, hẹn giờ tắt (1-3-6h)', N'Quạt trần 5 cánh Mitsubishi C56-RW5 SF trang bị điều khiển từ xa. Nhờ đó bạn dễ dàng điều khiển quạt hơn, bạn không cần phải ra tận hộp số mà vẫn có thể chỉnh quạt theo ý mình.', N'quat-tran-5-canh-mitsubishi-c56rw5-sf-xam-nhat-unaBcO.png', CAST(N'2021-07-26' AS Date), 0, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (47, 8, N'Quạt cây Toshiba Inverter DC F-LSD10(H) - Có điều khiển', 850000.0000, N'CW-7216', 65, 24, N'Việt Nam', 0, N'Quạt có đến 9 cánh, công suất 30 W, làm mát hiệu quả.', N'Quạt cây Toshiba Inverter F-LSD10(H) trang bị công nghệ DC Inverter tiết kiệm đến 70% điện năng, sử dụng an toàn và bền bỉ theo thời gian.', N'quat-cay-toshiba-inverter-dc-flsd10h-co-dieu-khien-7f6pI3.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (48, 8, N'Quạt lửng Midea FTS40-17VD', 100000.0000, N'CW-7217', 43, 12, N'Việt Nam', 0, N'Quạt lửng 3 cánh, công suất 45W', N'Quạt lửng Midea FTS40-17VD màu sắc trang nhã sẽ là một điểm nhấn cho phòng khách, bàn làm việc, góc học tập hay phòng ngủ… Có Midea FTS40-17VD bạn yên tâm hơn khỏi lo trời nóng.', N'quat-lung-midea-fts4017vd-5XUrrb.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (49, 8, N'Quạt hộp Midea FB40-9H', 200000.0000, N'CW-7218', 12, 24, N'Trung Quốc', 0, N'Motor SQD hiệu suất cao, siêu êm, siêu bền', N'Quạt Midea FB40-9H có kiểu dáng đơn giản phù hợp với nhiều không gian', N'-hFl4Zk.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (50, 8, N'Quạt lửng Senko L1638/LL1338-thân nhựa', 120000.0000, N'CW-7219', 43, 12, N'Thái Lan', 0, N'Thiết kế gọn nhẹ, dễ di chuyển vị trí của quạt khi sử dụng', N'Quạt lửng Senko LL1338 có màu sắc tươi tắn, vỏ ngoài bằng chất liệu nhựa có độ bền cao, lau chùi dễ dàng. Quạt có 3 cánh giúp tạo gió nhanh và tốt hơn cho bạn cảm thấy dễ chịu và mát mẻ, chân đế chắc chắn giữ quạt tốt.', N'-zD9Y1J.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (51, 8, N'Quạt treo tường Senko TC16', 200000.0000, N'CW-7220', 54, 12, N'Trung Quốc', 0, N'Công suất 50W', N'Quạt có kiểu dáng đơn giản, dễ tháo rời và lắp ráp, chất liệu sắt và nhựa cao cấp rất chắc chắn, khi treo trên tường ít bị rung lắc', N'-E68MUw.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (52, 8, N'Quạt treo tường Midea FW40-15VFR - Có điều khiển', 350000.0000, N'CW-7221', 8, 24, N'Trung Quốc', 0, N'Quạt treo tường 3 cánh, 3 tốc độ gió, công suất 45W', N'Quạt treo tường Midea FW40-15VFR sử dụng tiện lợi, an toàn, làm mát mọi không gian sống nhanh chóng, giá cả tốt, thích hợp với người tiêu dùng Việt.', N'-2Tdi78.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (53, 8, N'Quạt cây Midea FS40-15QR có điều khiển', 300000.0000, N'CW-7222', 12, 12, N'Trung Quốc', 0, N' Đường kính cánh quạt dài 40 cm, công suất 55 W cho khả năng làm mát cao.', N'Chế độ hẹn giờ tắt thông minh, điều khiển từ xa hiện đại.', N'quat-cay-midea-fs4015qr-co-dieu-khien-T5nX9b.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (54, 8, N'Quạt lửng Senko LS103/LS1630-ống sắt', 400000.0000, N'CW-7223', 54, 24, N'Thái Lan', 0, N'Công suất 47W./ Đường kính cánh quạt: 40 cm', N' Quạt lửng Senko LS103 có kích thước nhỏ gọn giúp việc di chuyển và bảo quản trở nên tiện lợi, dễ dàng. Senko LS103 thiết kế màu xanh trẻ trung, sang trọng của sản phẩm giúp không gian ngôi nhà bạn trở nên sáng sủa, đẹp mắt hơn.', N'-0z8b38.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (55, 8, N'Quạt cây Điện cơ QD400X-MS - Có điều khiển', 500000.0000, N'CW-7224', 123, 12, N'Trung Quốc', 0, N'Tích hợp điều khiển từ xa, thuận tiện điều chỉnh tốc độ gió', N'Quạt cây Điện cơ QD400X-MS có điều khiển từ xa là dòng quạt được sản xuất bởi công ty Điện cơ thống nhất, với 3 tốc độ gió. Đây là dòng quạt bán chạy nhất trên thị trường bởi kiểu dáng thiết kế sang trọng, chất lượng tốt, giá cả hợp lý', N'quat-dung-dien-co-qd400xms-co-dk-99YTtV.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (56, 8, N'Quạt cây Điện cơ QD450-DM', 400000.0000, N'CW-7225', 54, 24, N'Thái Lan', 0, N' Tốc độ quay: 1200 vòng/ phút', N'Quạt đứng Vinawind QĐ450-ĐM có thiết kế đơn giản, gọn đẹp, màu sắc trang nhã, mang lại vẻ đẹp hiện đại, phù hợp với nhiều không gian nội thất.', N'quat-dung-dien-co-qd450dm-MAhn2p.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (57, 8, N'Quạt treo tường Midea FW40-15VF', 350000.0000, N'CW-7226', 23, 12, N'Trung Quốc', 0, N'Quạt treo Midea 3 tốc độ gió phù hợp với nhiều nhu cầu sử dụng.', N'Quạt treo tường Midea FW40-15VF 3 cánh trong suốt, kiểu dáng đơn giản nhưng không kém phần tinh tế. Phù hợp với mọi không gian nhà. ', N'-0vSfZi.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (58, 8, N'Quạt treo tường Midea FW40-7JR', 100000.0000, N'CW-7227', 43, 24, N'Việt Nam', 0, N'Chế độ hẹn trong 7.5 giờ, thích hợp khi ngủ', N'Quạt treo tường có đk FW40-7JR có 3 tốc độ gió: tốc độ gió bình thường, tốc độ gió tự nhiên và tốc độ gió khi ngủ để bạn chọn.', N'-8G4Nla.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (59, 8, N'Quạt treo tường Midea FW40-6H', 200000.0000, N'CW-7228', 54, 12, N'Việt Nam', 0, N'Quạt treo tưởng 3 tốc độ gió đáp ứng nhu cầu làm mát khác nhau.', N'Quạt treo tường Midea FW406H có thiết kế treo tường, kiểu dáng nhỏ gọn không chiếm nhiều diện tích, thích hợp với mọi không gian sử dụng.', N'quat-treo-tuong-midea-fw406h-9calXg.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (60, 8, N'Quạt hộp Midea KYT30-15A', 500000.0000, N'CW-7229', 23, 24, N'Trung Quốc', 0, N'Quạt thiết kế sang trọng, công suất 40 W, làm mát nhanh.', N'Quạt Hộp Midea KYT3015A được thiết kế thời trang với dạng hộp nhỏ gọn, màu sắc phù hợp với nhiều không gian sống khác nhau.', N'-8qxdFA.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (61, 4, N'Dàn âm thanh Soundbar Sony HT-S20R//C', 400000.0000, N'CT-7200', 23, 12, N'Việt Nam', 0, N'Phát lại USB và sạc điện thoại thông minh', N'Chọn chỗ ngồi thoải mái trong căn phòng của bạn. Dàn âm thanh Sony với công nghệ Dolby® Digital, Surround Sound công suất lên tới 400W sẽ đem đến trải nghiệm hoàn hảo nhất cho bạn.', N'-l1E444.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (62, 4, N'Dàn âm thanh Sound bar Sony HT-S350//M 2.1 CH', 230000.0000, N'CT-7201', 43, 12, N'Thái Lan', 0, N'Loa thanh soundbar có kiểu dáng hiện đại, thanh lịch, hài hoà không gian.', N'Dàn âm thanh Sound bar Sony HT-S350//M 2.1 CH có kiểu dáng gọn gàng, phong cách hiện đại, thích hợp bố trí hài hoà vào nhiều không gian nội thất khác nhau hoặc có thể treo tường hoàn hảo, góp phần tăng thêm nét tinh tế, thanh lịch cho ngôi nhà của bạn.', N'-dVN3Hn.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (63, 4, N'Dàn âm thanh Sony HT-RT3 5.1 CH/ NFC/ Bluetooth', 3000000.0000, N'CT-7202', 12, 12, N'Việt Nam', 0, N'Loa Sound bar Sony HT-RT3 kĩ thuật số', N'Đắm mình trong từng bộ phim với âm thanh vòm 5.1 kênh trung thực của Loa Soundbar Sony HT-RT3', N'-85tbnU.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (64, 4, N'Loa soundbar Samsung HW-T550/XV 2.1ch', 4000000.0000, N'CT-7203', 34, 12, N'Trung Quốc', 0, N'Âm thanh vòm 3D bao trùm mọi giác quan', N'Công nghệ DTS Virtual:X tái tạo hoàn hảo chất âm 3D tuyệt mỹ. Cho bạn trải nghiệm cảm giác sống động và chân thực chưa từng có với âm thanh vòm đỉnh cao từ loa thanh Samsung.', N'-lZ267f.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (65, 4, N'Loa soundbar Samsung HW-T420/XV 2.1ch', 5000000.0000, N'CT-7204', 123, 12, N'Trung Quốc', 0, N'Âm Thanh 2.1ch Chân Thực', N'Với loa thanh 2.1ch kênh và loa siêu trầm 6.5 inch, bạn sẽ cảm nhận trọn vẹn dải âm chất lượng xung quanh với uy lực âm trầm sâu hơn, mạnh mẽ hơn.', N'-iqGg1V.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (66, 4, N'Loa SoundBar LG SL4 2.1 CH', 10000000.0000, N'CT-7205', 43, 12, N'Việt Nam', 0, N'Hi-res Audio đạt 24bit/192kHz.', N'Loa thanh soundbar LG 2.1 SL4 300W có 1 thanh loa và 1 loa trầm Carbon được thiết kế gọn gàng, chắc chắn, đường nét được cắt gọt hoàn hảo, màu đen quý phái tôn vinh mọi không gian bố trí.', N'-OH3zT1.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (67, 4, N'Loa Soundbar Samsung HW-Q600A/XV', 9000000.0000, N'CT-7206', 23, 12, N'Thái Lan', 0, N'Số kênh: 3.1.2 kênh', N'Công suất loa: 360W', N'-1UOnLR.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (68, 4, N'Dàn âm thanh Soundbar Sony HT-S500RF 5.1', 6500000.0000, N'CT-7207', 54, 12, N'Trung Quốc', 0, N'Âm thanh vòm chân thực 5.1 kênh, công suất 1000W', N'Trải nghiệm âm thanh như tại rạp chiếu phim ngay ở nhà nhờ hệ thống âm thanh 5.1 kênh với các loa sau nhỏ gọn có tổng công suất đầu ra 1000 W. Hãy đắm chìm trong khoảnh khắc lay động của âm thanh vòm chân thực.', N'-8JeXeX.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (69, 4, N'Dàn âm thanh Sony HT-S700RF', 15000000.0000, N'CT-7208', 23, 12, N'Trung Quốc', 0, N'Loa cao cho âm thanh ở mức ngang tai', N'Thưởng thức âm thanh như thể bạn đang xem phim ngoài rạp. Hệ thống âm thanh 5.1 kênh kín đáo với loa đứng phía sau và tổng công suất đầu ra 1000 W cho bạn chìm đắm trong sự kỳ diệu của âm thanh vòm đích thực. ', N'-nSxrxZ.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (70, 4, N'Loa soundbar Samsung HW-Q70T/XV 3.1.2 Ch', 20000000.0000, N'CT-7209', 54, 12, N'Việt Nam', 0, N'Công nghệ Q-Symphony đồng bộ hoàn hảo với Samsung TV', N'Loa thanh Samsung đã được điều chỉnh và kiểm nghiệm bởi các kỹ sư hàng đầu thế giới tại phòng nghiên cứu âm thanh California Audio Lab. Thưởng thức chất âm tròn đầy, cân bằng hoàn hảo nhờ công nghệ âm thanh tăng cường và mô hình máy tính tiên tiến.', N'-oQguk0.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (71, 4, N'Dàn âm thanh Sony HT-S700RF', 14000000.0000, N'CT-7210', 23, 12, N'Trung Quốc', 0, N'Tổng công suất đầu ra 1000 W ', N'Thưởng thức âm thanh như thể bạn đang xem phim ngoài rạp. Hệ thống âm thanh 5.1 kênh kín đáo với loa đứng phía sau và tổng công suất đầu ra 1000 W cho bạn chìm đắm trong sự kỳ diệu của âm thanh vòm đích thực. ', N'-nSxrxZ (1).jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (72, 4, N'Loa soundbar Samsung HW-Q70T/XV 3.1.2 Ch', 13000000.0000, N'CT-7211', 64, 12, N'Thái Lan', 0, N'Công nghệ Q-Symphony đồng bộ hoàn hảo với Samsung TV', N'Loa thanh Samsung đã được điều chỉnh và kiểm nghiệm bởi các kỹ sư hàng đầu thế giới tại phòng nghiên cứu âm thanh California Audio Lab. Thưởng thức chất âm tròn đầy, cân bằng hoàn hảo nhờ công nghệ âm thanh tăng cường và mô hình máy tính tiên tiến.', N'-K6NU44.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (73, 4, N'Loa SoundBar LG SN5R 4.1 CH', 15000000.0000, N'CT-7212', 234, 12, N'Thái Lanc', 0, N'TV và Loa thanh trở thành trung tâm điều khiển của bạn', N'Cảm nhận sự khác biệt với không gian ngập tràn âm thanh 3D. Loa thanh LG SN5R kết hợp với DTS Virtual:X biến ngôi nhà của bạn thành rạp hát tại gia, giúp bạn có thể đắm chìm vào những bộ phim yêu thích của mình.', N'-XtUa1n.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (74, 4, N'Loa Soundbar Samsung HW-Q700A/XV', 12000000.0000, N'CT-7213', 65, 12, N'Việt Nam', 0, N'Âm thanh đa hướng chân thực từ Dolby Atmos / DTS:X', N'Thưởng thức mọi nội dung với chất âm chân thực và sống động xung quanh mình, cùng độ sâu âm thanh hoàn hảo nhờ công nghệ Dolby Atmos & DTS:X.', N'-12lgF3.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (75, 4, N'Loa soundbar Samsung HW-Q60T/XV 5.1ch', 4000000.0000, N'CT-7214', 234, 12, N'Indonesia', 0, N'Truyền tải đồng bộ âm thanh với Samsung Acoustic Beam', N'Loa thanh Samsung đã được điều chỉnh và kiểm nghiệm bởi các kỹ sư hàng đầu thế giới tại phòng nghiên cứu âm thanh California Audio Lab. Thưởng thức chất âm tròn đầy, cân bằng hoàn hảo nhờ công nghệ âm thanh tăng cường và mô hình máy tính tiên tiến.', N'-Ho54Xq.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (76, 4, N'Loa Soundbar Sony HT-CT390 2.1 CH/ NFC/ Bluetooth', 35000000.0000, N'CT-7215', 54, 12, N'Trung Quốc', 0, N'Hệ thống loa 2.1 CH (kênh)', N'Công suất đầu ra 300W mang lại không gian âm nhạc sôi động, trong khi loa subwoofer không dây sẽ điểm thêm chiều sâu bằng những âm bass vang dội.', N'-R664e6.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (77, 4, N'Loa Soundbar 2.0 TCL TS7000T 160W', 30000000.0000, N'CT-7216', 234, 12, N'Việt Nam', 0, N'Công nghệ âm thanh: Dolby digital', N'Loa thanh TS 7000 với chiều dài 920mm được trang bị 4 loa tích hợp, công suất 160W cùng đèn LED đa sắc và thanh menu điều chỉnh ngay phía trên thân máy. ', N'loa-soundbar-tcl-ts7000-pIycJ7.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (78, 4, N'Loa Sound Bar Fenda T-160X', 10000000.0000, N'CT-7217', 54, 12, N'Trung Quốc', 0, N'Kết nối không dây Bluetooth giúp thoải mái phát nhạc từ thiết bị di động một cách nhanh chóng.', N'Loa Soundbar Fenda T-160X có kiểu dáng hình chữ nhật, thiết kế thời trang cùng với kiểu dáng bắt mắt, hiện đại mang lại tính thẩm mỹ cao', N'loa-sound-bar-fenda-t160x-iS4DbQ.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (79, 4, N'Dàn âm thanh Sound bar Sony HT-X8500/M 2.1', 12000000.0000, N'CT-7218', 234, 12, N'Thái Lan', 0, N'Loa Dolby Atmos/DTS:X 2.1 kênh với Vertical Surround Engine', N'Cho dù bạn đang ở phòng nào đi nữa, công nghệ DSP chỉ cần hai loa trước để tái hiện âm thanh xung quanh bạn trọn vẹn như ở rạp chiếu phim, bao gồm cả những âm thanh phía trên. ', N'-j1qzD6.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (80, 4, N'Loa Soundbar Samsung HW-Q950A/XV', 13000000.0000, N'CT-7219', 234, 12, N'Trung Quốc', 0, N'Thưởng thức sắc âm chuẩn 11.1.4CH', N'Công suất loa: 616W', N'loa-soundbar-samsung-hwq950axv-K7o60v.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (81, 5, N'Máy giặt 9 Kg Electrolux EWF9025BQSA Inverter', 12990000.0000, N'EWF9025BQSA', 24, 0, N'Thái Lan', 24, N'Máy giặt cửa trước màu bạc sang trọng, hiện đại.', N' Máy giặt Electrolux Inverter 9 Kg EWF9025BQSA với kiểu dáng cửa trước cùng sắc bạc sang trọng, hiện đại và viền cửa chrome bóng bẩy sẽ là điểm nhấn cho không gian nội thất của gia đình.', N'may-say-samsung-9kg-dv90m5200qwsv-cz60Ty.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (82, 5, N'Máy giặt lồng ngang Samsung Inverterter 9.5Kg WW95TA046AX/S', 13850000.0000, N'WW95TA046AX/SV', 12, 0, N'Việt Nam', 31, N'Công nghệ Inverter tiết kiệm điện', N'Giặt sạch sâu, bảo vệ sợi vải tốt hơn 45% với công nghệ giặt bong bóng siêu mịn EcoBubble', N'may-say-quan-ao-electrolux-edv805jqwa8kg-NYw4HC.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (83, 5, N'Máy giặt 8 Kg Electrolux EWF8025EQWA', 10990000.0000, N'EWF8025EQWA', 11, 1, N'Thái Lan', 28, N'Công nghệ giặt hơi nước giảm thiểu nếp nhăn', N'Máy giặt Electrolux 8 Kg EWF8025EQWA mang kiểu dáng cửa trước kết hợp cùng sắc trắng thanh lịch, tinh tế sẽ là sự lựa chọn hoàn hảo cho những vị gia chủ yêu thích vẻ đẹp tối giản nhưng không kém phần sang trọng.', N'0b953563-f747-4e27-a3a5-d602bab16b89_may-say-8kg-lg-dr-80bw.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (84, 5, N'Máy giặt lồng ngang Samsung Inverter 8,5Kg WW85J42G0BX/SVL', 7190000.0000, N'WW85J42G0BX/SV', 10, 1, N'Việt Nam', 12, N'Công nghệ Inverter giúp tiết kiệm năng lượng hiệu quả', N'Bảo vệ làn da, tránh tác nhân gây dị ứng, giảm nhăn sợi vải nhờ công nghệ giặt hơi nước Steam.', N'may-say-quan-ao-electrolux-edv705hqwa-7kg-4bbLK1.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (85, 5, N'Máy giặt 9 Kg Samsung Addwash WW90K54E0UX/SV hơi nước', 8990000.0000, N'WW90K54E0UX/SV', 15, 1, N'Việt Nam', 34, N'Công nghệ giặt bong bóng Ecobuble chăm sóc quần áo', N'Động cơ bền bỉ, tiết kiệm năng lượngCông nghệ Digital đạt chuẩn châu Âu, giúp tiết kiệm năng lượng tối đa, vận hành bền bỉ vượt trội', N'may-say-quan-ao-co-hoi-nuoc-electrolux-8kg-eds805kqwa-VnA24A.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (86, 5, N'Máy giặt/sấy Electrolux 8.0/5.0Kg EWW8025DGWA', 12990000.0000, N'EWW8025DGWA', 12, 1, N'Việt Nam', 12, N'Máy tích hợp bảng điều khiển song ngữ Anh/Việt có nút xoay, cảm ứng.', N'Máy giặt/sấy Electrolux 8.0/5.0Kg EWW8025DGWA với thiết kế sang trọng và trang nhã sẽ là điểm nhấn nổi bật cho mọi không gian nội thất. ', N'may-say-quan-ao-electrolux-edv805jqsa-8kg-60hoU2.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (87, 5, N'Máy giặt lồng ngang Toshiba Inverter 9,5Kg BK105S3V(SK)', 8790000.0000, N'BK105S3V(SK)', 10, 1, N' Trung Quốc', 0, N'Khối lượng giặt 9,5 Kg Công nghệ Great Waves tiên tiến giặt sạch sâu', N'Máy giặt Toshiba 9.5kg TW-BK105S3V (SK) sở hữu gam màu tối lịch lãm, kết hợp với kiểu dáng cửa trước hiện đại, hứa hẹn sẽ mang đến cho không gian nội thất của gia đình bạn vẻ đẹp sang trọng, tinh tế.', N'-NS5XTf.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (88, 5, N'Máy giặt lồng ngang Toshiba Inverter ', 12790000.0000, N'BK105S3F', 9, 0, N'Trung Quốc', 34, N'Color Care giảm 39% độ phai màu, 45% độ biến dạng đồ giặt', N'Greatwaves sẽ tạo ra sức mạnh siêu sóng để đánh bật các vết bẩn cứng đầu, khó chịu trên từng sợ vải', N'-ZAZs8u.png', CAST(N'2021-07-26' AS Date), 0, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (89, 5, N'NULLMáy giặt AQUA lồng ngang', 11290000.0000, N'QD-D950E', 14, 1, N'Việt Nam', 22, N'Vòng đệm kháng khuẩn ABT diệt khuẩn 99.9%, mối hàn laser bảo vệ quần áo', N'Người dùng sẽ không còn phải bận tâm quá nhiều về chi phí điện năng hằng tháng khi được trang bị công nghệ Inverter cho khả năng vận hành ổn định và tiết kiệm điện vượt trội.', N'may-say-ngung-tu-electrolux-8kg-edc804cewa-rXtA1z.jpg', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (90, 5, N'Máy giặt LG lồng ngang 8kg FM1208N6', 9990000.0000, N'FM1208N6', 12, 1, N'Việt Nam', 23, N'Chế độ giặt 6 chuyển động độc đáo', N'Máy giặt LG FM1208N6W với trang bị khối lượng giặt là 8kg sẽ là sự lựa chọn hàng đầu.', N'may-say-heatpump-samsung-9kg-dv90ta240aesv-J42Fjd.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (91, 5, N'Máy giặt Electrolux 8Kg ', 12990000.0000, N'EWW8025', 13, 1, N'Thái Lan', 0, N'Máy tích hợp bảng điều khiển song ngữ Anh/Việt có nút xoay, cảm ứng và màn hình hiển thị hiện đại', N'Máy giặt Electrolux sẽ là sự lựa chọn lý tưởng cho gia đình 4 - 5 người và giúp hong khô quần áo nhanh chóng vào những ngày mưa, bão', N'may-say-candy-9kg-cs-v9dfs-3rjyXX.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (92, 5, N'Máy sấy Whirlpool 15Kg 3LWED4815FW', 23990000.0000, N'FM1208N6', 12, 1, N'Việt Nam', 23, N'Công suất hoạt động mạnh mẽ 4725W, giặt đồ sạch hơn', N'Máy Sấy WHIRLPOOL 15 Kg 3LWED4815FW sẽ là gợi ý lý tưởng dành cho chị em cho những ngày thời tiết ẩm ương, hay những bạn muốn rút gọn thời gian phơi khô cho áo quần.', N'may-say-whirlpool-15kg-3lwed4815fw-RTzbY9.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (93, 5, N'Máy sấy Whirlpool 15Kg 3LWED4705FW', 9900000.0000, N'FM1UAHUA', 13, 1, N'Việt Nam', 23, N'13 chương trình sấy vô cùng hiện đại và tiện dụng', N'Có 13 chương trình sấy vô cùng hiện đại và tiện dụng', N'may-say-whirlpool-15kg-3lwed4705fw-L9R280.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (94, 5, N'Máy sấy Samsung AI Heatpump 9Kg DV90T7240BH/SV', 9990000.0000, N'FM1208N7', 45, 1, N'Trung Quốc', 23, N'Bộ 3 Cảm Biến Optimal Dry sấy khô đều, bền sợi vải', N'Công nghệ sấy Bơm Nhiệt Heatpump trang bị máy nén sử dụng ga trong môi trường áp suất cao, làm nóng luồng không khí giúp sấy khô áo quần hiệu quả và tiết kiệm tới 50% điện năng*. Sản phẩm đạt chuẩn tiết kiệm năng lượng tốt nhất Châu Âu +++.', N'may-say-samsung-ai-heatpump-9kg-dv90t7240bhsv-tx9xLJ.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (95, 5, N'Máy sấy Heat Pump Electrolux 8Kg EDH803BEWA', 8990000.0000, N'FM1208N8', 34, 1, N'Việt Nam', 23, N'Công nghệ cảm biến thông minh Smart Sensor điều chỉnh thời gian sấy khô để đảm bảo khả năng sấy khô chính xác', N'Các thiết bị cảm biến độ ẩm được kích hoạt 3 lần trong mỗi chu kỳ sấy để tránh tình trạng sấy khô quá mức có thể gây hư hại tới quần áo.', N'-W1l6Z8.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (96, 5, N'Máy sấy Heat Pump Electrolux 9Kg EDH903BEWA', 9990000.0000, N'FM1208N9', 25, 1, N'Trung Quốc', 23, N'Nhiệt độ sấy: 75 độ C', N'<p>GIỚI THIỆU SẢN PHẨM&nbsp;- M&Aacute;Y SẤY HEAT PUMP ELECTROLUX 9KG EDH903BEWA</p>

<h2>Kh&ocirc;ng bị co r&uacute;t, kh&ocirc;ng mất h&igrave;nh dạng của quần &aacute;o</h2>

<p>Hệ thống DelicateCare của d&ograve;ng sản phẩm&nbsp;m&aacute;y sấy nhiệt quần &aacute;o nhiệt ph&acirc;n Electrolux EDH903BEWA&nbsp;gi&uacute;p chu tr&igrave;nh sấy len v&agrave; lụa được kiểm so&aacute;t cẩn thận nhiệt độ v&agrave; c&agrave;i đặt chuyển động để mỗi chu kỳ được điều chỉnh theo c&aacute;c đặc t&iacute;nh độc đ&aacute;o của c&aacute;c loại vải mỏng n&agrave;y.&nbsp;Len được giữ phẳng tr&ecirc;n bề mặt&nbsp; v&agrave; lụa được sấy kh&ocirc; nhẹ nh&agrave;ng.&nbsp;Chất lượng quần &aacute;o của bạn được bảo quản để bảo vệ l&acirc;u hơn chống co ng&oacute;t v&agrave; mất h&igrave;nh dạng.</p>

<p><img src="https://mediamart.vn/Lib/Plugins/LazyLoad/lazy-bg.png" />&nbsp;</p>

<h2>Wifi kết nối để được tư vấn chăm s&oacute;c, theo y&ecirc;u cầu</h2>

<p>Với Ứng dụng Electrolux Life, bạn ho&agrave;n to&agrave;n c&oacute; thể tin rằng quần &aacute;o của bạn sẽ được chăm s&oacute;c đ&uacute;ng c&aacute;ch.&nbsp;Cố vấn chăm s&oacute;c cung cấp sẽ đưa ra hướng dẫn trực quan để hỗ trợ bạn trong việc l&agrave;m sạch tới hơn 48 loại vải v&agrave; 40 loại vết bẩn phổ biến nhất.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10-News/gdhEIWf34g2RW7I.jpg" /></p>

<h2>Giữ g&igrave;n độ bền quần &aacute;o&nbsp;của bạn l&acirc;u hơn</h2>

<p>Hệ thống SensiCare sử dụng c&aacute;c cảm biến nhiệt độ v&agrave; độ ẩm để đảm bảo giữ được độ bền của quần &aacute;o&nbsp;l&acirc;u hơn.&nbsp;Bằng c&aacute;ch điều chỉnh mức ti&ecirc;u thụ năng lượng v&agrave; thời gian chu kỳ theo k&iacute;ch cỡ v&agrave; loại vải, SensiCare gi&uacute;p l&agrave;m giảm hao m&ograve;n bằng c&aacute;ch bảo vệ quần &aacute;o của bạn tr&aacute;nh khỏi việc quần &aacute;o bị qu&aacute; kh&ocirc;.</p>

<p>&nbsp;<img src="https://cdn.mediamart.vn/Upload/download/2019-10-News/0n38Xqav0t7TXeQ.jpg" /></p>

<h2>Giảm đến 32% nếp nhăn&nbsp;</h2>

<p>Việc di chuyển xen kẽ theo chiều kim đồng hồ v&agrave; ngược chiều kim đồng hồ của&nbsp;m&aacute;y sấy quần &aacute;o Electrolux&nbsp;sẽ ngăn kh&ocirc;ng cho quần &aacute;o bị rối, l&agrave;m giảm nếp nhăn &iacute;t hơn tới 32% so với c&aacute;c d&ograve;ng m&aacute;y sấy kh&ocirc;ng kh&iacute; .&nbsp;&Iacute;t nếp gấp hơn c&oacute; nghĩa l&agrave; &iacute;t cần ủi ở nhiệt độ cao, do đ&oacute;, vải sẽ tr&ocirc;ng mới l&acirc;u hơn.</p>

<p>&nbsp;<img src="https://mediamart.vn/Lib/Plugins/LazyLoad/lazy-bg.png" /></p>

<h2>L&agrave;m phai m&agrave;u &iacute;t hơn 80%&nbsp;</h2>

<p>Giữ m&agrave;u vải cho quần &aacute;o của bạn l&acirc;u hơn bằng c&aacute;ch&nbsp;sử dụng&nbsp;m&aacute;y sấy Electrolux UltimateCare.&nbsp;</p>

<p>&nbsp;</p>

<p><strong>Chương tr&igrave;nh Sấy Kh&ocirc; Nhẹ Nh&agrave;ng ( Delicate Drying )</strong></p>

<p>Chương tr&igrave;nh Sấy&nbsp;Kh&ocirc; Nhẹ Nh&agrave;ng&nbsp;tự động giảm nhiệt độ để quần &aacute;o của bạn được sấy kh&ocirc; nhẹ nh&agrave;ng, bảo vệ tối đa độ bền vải quần &aacute;o của bạn.</p>

<p><img src="https://mediamart.vn/Lib/Plugins/LazyLoad/lazy-bg.png" /></p>

<p><strong>Y&ecirc;n tĩnh, bền bỉ, hiệu quả v&agrave; tiết kiệm năng lượng hơn</strong></p>

<p>Động cơ biến tần l&agrave;m giảm độ rung của m&aacute;y sấy để mang lại hiệu quả l&agrave;m kh&ocirc; &ecirc;m &aacute;i, hiệu quả v&agrave; tiết kiệm năng lượng hơn.</p>

<p><img src="https://mediamart.vn/Lib/Plugins/LazyLoad/lazy-bg.png" /></p>

<h2>Bảo quản vải&nbsp;len một c&aacute;ch dễ d&agrave;ng hơn</h2>

<p>M&aacute;y sấy Electrolux UltimateCare EDH903BEWA&nbsp;l&agrave;m kh&ocirc; an to&agrave;n quần &aacute;o len của bạn trong chu tr&igrave;nh được ph&ecirc; duyệt Woolmark của Electrolux.&nbsp;Chương tr&igrave;nh n&agrave;y đ&atilde; được chứng minh l&agrave; chăm s&oacute;c m&aacute;y sấy quần &aacute;o an to&agrave;n&nbsp;với chế độ sấy sạch tối ưu v&agrave; l&oacute;t nỉ tối thiểu.</p>

<p><img src="https://mediamart.vn/Lib/Plugins/LazyLoad/lazy-bg.png" /></p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<h2>Gi&aacute; phơi kh&ocirc; tiện dụng</h2>

<p>Từ nay đồ len, gi&agrave;y v&agrave; đồ chơi b&ocirc;ng kh&ocirc;ng c&ograve;n lo về chỗ phơi đồ v&igrave; m&aacute;y đ&atilde; sẵn gi&aacute; phơi đồ chuy&ecirc;n dụng, tr&aacute;nh khỏi&nbsp;sự lộn xộn mội khi cần t&igrave;m chỗ phơi. Đồ&nbsp;của bạn được l&agrave;m kh&ocirc; đều m&agrave; kh&ocirc;ng c&oacute; thiệt hại về h&igrave;nh dạng hoặc kết cấu.</p>
', N'-cSTvhl.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (97, 5, N'Tủ giặt hấp sấy LG Styler S3WF Linen White (Trắng)', 13000000.0000, N'FMUHS08N6', 22, 1, N'Việt Nam', 23, N'Chăm sóc quần áo với công nghệ hơi nước độc quyền TrureSteam làm giảm nếp nhăn và mùi, làm mới quần áo trong sự thoải mái của nhà bạn', N'<p>GIỚI THIỆU SẢN PHẨM&nbsp;- TỦ GIẶT HẤP SẤY LG STYLER S3WF LINEN WHITE (TRẮNG)</p>

<p><iframe frameborder="0" height="420" scrolling="no" src="https://www.youtube.com/embed/G3G1MsPfuXY?rel=0&amp;autoplay=0" width="745"></iframe></p>

<h3>Loại bỏ nếp nhăn v&agrave; m&ugrave;i kh&oacute; chịu</h3>

<p>Những bộ vest, v&aacute;y, &aacute;o len v&agrave; nhiều loại quần &aacute;o cao cấp kh&aacute;c được chăm s&oacute;c tỉ mỉ chỉ bằng một n&uacute;t bấm. Tr&ocirc;ng bạn sẽ lu&ocirc;n tinh tươm v&agrave; ho&agrave;n hảo nhất. H&atilde;y loại bỏ mọi m&ugrave;i kh&oacute; chịu để quần &aacute;o l&uacute;c n&agrave;o cũng<br />
tươi mới v&agrave; thơm phức!</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/1(1019).JPG" /></p>

<h3>Khử tr&ugrave;ng hiệu quả</h3>

<p>C&aacute;ch xử l&yacute; quần &aacute;o an to&agrave;n! C&ocirc;ng nghệ hơi nước TrueSteam 100% từ nước sạch, kh&ocirc;ng chứa h&oacute;a chất độc hại, gi&uacute;p loại bỏ đến 99,9% vi khuẩn v&agrave; c&aacute;c t&aacute;c nh&acirc;n g&acirc;y dị ứng. Dễ d&agrave;ng vệ sinh vải v&oacute;c v&agrave; c&aacute;c đồ d&ugrave;ng kh&oacute; giặt hoặc kh&ocirc;ng thể giặt.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/2(886).JPG" /></p>

<h3>Chăm s&oacute;c quần &aacute;o bằng hơi nước TrueSteam&trade;</h3>

<p>C&ocirc;ng nghệ TrueSteam&trade; của LG Styler c&ugrave;ng với chuyển động ngang của m&oacute;c treo di chuyển gi&uacute;p hơi nước thẩm thấu s&acirc;u v&agrave;o quần &aacute;o gi&uacute;p l&agrave;m giảm c&aacute;c chất g&acirc;y dị ứng, m&ugrave;i kh&oacute; chịu v&agrave; nếp nhăn. Cơ chế l&agrave;m kh&ocirc; nhiệt độ thấp gi&uacute;p l&agrave;m kh&ocirc; quần &aacute;o nhanh hơn so với phơi quần &aacute;o th&ocirc;ng thường, đồng thời ngăn ngừa sự co r&uacute;t v&agrave; hư hỏng do nhiệt.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/3(735).JPG" /></p>

<h3>Tạo nếp ly quần ho&agrave;n hảo</h3>

<p>Giữ ly quần sắc n&eacute;t đồng thời giảm nếp nhăn.<br />
Việc chăm s&oacute;c v&agrave; giữ nếp quần &acirc;u trở n&ecirc;n<br />
nhanh ch&oacute;ng v&agrave; dễ d&agrave;ng.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/4(15).gif" /></p>

<h3>Ngăn ngừa co r&uacute;t v&agrave; hư hỏng quần &aacute;o</h3>

<p>L&agrave;m kh&ocirc; quần &aacute;o nhẹ nh&agrave;ng m&agrave; kh&ocirc;ng phải lo lắng về sự co r&uacute;t vải hoặc hư hỏng quần &aacute;o. Kh&ocirc;ng c&ograve;n ẩm ướt v&agrave; c&aacute;c thiệt hại kh&aacute;c - m&agrave; chỉ c&ograve;n sự tươi mới như ch&uacute;ng ta lu&ocirc;n mong đợi!</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/5(495).JPG" /></p>

<h3>L&agrave;m tươi mới cả kh&ocirc;ng gian nh&agrave; bạn</h3>

<p>Kh&ocirc;ng chỉ giữ cho quần &aacute;o lu&ocirc;n tinh tươm,<br />
LG Styler c&ograve;n gi&uacute;p kh&ocirc;ng gian nh&agrave; bạn<br />
lu&ocirc;n tươi mới v&agrave; sạch sẽ</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/6(358).JPG" /></p>

<h3>Kết Nối Th&ocirc;ng Minh với WiFi</h3>

<p>C&ocirc;ng nghệ SmartThinQ&trade; cho ph&eacute;p bạn điều khiển hoặc kiểm so&aacute;t hoạt động của m&aacute;y mọi l&uacute;c mọi nơi. Bạn c&oacute; thể kiểm so&aacute;t mức ti&ecirc;u thụ năng lượng hoặc c&oacute; thể tải th&ecirc;m c&aacute;c chu tr&igrave;nh chăm s&oacute;c quần &aacute;o kh&aacute;c tr&ecirc;n hệ thống.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/7(272).JPG" /></p>

<h3>LG Styler &ndash; Cho cuộc sống khỏe mạnh hơn</h3>

<p>Trong suốt ng&agrave;y d&agrave;i, quần &aacute;o bạn đang mặc rất dễ b&aacute;m bụi, vi khuẩn v&agrave; c&aacute;c chất g&acirc;y dị ứng.<br />
Việc l&agrave;m sạch quần &aacute;o cũng quan trọng như việc bạn rửa tay mỗi ng&agrave;y.<br />
H&atilde;y giữ quần &aacute;o của bạn lu&ocirc;n sạch tinh tươm với LG Styler.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/8(191).JPG" /></p>
', N'-901KGH.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (98, 5, N'Máy sấy quần áo 7Kg Electrolux EDV705HQWA', 7900000.0000, N'CUAYA12J', 11, 1, N'Việt Nam', 23, N'Kích thước: Rộng 600 mm - Cao 845 mm - Sâu 600 mm', N'<p>GIỚI THIỆU SẢN PHẨM&nbsp;- M&Aacute;Y SẤY QUẦN &Aacute;O 7KG ELECTROLUX EDV705HQWA</p>

<p><strong>Thiết kế nhỏ gọn, hiện đại</strong><br />
M&aacute;y sấy Electrolux 7 Kg EDV705HQWA sở hữu thiết kế nhỏ gọn, chắc chắn c&ugrave;ng đường n&eacute;t tinh tế, gam m&agrave;u trắng trang nh&atilde; gi&uacute;p t&ocirc; điểm cho kh&ocirc;ng gian nội thất hiện đại của gia đ&igrave;nh bạn.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/hj-3M75r9.jpg" /></p>

<p>Khối lượng sấy 7 kg ph&ugrave; hợp với những gia đ&igrave;nh &iacute;t th&agrave;nh vi&ecirc;n hoặc chỉ sử dụng mấy sấy cho số lượng &iacute;t quần &aacute;o</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/hj-Yc4U8T.jpg" /></p>

<p><strong>C&ocirc;ng nghệ sấy th&ocirc;ng hơi sấy kh&ocirc; nhanh, tiết kiệm điện</strong><br />
Với c&ocirc;ng nghệ n&agrave;y, m&aacute;y sấy th&ocirc;ng hơi c&oacute; thể sấy kh&ocirc; quần &aacute;o nhanh ch&oacute;ng, tiết kiệm chi ph&iacute; điện. Ph&ugrave; hợp cho gia đ&igrave;nh c&oacute; cửa sổ hoặc kh&ocirc;ng gian rộng r&atilde;i, ống th&ocirc;ng hơi c&oacute; thể lắp trước hoặc sau m&aacute;y tiện lợi.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/hj-U3M849.jpg" /></p>

<p><strong>C&ocirc;ng nghệ sấy đảo chiều gi&uacute;p quần &aacute;o kh&ocirc; đều hơn, giảm nhăn tối ưu</strong><br />
C&ocirc;ng nghệ sấy đảo chiều th&ocirc;ng minh tr&ecirc;n m&aacute;y sấy quần &aacute;o Electrolux&nbsp; kh&ocirc;ng l&agrave;m quần &aacute;o bị xoắn v&agrave;o nhau, c&ocirc;ng nghệ n&agrave;y giữ cho nhiệt lượng ổn định gi&uacute;p sợi vải mềm mại v&agrave; kh&ocirc;ng l&agrave;m hư hại đến m&agrave;u sắc của quần &aacute;o.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/hj-ETKGEY.jpg" /></p>

<p><strong>Cảm biến th&ocirc;ng minh cho ph&eacute;p tự động điều chỉnh thời gian sấy kh&ocirc; quần &aacute;o</strong><br />
Cảm biến th&ocirc;ng minh cho ph&eacute;p tự động điều chỉnh thời gian sấy kh&ocirc; quần &aacute;o để hạn chế những t&aacute;c động xấu đến trang phục, bảo vệ chất vải, m&agrave;u sắc v&agrave; thiết kế. Kh&ocirc;ng chỉ tr&aacute;nh việc sấy kh&ocirc; qu&aacute; mức g&acirc;y hư tổn đến quần &aacute;o, c&ocirc;ng nghệ n&agrave;y c&ograve;n gi&uacute;p người d&ugrave;ng tiết kiệm thời gian v&agrave; chi ph&iacute; đ&aacute;ng kể.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/hj-2Iu7RY.jpg" /></p>

<p><strong>&Iacute;t nhăn</strong><br />
Chuyển động theo chiều kim đồng hồ v&agrave; ngược chiều kim đồng hồ lu&acirc;n phi&ecirc;n giảm t&igrave;nh trạng rối v&agrave; g&acirc;y nhăn quần &aacute;o &iacute;t hơn 32%*. Điều n&agrave;y gi&uacute;p quần &aacute;o kh&ocirc;ng cần ủi nhiều, do vậy, quần &aacute;o sẽ mới l&acirc;u hơn. * Giảm nhăn 32% so với sấy kh&ocirc; trải phẳng - đ&atilde; được thử nghiệm v&agrave; chứng nhận bởi THTI</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/4(59).png" /><br />
<br />
<strong>Chăm s&oacute;c m&agrave;u sắc vượt trội</strong><br />
M&aacute;y sấy Electrolux sẽ sấy kh&ocirc; quần &aacute;o của bạn đồng thời chăm s&oacute;c m&agrave;u sắc tốt hơn 80% sau 52 lần giặt*, do vậy, quần &aacute;o của bạn sẽ giữ được vẻ rực rỡ v&agrave; c&oacute; thời gian sử dụng l&acirc;u hơn. * Giảm phai m&agrave;u tới 80% so với phơi dưới &aacute;nh nắng mặt trời - đ&atilde; được thử nghiệm v&agrave; chứng nhận bởi UL.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/5(55).png" /><br />
<br />
<strong>Bảo vệ chất lượng sợi vải, kh&ocirc;ng sấy qu&aacute; kh&ocirc;</strong><br />
Cảm biến th&ocirc;ng minh điều chỉnh thời gian sấy ch&iacute;nh x&aacute;c. Cảm biến về độ ẩm sẽ đảm bảo quần &aacute;o kh&ocirc;ng bị sấy qu&aacute; kh&ocirc;, khiến chất lượng sợi vải lu&ocirc;n được bảo vệ</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/6(47).png" /><br />
<br />
<strong>Sấy tinh tế, tiết kiệm năng lượng</strong><br />
Trải nghiệm hiệu suất tối ưu ngay cả khi ở nhiệt độ thấp. Kh&ocirc;ng chỉ tiết kiệm tới 6% mức năng lượng đang sử dụng, quần &aacute;o của bạn c&ograve;n được bảo vệ. *Tiết kiệm 6% năng lượng so với mẫu sản phẩm trước đ&oacute;.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/7(37).png" /><br />
<br />
<strong>Gh&eacute;p đ&ocirc;i ho&agrave;n hảo tổng qu&aacute;t</strong><br />
Bạn c&oacute; thể lắp đặt chiếc m&aacute;y sấy ở bất cứ đ&acirc;u bạn muốn, b&ecirc;n cạnh hay ở tr&ecirc;n m&aacute;y giặt của bạn, khi sử dụng bộ xếp chồng. Chiếc m&aacute;y sấy n&agrave;y kết hợp với chiếc m&aacute;y giặt cửa trước Electrolux UltimateCare&trade; 500 sẽ đem đến cho bạn một tổng thể ho&agrave;n hảo.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/9(23).png" /></p>
', N'may-say-quan-ao-electrolux-edv705hqwa-7kg-4bbLK1 (1).png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (99, 5, N'Máy sấy quần áo 8Kg Electrolux EDV805JQWA', 10990000.0000, N'ASOIUSA45', 14, 1, N'Thái Lan', 23, N'Máy sấy thông hơi 8kg sấy khô nhanh, tiết kiệm điện, Động cơ: Dây cua roa', N'<h1><span style="color:#e74c3c"><strong>GIỚI THIỆU SẢN PHẨM&nbsp;- M&Aacute;Y SẤY QUẦN &Aacute;O 8KG ELECTROLUX EDV805JQWA</strong></span></h1>

<p><strong>Thiết kế sang trọng, hiện đại</strong><br />
M&aacute;y sấy Electrolux 8 Kg EDV805JQWA mang kiểu d&aacute;ng cửa trước hiện đại, sắc trắng thanh lịch sẽ l&agrave;m h&agrave;i l&ograve;ng bất k&igrave; vị gia chủ kh&oacute; t&iacute;nh n&agrave;o. B&ecirc;n cạnh đ&oacute;, kiểu lồng sấy&nbsp;ngang của m&aacute;y gi&uacute;p bạn kh&ocirc;ng phải khom lưng qu&aacute; nhiều để bỏ v&agrave;o hoặc lấy quần &aacute;o ra, ngăn chặn nguy cơ đau cột sống cho bạn.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/gh-3z0Vr6.jpg" /></p>

<p><strong>M&aacute;y sấy Electrolux 8 kg</strong><br />
Tuy c&oacute; vẻ ngo&agrave;i kh&aacute; nhỏ gọn nhưng chiếc m&aacute;y sấy Electrolux n&agrave;y lại được trang bị khối lượng sấy l&ecirc;n đến 9 kg, cho ph&eacute;p bạn dễ d&agrave;ng sấy được nhiều quần &aacute;o trong một lần.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/gh-a56mdT.jpg" /></p>

<p><strong>M&aacute;y sấy th&ocirc;ng hơi tiết kiệm điện, gi&aacute; th&agrave;nh phải chăng</strong><br />
Sử dụng c&ocirc;ng nghệ sấy th&ocirc;ng hơi trong vận h&agrave;nh, m&aacute;y sấy Electrolux kh&ocirc;ng chỉ gi&uacute;p quần &aacute;o nhanh ch&oacute;ng được hong kh&ocirc; chỉ trong t&iacute;ch tắc m&agrave; n&oacute; c&ograve;n tiết kiệm đ&aacute;ng kể chi ph&iacute; điện h&agrave;ng th&aacute;ng cũng như bạn kh&ocirc;ng phải tốn nhiều &quot;hầu bao&quot; để lựa chọn cho m&igrave;nh một chiếc m&aacute;y sấy th&ocirc;ng hơi.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/gh-cuurjk.jpg" /></p>

<p><strong>C&ocirc;ng nghệ Smart Sensor tự điều chỉnh thời gian sấy một c&aacute;ch th&ocirc;ng minh</strong><br />
Nhờ khả năng tự điều chỉnh thời gian sấy th&ocirc;ng minh dựa tr&ecirc;n khối lượng cũng như độ ẩm của quần &aacute;o, m&aacute;y sấy Electrolux sẽ gi&uacute;p bạn kh&ocirc;ng phải tốn nhiều thời gian để điều chỉnh m&aacute;y, đồng thời gi&uacute;p quần &aacute;o được sấy kh&ocirc; ở mức l&yacute; tưởng, hạn chế hư hỏng.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/gh-NO8Okk.jpg" /></p>

<p><strong>Sấy xoay tr&ograve;n đảo chiều gi&uacute;p quần &aacute;o kh&ocirc; đều v&agrave; chống xoắn rối</strong><br />
Sử dụng kỹ thuật sấy đảo chiều, m&aacute;y sấy gi&uacute;p quần &aacute;o được ph&acirc;n bổ đều trong lồng sấy, cho quần &aacute;o được sấy kh&ocirc; đồng đều m&agrave; kh&ocirc;ng lo chỗ c&ograve;n ẩm, chỗ bị sấy qu&aacute; nhiệt g&acirc;y hư hỏng. Đồng thời kỹ thuật n&agrave;y c&ograve;n gi&uacute;p quần &aacute;o được tơi ra, kh&ocirc;ng xoắn rối v&agrave;o nhau g&acirc;y nhăn nh&uacute;m, tốn thời gian l&agrave; ủi.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/gh-x25q39.jpg" /></p>

<p><strong>Sấy nhanh quần &aacute;o trong 40 ph&uacute;t</strong><br />
Đừng lo lắng, m&aacute;y sấy Electrolux với t&iacute;nh năng sấy nhanh 40&nbsp;ph&uacute;t sẽ nhanh ch&oacute;ng l&agrave;m kh&ocirc; ch&uacute;ng chỉ trong t&iacute;ch tắc, kịp thời cho bạn v&agrave; người th&acirc;n c&oacute; trang phục để đi l&agrave;m, đi học.</p>

<p><img src="https://cdn.mediamart.vn/Upload/download/2019-10/gh-o4ulNj.jpg" /></p>

<p><strong>&Iacute;t nhăn</strong><br />
Chuyển động theo chiều kim đồng hồ v&agrave; ngược chiều kim đồng hồ lu&acirc;n phi&ecirc;n giảm t&igrave;nh trạng rối v&agrave; g&acirc;y nhăn quần &aacute;o &iacute;t hơn 32%*. Điều n&agrave;y gi&uacute;p quần &aacute;o kh&ocirc;ng cần ủi nhiều, do vậy, quần &aacute;o sẽ mới l&acirc;u hơn. * Giảm nhăn 32% so với sấy kh&ocirc; trải phẳng - đ&atilde; được thử nghiệm v&agrave; chứng nhận bởi THTI</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/4(59).png" /><br />
<br />
<strong>Chăm s&oacute;c m&agrave;u sắc vượt trội</strong><br />
M&aacute;y sấy Electrolux sẽ sấy kh&ocirc; quần &aacute;o của bạn đồng thời chăm s&oacute;c m&agrave;u sắc tốt hơn 80% sau 52 lần giặt*, do vậy, quần &aacute;o của bạn sẽ giữ được vẻ rực rỡ v&agrave; c&oacute; thời gian sử dụng l&acirc;u hơn. * Giảm phai m&agrave;u tới 80% so với phơi dưới &aacute;nh nắng mặt trời - đ&atilde; được thử nghiệm v&agrave; chứng nhận bởi UL.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/5(55).png" /><br />
<br />
<strong>Bảo vệ chất lượng sợi vải, kh&ocirc;ng sấy qu&aacute; kh&ocirc;</strong><br />
Cảm biến th&ocirc;ng minh điều chỉnh thời gian sấy ch&iacute;nh x&aacute;c. Cảm biến về độ ẩm sẽ đảm bảo quần &aacute;o kh&ocirc;ng bị sấy qu&aacute; kh&ocirc;, khiến chất lượng sợi vải lu&ocirc;n được bảo vệ</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/6(47).png" /><br />
<br />
<strong>Sấy tinh tế, tiết kiệm năng lượng</strong><br />
Trải nghiệm hiệu suất tối ưu ngay cả khi ở nhiệt độ thấp. Kh&ocirc;ng chỉ tiết kiệm tới 6% mức năng lượng đang sử dụng, quần &aacute;o của bạn c&ograve;n được bảo vệ. *Tiết kiệm 6% năng lượng so với mẫu sản phẩm trước đ&oacute;.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/7(37).png" /><br />
<br />
<strong>Gh&eacute;p đ&ocirc;i ho&agrave;n hảo tổng qu&aacute;t</strong><br />
Bạn c&oacute; thể lắp đặt chiếc m&aacute;y sấy ở bất cứ đ&acirc;u bạn muốn, b&ecirc;n cạnh hay ở tr&ecirc;n m&aacute;y giặt của bạn, khi sử dụng bộ xếp chồng. Chiếc m&aacute;y sấy n&agrave;y kết hợp với chiếc m&aacute;y giặt cửa trước Electrolux UltimateCare&trade; 500 sẽ đem đến cho bạn một tổng thể ho&agrave;n hảo.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/9(23).png" /></p>
', N'may-say-quan-ao-electrolux-edv805jqwa8kg-NYw4HC (1).png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', NULL, NULL)
GO
INSERT [dbo].[Product] ([ID_Product], [ID_Category], [Name], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [CreatedDate], [Status], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (100, 5, N'Tủ giặt hấp sấy LG Styler S3RF Espresso (Cà phê)', 34990000.0000, N'S654FS5F5', 45, 1, N'Việt Nam', 23, N'Chăm sóc quần áo với công nghệ hơi nước độc quyền TrureSteam làm giảm nếp nhăn và mù', N'<h1><span style="color:#c0392b"><strong><span style="font-size:24px">GIỚI THIỆU SẢN PHẨM&nbsp;- TỦ GIẶT HẤP SẤY LG STYLER S3RF ESPRESSO (C&Agrave; PH&Ecirc;)</span></strong></span></h1>

<h3><iframe frameborder="0" height="420" scrolling="no" src="https://www.youtube.com/embed/G3G1MsPfuXY?rel=0&amp;autoplay=0" width="745"></iframe></h3>

<h3>Loại bỏ nếp nhăn v&agrave; m&ugrave;i kh&oacute; chịu</h3>

<p>Những bộ vest, v&aacute;y, &aacute;o len v&agrave; nhiều loại quần &aacute;o cao cấp kh&aacute;c được chăm s&oacute;c tỉ mỉ chỉ bằng một n&uacute;t bấm. Tr&ocirc;ng bạn sẽ lu&ocirc;n tinh tươm v&agrave; ho&agrave;n hảo nhất. H&atilde;y loại bỏ mọi m&ugrave;i kh&oacute; chịu để quần &aacute;o l&uacute;c n&agrave;o cũng<br />
tươi mới v&agrave; thơm phức!</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/1(1019).JPG" /></p>

<h3>Khử tr&ugrave;ng hiệu quả</h3>

<p>C&aacute;ch xử l&yacute; quần &aacute;o an to&agrave;n! C&ocirc;ng nghệ hơi nước TrueSteam 100% từ nước sạch, kh&ocirc;ng chứa h&oacute;a chất độc hại, gi&uacute;p loại bỏ đến 99,9% vi khuẩn v&agrave; c&aacute;c t&aacute;c nh&acirc;n g&acirc;y dị ứng. Dễ d&agrave;ng vệ sinh vải v&oacute;c v&agrave; c&aacute;c đồ d&ugrave;ng kh&oacute; giặt hoặc kh&ocirc;ng thể giặt.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/2(886).JPG" /></p>

<h3>Chăm s&oacute;c quần &aacute;o bằng hơi nước TrueSteam&trade;</h3>

<p>C&ocirc;ng nghệ TrueSteam&trade; của LG Styler c&ugrave;ng với chuyển động ngang của m&oacute;c treo di chuyển gi&uacute;p hơi nước thẩm thấu s&acirc;u v&agrave;o quần &aacute;o gi&uacute;p l&agrave;m giảm c&aacute;c chất g&acirc;y dị ứng, m&ugrave;i kh&oacute; chịu v&agrave; nếp nhăn. Cơ chế l&agrave;m kh&ocirc; nhiệt độ thấp gi&uacute;p l&agrave;m kh&ocirc; quần &aacute;o nhanh hơn so với phơi quần &aacute;o th&ocirc;ng thường, đồng thời ngăn ngừa sự co r&uacute;t v&agrave; hư hỏng do nhiệt.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/3(735).JPG" /></p>

<h3>Tạo nếp ly quần ho&agrave;n hảo</h3>

<p>Giữ ly quần sắc n&eacute;t đồng thời giảm nếp nhăn.<br />
Việc chăm s&oacute;c v&agrave; giữ nếp quần &acirc;u trở n&ecirc;n<br />
nhanh ch&oacute;ng v&agrave; dễ d&agrave;ng.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/4(15).gif" /></p>

<h3>Ngăn ngừa co r&uacute;t v&agrave; hư hỏng quần &aacute;o</h3>

<p>L&agrave;m kh&ocirc; quần &aacute;o nhẹ nh&agrave;ng m&agrave; kh&ocirc;ng phải lo lắng về sự co r&uacute;t vải hoặc hư hỏng quần &aacute;o. Kh&ocirc;ng c&ograve;n ẩm ướt v&agrave; c&aacute;c thiệt hại kh&aacute;c - m&agrave; chỉ c&ograve;n sự tươi mới như ch&uacute;ng ta lu&ocirc;n mong đợi!</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/5(495).JPG" /></p>

<h3>L&agrave;m tươi mới cả kh&ocirc;ng gian nh&agrave; bạn</h3>

<p>Kh&ocirc;ng chỉ giữ cho quần &aacute;o lu&ocirc;n tinh tươm,<br />
LG Styler c&ograve;n gi&uacute;p kh&ocirc;ng gian nh&agrave; bạn<br />
lu&ocirc;n tươi mới v&agrave; sạch sẽ</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/6(358).JPG" /></p>

<h3>Kết Nối Th&ocirc;ng Minh với WiFi</h3>

<p>C&ocirc;ng nghệ SmartThinQ&trade; cho ph&eacute;p bạn điều khiển hoặc kiểm so&aacute;t hoạt động của m&aacute;y mọi l&uacute;c mọi nơi. Bạn c&oacute; thể kiểm so&aacute;t mức ti&ecirc;u thụ năng lượng hoặc c&oacute; thể tải th&ecirc;m c&aacute;c chu tr&igrave;nh chăm s&oacute;c quần &aacute;o kh&aacute;c tr&ecirc;n hệ thống.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/7(272).JPG" /></p>

<h3>LG Styler &ndash; Cho cuộc sống khỏe mạnh hơn</h3>

<p>Trong suốt ng&agrave;y d&agrave;i, quần &aacute;o bạn đang mặc rất dễ b&aacute;m bụi, vi khuẩn v&agrave; c&aacute;c chất g&acirc;y dị ứng.<br />
Việc l&agrave;m sạch quần &aacute;o cũng quan trọng như việc bạn rửa tay mỗi ng&agrave;y.<br />
H&atilde;y giữ quần &aacute;o của bạn lu&ocirc;n sạch tinh tươm với LG Styler.</p>

<p><img src="https://cdn.mediamart.vn/Upload/images/8(191).JPG" /></p>
', N'-F8JE4l.png', CAST(N'2021-07-26' AS Date), 1, N'Nguoi Nguoi Quan Tri 1', CAST(N'2021-08-01' AS Date), N'Nguoi Quan Tri')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO

SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([ID_Role], [Name], [Code]) VALUES (1, N'Khach hang', N'CLIENT')
INSERT [dbo].[Role] ([ID_Role], [Name], [Code]) VALUES (2, N'Nguoi quan tri', N'ADMIN')

SET IDENTITY_INSERT [dbo].[Role] OFF
GO



SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([ID_Account], [ID_Role], [UserName], [Password], [FullName], [Phone], [Address], [Email], [Status], [Avatar]) VALUES (1, 2, N'admin', N'admin', N'Nguoi Quan Tri', N'0999888776          ', N'Dai hoc cong nghiep Ha Noi', N'nhom6.cntt01.k13@gmail.com', 1, NULL)
INSERT [dbo].[Account] ([ID_Account], [ID_Role], [UserName], [Password], [FullName], [Phone], [Address], [Email], [Status], [Avatar]) VALUES (2, 1, N'nhom6', N'nhom6', N'Nguyen Van An', N'0987654321          ', N'Cau Giay - Ha Noi', N'an123@gmail.com', 1, NULL)
INSERT [dbo].[Account] ([ID_Account], [ID_Role], [UserName], [Password], [FullName], [Phone], [Address], [Email], [Status], [Avatar]) VALUES (3, 1, N'user1', N'nhom6', N'Tưởng Giới Thạch', N'0989654321          ', N'Ba Đình - Hà Nội', N'tgt123@gmail.com', 1, NULL)
INSERT [dbo].[Account] ([ID_Account], [ID_Role], [UserName], [Password], [FullName], [Phone], [Address], [Email], [Status], [Avatar]) VALUES (4, 1, N'user2', N'nhom6', N'Nguyễn Minh Thảo', N'0989656688          ', N'Thanh Xuân - Hà Nội', N'thaoCute112@gmail.com', 1, NULL)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO

INSERT INTO Cart(ID_Account,ID_Product,Amount) VALUES
(3,1,1),
(3,20,2),
(3,50,1)


select * from Product
select * from Account
select * from Category
select * from Bill
select * from BillDetail
select * from Cart
select * from [Role]

insert into Bill(ID_Account,ReceiverName,ReceiverAddress,ReceiverEmail,ReceiverPhone,Note,PayType,Status,CreatedDate) values(18,N'Phạm Thị A',N'Bắc Ninh',N'trandobn@gmail.com','0385993661',N'Gửi nhanh',N'Chuyển khoản',0,N'2021-01-01')
insert into BillDetail values(3,10,5,50000);
insert into BillDetail values(4,10,5,50000);

insert into Bill(ID_Account,ReceiverName,ReceiverAddress,ReceiverEmail,ReceiverPhone,Note,PayType,Status,CreatedDate) values(2,N'Nguyễn văn',N'Bắc Ninh',N'trandobn@gmail.com','0385993661',N'Gửi nhanh',N'Chuyển khoản',0,N'2021-01-01')
insert into BillDetail values(6,11,5,50000);
insert into BillDetail values(5,11,5,10000);

insert into Bill(ID_Account,ReceiverName,ReceiverAddress,ReceiverEmail,ReceiverPhone,Note,PayType,Status,CreatedDate,ModifiedDate) values(19,N'Trần Thị Hoa',N'Bắc Ninh',N'trandobn@gmail.com','0385993661',N'Gửi nhanh',N'Chuyển khoản',1,N'2021-01-01',N'2021-11-04')
insert into BillDetail values(6,13,5,50000);
insert into BillDetail values(5,13,5,50000);

insert into Bill(ID_Account,ReceiverName,ReceiverAddress,ReceiverEmail,ReceiverPhone,Note,PayType,Status,CreatedDate,ModifiedDate) values(21,N'Hoàng Văn Ba',N'Hà Nội',N'tradfndobn@gmail.com','0978458751',N'Gửi chậm',N'Thanh toán khi nhận hàng',2,N'2021-01-01',N'2021-11-04')
insert into BillDetail values(6,16,5,100000);
insert into BillDetail values(5,16,5,50000);

insert into Bill(ID_Account,ReceiverName,ReceiverAddress,ReceiverEmail,ReceiverPhone,Note,PayType,Status,CreatedDate,ModifiedDate) values(21,N'Hoàng Văn Ba',N'Hà Nội',N'tradfndobn@gmail.com','0978458751',N'Gửi chậm',N'Thanh toán khi nhận hàng',0,N'2021-01-01',N'2021-11-04')
insert into BillDetail values(6,19,5,100000);
insert into BillDetail values(5,19,5,50000);

insert into Bill(ID_Account,ReceiverName,ReceiverAddress,ReceiverEmail,ReceiverPhone,Note,PayType,Status,CreatedDate,ModifiedDate) values(21,N'Hoàng Văn Ba',N'Hà Nội',N'tradfndobn@gmail.com','0978458751',N'Gửi chậm',N'Thanh toán khi nhận hàng',0,N'2021-01-01',N'2021-11-04')
insert into BillDetail values(6,20,5,100000);
insert into BillDetail values(5,20,5,50000);

insert into Bill(ID_Account,ReceiverName,ReceiverAddress,ReceiverEmail,ReceiverPhone,Note,PayType,Status,CreatedDate,ModifiedDate) values(21,N'Hoàng Văn Ba',N'Hà Nội',N'tradfndobn@gmail.com','0978458751',N'Gửi chậm',N'Thanh toán khi nhận hàng',0,N'2021-01-01',N'2021-11-04')
insert into BillDetail values(6,21,5,100000);
insert into BillDetail values(5,21,5,50000);



--delete from BillDetail
--delete from Bill where ID_Bill=12
--delete from BillDetail where ID_Bill=12