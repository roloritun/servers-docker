use master;
create database [tax.db];
GO
use [tax.db];
CREATE TABLE [dbo].[LineItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LineItemCode]  [nvarchar](max) NOT NULL,
	[LineItemDescription] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL);