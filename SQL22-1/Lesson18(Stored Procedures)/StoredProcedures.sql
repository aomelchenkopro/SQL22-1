
SET XACT_ABORT ON;  
/*
Реализовать хранимую процедуру для расчета общей суммы продаж по сотруднику
- Используется таблица [Sales].[SalesOrderHeader]
*/

--==================================================================================================
-- Create a stored procedure of total sales amount calculating

-- The head of the procedure 
CREATE PROCEDURE CALCULATE_TOTAL_SALES 
(
	@BusinessEntityID INT      NULL,     -- ID of an employee
	@FromDate         DATETIME NULL,     -- lower edge of the sales period
	@ToDate           DATETIME NULL,     -- upper edge of the sales period
	@TotalSalesAmount MONEY OUTPUT       -- Total amount of sales within a period (OUTPUT PARAMETER)
)
-- The body of the procedure
AS BEGIN
	IF @BusinessEntityID IN (SELECT SalesPersonID FROM [Sales].[SalesOrderHeader])
		BEGIN
		    PRINT('The employee has been identified successfully')

			PRINT('The procedure is calculating right now')

			-- Calculate the amount of sales within the period
			SET @TotalSalesAmount = (SELECT SUM(SubTotal)
								       FROM [Sales].[SalesOrderHeader]
	                                  WHERE SalesPersonID = @BusinessEntityID
	                                    AND OrderDate BETWEEN @FromDate AND @ToDate);

			PRINT('The procedure has finished calculating')

		END
		ELSE
			PRINT('The employee does not exist');
END;

--==================================================================================================
DECLARE @Total MONEY;
EXECUTE CALCULATE_TOTAL_SALES 279, '20110101 00:00:00', '20111231 23:59:59',  @Total OUTPUT;
SELECT @Total;

--==================================================================================================
IF OBJECT_ID('[SQL221].[dbo].[CHANGE_DEPARTMENT]', 'p') IS NOT NULL DROP PROCEDURE CHANGE_DEPARTMENT;
GO
CREATE PROCEDURE CHANGE_DEPARTMENT 
(
@BusinessEntityID INT,
@DepartmentID     INT
) AS
BEGIN
	BEGIN TRY

			BEGIN TRANSACTION
		
			-- Close current department
			UPDATE [HumanResources].[EmployeeDepartmentHistory]
			   SET EndDate = SYSDATETIME(),
				   ModifiedDate = SYSDATETIME()
			 WHERE BusinessEntityID = @BusinessEntityID
			   AND EndDate IS NULL;

			-- Open a new one
			INSERT INTO [HumanResources].[EmployeeDepartmentHistory]
			([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate],
			[EndDate], [ModifiedDate])
			VALUES (@BusinessEntityID, @DepartmentID, 1, SYSDATETIME(), NULL, SYSDATETIME());

			PRINT('primary key')
		
			COMMIT TRANSACTION;

		END TRY
		BEGIN CATCH
			   IF (XACT_STATE()) = -1  
				BEGIN  
					PRINT 'The transaction is in an uncommittable state.' +  
						  ' Rolling back transaction.'  
					ROLLBACK TRANSACTION;  
				END;

				 IF (XACT_STATE()) = 1  
				BEGIN  
					PRINT 'The transaction is committable.' +   
						  ' Committing transaction.'  
					COMMIT TRANSACTION;     
				END;  
		END CATCH

END;

--===========================================================================


ROLLBACK TRAN

EXECUTE CHANGE_DEPARTMENT 18, 3

SELECT *
  FROM [HumanResources].[EmployeeDepartmentHistory]
 WHERE BusinessEntityID = 18

