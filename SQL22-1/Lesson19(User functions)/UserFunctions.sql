use [SQL221];
/*
Scalar user defined functions 
Inline user defined functions 
Multi statements user defined functions 
*/
GO
--============================================================================================
-- SCALAR USER DEFINED FUNCTIONS 

-- Create a user defined function that will calculate an all time sum of sales

-- The header of a function
CREATE FUNCTION dbo.CalcCardSales (@CreditCardID int)
	RETURNS MONEY AS
-- The body of a function
	BEGIN
		DECLARE @SubTotal MONEY;

		IF @CreditCardID NOT IN (SELECT H.CreditCardID FROM [Sales].[SalesOrderHeader] H)
		BEGIN
			SET @SubTotal = -1;
		END
		ELSE
		BEGIN
			SET @SubTotal = (SELECT SUM(H.SubTotal)
		                       FROM [Sales].[SalesOrderHeader] H
		                      WHERE H.CreditCardID = @CreditCardID
							    AND H.CreditCardApprovalCode LIKE '%8' );
		END
		   
		RETURN @SubTotal;
	END;

GO
SELECT *,
       dbo.CalcCardSales(C.CreditCardID)
  FROM [Sales].[CreditCard] C
 WHERE CardType = N'SuperiorCard';

 SELECT * FROM [Sales].[SalesOrderHeader]



/*
Задача 1
Реализуйте пользовательскую scalar функцию, возвращающую по идентификатору работника
наименование департамента (на сейчас), в котором работает указанный сотрудник.
*/
--====================================================================================
-- Ян
use [SQL221];
go
CREATE FUNCTION dbo.ReturnDepart (@BusinessEntityID int)
-- drop FUNCTION dbo.ReturnDepart
	RETURNS nvarchar(50) AS
	BEGIN
		DECLARE @DepartName nvarchar(50);

		IF @BusinessEntityID NOT IN (SELECT BusinessEntityID FROM [HumanResources].[EmployeeDepartmentHistory])
		BEGIN
		  set @DepartName = 'No such an employee';
		END
		ELSE
		BEGIN
			SET @DepartName = (Select top 1
			                          t1.[name] 
                                from [HumanResources].[Department] as t1
                                join [HumanResources].[EmployeeDepartmentHistory] as t2 on t2.DepartmentID = t1.DepartmentID
                                                                                        and t2.EndDate is null
                               where t2.BusinessEntityID = @BusinessEntityID
							   order by t2.StartDate desc);
		END
		   
		RETURN @DepartName;
	END;

 go 
 --Check 
 SELECT dbo.ReturnDepart(37)

 select BusinessEntityID, dbo.ReturnDepart(100000)
 from [HumanResources].[Employee]

 select BusinessEntityID, dbo.ReturnDepart(BusinessEntityID)
 from [HumanResources].[EmployeeDepartmentHistory]
--====================================================================================
GO
IF OBJECT_ID('dbo.GetRelevantDep', 'FN') IS NOT NULL DROP FUNCTION dbo.GetRelevantDep;
-- Create a function that will return the name of the last departament of an employee
GO
-- The head of a function
CREATE FUNCTION dbo.GetRelevantDep (@BusinessEntityID int)
	RETURNS NVARCHAR(50) AS

	--The body of a function
	BEGIN
		RETURN (

		-- The query returns only one name of a department in a prioritized order
		SELECT TOP 1
		       D.[Name]
		  FROM [HumanResources].[EmployeeDepartmentHistory] H
		 INNER JOIN [HumanResources].[Department] D ON D.DepartmentID = H.DepartmentID
		 WHERE H.BusinessEntityID = @BusinessEntityID
		   AND H.EndDate IS NULL
		 ORDER BY H.StartDate DESC
		 
		 );
	END;
GO

SELECT E.*, dbo.GetRelevantDep(E.BusinessEntityID) RelevanDepName
  FROM [HumanResources].[Employee] E;
--====================================================================================
--  INLINE USER DEFINED FUNCTIONS 
GO
IF OBJECT_ID('Sales.ufn_SalesByStore', 'IF') IS NOT NULL DROP FUNCTION Sales.ufn_SalesByStore;
GO
CREATE FUNCTION Sales.ufn_SalesByStore (@storeid int)
RETURNS TABLE
AS
RETURN
(
    SELECT P.ProductID, 
	       P.[Name], 
		   SUM(SD.LineTotal) AS 'Total'
      FROM Production.Product     AS P
      JOIN Sales.SalesOrderDetail AS SD ON SD.ProductID    = P.ProductID
      JOIN Sales.SalesOrderHeader AS SH ON SH.SalesOrderID = SD.SalesOrderID
      JOIN Sales.Customer         AS C  ON SH.CustomerID   = C.CustomerID
     WHERE C.StoreID = @storeid
     GROUP BY P.ProductID, 
	          P.Name
);
GO

SELECT T1.*,
       T2.Color
  FROM Sales.ufn_SalesByStore(934) T1
  LEFT OUTER JOIN [Production].[Product] T2 ON T2.ProductID = T1.ProductID
;
--====================================================================================
/*
Реализовать пользовательскую INLINE 
*/
--====================================================================================
-- Ян
use SQL221
go

IF OBJECT_ID (N'SalesByCustumer', N'IF') IS NOT NULL DROP FUNCTION SalesByCustumer;
GO
CREATE FUNCTION SalesByCustumer(@custumeID int, @DataStart datetime, @DataEnd datetime)
 RETURNS TABLE
 AS
RETURN
(
Select [CustomerID],
       [CreditCardID],
       sum([SubTotal]) as SumMoney
 from [Sales].[SalesOrderHeader]
 Where OrderDate between @DataStart and @DataEnd
  and CustomerID = @custumeID
 group by CustomerID,
          CreditCardID
);
go
--check 
select * from  SalesByCustumer (30052,'20000101','20200101 23:59:59')

select * from sys.objects where name = 'ufn_FindReports'
--====================================================================================
GO
-- MULTI-STATEMENT USER DEFINED FUNCTIONS 
IF OBJECT_ID (N'ufn_FindReports', N'TF') IS NOT NULL DROP FUNCTION dbo.ufn_FindReports;
GO
CREATE FUNCTION dbo.ufn_FindReports (@InEmpID INTEGER)
RETURNS @retFindReports TABLE
(
    EmployeeID int primary key NOT NULL,
    FirstName nvarchar(255) NOT NULL,
    LastName nvarchar(255) NOT NULL,
    JobTitle nvarchar(50) NOT NULL,
    RecursionLevel int NOT NULL
)
--Returns a result set that lists all the employees who report to the
--specific employee directly or indirectly.*/
AS
BEGIN
WITH EMP_cte(EmployeeID, OrganizationNode, FirstName, LastName, JobTitle, RecursionLevel) -- CTE name and columns
    AS (

	  ---------------------------------------------------------------------------------------
      -- Get the initial list of Employees for Manager n
      SELECT e.BusinessEntityID, 
		     OrganizationNode = ISNULL(e.OrganizationNode, CAST('/' AS hierarchyid)) , -- Where the employee is located in corporate hierarchy.
			 p.FirstName, 
			 p.LastName, 
			 e.JobTitle, 
			 0
        FROM HumanResources.Employee e
       INNER JOIN Person.Person      p ON p.BusinessEntityID = e.BusinessEntityID
       WHERE e.BusinessEntityID = @InEmpID
	  ---------------------------------------------------------------------------------------


      UNION ALL
	  ---------------------------------------------------------------------------------------
      -- Join recursive member to anchor
      SELECT e.BusinessEntityID, 
	         e.OrganizationNode, 
			 p.FirstName, 
			 p.LastName, 
			 e.JobTitle, 
			 RecursionLevel + 1
        FROM HumanResources.Employee e
       INNER JOIN EMP_cte ON e.OrganizationNode.GetAncestor(1) = EMP_cte.OrganizationNode
       INNER JOIN Person.Person p ON p.BusinessEntityID = e.BusinessEntityID
        )

-- copy the required columns to the result of the function
    INSERT @retFindReports
    SELECT EmployeeID, FirstName, LastName, JobTitle, RecursionLevel
    FROM EMP_cte
    RETURN
END;
GO


-- Example invocation
SELECT f.EmployeeID, 
       f.FirstName,
	   f.LastName, 
	   f.JobTitle, 
	   f.RecursionLevel,
	   h.*
FROM dbo.ufn_FindReports(1) f
left join [Sales].[SalesOrderHeader] h on h.[SalesPersonID] = f.EmployeeID


