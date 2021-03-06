USE [master]
GO
/****** Object:  Database [Test]    Script Date: 3/23/2022 4:53:46 PM ******/
CREATE DATABASE [Test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Test', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Test.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Test_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Test_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Test] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Test] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Test] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Test] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Test] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Test] SET ARITHABORT OFF 
GO
ALTER DATABASE [Test] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Test] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Test] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Test] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Test] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Test] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Test] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Test] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Test] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Test] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Test] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Test] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Test] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Test] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Test] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Test] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Test] SET RECOVERY FULL 
GO
ALTER DATABASE [Test] SET  MULTI_USER 
GO
ALTER DATABASE [Test] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Test] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Test] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Test] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Test] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Test] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Test', N'ON'
GO
ALTER DATABASE [Test] SET QUERY_STORE = OFF
GO
USE [Test]
GO
/****** Object:  User [kunal]    Script Date: 3/23/2022 4:53:46 PM ******/
CREATE USER [kunal] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [devloper]    Script Date: 3/23/2022 4:53:46 PM ******/
CREATE USER [devloper] FOR LOGIN [devloper] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [admin]    Script Date: 3/23/2022 4:53:46 PM ******/
CREATE USER [admin] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[admin]
GO
/****** Object:  Schema [admin]    Script Date: 3/23/2022 4:53:47 PM ******/
CREATE SCHEMA [admin]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 3/23/2022 4:53:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[EmailAddress] [nvarchar](50) NULL,
	[DOB] [datetime] NULL,
	[Salary] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([Id], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [DOB], [Salary], [CreatedDate]) VALUES (2, N'Kunal', N'Gawatre', N'7895462132', N'kunalgaw@cybage.com', CAST(N'2022-03-02T00:00:00.000' AS DateTime), CAST(25000.00 AS Decimal(18, 2)), CAST(N'2022-03-23T14:19:23.310' AS DateTime))
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
/****** Object:  StoredProcedure [dbo].[Sp_Crud]    Script Date: 3/23/2022 4:53:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Sp_Crud]  
(  
@EmpId int=0,@FirstName varchar(50)=Null,@LastName varchar(50)=Null,@PhoneNumber nvarchar(15)=Null,  
@EmailAddress nvarchar(50)=Null,@Salary decimal=Null,@Event varchar(10),@DOB datetime=Null 
)  
AS   
BEGIN  
    IF(@Event='Select')  
    BEGIN  
    SELECT * FROM Employee ORDER BY FirstName ASC;  
    END  
  
    ELSE IF(@Event='Add')  
    BEGIN  
    INSERT INTO Employee (FirstName,LastName,PhoneNumber,EmailAddress,DOB,Salary,CreatedDate) VALUES(@FirstName,@LastName,@PhoneNumber,@EmailAddress,@DOB,@Salary,GETDATE());  
    END  
  
    ELSE IF(@Event='Update')  
    BEGIN  
    UPDATE Employee SET FirstName=@FirstName,LastName=@LastName,PhoneNumber=@PhoneNumber,EmailAddress=@EmailAddress,Salary=@Salary where Id=@EmpId;  
    END  
  
    ELSE  
    BEGIN  
    DELETE FROM Employee WHERE Id=@EmpId;  
    END  
END  
  
GO
USE [master]
GO
ALTER DATABASE [Test] SET  READ_WRITE 
GO
