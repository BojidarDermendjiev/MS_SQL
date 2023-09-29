CREATE DATABASE [TableRelations]

USE [TableRelations]

--01. One-To-One Relationship

CREATE TABLE [Passports]
(
	[PassportID] INT NOT NULL,
	[PassportNumber] CHAR(8) NOT NULL,
)

ALTER TABLE [Passports]
ADD CONSTRAINT PK_PassportId 
PRIMARY KEY (PassportId)

INSERT INTO [Passports] VALUES
	(101, 'N34FG21B'),
	(102, 'K65LO4R7'),
	(103, 'ZE657QP2')

-- Table Persons

CREATE TABLE [Persons]
(
	[PersonId] INT IDENTITY,
	[FirstName] NVARCHAR(50) NOT NULL,
	[Salary] DECIMAL(7, 2) NOT NULL,
	[PassportID] INT NOT NULL
)

ALTER TABLE [Persons]
ADD CONSTRAINT PK_PersonId
PRIMARY KEY (PersonId)

ALTER TABLE [Persons]
ADD CONSTRAINT FK_Persons_Passports
FOREIGN KEY (PassportId) 
REFERENCES [Passports](PassportId)

INSERT INTO [Persons] VALUES
	('Roberto', 43300.00, 102),
	('Tom', 56100.00, 103),
	('Yana', 60200.00, 101)

--02. One-To-Many Relationship

CREATE TABLE [Manufacturers](
    [ManufacturerID] INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(100),
    [EstablishedOn] DATE NOT NULL
)


INSERT INTO [Manufacturers]
    ([Name], [EstablishedOn]) 
    VALUES
	    ('BMW', '1916-03-07'),
	    ('Tesla', '2003-01-01'),
	    ('Lada', '1966-05-01')


CREATE TABLE [Models](
    [ModelID] INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(100),
    [ManufacturerID] INT FOREIGN KEY REFERENCES [Manufacturers]([ManufacturerID])
)

INSERT INTO [Models] VALUES
	('X1', 1),
	('i6', 1),
	('Model S', 2),
	('Model X', 2),
	('Model 3', 2),
	('Nova', 3)

--03. Many-To-Many Relationship

CREATE TABLE [Students](
    [StudentID] INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(100) NOT NULL
)

INSERT INTO [Students] VALUES
	('Mila'),
	('Toni'),
	('Ron')


CREATE TABLE [Exams](
    [ExamID] INT IDENTITY(101, 1) PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL
)

INSERT INTO [Exams] VALUES
	('SpringMVC'),
	('Neo4j'),
	('Oracle 11g')

CREATE TABLE [StudentsExams](
    [StudentID] INT FOREIGN KEY REFERENCES[Students]([StudentID]) NOT NULL,
    [ExamID] INT FOREIGN KEY REFERENCES [Exams](ExamID) NOT NULL,
    CONSTRAINT PK_StudentsExams 
	PRIMARY KEY (StudentID, ExamID)
)

INSERT INTO [StudentsExams] VALUES
	(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103)

--04. Self-Referencing

CREATE TABLE [Teachers](
    [TeacherID] INT IDENTITY(101, 1) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    [ManagerID] INT FOREIGN KEY REFERENCES [Teachers]([TeacherID])
)

INSERT INTO [Teachers] VALUES
	('John', NULL),
	('Maya', 106),
	('Silvia', 106),
	('Ted', 105),
	('Mark', 101),
	('Greta', 101)

--05. Online Store Database

CREATE TABLE [Cities](
    [CityID] INT PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100) NOT NULL
)

CREATE TABLE [Customers](
    [CustomerID] INT PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Birthday] DATE NOT NULL,
    [CityID] INT NOT NULL 
     FOREIGN KEY REFERENCES [Cities]([CityID]) 
)

CREATE TABLE [Orders](
    [OrderID] INT PRIMARY KEY NOT NULL,
    [CustomerID] INT NOT NULL
     FOREIGN KEY REFERENCES [Customers]([CustomerID]) 
)

CREATE TABLE [ItemTypes](
    [ItemTypeID] INT PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100) NOT NULL
)

CREATE TABLE [Items](
    [ItemID] INT PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [ItemTypeID] INT NOT NULL
     FOREIGN KEY REFERENCES [ItemTypes]([ItemTypeID])
)

CREATE TABLE [OrderItems](
    [OrderID] INT NOT NULL
     FOREIGN KEY REFERENCES [Orders]([OrderID]),
    [ItemID] INT NOT NULL
     FOREIGN KEY REFERENCES [Items]([ItemID]),
     CONSTRAINT PK_OrderItems
		PRIMARY KEY (OrderID, ItemID)
)

--06. University Database

CREATE TABLE [Majors](
    [MajorID] INT PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100) NOT NULL
)

CREATE TABLE [Subjects](
    [SubjectID] INT PRIMARY KEY NOT NULL,
    [SubjectName] NVARCHAR(100) NOT NULL
)

CREATE TABLE [Students](
    [StudentID] INT PRIMARY KEY NOT NULL,
    [StudentNumber] INT NOT NULL,
    [StudentName] NVARCHAR(100) NOT NULL,
    [MajorID] INT FOREIGN KEY REFERENCES [Majors]([MajorID]) NOT NULL
)

CREATE TABLE [Agenda](
    [StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]) NOT NULL,
    [SubjectID] INT FOREIGN KEY REFERENCES [Subjects]([SubjectID]) NOT NULL,
    CONSTRAINT PK_Agenda 
		PRIMARY KEY (StudentID, SubjectID)
)

CREATE TABLE [Payments](
    [PaymentID] INT NOT NULL PRIMARY KEY,
    [PaymentDate] DATE NOT NULL,
    [PaymentAmount] DECIMAL(6, 2) NOT NULL,
   [StudentID] INT NOT NULL FOREIGN KEY
		REFERENCES [Students](StudentID)
)

--07. SoftUni Design

CREATE TABLE [Managers](
    [ManagerID] INT PRIMARY KEY NOT NULL,
    [ManagerName] NVARCHAR(100) NOT NULL
)

CREATE TABLE [Employees](
    [EmployeeID] INT PRIMARY KEY NOT NULL,
    [EmployeeName] NVARCHAR(100) NOT NULL,
    [DepartmentID] INT FOREIGN KEY REFERENCES [Departments]([DepartmentID]) NOT NULL,
    [ManagerID] INT FOREIGN KEY REFERENCES [Managers]([ManagerID]) NOT NULL
)

CREATE TABLE [Departments](
    [DepartmentID] INT PRIMARY KEY NOT NULL,
    [DepartmentName] NVARCHAR(100) NOT NULL,
    [ManagerID] INT FOREIGN KEY REFERENCES [Employees]([EmployeeID]) NOT NULL
)

--08. Geography Design

CREATE TABLE [Country](
    [CountryID] INT PRIMARY KEY NOT NULL,
    [CountryName] NVARCHAR(100) NOT NULL
)
CREATE TABLE [Region](
    [RegionID] INT PRIMARY KEY NOT NULL,
    [RegionName] NVARCHAR(100) NOT NULL,
    [CountryID] INT FOREIGN KEY REFERENCES [Country]([CountryID]) NOT NULL
)
CREATE TABLE [City](
    [CityID] INT PRIMARY KEY NOT NULL,
    [CityName] NVARCHAR(100) NOT NULL,
    [RegionID] INT FOREIGN KEY REFERENCES [Region]([RegionID]) NOT NULL
)

--09. *Peaks in Rila

USE [Geography]

SELECT m.MountainRange, p.PeakName, p.Elevation
FROM [Peaks] AS p
JOIN [Mountains] AS m
ON p.MountainId = m.Id
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC