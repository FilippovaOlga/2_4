SELECT id, FirstName, LastName FROM Employees
WHERE Salary=(SELECT MAX(Salary) FROM Employees);

SELECT LastName FROM Employees
ORDER BY LastName;

SELECT JobLevel, ROUND(AVG(current_date-DateIn)/365.0,1) AS JobStage  FROM Employees
GROUP BY JobLevel
ORDER BY JobLevel;

-- d.Выведите фамилию сотрудника и название отдела, в котором он работает
SELECT e.LastName, d.DivisionName  
FROM Employees AS e
LEFT JOIN Divisions AS d
ON d.id=e.division_id
ORDER BY e.LastName;

-- e.Выведите название отдела и фамилию сотрудника 
-- с самой высокой зарплатой в данном отделе и 
-- саму зарплату также
WITH MaxSal AS 
(SELECT d.DivisionName as Division, 
 e.LastName  as LastName, 
 Salary as Salary
FROM Employees AS e
LEFT JOIN Divisions AS d
ON d.id=e.division_id), 

FinTab AS
(SELECT Division,LastName,Salary,
ROW_NUMBER() OVER(PARTITION BY Division ORDER BY Salary DESC) AS Numb
FROM MaxSal)

SELECT Division,LastName,Salary FROM FinTab
WHERE numb =1;