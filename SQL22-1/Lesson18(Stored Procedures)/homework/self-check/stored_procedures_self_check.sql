/*
Реализуйте хранимую процедуру, которая рассчитывает общую сумму продаж (за все время) для продукта.
Процедура принимает входящий параметр - @ProductID, и выходящий параметр - @TotalSales.
Вывести сообщение - 'The product does not exist', в случае если продукта с указанным идентификатором не существует.
Вывести сообщение - 'The total sales amount has been calculated successfully', в случае если продукт существует.
- Используется таблица [Sales].[SalesOrderDetail]
*/

IF OBJECT_ID('DBO.GetProductSales', 'P') IS NOT NULL DROP PROCEDURE GetProductSales;

GO

-- Create a stored procedure that will calculate a product's total amount of sales  
CREATE PROCEDURE GetProductSales(@ProductID int, @TotalSales numeric(15,2) output) AS
	BEGIN
	    IF @ProductID IN (SELECT d.ProductID FROM [Sales].[SalesOrderDetail] d)
			BEGIN
				-- Calculate the total amount of sales
				SET @TotalSales = (SELECT SUM(d.LineTotal)
									 FROM [Sales].[SalesOrderDetail] d);
				PRINT('The total sales amount has been calculated successfully')
			END
		ELSE
		PRINT('The product does not exist')
		  
	END;

GO

DECLARE @TotalSalesAmount numeric(15, 2);
EXEC GetProductSales 776, @TotalSalesAmount OUTPUT;
SELECT @TotalSalesAmount;
