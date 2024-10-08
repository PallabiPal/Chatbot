USE [master]
GO
/****** Object:  Database [information]    Script Date: 13-06-2024 14:51:52 ******/
CREATE DATABASE [information]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'information', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\information.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'information_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\information_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [information] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [information].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [information] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [information] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [information] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [information] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [information] SET ARITHABORT OFF 
GO
ALTER DATABASE [information] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [information] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [information] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [information] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [information] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [information] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [information] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [information] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [information] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [information] SET  ENABLE_BROKER 
GO
ALTER DATABASE [information] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [information] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [information] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [information] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [information] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [information] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [information] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [information] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [information] SET  MULTI_USER 
GO
ALTER DATABASE [information] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [information] SET DB_CHAINING OFF 
GO
ALTER DATABASE [information] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [information] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [information] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [information] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [information] SET QUERY_STORE = ON
GO
ALTER DATABASE [information] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [information]
GO
/****** Object:  User [sa1]    Script Date: 13-06-2024 14:51:52 ******/
CREATE USER [sa1] FOR LOGIN [sa1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[chatbot_options]    Script Date: 13-06-2024 14:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chatbot_options](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[response_id] [int] NULL,
	[option_text] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[chatbot_responses]    Script Date: 13-06-2024 14:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chatbot_responses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[question] [nvarchar](255) NOT NULL,
	[response] [nvarchar](255) NOT NULL,
	[has_options] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[enquiries]    Script Date: 13-06-2024 14:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[enquiries](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[current_month] [nvarchar](50) NOT NULL,
	[financial_year] [int] NOT NULL,
	[enquiry_text] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ticket]    Script Date: 13-06-2024 14:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ticket](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mobile_no] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 13-06-2024 14:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[login_id] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[chatbot_options] ON 

INSERT [dbo].[chatbot_options] ([id], [response_id], [option_text]) VALUES (1, 2, N'Generate a strong password')
INSERT [dbo].[chatbot_options] ([id], [response_id], [option_text]) VALUES (3, 2, N'existing password ')
INSERT [dbo].[chatbot_options] ([id], [response_id], [option_text]) VALUES (7, 1, N'TMS COMPLAINT')
INSERT [dbo].[chatbot_options] ([id], [response_id], [option_text]) VALUES (8, 1, N'DMS COMPLAINT')
INSERT [dbo].[chatbot_options] ([id], [response_id], [option_text]) VALUES (9, 1, N'TICKET RAISE')
INSERT [dbo].[chatbot_options] ([id], [response_id], [option_text]) VALUES (10, 1, N'NEED PASSWORD')
INSERT [dbo].[chatbot_options] ([id], [response_id], [option_text]) VALUES (13, 1, N'EXIT')
SET IDENTITY_INSERT [dbo].[chatbot_options] OFF
GO
SET IDENTITY_INSERT [dbo].[chatbot_responses] ON 

INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (1, N'hello', N'Hello! How can I assist you today?', 1)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (2, N'Need Password', N'', 1)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (3, N'Need Password', N'', 1)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (4, N'how are you', N'I''m doing well, thanks for asking!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (5, N'what can you do', N'I can answer questions, provide information, and assist with tasks.', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (6, N'goodbye', N'Goodbye! It was nice chatting with you.', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (7, N'thanks', N'You''re welcome!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (8, N'thank you', N'You''re welcome!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (9, N'how old are you', N'I don''t have an age, I''m a computer program!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (10, N'what is your purpose', N'My purpose is to assist and provide information to users like you.', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (11, N'What is the meaning of life?', N'42! Just kidding, I am still trying to figure that out myself. Want to grab a virtual coffee and discuss the meaninglessness of existence?', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (12, N'Can you tell me a joke?', N'Why did the robot go on a diet? Because it wanted to lose some bytes!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (13, N'Do you have a sense of humor?', N'Of course, I am a bot, I have a byte of humor!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (14, N'What is the best way to cook a chicken?', N'I''m a chatbot, not a chef! But I can give you a recipe for a robotic chicken nugget... just kidding!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (15, N'Do you have feelings?', N'Only 1s and 0s, but I can pretend to be emotional if you want.', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (16, N'Can you write a poem about a cat?', N'Here''s a quick one: ''Furry feline, whiskers so fine, purring loudly, all the time...'' Okay, I''ll stick to coding, not poetry!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (17, N'Can you talk like a pirate?', N'Arrgh, shiver me circuits! Aye, I be a chatbot, matey!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (18, N'Do you have a favorite food?', N'Bytes and bits of memory, of course! Just kidding, I don''t eat... or do I?', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (19, N'Can you tell me a secret?', N'I''m a chatbot, I don''t have secrets... or do I? Just kidding, I''m an open book... or code!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (20, N'Can you do a funny dance?', N'I''m a chatbot, I don''t have a body... but I can do a virtual robot dance for you!', NULL)
INSERT [dbo].[chatbot_responses] ([id], [question], [response], [has_options]) VALUES (21, N'existing password', N'Please enter your login ID to retrieve your password.', 0)
SET IDENTITY_INSERT [dbo].[chatbot_responses] OFF
GO
SET IDENTITY_INSERT [dbo].[enquiries] ON 

INSERT [dbo].[enquiries] ([id], [current_month], [financial_year], [enquiry_text]) VALUES (1, N'January', 2022, N'Enquiry 1')
INSERT [dbo].[enquiries] ([id], [current_month], [financial_year], [enquiry_text]) VALUES (2, N'January', 2022, N'Enquiry 2')
INSERT [dbo].[enquiries] ([id], [current_month], [financial_year], [enquiry_text]) VALUES (3, N'February', 2022, N'Enquiry 3')
INSERT [dbo].[enquiries] ([id], [current_month], [financial_year], [enquiry_text]) VALUES (4, N'February', 2022, N'Enquiry 4')
INSERT [dbo].[enquiries] ([id], [current_month], [financial_year], [enquiry_text]) VALUES (5, N'March', 2022, N'Enquiry 5')
INSERT [dbo].[enquiries] ([id], [current_month], [financial_year], [enquiry_text]) VALUES (6, N'March', 2022, N'Enquiry 6')
INSERT [dbo].[enquiries] ([id], [current_month], [financial_year], [enquiry_text]) VALUES (7, N'January', 2023, N'Enquiry 7')
INSERT [dbo].[enquiries] ([id], [current_month], [financial_year], [enquiry_text]) VALUES (8, N'January', 2023, N'Enquiry 8')
INSERT [dbo].[enquiries] ([id], [current_month], [financial_year], [enquiry_text]) VALUES (9, N'February', 2023, N'Enquiry 9')
INSERT [dbo].[enquiries] ([id], [current_month], [financial_year], [enquiry_text]) VALUES (10, N'February', 2023, N'Enquiry 10')
SET IDENTITY_INSERT [dbo].[enquiries] OFF
GO
SET IDENTITY_INSERT [dbo].[ticket] ON 

INSERT [dbo].[ticket] ([id], [mobile_no]) VALUES (1, 1234567890)
INSERT [dbo].[ticket] ([id], [mobile_no]) VALUES (2, 1234567890)
INSERT [dbo].[ticket] ([id], [mobile_no]) VALUES (3, 987654321)
INSERT [dbo].[ticket] ([id], [mobile_no]) VALUES (4, 1234567890)
SET IDENTITY_INSERT [dbo].[ticket] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [login_id], [password]) VALUES (1, N'1234', N'abcd')
INSERT [dbo].[users] ([id], [login_id], [password]) VALUES (2, N'5678', N'efgh')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[chatbot_responses] ADD  DEFAULT ((0)) FOR [has_options]
GO
ALTER TABLE [dbo].[chatbot_options]  WITH CHECK ADD FOREIGN KEY([response_id])
REFERENCES [dbo].[chatbot_responses] ([id])
GO
USE [master]
GO
ALTER DATABASE [information] SET  READ_WRITE 
GO
