CREATE TABLE EmployeeErrors
(EmployeeID varchar(50), 
 FirstName varchar(50),
 LastName varchar(50)
 )

 INSERT INTO EmployeeErrors
 VALUES (1001, 'Jimbo', 'Halbert'),
        (1002, 'Pamela', 'Beasely'),
		(1003, 'TOby', 'Flenderson - Fired')

UPDATE EmployeeErrors SET EmployeeID = '  1002'
WHERE FirstName = 'Pamela'

UPDATE EmployeeErrors SET EmployeeID = '1001  '
WHERE FirstName = 'Jimbo'

UPDATE EmployeeErrors SET EmployeeID = '1005'
WHERE FirstName = 'TOby'

SELECT * 
FROM EmployeeErrors

-- Using Trim, LTRIM, RTRIM

SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM 
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM 
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM 
FROM EmployeeErrors

-- Using Replace -- 

SELECT LastName, REPLACE(LastName, '- Fired', '') AS LastNameFixed
FROM EmployeeErrors

-- Using Substring -- 
SELECT SUBSTRING(FirstName, 3,3)
FROM EmployeeErrors

SELECT err.FirstName, SUBSTRING(err.FirstName,1,3), demo.FirstName, SUBSTRING(demo.FirstName,1,3) 
FROM EmployeeErrors err
JOIN EmployeeDemographics demo
ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(demo.FirstName,1,3)

-- Gender
-- LastName
-- AGE
-- DOB

-- Using UPPER AND lower 

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors

-----------CTE ---------------------

WITH CTE_Employee AS 
(SELECT FirstName, LastName, Gender, Salary, 
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender, 
AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM SQLTutorial..EmployeeDemographics demo
JOIN SQLTutorial..EmployeeSalary sal
     ON demo.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
SELECT FirstName, AvgSalary
FROM CTE_Employee



----------------Temp Tables ---------------------

CREATE TABLE #temp_Employee 
(EmployeeID int, 
 JobTitle varchar(100), 
 Salary int
 )
 SELECT * 
 FROM #temp_Employee

 INSERT INTO #temp_Employee 
 VALUES ('1001', 'HR', '45000')

 INSERT INTO #temp_Employee 
 SELECT *
 FROM SQLTutorial..EmployeeSalary

 DROP TABLE IF EXISTS #Temp_Employee2
 CREATE TABLE #Temp_Employee2 
 (JobTitle varchar(50), 
  EmployeesPerJob int, 
  AvgAge int, 
  AvgSalary int)

  INSERT INTO #Temp_Employee2
  SELECT JobTitle, COUNT(JobTitle), Avg(Age), AVG(salary)
  FROM SQLTutorial..EmployeeDemographics demo
  JOIN SQLTutorial..EmployeeSalary sal
     ON demo.EmployeeID = sal.EmployeeID
  GROUP BY JobTitle

  SELECT * 
  FROM #Temp_Employee2


  ---------- Store Procedure ------------------

  CREATE PROCEDURE TEST 
  AS 
  SElECT * 
  FROM SQLTutorial.dbo.EmployeeDemographics

  EXEC TEST

  CREATE PROCEDURE Temp_Employee
  AS 
  CREATE TABLE #Temp_Employee 
 (JobTitle varchar(50), 
  EmployeesPerJob int, 
  AvgAge int, 
  AvgSalary int)

  SELECT * 
  FROM #Temp_Employee

  EXEC Temp_Employee

  ALTER PROCEDURE [dbo].[Temp_Employee]
  @JobTitle varchar(100)
  AS 
  CREATE TABLE #Temp_Employee
  (JobTitle varchar(100),
   EmployeesPerJob int, 
   AvgAge int, 
   AvgSalary int
   )

  INSERT INTO #Temp_Employee
  SELECT @JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
  FROM SQLTutorial..EmployeeDemographics demo
  JOIN SQLTutorial..EmployeeSalary sal
     ON demo.EmployeeID = sal.EmployeeID
  WHERE JobTitle = @JobTitle
  GROUP BY JobTitle

  SELECT * 
  FROM #Temp_Employee

  --------------- Subqueries ---------------------

  SELECT * 
  FROM SQLTutorial..EmployeeSalary

  -- Subquery in Select 

  SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM SQLTutorial..EmployeeSalary) AS AllAvgSalary
  FROM SQLTutorial..EmployeeSalary

  -- How to do it with Partition By

  SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
  FROM SQLTutorial..EmployeeSalary

  -- Why Group By doesn't work

  SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSalary
  FROM SQLTutorial..EmployeeSalary
  GROUP BY EmployeeID, Salary
  ORDER BY EmployeeID,Salary 

  -- Subquery in FROM statement

  SELECT a.EmployeeID, AllAvgSalary 
  FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
        FROM SQLTutorial..EmployeeSalary) a

  -- Subquery in Where 

  SELECT EmployeeID, JobTitle, Salary
  FROM SQLTutorial..EmployeeSalary
  WHERE EmployeeID IN (SELECT EmployeeID 
                       FROM SQLTutorial..EmployeeDemographics
					   WHERE Age > 30)