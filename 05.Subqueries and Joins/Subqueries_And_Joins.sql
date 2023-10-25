--01. Employee Address

SELECT TOP(5) 
	        e.[Id], 
	        e.[JobTitle], 
	        e.[AddressId], 
	        a.[AddressText]
      FROM [Employees] AS [e]
INNER JOIN [Addresses] AS [a]
        ON e.[AddressID] = a.[Id]
  ORDER BY [AddressID]


-- 02. Addresses with Towns

-- SELECT TOP(50)
-- 		e.[FirstName]
-- 		, e.[LastName]
-- 		, t.[Name]
-- 		, a.[AddressText]
-- 		FROM [Employees] AS e
-- 		JOIN [Address] AS a
-- 			ON e.[AddressID] = a.[AddressID]
-- 		JOIN [Towns] AS t
-- 			ON t.[TownID] = a.[TownID]
-- 	ORDER BY e.[FirstName], e.[LastName]

SELECT TOP(50) 
	e.[FirstName], 
	e.[LastName],
	t.[Name],
	a.[AddressText]
FROM [Employees] AS [e]
JOIN [Addresses] AS [a]
	ON e.[AddressID] = a.[Id]
JOIN [Towns] AS [t]
	ON a.[TownID] = t.[Id]
ORDER BY e.[FirstName], e.[LastName]

-- 03. Sales Employees

SELECT 
	e.[Id]
	, e.[FirstName]
	, e.[LastName]
	, d.[Name]
FROM [Employees] AS [e]
JOIN [Departments] AS [d]
 	ON e.[DepartmentID] = d.[Id]
WHERE d.[Name] = 'Sales'
ORDER BY e.[Id] 

-- 04. Employee Departments

SELECT TOP(5)
	e.[Id]
	, e.[FirstName]
	, e.[Salary]
	, d.[Name] AS [DepartmentName]
FROM [Employees] AS [e]
JOIN [Departments] AS [d]
 	ON e.[DepartmentID] = d.[Id]
WHERE e.[Salary] > 15000
ORDER BY d.[Id] 

-- 05. Employees Without Projects

SELECT TOP(3) 
	e.[Id]
	, e.[FirstName]
FROM [Employees] AS e
LEFT JOIN [EmployeesProjects] AS [ep]
	ON e.[Id] = ep.[EmployeeID]
WHERE ep.ProjectID IS NULL
ORDER BY e.[Id]

-- 06. Employees Hired After

SELECT 
	e.[FirstName]
	, e.[LastName]
	, e.[HireDate]
	, d.[Name] AS [DeptName]
FROM [Employees] AS e
JOIN [Departments] as d
	ON e.[DepartmentID] = d.[Id]
WHERE
	e.[HireDate] > '1999-01-01' AND
	d.[Name] IN ('Sales', 'Finance')
ORDER BY e.[HireDate]

-- 07. Employees With Project


SELECT TOP(5)
	e.[Id]
	, e.[FirstName]
	, p.[Name] AS [ProjectName]
FROM [Employees] AS [e]
INNER JOIN [EmployeesProjects] AS [ep]
	ON e.[Id] = ep.[EmployeeID]
INNER JOIN [Projects] AS [p]
	ON ep.[ProjectID] = p.[ProjectID]
WHERE 
	p.[StartDate] > '2002-08-13' AND
	p.[EndDate] IS NULL
ORDER BY e.[Id]

-- 08. Employee 24

    SELECT
        [e].[EmployeeID]
      , [e].[FirstName]
      , CASE 
            WHEN [p].[StartDate] >= '2005-01-01' THEN NULL
            ELSE [p].[Name]
        END AS [ProjectName]
      FROM [Employees] AS [e]
      JOIN [EmployeesProjects] AS [ep]
        ON [e].[EmployeeID] = [ep].[EmployeeID]
      JOIN [Projects] AS [p]
        ON [p].[ProjectID] = [ep].[ProjectID]
     WHERE [e].[EmployeeID] = 24
      

-- 09. Employee Manager
    SELECT
			[e].[EmployeeID]
			, [e].[FirstName]
			, [e].[ManagerID]
			, [m].[FirstName] AS [ManagerName]
	  FROM [Employees] AS [e]
INNER JOIN [Employees] AS [m]
		ON [e].[ManagerID] = [m].[EmployeeID]
	 WHERE [e].[ManagerID] IN (3, 7)
  ORDER BY [e].[EmployeeID]

-- 10. Employees Summary

USE [SoftUni]

SELECT TOP(50)
	[e].[Id],
	CONCAT([e].[FirstName], ' ',[e].[LastName]) AS [EmployeeName],
	CONCAT([manger].[FirstName],' ', [manger].[LastName]) AS [ManagerName],
	[d].[Name] AS [DepartmentName]
	FROM
	[Employees] AS [e]
	JOIN [Employees] AS [manger]
		ON [e].[Id] = [manger].[Id]
	JOIN [Departments] AS [d]
		ON [e].[Id] = [d].[Id]
	ORDER BY [e].[Id]

-- 11. Min Average Salary

SELECT
	MIN([a].AverageSalary) AS MinAverageSalary
	FROM
	(
		SELECT 
		[e].[DepartmentId],
		AVG([e].[Salary]) AS [AverageSalary]
		FROM [Employees] AS [e]
		GROUP BY [e].[DepartmentId]
	) AS [a]

-- 12. Highest Peaks in Bulgaria

USE [Geography]

SELECT 
	   mc.[CountryCode],
	   m.[MountainRange],
	   p.[PeakName],
	   p.[Elevation]
 FROM
      [MountainsCountries] AS [mc]
 JOIN [Mountains] AS [m]
   ON [mc].[MountainId] = [m].[Id]
 JOIN [Peaks] AS [p]
   ON [mc].[MountainId] = [p].[MountainId]
WHERE [mc].[CountryCode] = 'BG' 
  AND 
      [p].[Elevation] > 2835
ORDER BY [p].[Elevation] DESC

-- 13. Count Mountain Ranges

  SELECT
		 [mc].[CountryCode],
		 COUNT([m].[MountainRange]) AS [MountainRange]
    FROM
		 [MountainsCountries] AS [mc]
    JOIN [Mountains] AS [m]
      ON [mc].[MountainId] = [m].[Id]
   WHERE [mc].[CountryCode] IN ('BG', 'RU', 'US')
GROUP BY [mc].[CountryCode]

-- 14. Countries With or Without Rivers

SELECT TOP(5)
            [c].[CountryName],
			[r].[RiverName]
	   FROM [Continents] AS [c]
  LEFT JOIN [CountriesRivers] AS [cr]
		 ON [c].[ContinentCode] = [cr].[CountryCode]
  LEFT JOIN [Rivers] AS [r]
 		 ON [cr].[RiverId] = [r].[Id]
      WHERE [c].[ContinentCode] = 'AF'
   ORDER BY [c].[CountryName] ASC

-- 15. Continents and Currencies

SELECT 
    [r].ContinentCode, 
	[r].CurrencyCode, 
	[r].CurrencyUsage
  FROM
	(
		SELECT 
			   [c].[ContinentCode],
			   [c].[CurrencyCode],
		       COUNT(c.[CurrencyCode]) AS [CurrencyUsage],
		       DENSE_RANK() OVER
	  			(
		          PARTITION BY c.[ContinentCode] 
		              ORDER BY COUNT(c.[CurrencyCode]) DESC
	  			) AS [CurrencyRank]
		       FROM [Continents] AS [c]
		   GROUP BY [c].[ContinentCode],
		            [c].[CurrencyCode]
		      HAVING COUNT(c.[CurrencyCode]) > 1


	) AS [r] 
   WHERE [r].CurrencyRank = 1
ORDER BY [r].ContinentCode

-- 16. Countries Without any Mountains

   SELECT COUNT([c].[CountryCode]) AS [Count]
     FROM [Countries] AS [c]
LEFT JOIN [MountainsCountries] AS [mc]
	   ON [c].[CountryCode] = [mc].[CountryCode]
    WHERE [mc].[MountainId] IS NULL


-- 17. Highest Peak and Longest River by Country


SELECT TOP(5)
			  [c].[CountryName],
			  MAX([p].[Elevation]) AS [HighestPeakElevation],
			  MAX([r].[Length]) AS [LongestRiverLength]
		FROM [Countries] AS [c]
  INNER JOIN [MountainsCountries] AS [mc]
          ON [c].[CountryCode] = [mc].[CountryCode]
  INNER JOIN [Peaks] AS [p]
          ON [mc].[MountainId] = [p].[MountainId]
  INNER JOIN [CountriesRivers] AS [cr]
		  ON [c].[CountryCode] = [cr].[CountryCode]
  INNER JOIN [Rivers] AS [r]
          ON [cr].[RiverId] = [r].[Id]
	GROUP BY [CountryName]
    ORDER BY 
			 [HighestPeakElevation] DESC,
			 [LongestRiverLength] DESC,
			 [CountryName] ASC

-- 18. Highest Peak Name and Elevation by Country

SELECT TOP(5)
			[Country],
			CASE
				   WHEN [PeakName] IS NULL THEN '(no highest peak)'
				   ELSE [PeakName]
			     END AS [Highest Peak Name],
			CASE
					WHEN [Elevation] IS NULL THEN 0
					ELSE [Elevation]
				  END AS [Highest Peak Elevation],
			CASE
					WHEN [MountainRange] IS NULL THEN '(no mountain)'
					ELSE [MountainRange]
				  END AS [Mountain]

			FROM
				(
					SELECT 
							c.[CountryName] AS [Country],
							m.[MountainRange],
							p.[PeakName],
							p.[Elevation],
							DENSE_RANK() OVER
							(
								PARTITION BY c.[CountryName] 
									ORDER BY p.[Elevation] DESC
							) AS [PeakRank]
					FROM [Countries] AS [c]
			   LEFT JOIN [MountainsCountries] AS [mc]
					  ON mc.[CountryCode] = c.[CountryCode]
	           LEFT JOIN [Mountains] AS [m]
					  ON mc.[MountainId] = m.[Id]
	 		   LEFT JOIN [Peaks] AS [p]
					  ON p.[MountainId] = m.[Id]
					) AS [PeakRankingTable]
WHERE [PeakRank] = 1
ORDER BY [Country], [Highest Peak Name] 