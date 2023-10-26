USE [Gringotts]


-- 01. Records’ Count

SELECT COUNT(*) AS [Count]
  FROM [WizzardDeposits]

-- 02. Longest Magic Wand

SELECT MAX([MagicWandSize]) AS LongestMagicWand
  FROM [WizzardDeposits]

-- 03. Longest Magic Wand per Deposit Groups

  SELECT [wd].[DepositGroup]
       , MAX([wd].[DepositGroup]) AS [LongestMagicWand]
    FROM [WizzardDeposits] AS [wd]
GROUP BY [wd].[DepositGroup]

-- 04. Smallest Deposit Group per Magic Wand Size

    SELECT TOP(2)
             [wd].[DepositGroup]
        FROM [WizzardDeposits] AS [wd]
    GROUP BY [wd].[DepositGroup]
    ORDER BY AVG([wd].[MagicWandSize])

-- 05. Deposits Sum

SELECT 
       [wd].[DepositGroup]
     , SUM([wd].[DepositAmount]) AS [TotalSum]
FROM [WizzardDeposits] AS [wd]
GROUP BY [wd].[DepositGroup]

-- 06. Deposits Sum for Ollivander Family

  SELECT 
         [wd].[DepositGroup]
         , SUM([wd].[DepositAmount])
    FROM [WizzardDeposits] AS [wd]
   WHERE [wd].[MagicWandCreator] = 'Ollivander family'
GROUP BY [wd].[DepositGroup]

-- 07. Deposits Filter

  SELECT 
         [wd].[DepositGroup]
         , SUM([wd].[DepositAmount]) AS [TotalSum]
    FROM [WizzardDeposits] AS [wd]
   WHERE [wd].[MagicWandCreator] = 'Ollivander family'
GROUP BY [wd].[DepositGroup]
  HAVING SUM([wd].[DepositAmount]) < 150000
ORDER BY [TotalSum] DESC


-- 08. Deposit Charge

   SELECT
          [wd].[DepositGroup]
          , [wd].[MagicWandCreator]
          , MIN([wd].[DepositCharge]) AS [MinDepositCharge]
     FROM [WizzardDeposits] AS [wd]
 GROUP BY [wd].[DepositGroup], [wd].[MagicWandCreator]
 ORDER BY [wd].[MagicWandCreator], [wd].[DepositGroup]

-- 09. Age Groups

SELECT
       [AgeGroup]
     , COUNT([AgeGroup]) AS [WizardCount]
FROM 
(
    SELECT 
        CASE
            WHEN [Age] <= 10
            THEN '[0-10]'
            WHEN [Age] > 10
             AND [Age] <= 20
            THEN '[11-20]'
            WHEN [Age] > 20
             AND [Age] <= 30
            THEN '[21-30]'
            WHEN [Age] > 30
             AND [Age] <= 40
            THEN '[31-40]'
            WHEN [Age] > 40
             AND [Age] <= 50
            THEN '[41-50]'
            WHEN [Age] > 50
             AND [Age] <= 60
            THEN '[51-60]'
            ELSE '[61+]'
        END AS [AgeGroup]
    FROM [WizzardDeposits]
)AS [a]
GROUP BY [AgeGroup]

-- 10. First Letter

  SELECT
DISTINCT [FirstLetter]
    FROM
        (
          SELECT SUBSTRING([FirstName], 1, 1) AS [FirstLetter]
            FROM [WizzardDeposits] AS [wd]
           WHERE [wd].[DepositGroup] = 'Troll Chest'  
        ) AS [letters]

-- 11. Average Interest

  SELECT
         [wd].[DepositGroup]
        , [wd].[IsDepositExpired]
        , AVG([wd].[DepositInterest]) AS [AverageInterest]
    FROM [WizzardDeposits] AS [wd]
   WHERE [wd].[DepositStartDate] >  '1985-01-01' 
GROUP BY [wd].[DepositGroup], [wd].[IsDepositExpired]
ORDER BY [wd].[DepositGroup] DESC 
        ,[wd].[IsDepositExpired] ASC

-- 12. *Rich Wizard, Poor Wizard

   SELECT 
           SUM([wd].[DepositAmount] - [leftWD].[DepositAmount]) AS [SumDifference]
     FROM [WizzardDeposits] AS [wd]
LEFT JOIN [WizzardDeposits] AS [leftWD]
       ON [wd].[Id] = [leftWD].[Id] - 1

-- 13. Departments Total Salaries

USE [SoftUni]
 
  SELECT
         [e].[DepartmentId]
         , SUM([e].[Salary]) AS [TotalSalary]
    FROM [Employees] AS [e]
GROUP BY [e].[DepartmentId]

-- 14. Employees Minimum Salaries

  SELECT
         [e].[DepartmentId]
         , MIN([e].[Salary]) AS [MinimumSalary]
    FROM [Employees] AS [e]
   WHERE [e].[DepartmentId] IN (2, 5, 7) 
     AND [e].[HireDate] > '2000-01-01'
GROUP BY [e].[DepartmentId]

-- 15. Employees Average Salaries

 SELECT *
   INTO [NewTable]
   FROM [Employees] AS [e]
  WHERE [e].[Salary] > 30000

DELETE
  FROM [NewTable]
 WHERE [ManagerID] = 42

UPDATE [NewTable]
   SET [Salary] += 5000
 WHERE [DepartmentID] = 1

  SELECT
          [t].[DepartmentId]
         , AVG([t].[Salary]) AS [AverageSalary]
    FROM [NewTable] AS [t]
GROUP BY [t].[DepartmentId]

-- 16. Employees Maximum Salaries

   SELECT
         [e].[DepartmentId]
         , MAX([e].[Salary]) AS [MaxSalary]
    FROM [Employees] AS [e]
GROUP BY [e].[DepartmentId]
  HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

-- 17. Employees Count Salaries

SELECT
       COUNT([e].[EmployeeID]) AS [Count]
  FROM [Employees] AS [e]
 WHERE [e].[ManagerID] IS NULL

-- 18. *3rd Highest Salary

SELECT
 	[DepartmentID],
	MAX([Salary]) AS [ThirdHighestSalary]
FROM
(
	SELECT 
		[DepartmentID],
		[Salary],
		DENSE_RANK() OVER (PARTITION BY [DepartmentID] ORDER BY [Salary] DESC) AS [Rank]
	FROM [Employees]
) AS [t]
WHERE [Rank] = 3
GROUP BY [DepartmentID]

-- 19. **Salary Challenge

SELECT TOP 10
	e.[FirstName],
	e.[LastName],
	e.[DepartmentID]
     FROM [Employees] AS [e]
LEFT JOIN 
(
    SELECT
         [e].[DepartmentId]
         , AVG([e].[Salary]) AS [AverageSalary]
        FROM [Employees] AS [e]
        GROUP BY [e].[DepartmentId]
) AS [AvgTable]
   ON [e].[DepartmentId] = [AvgTable].[DepartmentId]
WHERE [e].[Salary] > [AvgTable].[AverageSalary]
