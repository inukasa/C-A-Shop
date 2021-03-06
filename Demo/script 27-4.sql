use [C&A]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[categoryID] [int] NOT NULL,
	[categoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportShipment]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportShipment](
	[ImportShipmentID] [int] IDENTITY(1,1) NOT NULL,
	[importDate] [datetime] NULL,
	[productID] [nvarchar](50) NULL,
	[importPrice] [float] NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK_ImportShipment] PRIMARY KEY CLUSTERED 
(
	[ImportShipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[productID] [nvarchar](50) NOT NULL,
	[productQuantity] [int] NOT NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[orderID] [int] NOT NULL,
	[userID] [int] NOT NULL,
	[orderTotalPrice] [float] NULL,
	[dateCreate] [nvarchar](50) NULL,
	[dateConfirm] [nvarchar](50) NULL,
	[orderStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[orderDetailID] [int] NOT NULL,
	[orderID] [int] NULL,
	[productName] [nvarchar](50) NULL,
	[productQuantityOrder] [int] NULL,
	[productTotalPrice] [float] NULL,
	[productID] [nvarchar](50) NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[orderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[productID] [nvarchar](50) NOT NULL,
	[subcategoryID] [int] NOT NULL,
	[supplierID] [int] NOT NULL,
	[productName] [nvarchar](50) NULL,
	[productDescription] [nvarchar](max) NULL,
	[productFeedback] [nvarchar](max) NULL,
	[productRate] [int] NULL,
	[productSize] [nvarchar](50) NULL,
	[productColor] [nvarchar](50) NULL,
	[exportPrice] [float] NULL,
	[productStatus] [nvarchar](50) NULL,
	[productIcon] [nvarchar](max) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[rateID] [int] NOT NULL,
	[userID] [int] NOT NULL,
	[productID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED 
(
	[rateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShippingInfor]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingInfor](
	[shipID] [int] NOT NULL,
	[orderID] [int] NOT NULL,
	[shipPhone] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[shipName] [nvarchar](50) NULL,
	[dateShip] [nvarchar](50) NULL,
 CONSTRAINT [PK_ShippingInfor] PRIMARY KEY CLUSTERED 
(
	[shipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[cartID] [int] NOT NULL,
	[userID] [int] NOT NULL,
	[productID] [nvarchar](50) NOT NULL,
	[productQuantityOrder] [int] NOT NULL,
	[productTotalPrice] [float] NOT NULL,
	[productPrice] [float] NOT NULL,
 CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[cartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubCategory]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCategory](
	[subcategoryID] [int] IDENTITY(1,1) NOT NULL,
	[categoryID] [int] NOT NULL,
	[subcategoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_SubCategory] PRIMARY KEY CLUSTERED 
(
	[subcategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[supplierID] [int] IDENTITY(1,1) NOT NULL,
	[supplierName] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[supplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[typeID] [int] NOT NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[fullname] [nvarchar](50) NULL,
	[address] [nvarchar](max) NULL,
	[phone] [nvarchar](50) NULL,
	[email] [nvarchar](max) NULL,
	[gender] [nvarchar](50) NULL,
	[birthday] [nvarchar](50) NULL,
	[registerDate] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserType]    Script Date: 4/29/2020 2:39:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserType](
	[typeID] [int] NOT NULL,
	[typeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED 
(
	[typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Category] ([categoryID], [categoryName]) VALUES (1, N'Đồ Nam')
INSERT [dbo].[Category] ([categoryID], [categoryName]) VALUES (2, N'Đồ Nữ')
INSERT [dbo].[Category] ([categoryID], [categoryName]) VALUES (3, N'Dụng cụ')
SET IDENTITY_INSERT [dbo].[ImportShipment] ON 

INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (1, CAST(N'2020-01-16T21:43:25.657' AS DateTime), N'AB_X_XL_ADDIDAS', 2000000, 10)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (2, CAST(N'2020-03-16T21:44:23.800' AS DateTime), N'AB_X_XL_ADDIDAS', 1000000, 10)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (14, CAST(N'2020-01-21T18:12:03.307' AS DateTime), N'NA_ĐEN_XXL_NHÀ CUNG CẤP 1', 2000000, 20)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (15, CAST(N'2020-01-21T18:12:15.247' AS DateTime), N'EA_XANH_12_NHÀ CUNG CẤP 1', 2000000, 20)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (16, CAST(N'2020-02-03T11:21:03.963' AS DateTime), N'EA_XANH_12_NHÀ CUNG CẤP 1', 1800000, 20)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (17, CAST(N'2020-02-03T12:17:12.860' AS DateTime), N'NA_ĐEN_XXL_NHÀ CUNG CẤP 1', 1800000, 20)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (18, CAST(N'2020-04-22T20:33:00.870' AS DateTime), N'ÁPXL_XANH LÁXANH LÁ_XL_NHÀ CUNG CẤP 1', 500000, 50)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (19, CAST(N'2020-04-23T17:38:33.690' AS DateTime), N'ÁPĐCN_ĐEN_XL_NHÀ CUNG CẤP 1', 600000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (20, CAST(N'2020-04-23T17:38:53.683' AS DateTime), N'ÁPĐĐ_ĐỎ NÂUĐỎ NÂU_XL_NHÀ CUNG CẤP 4', 700000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (21, CAST(N'2020-04-23T17:47:06.100' AS DateTime), N'ÁPT_TRẮNG_XXL_NHÀ CUNG CẤP 2', 500000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (22, CAST(N'2020-04-23T17:48:53.893' AS DateTime), N'ÁPVN_VÀNG_XXL_NHÀ CUNG CẤP 4', 600000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (23, CAST(N'2020-04-23T17:49:20.163' AS DateTime), N'ÁPXL_XANH LÁXANH LÁ_XL_NHÀ CUNG CẤP 1', 600000, 9500)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (24, CAST(N'2020-04-23T17:49:48.190' AS DateTime), N'ÁPXN_XANH_XL_NHÀ CUNG CẤP 2', 500000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (25, CAST(N'2020-04-23T17:50:15.717' AS DateTime), N'ÁPXN_XANH_XL_NHÀ CUNG CẤP 5', 500000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (26, CAST(N'2020-04-23T17:50:32.780' AS DateTime), N'ÁTTCN_ĐEN_XL_NHÀ CUNG CẤP 5', 600000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (27, CAST(N'2020-04-27T21:23:44.107' AS DateTime), N'ÁMH1_XANH LÁXANH LÁ_XL_NHÀ CUNG CẤP 3', 500000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (28, CAST(N'2020-04-27T21:30:46.503' AS DateTime), N'ÁMH2_XANH_XL_NHÀ CUNG CẤP 3', 700000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (29, CAST(N'2020-04-27T21:33:38.943' AS DateTime), N'ÁMH3_CAM_M_NHÀ CUNG CẤP 3', 700000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (30, CAST(N'2020-04-27T21:43:42.613' AS DateTime), N'ÁMH4_ĐỎ_XXL_NHÀ CUNG CẤP 3', 700000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (31, CAST(N'2020-04-28T17:09:21.603' AS DateTime), N'SP0_Đ_XXL_NHÀ CUNG CẤP 1', 500000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (32, CAST(N'2020-04-28T17:09:45.377' AS DateTime), N'SP0_ĐEN_L_NHÀ CUNG CẤP 1', 700000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (33, CAST(N'2020-04-28T17:10:02.197' AS DateTime), N'SP0_ĐEN_XXL_NHÀ CUNG CẤP 1', 500000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (34, CAST(N'2020-04-28T17:10:30.360' AS DateTime), N'SP1_ĐEN_XXL_NHÀ CUNG CẤP 3', 1000000, 100)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (35, CAST(N'2020-04-28T17:12:26.583' AS DateTime), N'ÁMH3_CAM _XL_NHÀ CUNG CẤP 3', 700000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (36, CAST(N'2020-04-28T19:14:56.697' AS DateTime), N'ÁMH3_CAM _XL_NHÀ CUNG CẤP 3', 700000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (37, CAST(N'2020-04-28T19:15:20.910' AS DateTime), N'ÁMH3_XANH_L_NHÀ CUNG CẤP 3', 700000, 10000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (38, CAST(N'2020-04-29T00:01:11.753' AS DateTime), N'GDN3_ĐEN_XL_NHÀ CUNG CẤP 3', 700000, 700)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (39, CAST(N'2020-04-29T00:06:33.260' AS DateTime), N'GTTN1_TRẮNG_40_NHÀ CUNG CẤP 2', 600000, 700)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (40, CAST(N'2020-04-29T00:07:03.670' AS DateTime), N'GTTN2_XÁM_40_NHÀ CUNG CẤP 2', 600000, 800)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (41, CAST(N'2020-04-29T00:07:36.260' AS DateTime), N'GTTN3_TRẮNG_42_NHÀ CUNG CẤP 2', 75000, 500)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (42, CAST(N'2020-04-29T00:21:56.477' AS DateTime), N'BĐ1_TRẮNG_30_NHÀ CUNG CẤP 2', 85000, 100)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (43, CAST(N'2020-04-29T00:22:52.047' AS DateTime), N'BĐ2_XÁM_30_NHÀ CUNG CẤP 2', 95000, 100)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (44, CAST(N'2020-04-29T00:28:46.593' AS DateTime), N'BR1_ĐỎ_40_NHÀ CUNG CẤP 2', 100000, 250)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (45, CAST(N'2020-04-29T00:29:11.603' AS DateTime), N'BR2_ĐỎ_40_NHÀ CUNG CẤP 2', 100000, 250)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (46, CAST(N'2020-04-29T00:29:38.890' AS DateTime), N'BR3_ĐỎ_40_NHÀ CUNG CẤP 3', 100000, 250)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (47, CAST(N'2020-04-29T01:00:24.813' AS DateTime), N'BC1_NHIỀU MÀUNHIỀU MÀU_35_NHÀ CUNG CẤP 5', 100000, 800)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (48, CAST(N'2020-04-29T01:01:09.713' AS DateTime), N'BC2_NHIỀU MÀU NHIỀU MÀU _30_NHÀ CUNG CẤP 3', 100000, 800)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (49, CAST(N'2020-04-29T01:01:32.687' AS DateTime), N'BC3_NHIỀU MÀUNHIỀU MÀU_30_NHÀ CUNG CẤP 5', 100000, 800)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (50, CAST(N'2020-04-29T01:01:51.473' AS DateTime), N'BC4_VÀNG_40_NHÀ CUNG CẤP 5', 100000, 800)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (51, CAST(N'2020-04-29T01:36:09.247' AS DateTime), N'ÁMHN1_TÍM THANTÍM THAN_XL_NHÀ CUNG CẤP 5', 400000, 700)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (52, CAST(N'2020-04-29T01:36:28.380' AS DateTime), N'ÁMHN2_ĐEN_L_NHÀ CUNG CẤP 4', 400000, 400)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (53, CAST(N'2020-04-29T01:36:45.883' AS DateTime), N'ÁMHN3_TRẮNG_M_NHÀ CUNG CẤP 4', 400000, 500)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (54, CAST(N'2020-04-29T02:28:18.030' AS DateTime), N'SP0_XANH_XXL_NHÀ CUNG CẤP 1', 900000, 1000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (55, CAST(N'2020-04-29T02:31:30.037' AS DateTime), N'F_XANH_M_NHÀ CUNG CẤP 1', 300000, 1000)
INSERT [dbo].[ImportShipment] ([ImportShipmentID], [importDate], [productID], [importPrice], [quantity]) VALUES (56, CAST(N'2020-04-29T02:34:04.557' AS DateTime), N'ÁMĐ_TÍM _XL_NHÀ CUNG CẤP 3', 700000, 1000)
SET IDENTITY_INSERT [dbo].[ImportShipment] OFF
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'AB_X_XL_ADDIDAS', 2332)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁMĐ_TÍM _XL_NHÀ CUNG CẤP 3', 1000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁMH1_XANH LÁXANH LÁ_XL_NHÀ CUNG CẤP 3', 10000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁMH2_XANH_XL_NHÀ CUNG CẤP 3', 9920)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁMH3_CAM _XL_NHÀ CUNG CẤP 3', 20000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁMH3_CAM_M_NHÀ CUNG CẤP 3', 9995)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁMH3_XANH_L_NHÀ CUNG CẤP 3', 10000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁMH4_ĐỎ_XXL_NHÀ CUNG CẤP 3', 9985)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁMHN1_TÍM THANTÍM THAN_XL_NHÀ CUNG CẤP 5', 700)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁMHN2_ĐEN_L_NHÀ CUNG CẤP 4', 400)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁMHN3_TRẮNG_M_NHÀ CUNG CẤP 4', 500)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁPĐCN_ĐEN_XL_NHÀ CUNG CẤP 1', 10000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁPĐĐ_ĐỎ NÂUĐỎ NÂU_XL_NHÀ CUNG CẤP 4', 10000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁPT_TRẮNG_XXL_NHÀ CUNG CẤP 2', 9999)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁPVN_VÀNG_XXL_NHÀ CUNG CẤP 4', 10000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁPXL_XANH LÁXANH LÁ_XL_NHÀ CUNG CẤP 1', 9550)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁPXN_XANH_XL_NHÀ CUNG CẤP 2', 10000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁPXN_XANH_XL_NHÀ CUNG CẤP 5', 9985)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'ÁTTCN_ĐEN_XL_NHÀ CUNG CẤP 5', 10000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'BC1_NHIỀU MÀUNHIỀU MÀU_35_NHÀ CUNG CẤP 5', 800)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'BC2_NHIỀU MÀU NHIỀU MÀU _30_NHÀ CUNG CẤP 3', 800)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'BC3_NHIỀU MÀUNHIỀU MÀU_30_NHÀ CUNG CẤP 5', 800)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'BC4_VÀNG_40_NHÀ CUNG CẤP 5', 800)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'BĐ1_TRẮNG_30_NHÀ CUNG CẤP 2', 100)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'BĐ2_XÁM_30_NHÀ CUNG CẤP 2', 100)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'BR1_ĐỎ_40_NHÀ CUNG CẤP 2', 250)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'BR2_ĐỎ_40_NHÀ CUNG CẤP 2', 250)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'BR3_ĐỎ_40_NHÀ CUNG CẤP 3', 250)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'DA_XANH_21_NHÀ CUNG CẤP 1', 3020)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'EA_XANH_12_NHÀ CUNG CẤP 1', 2262)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'F_XANH_M_NHÀ CUNG CẤP 1', 1000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'GDN3_ĐEN_XL_NHÀ CUNG CẤP 3', 700)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'GTTN1_TRẮNG_40_NHÀ CUNG CẤP 2', 700)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'GTTN2_XÁM_40_NHÀ CUNG CẤP 2', 800)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'GTTN3_TRẮNG_42_NHÀ CUNG CẤP 2', 500)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'NA_ĐEN_XXL_NHÀ CUNG CẤP 1', 45)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SP0_Đ_XXL_NHÀ CUNG CẤP 1', 20006)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SP0_ĐEN_L_NHÀ CUNG CẤP 1', 10007)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SP0_ĐEN_XXL_NHÀ CUNG CẤP 1', 10008)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SP0_XANH_XXL_NHÀ CUNG CẤP 1', 1000)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SP1_ĐEN_XXL_NHÀ CUNG CẤP 3', 106)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SP1_XANH LÁXANH LÁ_L_NHÀ CUNG CẤP 3', 10)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SP4_Đ_M_NHÀ CUNG CẤP 3', 11)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SPM1_Đ_30_NHÀ CUNG CẤP 5', 12)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SPM2_Đ_30_NHÀ CUNG CẤP 1', 123)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SPM3_X_50_NHÀ CUNG CẤP 1', 23)
INSERT [dbo].[Inventory] ([productID], [productQuantity]) VALUES (N'SPT_VÀNG_50_NHÀ CUNG CẤP 2', 100)
INSERT [dbo].[Order] ([orderID], [userID], [orderTotalPrice], [dateCreate], [dateConfirm], [orderStatus]) VALUES (1, 8, 5000000, N'11/24/2019', N'12/24/2019 11:39:00 PM', N'Đã xử lý')
INSERT [dbo].[Order] ([orderID], [userID], [orderTotalPrice], [dateCreate], [dateConfirm], [orderStatus]) VALUES (2, 5, 6000000, N'12/24/2020 3:48:57 PM', N'12/24/2019 11:30:05 PM', N'Đã xử lý')
INSERT [dbo].[Order] ([orderID], [userID], [orderTotalPrice], [dateCreate], [dateConfirm], [orderStatus]) VALUES (3, 5, 1000000, N'02/24/2020 3:48:57 PM', N'12/24/2019 11:34:03 PM', N'Đã xử lý')
INSERT [dbo].[Order] ([orderID], [userID], [orderTotalPrice], [dateCreate], [dateConfirm], [orderStatus]) VALUES (4, 9, 2000000, N'12/24/2020 3:48:57 PM', N'12/24/2019 11:39:02 PM', N'Hủy')
INSERT [dbo].[Order] ([orderID], [userID], [orderTotalPrice], [dateCreate], [dateConfirm], [orderStatus]) VALUES (6, 12, 3000000, N'1/15/2020 5:14:20 AM', N'1/15/2020 5:14:20 AM', N'Đang xử lý')
INSERT [dbo].[Order] ([orderID], [userID], [orderTotalPrice], [dateCreate], [dateConfirm], [orderStatus]) VALUES (7, 10, 49600000, N'4/27/2020 10:08:22 PM', N'4/27/2020 10:10:36 PM', N'Đã xử lý')
INSERT [dbo].[Order] ([orderID], [userID], [orderTotalPrice], [dateCreate], [dateConfirm], [orderStatus]) VALUES (8, 10, 19500000, N'4/28/2020 4:41:34 PM', N'4/28/2020 4:49:34 PM', N'Đã xử lý')
INSERT [dbo].[Order] ([orderID], [userID], [orderTotalPrice], [dateCreate], [dateConfirm], [orderStatus]) VALUES (9, 10, 10500000, N'4/28/2020 4:42:00 PM', N'4/28/2020 4:49:36 PM', N'Đã xử lý')
INSERT [dbo].[Order] ([orderID], [userID], [orderTotalPrice], [dateCreate], [dateConfirm], [orderStatus]) VALUES (10, 10, 6600000, N'4/28/2020 4:42:48 PM', N'4/28/2020 4:49:37 PM', N'Đã xử lý')
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productName], [productQuantityOrder], [productTotalPrice], [productID]) VALUES (1, 7, N'ÁO PHÔNG TRẮNG', 1, 600000, N'ÁPT_TRẮNG_XXL_NHÀ CUNG CẤP 2')
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productName], [productQuantityOrder], [productTotalPrice], [productID]) VALUES (2, 7, N'ÁO MÙA HÈ 2', 70, 49000000, N'ÁMH2_XANH_XL_NHÀ CUNG CẤP 3')
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productName], [productQuantityOrder], [productTotalPrice], [productID]) VALUES (3, 8, N'ÁO MÙA HÈ 2', 10, 7000000, N'ÁMH2_XANH_XL_NHÀ CUNG CẤP 3')
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productName], [productQuantityOrder], [productTotalPrice], [productID]) VALUES (4, 8, N'ÁO MÙA HÈ 3 ', 5, 3500000, N'ÁMH3_CAM_M_NHÀ CUNG CẤP 3')
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productName], [productQuantityOrder], [productTotalPrice], [productID]) VALUES (5, 8, N'ÁO PHÔNG XANH NAVY', 15, 9000000, N'ÁPXN_XANH_XL_NHÀ CUNG CẤP 5')
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productName], [productQuantityOrder], [productTotalPrice], [productID]) VALUES (6, 9, N'ÁO MÙA HÈ 4', 15, 10500000, N'ÁMH4_ĐỎ_XXL_NHÀ CUNG CẤP 3')
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productName], [productQuantityOrder], [productTotalPrice], [productID]) VALUES (7, 10, N'GIÀY DA NỮ LOẠI 1', 3, 6600000, N'SP1_ĐEN_XXL_NHÀ CUNG CẤP 3')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'AB_X_XL_ADDIDAS', 0, 1, N'GIÀY DA NAM', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 1, N'40', N'XANH', 2200000, N'Active', N'giay1.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'AB_X_XL_ADDIDASS', 1, 1, N'GIÀY DA NAM', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 50, N'42', N'XANH', 2200000, N'Inactive', N'pi7.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁMĐ_TÍM _XL_NHÀ CUNG CẤP 3', 5, 2, N'ÁO MÙA ĐÔNG ', N'Áo thể thao nam được thiết kế chuyên biệt cho các hoạt động thể thao, dã ngoại, đi chơi. Quần có kiểu dáng đơn giản, trẻ trung, dễ kết hợp với các trang phục, phụ kiện khác. Anta Sports là nhà cung cấp chính thức và nhà tài trợ của nhiều đội, cầu thủ và hiệp hội như Klay Thompson , Gordon Hayward , Kevin Garnett , Rajon Rondo , Luis Scola , Manny Pacquiao và trước đây là Chandler Parsons .', N'Sản phẩm tốt', 0, N'XL', N'TÍM ', 700000, N'Active', N'Ao01.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁMH1_XANH LÁXANH LÁ_XL_NHÀ CUNG CẤP 3', 5, 2, N'ÁO MÙA HÈ 1', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 7, N'XL', N'XANH LÁ', 600000, N'Active', N'Ao01Green.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁMH2_XANH_XL_NHÀ CUNG CẤP 3', 5, 2, N'ÁO MÙA HÈ 2', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 10, N'XL', N'XANH', 700000, N'Active', N'Ao 01 LightBlue.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁMH3_CAM _XL_NHÀ CUNG CẤP 3', 5, 2, N'ÁO MÙA HÈ 3', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 8, N'XL', N'CAM ', 700000, N'Inactive', N'Ao01Orange.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁMH3_CAM_M_NHÀ CUNG CẤP 3', 5, 2, N'ÁO MÙA HÈ 3 ', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 10, N'M', N'CAM', 700000, N'Active', N'Ao01Orange.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁMH3_XANH_L_NHÀ CUNG CẤP 3', 5, 2, N'ÁO MÙA HÈ 3 ', N'Áo thể thao nam được thiết kế chuyên biệt cho các hoạt động thể thao, dã ngoại, đi chơi. Quần có kiểu dáng đơn giản, trẻ trung, dễ kết hợp với các trang phục, phụ kiện khác. Anta Sports là nhà cung cấp chính thức và nhà tài trợ của nhiều đội, cầu thủ và hiệp hội như Klay Thompson , Gordon Hayward , Kevin Garnett , Rajon Rondo , Luis Scola , Manny Pacquiao và trước đây là Chandler Parsons .', N'Sản phẩm tốt', 0, N'L', N'XANH', 800000, N'Inactive', N'Ao01Orange.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁMH4_ĐỎ_XXL_NHÀ CUNG CẤP 3', 5, 2, N'ÁO MÙA HÈ 4', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 10, N'XXL', N'ĐỎ', 700000, N'Active', N'Ao01DeepRed.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁMHN1_TÍM THANTÍM THAN_XL_NHÀ CUNG CẤP 5', 8, 4, N'ÁO MÙA HÈ NỮ 1', N'Áo mùa hè mát mẻ với nhiều kiểu dáng dành cho các bạn gái ', NULL, 0, N'XL', N'TÍM THAN', 400000, N'Active', N'AoMuaHe1.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁMHN2_ĐEN_L_NHÀ CUNG CẤP 4', 8, 3, N'ÁO MÙA HÈ NỮ 2', N'Áo mùa hè mát mẻ với nhiều kiểu dáng dành cho các bạn gái ', NULL, 0, N'L', N'ĐEN', 400000, N'Active', N'AoMuaHe2.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁMHN3_TRẮNG_M_NHÀ CUNG CẤP 4', 8, 3, N'ÁO MÙA HÈ NỮ 3', N'Áo mùa hè mát mẻ với nhiều kiểu dáng dành cho các bạn gái ', NULL, 0, N'M', N'TRẮNG', 400000, N'Active', N'AoMuaHe3.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁPĐCN_ĐEN_XL_NHÀ CUNG CẤP 1', 5, 0, N'ÁO PHÔNG ĐEN CHO NAM', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 10, N'XL', N'ĐEN', 500000, N'Active', N'AoTheThao4.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁPĐĐ_ĐỎ NÂUĐỎ NÂU_XL_NHÀ CUNG CẤP 4', 5, 3, N'ÁO PHÔNG ĐỎ ĐẬM', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 10, N'XL', N'ĐỎ NÂU', 600000, N'Active', N'Ao01DeepRed.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁPT_TRẮNG_XXL_NHÀ CUNG CẤP 2', 5, 1, N'ÁO PHÔNG TRẮNG', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 10, N'XXL', N'TRẮNG', 600000, N'Active', N'Ao01White.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁPVN_VÀNG_XXL_NHÀ CUNG CẤP 4', 5, 3, N'ÁO PHÔNG VÀNG NHẠT', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 10, N'XXL', N'VÀNG', 700000, N'Active', N'Ao01Orange.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁPXL_XANH LÁXANH LÁ_XL_NHÀ CUNG CẤP 1', 5, 0, N'ÁO PHÔNG XANH LÁ', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 10, N'XL', N'XANH LÁ', 500000, N'Active', N'Ao01Green.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁPXN_XANH_XL_NHÀ CUNG CẤP 2', 5, 1, N'ÁO PHÔNG XANH NAM', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 10, N'XL', N'XANH', 600000, N'Active', N'Ao01LightBlue.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁPXN_XANH_XL_NHÀ CUNG CẤP 5', 5, 4, N'ÁO PHÔNG XANH NAVY', N'Sản phẩm cần có số #1 của cánh đàn ông. #Coolmate đã nghiên cứu rất kỹ về dáng người Việt Nam để đưa ra những chiếc áo thun với dáng vừa nhất, đẹp nhất cho người mặc. Hơn thế nữa, chất liệu cotton 100% với độ dày vừa phải, cộng với việc bề mặt vải đã được chải lông kỹ đảm bảo mang tới cảm giác vừa thoáng khí lại vô cùng thoải mái và “sướng” khi mặc. Vải đã được xử lý co rút trước khi may, nên đảm bảo giữ form tốt, không bị nhão, xù lông sau khi giặt, kể cả giặt bằng máy giặt.', N'Sản phẩm tốt', 10, N'XL', N'XANH', 600000, N'Active', N'Ao04Navy.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'ÁTTCN_ĐEN_XL_NHÀ CUNG CẤP 5', 5, 4, N'ÁO THỂ THAO CHO NAM', N'Áo thể thao nam được thiết kế chuyên biệt cho các hoạt động thể thao, dã ngoại, đi chơi. Quần có kiểu dáng đơn giản, trẻ trung, dễ kết hợp với các trang phục, phụ kiện khác. Anta Sports là nhà cung cấp chính thức và nhà tài trợ của nhiều đội, cầu thủ và hiệp hội như Klay Thompson , Gordon Hayward , Kevin Garnett , Rajon Rondo , Luis Scola , Manny Pacquiao và trước đây là Chandler Parsons .', N'Sản phẩm tốt', 10, N'XL', N'ĐEN', 800000, N'Active', N'Ao7.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'BC1_NHIỀU MÀUNHIỀU MÀU_35_NHÀ CUNG CẤP 5', 7, 4, N'BÓNG CHUYỀN 1 ', N'Bóng làm từ nhựa tổng hợp rất bền và đàn hồi', N'Sản phẩm tốt', 0, N'35', N'NHIỀU MÀU', 100000, N'Active', N'BongChuyen1.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'BC2_NHIỀU MÀU NHIỀU MÀU _30_NHÀ CUNG CẤP 3', 7, 2, N'BÓNG CHUYỀN 2', N'Bóng làm từ nhựa tổng hợp rất bền và đàn hồi', N'Sản phẩm tốt', 0, N'30', N'NHIỀU MÀU ', 100000, N'Active', N'BongChuyen2.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'BC3_NHIỀU MÀUNHIỀU MÀU_30_NHÀ CUNG CẤP 5', 7, 4, N'BÓNG CHUYỀN 3', N'Bóng làm từ nhựa tổng hợp rất bền và đàn hồi', N'Sản phẩm tốt', 0, N'30', N'NHIỀU MÀU', 100000, N'Active', N'BongChuyen3.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'BC4_VÀNG_40_NHÀ CUNG CẤP 5', 7, 4, N'BÓNG CHUYỀN 4', N'Bóng làm từ nhựa tổng hợp rất bền và đàn hồi', N'Sản phẩm tốt', 0, N'40', N'VÀNG', 100000, N'Active', N'BongChuyen4.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'BĐ1_TRẮNG_30_NHÀ CUNG CẤP 2', 6, 1, N'BÓNG ĐÁ 1', N'Bóng làm từ nhựa tổng hợp rất bền và đàn hồi', N'Sản phẩm tốt', 0, N'30', N'TRẮNG', 80000, N'Active', N'BongDa1.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'BĐ2_XÁM_30_NHÀ CUNG CẤP 2', 6, 1, N'BÓNG ĐÁ 2', N'Bóng làm từ nhựa tổng hợp rất bền và đàn hồi', N'Sản phẩm tốt', 0, N'30', N'XÁM', 90000, N'Active', N'BongDa2.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'BR1_ĐỎ_40_NHÀ CUNG CẤP 2', 4, 1, N'BÓNG RỔ 1', N'Bóng làm từ nhựa tổng hợp rất bền và đàn hồi', N'Sản phẩm tốt', 0, N'40', N'ĐỎ', 100000, N'Active', N'BongRo1.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'BR2_ĐỎ_40_NHÀ CUNG CẤP 2', 4, 1, N'BÓNG RỔ 2', N'Bóng làm từ nhựa tổng hợp rất bền và đàn hồi', N'Sản phẩm tốt', 0, N'40', N'ĐỎ', 100000, N'Active', N'BongRo2.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'BR3_ĐỎ_40_NHÀ CUNG CẤP 3', 4, 2, N'BÓNG RỔ 3', N'Bóng làm từ nhựa tổng hợp rất bền và đàn hồi', N'Sản phẩm tốt', 0, N'40', N'ĐỎ', 100000, N'Active', N'BongRo3.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'DA_XANH_21_NHÀ CUNG CẤP 1', 1, 0, N'GIÀY VẢI LOẠI 1', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'39', N'XANH', 500000, N'Active', N'giay3.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'EA_XANH_12_NHÀ CUNG CẤP 1', 1, 0, N'GIÀY VẢI LOẠI 2', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'40', N'XANH', 500000, N'Active', N'giay2.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'F_XANH_M_NHÀ CUNG CẤP 1', 1, 0, N'GIÀY VẢI LOẠI 3', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'44', N'XANH', 300000, N'Active', N'giay3.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'GDN3_ĐEN_XL_NHÀ CUNG CẤP 3', 3, 2, N'GIÀY DA NỮ 3', N'Giày da dành cho nữ giới', N'Sản phẩm tốt', 0, N'XL', N'ĐEN', 700000, N'Active', N'GiayDaNu3.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'GTTN1_TRẮNG_40_NHÀ CUNG CẤP 2', 2, 1, N'GIÀY THỂ THAO NỮ 1', N'Giày thể thao cho nữ vận động ngoài trời với kiểu dáng thon gọn, ôm sát cổ chân, khá là mát mẻ ', N'Sản phẩm tốt', 0, N'40', N'TRẮNG', 700000, N'Active', N'GiayNu1.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'GTTN2_XÁM_40_NHÀ CUNG CẤP 2', 2, 1, N'GIÀY THỂ THAO NỮ 2', N'Giày thể thao cho nữ vận động ngoài trời với kiểu dáng thon gọn, ôm sát cổ chân, khá là mát mẻ ', N'Sản phẩm tốt', 0, N'40', N'XÁM', 750000, N'Active', N'GiayNu2.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'GTTN3_TRẮNG_42_NHÀ CUNG CẤP 2', 2, 1, N'GIÀY THỂ THAO NỮ 3', N'Giày thể thao cho nữ vận động ngoài trời với kiểu dáng thon gọn, ôm sát cổ chân, khá là mát mẻ ', N'Sản phẩm tốt', 0, N'42', N'TRẮNG', 800000, N'Active', N'GiayNu3.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'NA_ĐEN_XXL_NHÀ CUNG CẤP 1', 0, 0, N'GIÀY VẢI LOẠI 4', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'43', N'ĐEN', 700000, N'Active', N'giay4.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SP0_Đ_XXL_NHÀ CUNG CẤP 1', 0, 0, N'GIÀY VẢI THOÁNG LOẠI 1', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 110, N'40', N'ĐEN', 300000, N'Active', N'giay4.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SP0_ĐEN_L_NHÀ CUNG CẤP 1', 0, 0, N'GIÀY VẢI THOÁNG LOẠI 2', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'41', N'ĐEN', 400000, N'Active', N'giay3.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SP0_ĐEN_XXL_NHÀ CUNG CẤP 1', 0, 0, N'GIÀY VẢI THOÁNG LOẠI 3', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'42', N'ĐEN', 300000, N'Active', N'giay1.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SP0_XANH_XXL_NHÀ CUNG CẤP 1', 0, 0, N'GIÀY VẢI THOÁNG MÁT', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Thoáng khí', 10, N'45', N'XANH', 900000, N'Active', N'giay1.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SP1_ĐEN_XXL_NHÀ CUNG CẤP 3', 3, 2, N'GIÀY DA NỮ LOẠI 1', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'37', N'ĐEN', 2200000, N'Active', N'GiayDaNu1.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SP1_XANH LÁXANH LÁ_L_NHÀ CUNG CẤP 3', 3, 2, N'GIÀY DA NỮ LOẠI 2', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'39', N'XANH LÁ', 2200000, N'Active', N'GiayDaNu2.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SP4_Đ_M_NHÀ CUNG CẤP 3', 2, 2, N'GIÀY VẢI NỮ LOẠI 1', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'40', N'ĐEN', 800000, N'Inactive', N'pi7.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SPM1_Đ_30_NHÀ CUNG CẤP 5', 2, 4, N'GIÀY VẢI MỀM NỮ', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'42', N'ĐEN', 2500000, N'Active', N'giay4.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SPM2_Đ_30_NHÀ CUNG CẤP 1', 1, 0, N'GIÀY VẢI TRƠN CHO NAM', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'43', N'ĐỎ', 1000000, N'Active', N'giay3.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SPM3_X_50_NHÀ CUNG CẤP 1', 1, 0, N'GIÀY VẢI MỀM CHO NAM', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'45', N'XANH', 1100000, N'Active', N'giay1.jpg')
INSERT [dbo].[Product] ([productID], [subcategoryID], [supplierID], [productName], [productDescription], [productFeedback], [productRate], [productSize], [productColor], [exportPrice], [productStatus], [productIcon]) VALUES (N'SPT_VÀNG_50_NHÀ CUNG CẤP 2', 1, 1, N'GIÀY VẢI MỀM CHO NAM', N'THÔNG TIN SẢN PHẨM: Chất liệu là Da bò thật 100% nhập khẩu nguyên miếng. Đế cao su đúc nguyên khối cùng với màu sắc là màu đen trơn nhẵn đi với kiểu dáng thiết kế bởi SmartMen theo hơi hướng lịch lãm nhưng vẫn rất trẻ trung và thời thượng. Có xuất xứ và phân phối độc quyền bởi NAM SMART MEN.', N'Sản phẩm tốt', 10, N'45', N'VÀNG', 1000000, N'Active', N'giay4.jpg')
INSERT [dbo].[Rating] ([rateID], [userID], [productID]) VALUES (0, 6, N'NA_ĐEN_XXL_NHÀ CUNG CẤP 1')
INSERT [dbo].[Rating] ([rateID], [userID], [productID]) VALUES (1, 10, N'SP0_Đ_XXL_NHÀ CUNG CẤP 1')
INSERT [dbo].[Rating] ([rateID], [userID], [productID]) VALUES (2, 6, N'AB_X_XL_ADDIDAS')
INSERT [dbo].[ShippingInfor] ([shipID], [orderID], [shipPhone], [address], [shipName], [dateShip]) VALUES (1, 2, N'09555555555', N'Số 36 ngõ 44 pháo đài láng', N'Nguyễn Minh Đức', NULL)
INSERT [dbo].[ShippingInfor] ([shipID], [orderID], [shipPhone], [address], [shipName], [dateShip]) VALUES (2, 3, N'09555555555', N'Số 36 ngõ 44 pháo đài láng', N'Nguyễn Minh Đức', NULL)
INSERT [dbo].[ShippingInfor] ([shipID], [orderID], [shipPhone], [address], [shipName], [dateShip]) VALUES (3, 1, N'09555555555', N'Số 36 ngõ 44 pháo đài láng', N'Nguyễn Minh Đức', NULL)
INSERT [dbo].[ShippingInfor] ([shipID], [orderID], [shipPhone], [address], [shipName], [dateShip]) VALUES (4, 4, N'09555555555', N'Số 36 ngõ 44 pháo đài láng', N'Nguyễn Minh Đức', NULL)
INSERT [dbo].[ShippingInfor] ([shipID], [orderID], [shipPhone], [address], [shipName], [dateShip]) VALUES (6, 6, N'0912312312', N'Tp. Việt Trì', N'customerdemo123123', NULL)
INSERT [dbo].[ShippingInfor] ([shipID], [orderID], [shipPhone], [address], [shipName], [dateShip]) VALUES (7, 7, N'095555555554', N'Số 36 ngõ 44 pháo đài láng h', N'Nguyễn Minh Đức', NULL)
INSERT [dbo].[ShippingInfor] ([shipID], [orderID], [shipPhone], [address], [shipName], [dateShip]) VALUES (8, 8, N'095555555554', N'Số 36 ngõ 44 pháo đài láng h', N'Nguyễn Minh Đức', NULL)
INSERT [dbo].[ShippingInfor] ([shipID], [orderID], [shipPhone], [address], [shipName], [dateShip]) VALUES (9, 9, N'095555555554', N'Số 36 ngõ 44 pháo đài láng h', N'Nguyễn Minh Đức', NULL)
INSERT [dbo].[ShippingInfor] ([shipID], [orderID], [shipPhone], [address], [shipName], [dateShip]) VALUES (10, 10, N'095555555554', N'Số 36 ngõ 44 pháo đài láng h', N'Nguyễn Minh Đức', NULL)
INSERT [dbo].[ShoppingCart] ([cartID], [userID], [productID], [productQuantityOrder], [productTotalPrice], [productPrice]) VALUES (1, 6, N'SP0_ĐEN_XXL_NHÀ CUNG CẤP 1', 8, 2400000, 300000)
SET IDENTITY_INSERT [dbo].[SubCategory] ON 

INSERT [dbo].[SubCategory] ([subcategoryID], [categoryID], [subcategoryName]) VALUES (0, 1, N'Giày Vải Nam 1')
INSERT [dbo].[SubCategory] ([subcategoryID], [categoryID], [subcategoryName]) VALUES (1, 1, N'Giày Nam')
INSERT [dbo].[SubCategory] ([subcategoryID], [categoryID], [subcategoryName]) VALUES (2, 2, N'Giày Nữ')
INSERT [dbo].[SubCategory] ([subcategoryID], [categoryID], [subcategoryName]) VALUES (3, 2, N'Giày Da Nữ')
INSERT [dbo].[SubCategory] ([subcategoryID], [categoryID], [subcategoryName]) VALUES (4, 3, N'Bóng Rổ')
INSERT [dbo].[SubCategory] ([subcategoryID], [categoryID], [subcategoryName]) VALUES (5, 1, N'Quần Thể Thao Nam')
INSERT [dbo].[SubCategory] ([subcategoryID], [categoryID], [subcategoryName]) VALUES (6, 3, N'Bóng đá')
INSERT [dbo].[SubCategory] ([subcategoryID], [categoryID], [subcategoryName]) VALUES (7, 3, N'Bóng Chuyền')
INSERT [dbo].[SubCategory] ([subcategoryID], [categoryID], [subcategoryName]) VALUES (8, 2, N'Áo dành cho nữ')
SET IDENTITY_INSERT [dbo].[SubCategory] OFF
SET IDENTITY_INSERT [dbo].[Supplier] ON 

INSERT [dbo].[Supplier] ([supplierID], [supplierName], [email], [phone], [address]) VALUES (0, N'NHÀ CUNG CẤP 1', N'nhacungcap1@gmail.com', N'0961123797', N'Số 36 ngõ 44 pháo đài láng')
INSERT [dbo].[Supplier] ([supplierID], [supplierName], [email], [phone], [address]) VALUES (1, N'NHÀ CUNG CẤP 2', N'nhacungcap2@gmail.com', N'0961123797', N'Số 36 ngõ 50 Hồ chi minh')
INSERT [dbo].[Supplier] ([supplierID], [supplierName], [email], [phone], [address]) VALUES (2, N'NHÀ CUNG CẤP 3', N'nhacungcap3@gmail.com', N'0961123797', N'Số 85, d3, phường hoàng mai')
INSERT [dbo].[Supplier] ([supplierID], [supplierName], [email], [phone], [address]) VALUES (3, N'NHÀ CUNG CẤP 4', N'nhacungcap4@gmail.com', N'0812345895', N'phố hoa bằng')
INSERT [dbo].[Supplier] ([supplierID], [supplierName], [email], [phone], [address]) VALUES (4, N'NHÀ CUNG CẤP 5', N'nhacungcap5@gmail.com', N'0978852079', N'Long biên, Hà Nội')
SET IDENTITY_INSERT [dbo].[Supplier] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([userID], [typeID], [username], [password], [fullname], [address], [phone], [email], [gender], [birthday], [registerDate], [status]) VALUES (0, 1, N'manager1', N'manager', N'Quan ly cua hang', N'690 Hồng Hà', N'0961123797', N'nhacungcap4@gmail.com', N'Nam', N'05/06/1997', N'12/22/2019 11:06:22 AM', N'Inactive')
INSERT [dbo].[User] ([userID], [typeID], [username], [password], [fullname], [address], [phone], [email], [gender], [birthday], [registerDate], [status]) VALUES (5, 1, N'manager', N'111111', N'Nguyễn Minh ĐỨc', N'691 Hồng Hà', N'0961123797', N'nhacungcap1@gmail.com', N'Nam', N'01/04/1997', N'1/16/2020 7:47:33 PM', N'Active')
INSERT [dbo].[User] ([userID], [typeID], [username], [password], [fullname], [address], [phone], [email], [gender], [birthday], [registerDate], [status]) VALUES (6, 3, N'Customer', N'111111', N'Nguyễn Minh Đức', N'692 Hồng Hà', N'0961123796', N'nhacungcap2@gmail.com', N'Nữ', N'15/01/1997', N'12/19/2019 9:22:37 AM', N'Inactive')
INSERT [dbo].[User] ([userID], [typeID], [username], [password], [fullname], [address], [phone], [email], [gender], [birthday], [registerDate], [status]) VALUES (8, 3, N'Customer02', N'customer', N'Nguyễn Văn C', N'683 Chương Dương', N'0961123792', N'nhacungcap7@gmail.com', N'Nam', N'24/08/1997', N'12/19/2019 9:22:37 AM', N'Inactive')
INSERT [dbo].[User] ([userID], [typeID], [username], [password], [fullname], [address], [phone], [email], [gender], [birthday], [registerDate], [status]) VALUES (9, 3, N'Customer03', N'customer', N'Trần Thị E', N'19 An Dương', N'0961154678', N'nhacungcap5@gmail.com', N'Nữ', N'11/01/1997', N'12/19/2019 9:22:37 AM', N'Active')
INSERT [dbo].[User] ([userID], [typeID], [username], [password], [fullname], [address], [phone], [email], [gender], [birthday], [registerDate], [status]) VALUES (10, 3, N'customerdemo', N'mkuln', N'Nguyễn Minh Đức', N'456 ABC', N'0955555554', N'ducnmse05025@fpt.edu.vnn', N'Nam', N'14/01/1997', N'12/24/2019 2:14:10 AM', N'Active')
INSERT [dbo].[User] ([userID], [typeID], [username], [password], [fullname], [address], [phone], [email], [gender], [birthday], [registerDate], [status]) VALUES (12, 3, N'customerdemo123123', N'123123', N'Phạm Minh Tuấn', N'Tp. Việt Trì', N'0912312312', N'tuan23798@gmail.com34', N'Nam', N'14/02/1997', N'1/13/2020 3:50:16 AM', N'Active')
INSERT [dbo].[User] ([userID], [typeID], [username], [password], [fullname], [address], [phone], [email], [gender], [birthday], [registerDate], [status]) VALUES (14, 2, N'staff1', N'111111', N'Nguyễn Minh Đức', N'Hà Nội', N'0948462810', N'uchikinatora@gmail.com', N'Nam', N'28/10/1996', N'4/20/2020 3:50:16 AM', N'Active')
INSERT [dbo].[User] ([userID], [typeID], [username], [password], [fullname], [address], [phone], [email], [gender], [birthday], [registerDate], [status]) VALUES (15, 2, N'staffdemo', N'111111', N'Lê Thị Hằng', N'575 Cầu giấy', N'0923456789', N'abcxyz@gmail.com', N'Nữ', N'01/05/2012', N'4/27/2020 9:38:45 PM', N'Active')
SET IDENTITY_INSERT [dbo].[User] OFF
INSERT [dbo].[UserType] ([typeID], [typeName]) VALUES (1, N'manager')
INSERT [dbo].[UserType] ([typeID], [typeName]) VALUES (2, N'staff')
INSERT [dbo].[UserType] ([typeID], [typeName]) VALUES (3, N'customer')
ALTER TABLE [dbo].[ImportShipment]  WITH CHECK ADD  CONSTRAINT [FK_ImportShipment_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([productID])
GO
ALTER TABLE [dbo].[ImportShipment] CHECK CONSTRAINT [FK_ImportShipment_Product]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([productID])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_Product]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([userID])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([orderID])
REFERENCES [dbo].[Order] ([orderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_SubCategory] FOREIGN KEY([subcategoryID])
REFERENCES [dbo].[SubCategory] ([subcategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_SubCategory]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Supplier] FOREIGN KEY([supplierID])
REFERENCES [dbo].[Supplier] ([supplierID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Supplier]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([productID])
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_Product]
GO
ALTER TABLE [dbo].[ShippingInfor]  WITH CHECK ADD  CONSTRAINT [FK_ShippingInfor_Order] FOREIGN KEY([orderID])
REFERENCES [dbo].[Order] ([orderID])
GO
ALTER TABLE [dbo].[ShippingInfor] CHECK CONSTRAINT [FK_ShippingInfor_Order]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([productID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Product]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_User] FOREIGN KEY([userID])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_User]
GO
ALTER TABLE [dbo].[SubCategory]  WITH CHECK ADD  CONSTRAINT [FK_SubCategory_Category] FOREIGN KEY([categoryID])
REFERENCES [dbo].[Category] ([categoryID])
GO
ALTER TABLE [dbo].[SubCategory] CHECK CONSTRAINT [FK_SubCategory_Category]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_UserType] FOREIGN KEY([typeID])
REFERENCES [dbo].[UserType] ([typeID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_UserType]
GO
