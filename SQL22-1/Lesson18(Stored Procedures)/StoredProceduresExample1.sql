/*
Реализовать хранимую процедуру для расчета общей суммы продаж по сотруднику
- Используется таблица [Sales].[SalesOrderHeader]
*/

--==================================================================================================
-- Create a stored procedure of total sales amount calculating

-- The head of the procedure 
CREATE PROCEDURE CALCULATE_TOTAL_SALES_EXAMPLES_1
(
	@BusinessEntityID INT -- ID of an employee

)
-- The body of the procedure
AS BEGIN
	IF @BusinessEntityID IN (SELECT SalesPersonID FROM [Sales].[SalesOrderHeader] )
		BEGIN
		    PRINT('The employee has been identified successfully')

			PRINT('The procedure is calculating right now')

			-- Calculate the amount of sales within the period
			SELECT SUM(SubTotal)
			  FROM [Sales].[SalesOrderHeader]
	         WHERE SalesPersonID = @BusinessEntityID;

			PRINT('The procedure has finished calculating')

		END
		ELSE
			PRINT('The employee does not exist');
END;

--==================================================================================================
-- drop table #local_temp_table_1;
create table #local_temp_table_1(
       id        int identity,
	   amount    money,
	   exec_date datetime default SYSDATETIME()
);

insert into #local_temp_table_1(amount)
EXECUTE CALCULATE_TOTAL_SALES_EXAMPLES_1 279;

select * from #local_temp_table_1;