USE [master]
GO
/****** Object:  Database [C&A]    Script Date: 11/12/2019 11:36:55 PM ******/
CREATE DATABASE [C&A]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'C&A', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.PHAMTUNG\MSSQL\DATA\C&A.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'C&A_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.PHAMTUNG\MSSQL\DATA\C&A_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [C&A] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [C&A].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [C&A] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [C&A] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [C&A] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [C&A] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [C&A] SET ARITHABORT OFF 
GO
ALTER DATABASE [C&A] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [C&A] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [C&A] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [C&A] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [C&A] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [C&A] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [C&A] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [C&A] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [C&A] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [C&A] SET  ENABLE_BROKER 
GO
ALTER DATABASE [C&A] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [C&A] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [C&A] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [C&A] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [C&A] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [C&A] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [C&A] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [C&A] SET RECOVERY FULL 
GO
ALTER DATABASE [C&A] SET  MULTI_USER 
GO
ALTER DATABASE [C&A] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [C&A] SET DB_CHAINING OFF 
GO
ALTER DATABASE [C&A] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [C&A] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [C&A] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'C&A', N'ON'
GO
ALTER DATABASE [C&A] SET QUERY_STORE = OFF
GO
USE [C&A]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [C&A]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/12/2019 11:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[categoryID] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 11/12/2019 11:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[productPropertyID] [nvarchar](50) NOT NULL,
	[categoryID] [int] NOT NULL,
	[productQuantity] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order]    Script Date: 11/12/2019 11:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[orderID] [int] NOT NULL,
	[userID] [int] NOT NULL,
	[productID] [int] NOT NULL,
	[productName] [nvarchar](50) NULL,
	[productQuantityOrder] [nvarchar](50) NULL,
	[productTotalPrice] [nvarchar](50) NULL,
	[orderTotalPrice] [nvarchar](50) NULL,
	[dateCreate] [nvarchar](50) NULL,
	[dateConfirm] [nvarchar](50) NULL,
	[orderStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 11/12/2019 11:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[productID] [nvarchar](50) NOT NULL,
	[categoryID] [int] NOT NULL,
	[supplierID] [int] NOT NULL,
	[productName] [nvarchar](50) NULL,
	[productDescription] [nvarchar](max) NULL,
	[productFeedback] [nvarchar](max) NULL,
	[productRate] [int] NULL,
	[importDate] [datetime] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductProperty]    Script Date: 11/12/2019 11:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductProperty](
	[productPropertyID] [nvarchar](50) NOT NULL,
	[productID] [nvarchar](50) NOT NULL,
	[productSize] [nvarchar](50) NULL,
	[productColor] [nvarchar](50) NULL,
	[importPrice] [nvarchar](50) NULL,
	[exportPrice] [nvarchar](50) NULL,
	[productStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductProperty] PRIMARY KEY CLUSTERED 
(
	[productPropertyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReturnOrder]    Script Date: 11/12/2019 11:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnOrder](
	[productID] [int] NOT NULL,
	[productName] [nvarchar](50) NULL,
	[quantity] [nvarchar](50) NULL,
	[descriptionReturn] [nvarchar](max) NULL,
 CONSTRAINT [PK_ReturnOrder] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShippingInfor]    Script Date: 11/12/2019 11:36:56 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 11/12/2019 11:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[cartID] [int] NOT NULL,
	[userID] [int] NOT NULL,
	[productID] [nvarchar](50) NOT NULL,
	[productName] [nvarchar](50) NULL,
	[productQuantityOrder] [nvarchar](50) NULL,
	[productTotalPrice] [nvarchar](50) NULL,
	[orderTotalPrice] [nvarchar](50) NULL,
 CONSTRAINT [PK_ShoppingCart_1] PRIMARY KEY CLUSTERED 
(
	[cartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 11/12/2019 11:36:56 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/12/2019 11:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userID] [int] NOT NULL,
	[typeID] [int] NOT NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[fullname] [nvarchar](50) NULL,
	[avatar] [nvarchar](max) NULL,
	[address] [nvarchar](max) NULL,
	[phone] [nvarchar](max) NULL,
	[email] [nvarchar](max) NULL,
	[gender] [nvarchar](50) NULL,
	[birthday] [nvarchar](50) NULL,
	[registerDate] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserType]    Script Date: 11/12/2019 11:36:56 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_productRate]  DEFAULT ((0)) FOR [productRate]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_importDate]  DEFAULT (getdate()) FOR [importDate]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_ProductProperty] FOREIGN KEY([productPropertyID])
REFERENCES [dbo].[ProductProperty] ([productPropertyID])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_ProductProperty]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_ReturnOrder] FOREIGN KEY([productID])
REFERENCES [dbo].[ReturnOrder] ([productID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_ReturnOrder]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([userID])
REFERENCES [dbo].[Users] ([userID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([categoryID])
REFERENCES [dbo].[Category] ([categoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Supplier] FOREIGN KEY([supplierID])
REFERENCES [dbo].[Supplier] ([supplierID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Supplier]
GO
ALTER TABLE [dbo].[ProductProperty]  WITH CHECK ADD  CONSTRAINT [FK_ProductProperty_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([productID])
GO
ALTER TABLE [dbo].[ProductProperty] CHECK CONSTRAINT [FK_ProductProperty_Product]
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
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_User1] FOREIGN KEY([userID])
REFERENCES [dbo].[Users] ([userID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_User1]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_User_UserType1] FOREIGN KEY([typeID])
REFERENCES [dbo].[UserType] ([typeID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_User_UserType1]
GO
USE [master]
GO
ALTER DATABASE [C&A] SET  READ_WRITE 
GO
