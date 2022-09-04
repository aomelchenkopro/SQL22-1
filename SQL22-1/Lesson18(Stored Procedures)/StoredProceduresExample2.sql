/*
Реализовать хранимую процедуру для расчета общей суммы продаж по сотруднику
- Используется таблица [Sales].[SalesOrderHeader]
*/

--==================================================================================================
-- Create a stored procedure of total sales amount calculating

-- The head of the procedure 
-- DROP PROCEDURE CALCULATE_TOTAL_SALES_EXAMPE_2;
CREATE PROCEDURE CALCULATE_TOTAL_SALES_EXAMPE_2
(
	@BusinessEntityID INT      NULL,     -- ID of an employee
	@TotalSalesAmount MONEY OUTPUT,      -- Total amount of sales within a period (OUTPUT PARAMETER)
	@FromDate         DATETIME NULL,     -- lower edge of the sales period
	@ToDate           DATETIME NULL      -- upper edge of the sales period

)
-- The body of the procedure
AS BEGIN
	IF @BusinessEntityID IN (SELECT SalesPersonID FROM [Sales].[SalesOrderHeader])
		BEGIN
		    PRINT('The employee has been identified successfully')
		    DECLARE @SQL NVARCHAR(1000);
			    SET @SQL = CONCAT(N'SELECT SUM(SubTotal) FROM [Sales].[SalesOrderHeader] WHERE SalesPersonID = ', @BusinessEntityID);

			IF @FromDate IS NOT NULL AND @ToDate IS NOT NULL
				BEGIN
				    PRINT('The period was specified');
					SET @SQL = CONCAT(@SQL, N' ', N' AND OrderDate BETWEEN ', N'''', convert(varchar(25), @FromDate, 21), N'''', N' AND', N' ', N'''',convert(varchar(25), @ToDate, 21), N'''');
				END

			PRINT('The procedure is calculating right now')
			PRINT(CONCAT_WS(N' ', @SQL, 'is going to be executed'))
			execute sp_executesql @SQL;

			PRINT('The procedure has finished calculating')

		END
		ELSE
			PRINT('The employee does not exist');
END;

--==================================================================================================
DECLARE @Total MONEY;
EXECUTE CALCULATE_TOTAL_SALES_EXAMPE_2 279,  @Total OUTPUT, null, null;
SELECT @Total;
