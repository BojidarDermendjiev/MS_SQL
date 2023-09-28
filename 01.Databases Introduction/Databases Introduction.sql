--1st.Exercise
CREATE DATABASE [Minions]

USE [Minions]

GO
--2nd.Exercise
CREATE TABLE Minions(
	[Id] INT PRIMARY KEY,
	[Name] VARCHAR(100) NOT NULL,
	[Age] INT NOT NULL
)

--3th.Exercise
CREATE TABLE Towns(
	[Id] INT PRIMARY KEY,
	[Name] VARCHAR(100) NOT NULL
)

 ALTER TABLE [Minions]
 ADD [TownId] INT FOREIGN KEY REFERENCES [Towns]([Id]) NOT NULL
 
 --4th.Exercise
INSERT INTO [Towns]([Id],[Name])
		VALUES
		(1, 'Sofia'),
		(2, 'Plovdiv'),
		(3, 'Varna')

ALTER TABLE[Minions]
ALTER COLUMN [Age] INT

INSERT INTO [Minions]([Id], [Name], [Age], [TownId])
		VALUES
		(1, 'Kevin', 22, 1),
		(2, 'Bob', 15, 3),
		(3, 'Steward', NULL, 2)

--5th.Exercise
TRUNCATE TABLE [Minions]
--6th.Exercise
DROP TABLE [Minions]
--7th.Exercise
CREATE TABLE People(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200) NOT NULL, 
	[Pircture] VARBINARY(MAX), 
	CHECK (DATALENGTH([Pircture]) <= 2000000),
	[Height] DECIMAL(3, 2), 
	[Weight] DECIMAL(5, 2), 
	[Gender] CHAR(1) NOT NULL,
	CHECK ([Gender] = 'm' OR [Gender] = 'f'), 
	[Birthdate] DATE NOT NULL, 
	[Biography] NVARCHAR(MAX)
)

INSERT INTO [People]([Name], [Height], [Weight], [Gender], [Birthdate])
	VALUES
	('Pesho', 1.77, 75.2, 'm', '1998-05-24'),
	('Krasi', 1.87, 80.2, 'm', '1978-06-11'),
	('George', 1.82, 100.2, 'm', '1968-03-26'),
	('Ivan', 1.90, 85.2, 'm', '1928-01-19'),
	('Maria', 1.74, 47.2, 'f', '1928-01-19')

--8th.Exercise

CREATE TABLE Users(
	[Id] BIGINT,
	[Username] NVARCHAR(30) NOT NULL,
	[Password] NVARCHAR(26) NOT NULL,
	[ProfilePicture] IMAGE,
	[LastLoginTime] DATETIME,
	[IsDeleted] BIT,
	Constraint Pk_Users Primary Key(Id) 
)

DROP TABLE [Users]

INSERT INTO [Users]([Id], [Username], [Password], [ProfilePicture], [LastLoginTime], [IsDeleted])
 	VALUES
	('Username 1', 'Password 1', NULL, NULL, 0),
	('Username 2', 'Password 2', NULL, NULL, 0),
	('Username 3', 'Password 3', NULL, NULL, 0),
	('Username 4', 'Password 4', NULL, NULL, 1),
	('Username 5', 'Password 5', NULL, NULL, 1)
 
--9th.Exercise
ALTER TABLE [Users]
	DROP CONSTRAINT PK_Users

ALTER TABLE [Users]
	ADD CONSTRAINT PK_Users
	PRIMARY KEY (Id, Username)
 
--10th.Exercise
ALTER TABLE [Users]
	ADD CONSTRAINT Check_Password
		CHECK (LEN([Password]) >= 5)

 
--11th.Exercise

ALTER TABLE [Users]
ADD CONSTRAINT df_LastLoginTime
DEFAULT GETDATE() FOR [LastLoginTime]

--12th.Exercise

ALTER TABLE [Users]
DROP PK__Users__3214EC0782CA3FE3

ALTER TABLE [Users]
ADD CONSTRAINT PK__Users__3214EC0782CA3FE3 PRIMARY KEY (Id) ;

ALTER TABLE [Users]
ADD CONSTRAINT CHK_Usernames CHECK (LEN(Username) >= 3)

--13th.Exercise

CREATE DATABASE [Movies]

USE [Movies]

CREATE TABLE Directors(
	[Id] INT PRIMARY KEY IDENTITY,
	[DirectorName] NVARCHAR(100),
	[Note] NVARCHAR(MAX)
)

CREATE TABLE Genres(
	[Id] INT PRIMARY KEY IDENTITY,
	[GenreName] NVARCHAR(100),
	[Notes] NVARCHAR(MAX)
)

CREATE TABLE Categories(
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] NVARCHAR(100),
	[Notes] NVARCHAR(MAX)
) 

CREATE TABLE Movies(
	[Id] INT PRIMARY KEY IDENTITY,
	[Title] NVARCHAR(50) NOT NULL,
	[DirectorId] INT FOREIGN KEY REFERENCES [Directors](Id) NOT NULL,
	[CopyrightYear] INT NOT NULL,
	[Length] NVARCHAR(MAX),
	[GenreId] INT FOREIGN KEY REFERENCES [Genres](Id) NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories](Id) NOT NULL,
	[Rating] DECIMAL(2, 1) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

INSERT INTO [Directors] VALUES
	('Stanley Kubrick', NULL),
	('Alfred Hitchcock', NULL),
	('Quentin Tarantino', NULL),
	('Steven Spielberg', NULL),
	('Martin Scorsese', NULL)

INSERT INTO [Genres] VALUES
	('Action', NULL),
	('Comedy', NULL),
	('Drama', NULL),
	('Fantasy', NULL),
	('Horror', NULL)

INSERT INTO [Categories] VALUES
	('Short', NULL),
	('Long', NULL),
	('Biography', NULL),
	('Documentary', NULL),
	('TV', NULL)

INSERT INTO [Movies] VALUES
	('The Shawshank Redemption', 1, 1994, '02:22:00', 2, 3, 9.4, NULL),
	('The Godfather', 2, 1972, '02:55:00', 3, 4, 9.2, NULL),
	('Schindler`s List', 3, 1993, '03:15:00', 4, 5, 9.0, NULL),
	('Pulp Fiction', 4, 1994, '02:34:00', 5, 1, 8.9, NULL),
	('Fight Club', 5, 1999, '02:19:00', 1, 2, 8.8, NULL)


--14th.Exercise

CREATE DATABASE [CarRental]
 
USE [CarRental]


CREATE TABLE [Categories](
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] NVARCHAR(100) NOT NULL,
	[DailyRate] DECIMAL(6, 2) NOT NULL,	
	[WeeklyRate] DECIMAL(6, 2) NOT NULL,	
	[MonthlyRate] DECIMAL(6, 2) NOT NULL,	
	[WeekendRate] DECIMAL(6, 2) NOT NULL	
) 

CREATE TABLE [Cars](
	[Id] INT PRIMARY KEY IDENTITY,
	[PlateNumber] VARCHAR(30) NOT NULL,
	[Manufacturer] VARCHAR(30) NOT NULL,
	[Model] VARCHAR(50) NOT NULL, 
	[CarYear] INT NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]) NOT NULL,
	[Doors] INT NOT NULL,
	[Picture] IMAGE,
	[Condition] NVARCHAR(MAX) NOT NULL,
	[Available] BIT NOT NULL
)

CREATE TABLE [Employees](
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[Title] VARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

CREATE TABLE [Customers](
	[Id] INT PRIMARY KEY IDENTITY,
	[DriverLicenceNumber] INT NOT NULL,
	[FullName] NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(200) NOT NULL,
	[City] NVARCHAR(100) NOT NULL,
	[ZIPCode] INT NOT NULL,
	[Notes] NVARCHAR(MAX)
)

CREATE TABLE [RentalOrders](
	[Id] INT PRIMARY KEY IDENTITY,
	[EmployeeId] INT FOREIGN KEY REFERENCES[Employees]([Id]) NOT NULL,
	[CustomerId] INT FOREIGN KEY REFERENCES[Customers]([Id]) NOT NULL,
	[CarId] INT FOREIGN KEY REFERENCES[Cars]([Id]) NOT NULL,
	[TankLevel] INT NOT NULL,
	[KilometrageStart] INT NOT NULL,
	[KilometrageEnd] INT NOT NULL,
	[TotalKilometrage] INT NOT NULL,
	[StartDate] DATE  NOT NULL,
	[EndDate] DATE  NOT NULL,
	[TotalDays] INT NOT NULL,
	[RateApplied] DECIMAL(6, 2) NOT NULL,
	[TaxRate] DECIMAL(4, 2) NOT NULL,
	[OrderStatus] VARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(MAX)
) 

INSERT INTO [Categories] VALUES
	('First category name', 10.00, 50.00, 150.00, 20.00),
	('Second category name', 50.00, 250.00, 750.00, 100.00),
	('Third category name', 100.00, 500.00, 1500.00, 200.00)

INSERT INTO [Cars] VALUES
	('PLN 0001', 'Ford', 'Model A', 1994, 1, 4, NULL, 'Good', 1),
	('PLN 0002', 'Tesla', 'Model B', 2021, 2, 4, NULL, 'Great', 1),
	('PLN 0003', 'Capsule Corp', 'Model C', 2054, 3, 10, NULL, 'Best', 0)

INSERT INTO [Employees] VALUES
	('Tyler', 'Durden', 'Edward Norton`s Alter Ego', NULL),
	('Plain', 'Jane', 'some gal', NULL),
	('Average', 'Joe', 'some dude', NULL)

INSERT INTO [Customers] VALUES
	('123456', 'Jimmy Carr', 'Britain', 'London', 1000, NULL),
	('654321', 'Bill Burr', 'USA', 'Washington', 2000, NULL),
	('999999', 'Louis CK', 'Mexico', 'Mexico City', 3000, NULL)

INSERT INTO [RentalOrders]
	(
		[EmployeeId],
		[CustomerId],
		[CarId],
		[TankLevel],
		[KilometrageStart],
		[KilometrageEnd],
		[TotalKilometrage],
		[StartDate],
		[EndDate],
		[TotalDays],
		[RateApplied],
		[TaxRate],
		[OrderStatus],
		[Notes]
	)
	VALUES
	(1, 1, 1, 70, 90000, 100000, 10000, '1994-10-01', '1994-10-21', 20, 100.00, 14.00, 'Pending', NULL),
	(2, 2, 2, 85, 250000, 2750000, 25000, '2011-11-12', '2011-11-24', 12, 150.00, 17.50, 'Canceled', NULL),
	(3, 3, 3, 90, 0, 120000, 120000, '2025-04-05', '2025-05-02', 27, 220.00, 21.25, 'Delivered', NULL)

--15th.Exercise

CREATE DATABASE [Hotel]

USE [Hotel]

CREATE TABLE [Employees](
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[Title] VARCHAR(30) NOT NULL,
	[Notes] NVARCHAR(MAX)
) 

CREATE TABLE [Customers](
	[AccountNumber] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[PhoneNumber] INT NOT NULL,
	[EmergencyName] VARCHAR(50),
	[EmergencyNumber] INT,
	[Notes] NVARCHAR(MAX)
	
) 

CREATE TABLE [RoomStatus](
	[RoomStatus] VARCHAR(50) PRIMARY KEY NOT NULL,
	[Notes] NVARCHAR(MAX)
) 

CREATE TABLE [RoomTypes](
	[RoomType] VARCHAR(50) PRIMARY KEY NOT NULL,
	[Notes] NVARCHAR(MAX)
) 

CREATE TABLE [BedTypes](
	[BedType] VARCHAR(50) PRIMARY KEY NOT NULL,
	[Notes] NVARCHAR(MAX)
) 

CREATE TABLE [Rooms](
	[RoomNumber] INT PRIMARY KEY IDENTITY,
	[RoomType] VARCHAR(50) FOREIGN KEY REFERENCES [RoomTypes](RoomType) NOT NULL,
	[BedType] VARCHAR(50) FOREIGN KEY REFERENCES [BedTypes](BedType) NOT NULL,
	[Rate] DECIMAL(5,2) NOT NULL,
	[RoomStatus] VARCHAR(50) FOREIGN KEY REFERENCES [RoomStatus](RoomStatus) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

CREATE TABLE [Payments](
	[Id] INT PRIMARY KEY IDENTITY,
	[EmployeeId] INT FOREIGN KEY  REFERENCES [Employees]([Id]) NOT NULL,
	[PaymentDate] DATE NOT NULL,
	[AccountNumber] INT FOREIGN KEY REFERENCES [Customers]([AccountNumber]) NOT NULL,
	[FirstDateOccupied] DATE NOT NULL,
	[LastDateOccupied] DATE NOT NULL,
	[TotalDays] INT NOT NULL,
	[AmountCharged] DECIMAL(6, 2) NOT NULL,
	[TaxRate] DECIMAL(4, 2) NOT NULL,
	[TaxAmount] DECIMAL(6, 2) NOT NULL,
	[PaymentTotal] DECIMAL(6, 2) NOT NULL,
	[Notes] NVARCHAR(MAX)
) 

CREATE TABLE [Occupancies](
	[Id] INT PRIMARY KEY IDENTITY,
	[EmployeeId] INT FOREIGN KEY  REFERENCES [Employees]([Id]) NOT NULL,
	[DateOccupied] DATE NOT NULL,
	[AccountNumber] INT FOREIGN KEY REFERENCES [Customers]([AccountNumber]) NOT NULL,
	[RoomNumber] INT FOREIGN KEY REFERENCES [Rooms]([RoomNumber]) NOT NULL,
	[RateApplied] DECIMAL(4, 2) NOT NULL,
	[PhoneCharge] DECIMAL(4, 2) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

INSERT INTO [Employees] VALUES
	('Jim', 'McJim', 'Supervisor', NULL),
	('Jane', 'McJane', 'Cook', NULL),
	('John', 'McJohn', 'Waiter', NULL)
		
INSERT INTO [Customers] VALUES
	('Mickey', 'Mouse', 12345678, 'Minnie', 11111111, NULL),
	('Donald', 'Duck', 87654321, 'Daisy', 22222222, NULL),
	('Scrooge', 'McDuck', 9999999, 'Richie', 33333333, NULL)
		
INSERT INTO [RoomStatus] VALUES
	('Free', NULL),
	('Occupied', NULL),
	('No idea', NULL)
		
INSERT INTO [RoomTypes] VALUES
	('Room', NULL),
	('Studio', NULL),
	('Apartment', NULL)
		
INSERT INTO [BedTypes] VALUES
	('Big', NULL),
	('Small', NULL),
	('Child', NULL)
		
INSERT INTO [Rooms] VALUES
	('Room', 'Big', 15.00, 'Free', NULL),
	('Studio', 'Small', 12.50, 'Occupied', NULL),
	('Apartment', 'Child', 10.25, 'No idea', NULL)
		
INSERT INTO [Payments] VALUES
	(1, '2023-02-01', 1, '2023-01-11', '2023-01-14', 3, 250.00, 20.00, 50.00, 300.00, NULL),
	(2, '2023-02-02', 2, '2023-01-12', '2023-01-15', 3, 199.90, 20.00, 39.98, 239.88, NULL),
	(3, '2023-02-03', 3, '2023-01-13', '2023-01-16', 3, 330.50, 20.00, 66.10, 396.60, NULL)
	   	
INSERT INTO [Occupancies] VALUES
	(1, '2023-01-01', 1, 1, 20.00, 15.00, NULL),
	(2, '2023-01-02', 2, 2, 20.00, 12.50, NULL),
	(3, '2023-01-03', 3, 3, 20.00, 18.90, NULL)

--16th.Exercise

CREATE DATABASE [SoftUni]

USE [SoftUni]

CREATE TABLE [Towns](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(100) NOT NULL
)

CREATE TABLE [Addresses](
	[Id] INT PRIMARY KEY IDENTITY,
	[AddressText] NVARCHAR(200) NOT NULL,
	[TownId] INT FOREIGN KEY REFERENCES [Towns]([Id]) NOT NULL
)

CREATE TABLE [Departments](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(100) NOT NULL
)

CREATE TABLE [Employees](
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] VARCHAR(50) NOT NULL,
	[MiddleName] VARCHAR(50) NOT NULL,
	[LastName] VARCHAR(50) NOT NULL,
	[JobTitle] VARCHAR(50) NOT NULL,
	[DepartmentId] INT FOREIGN KEY REFERENCES [Departments]([Id]) NOT NULL,
	[HireDate] DATE NOT NULL,
	[Salary] DECIMAL(6,2) NOT NULL,
	[AddressId] INT FOREIGN KEY REFERENCES [Addresses]([Id]) NOT NULL
)

--17th.Exercise

USE [master]

BACKUP DATABASE [SoftUni]
	TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\SoftUniDB.bak' 

GO

DROP DATABASE [SoftUni]

GO

RESTORE DATABASE [SoftUni] 
	FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\SoftUniDB.bak'

--18th.Exercise

USE [SoftUni]

INSERT INTO [Towns] VALUES
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')
	
INSERT INTO [Departments] VALUES
	('Engineering'),
	('Sales'),
	('Marketing'),
	('Software Development'),
	('Quality Assurance')

INSERT INTO [Addresses] VALUES
	('Default entry', 1)

INSERT INTO [Employees] VALUES
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer',4,'2013-02-01',3500.00,1),
	('Petar','Petrov','Petrov','Senior Engineer',1,'2004-03-02',4000.00,1),
	('Maria', 'Petrova', 'Ivanova', 'Intern',5, '2016-08-28', 525.25,1),
	('Georgi','Teziev','Ivanov','CEO',2,'2007-12-09',3000.00,1),
	('Peter','Pan','Pan','Intern',3,'2016-08-28',599.88,1)

--19th.Exercise

SELECT * FROM [Towns]	

SELECT * FROM [Departments]	

SELECT * FROM [Employees]

--20th.Exercise

SELECT * FROM [Towns]	
 	ORDER BY [Name]

SELECT * FROM [Departments]	
	 ORDER BY [Name]

SELECT * FROM [Employees]
	 ORDER BY [Salary]

--21th.Exercise

SELECT [Name] FROM [Towns]	
	ORDER BY [Name]

SELECT [Name] FROM [Departments]	
	ORDER BY [Name]

SELECT [FirstName], [LastName], [JobTitle], [Salary] FROM [Employees]
	ORDER BY [Salary] DESC

--22th.Exercise

UPDATE [Employees]
	SET [Salary] *= 1.1

SELECT [Salary] FROM [Employees]
--23th.Exercise

USE [Hotel]

UPDATE [Payments]
	SET [TaxRate] -= 0.03

SELECT [TaxRate] FROM [Payments]

--24th.Exercise

DELETE [Occupancies]


GO

