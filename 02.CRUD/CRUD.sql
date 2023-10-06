--1stExercise

USE SoftUni

SELECT * FROM [Departments]

--2ndExercise

SELECT [Name] FROM [Departments]

--3thExercise

SELECT [FirstName], [LastName], [Salary] FROM [Employees]

--4thExercise


SELECT [FirstName], [MiddleName], [LastName] FROM [Employees]

--5thExercise

SELECT [FirstName] + '.' + [LastName] + '@softuni.bg' 
AS [Full Email Address]
FROM [Employees]


--6thExercise

SELECT DISTINCT [Salary] 
FROM [Employees]

--7thExercise

SELECT * FROM [Employees]
WHERE [JobTitle] = 'Sales Representative'

--8thExercise

SELECT [FirstName], [LastName], [JobTitle]
FROM [Employees]
WHERE [Salary] >= 20000 AND [Salary] <= 30000
--WHERE [Salary] BETWEEN 20000 AND 30000

--9thExercise

SELECT [FirstName] + ' ' + [MiddleName] +  ' ' + [LastName] 
  FROM [Employees]
	AS [Full Name]
 WHERE [Salary] IN (25000, 14000, 12500, 23600)

 --SELECT CONCAT([FirstName], ' ', [MiddleName], ' ', [LastName])
 --SELECT CONCAT_WS(' ', [FirstName], [MiddleName], [LastName])
	--AS [Full Name]
 -- FROM [Employees]
 --WHERE [Salary] IN (25000, 14000, 12500, 23600)

--10thExercise

SELECT [FirstName], [LastName]
FROM [Employees]
WHERE [ManagerID] IS NULL

--11thExercise

SELECT [FirstName], [LastName], [Salary]
FROM [Employees]
WHERE [Salary] > 50000
ORDER BY [Salary] DESC

--12thExercise

SELECT TOP(5) [FirstName], [LastName] 
FROM [Employees]
ORDER BY [Salary] DESC

--13thExercise

SELECT [FirstName], [LastName]
FROM [Employees]
WHERE [DepartmentId] NOT IN (4)

--14thExercise

SELECT * FROM [Employees]
ORDER BY 
    [Salary] DESC,
    [FirstName] ASC,
    [LastName] DESC,
    [MiddleName] ASC

--15thExercise

GO
CREATE VIEW [V_EmployeesSalaries] 
		 AS
			(
				SELECT CONCAT([FirstName], ' ', [LastName], ' ', [Salary])
				FROM [Employees]
			)
GO
	

--16thExercise

CREATE VIEW V_EmployeeNameJobTitle AS
SELECT 
    CONCAT([FirstName], 
           CASE WHEN [MiddleName] IS NULL THEN '' ELSE CONCAT(' ', [MiddleName]) END, 
           ' ', Lastname) AS [Full Name],
    [JobTitle]
FROM [Employees];

-- CREATE VIEW V_EmployeeNameJobTitle AS
-- 	SELECT 
--     [FirstName] + ' ' + [MiddleName] + ' ' + [LastName] AS [Full Name],
--     [JobTitle] AS [Job Title]
-- FROM [Employees]

--17thExercise

SELECT DISTINCT [JobTitle] FROM [Employees]

--18thExercise

SELECT TOP(10) * FROM [Projects]
ORDER BY
    [StartDate] ASC,
    [Name] ASC

--19thExercise

SELECT TOP(7) [FirstName], [LastName], [HireDate] 
FROM [Employees]
ORDER BY [HireDate] DESC

--20thExercise

SELECT * INTO Employees_Backup FROM Employees;

UPDATE [Employees]
	SET [Salary] *= 1.12
    WHERE [DepartmentID] IN (1, 2, 4, 11)

SELECT * FROM [Employees]

TRUNCATE TABLE Employees;
INSERT INTO Employees SELECT * FROM Employees_Backup;
DROP TABLE Employees_Backup;

--21thExercise

USE [Geography]

SELECT [PeakName] 
FROM [Peaks]
ORDER BY [PeakName]

--22thExercise

USE [Geography]
 
SELECT TOP(30) [CountryName], [Population] 
FROM [Countries]
WHERE [ContinentCode] = 'Europe'
ORDER BY [Population] DESC, [CountryName] ASC

--23thExercise

SELECT [CountryName], [CountryCode],
	CASE WHEN [CurrencyCode] = 'EUR' THEN 'Euro'
	ELSE 'Not Euro'
	END AS [Currency]
FROM [Countries]
ORDER BY [CountryName]

--24thExercise

USE [Diablo]

SELECT [Name] FROM [Characters]
ORDER BY [Name]