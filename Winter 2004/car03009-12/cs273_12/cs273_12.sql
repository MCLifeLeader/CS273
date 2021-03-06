use master
go

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'cs273_12')
	DROP DATABASE [cs273_12]
GO

CREATE DATABASE [cs273_12]
ON (
	NAME = N'cs273_12_Data', 
	FILENAME = N'd:\fm_sql\MSSQL\Data\cs273_12.MDF', 
	SIZE = 1, 
	FILEGROWTH = 10%
) LOG ON (
	NAME = N'cs273_12_Log', 
	FILENAME = N'd:\fm_sql\MSSQL\Data\cs273_12.LDF', 
	SIZE = 1, 
	FILEGROWTH = 10%
)
GO

use cs273_12
go

CREATE TABLE [Programs] (
	ProgramID int IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL ,
	ProgramName varchar (50) NOT NULL ,
	CONSTRAINT PK_Program_cs273_12 PRIMARY KEY CLUSTERED
	(
		ProgramID
	) ON [PRIMARY]
) ON [PRIMARY]
GO

/*
CREATE TABLE [ClassGroups] (
	GroupID char(10) NOT NULL ,
	CONSTRAINT PK_ClassGroups_cs273_12 PRIMARY KEY CLUSTERED
	(
		GroupID
	) ON [PRIMARY]
) ON [PRIMARY]
--GO
*/

CREATE TABLE [ClassData] (
	DataID int NOT NULL ,
	Data varchar (50) NOT NULL ,
	CONSTRAINT PK_ClassData_cs273_12 PRIMARY KEY CLUSTERED
	(
		DataID
	) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [Classes] (
	GroupID char (10) NOT NULL ,
	ClassID char (20) NOT NULL ,
	ClassName varchar (50) NOT NULL ,
	Credits int NOT NULL DEFAULT(5) ,
	CONSTRAINT PK_Classes_cs273_12 PRIMARY KEY CLUSTERED
	(
		GroupID,
		ClassID
	) ON [PRIMARY] /*,
	CONSTRAINT FK_Classes_ClassGroups FOREIGN KEY
	(
		GroupID
	) REFERENCES [ClassGroups] (
		GroupID
	)*/
) ON [PRIMARY]
GO

CREATE TABLE [Categories] (
	CategoryID int IDENTITY(1, 1) NOT NULL ,
	Category varchar (50) NOT NULL ,
	CONSTRAINT PK_Categories_cs273 PRIMARY KEY CLUSTERED
	(
		CategoryID
	) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Requierments] (
	ProgramID int NOT NULL ,
	GroupID char (10) NOT NULL ,
	ClassID char (20) NOT NULL ,
	CategoryID int NOT NULL ,
	CONSTRAINT PK_Requierments_cs273_12 PRIMARY KEY CLUSTERED
	(
		ProgramID,
		ClassID
	) ON [PRIMARY] ,
	CONSTRAINT FK_Requierments_Programs FOREIGN KEY
	(
		ProgramID
	) REFERENCES [Programs] (
		ProgramID
	),
	CONSTRAINT FK_Requierments_Classes FOREIGN KEY
	(
		GroupID,
		ClassID
	) REFERENCES [Classes] (
		GroupID,
		ClassID
	),
	CONSTRAINT FK_Requierments_Categories FOREIGN KEY
	(
		CategoryID
	) REFERENCES [Categories] (
		CategoryID
	)
) ON [PRIMARY]
GO




