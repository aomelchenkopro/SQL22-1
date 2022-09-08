/*Реализуйте хранимую процедуру, которая рассчитывает общую сумму продаж (за все время) для продукта.
Процедура принимает входящий параметр - @ProductID, и выходящий параметр - @TotalSales.
Вывести сообщение - 'The product does not exist', в случае если продукта с указанным идентификатором не существует.
Вывести сообщение - 'The total sales amount has been calculated successfully', в случае если продукт существует.
- Используется таблица [Sales].[SalesOrderDetail]*/

use SQL221
go
-- drop procedure Sum_Sales_For_Product
CREATE PROCEDURE Sum_Sales_For_Product
(
	@ProductID int,     
	@TotalSales numeric(38,6) OUTPUT       
)

AS BEGIN
	IF @ProductID IN (SELECT ProductID FROM [Sales].[SalesOrderDetail])
		BEGIN
		    PRINT('The total sales amount has been calculated successfully')

			SET @TotalSales = (SELECT sum(LineTotal)
								       FROM [Sales].[SalesOrderDetail]
	                                  WHERE ProductID = @ProductID);

		END
		ELSE
			PRINT('The product does not exist');
END;

--==================================================================================================
Go
DECLARE @TotalSales numeric(38,6);
EXECUTE Sum_Sales_For_Product 776, @TotalSales OUTPUT;
SELECT @TotalSales;
--Check
SELECT sum(LineTotal)
 FROM [Sales].[SalesOrderDetail]
 WHERE ProductID = 776