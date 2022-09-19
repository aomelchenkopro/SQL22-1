/*
Реализуйте пользовательскую scalar функцию, которая по идент. работника возвращает среднее кол-во уникальных заказов в месяц.
Функция принимает один входящий параметр - @BusinessEntityID - идент. работника. Функция возвращает NUMERIC(15,2) - среднее 
кол-во заказов в месяц. Месяц - период - yyyyMM.
- Используется таблица -[Sales].[SalesOrderHeader]
- Задействуйте строковую функцию FORMAT
- Задействуйте функцию преобразования данных CONVERT
- Задействуйте агрегатную функцию AVG

*/

IF OBJECT_ID('dbo.GetCurrentOrderQty', 'FN') IS NOT NULL DROP FUNCTION dbo.GetCurrentOrderQty;
GO
-- Create a function that will calculate the average number of orders per month
CREATE FUNCTION dbo.GetCurrentOrderQty(@BusinessEntityID int)
	RETURNS NUMERIC(15,2)
		BEGIN
			DECLARE @OrderQty NUMERIC(15,2);
				SET @OrderQty = (SELECT AVG(CONVERT(NUMERIC(15,2),Q.OrderQty))
                                   FROM (SELECT H.SalesPersonID,
                                                FORMAT(H.OrderDate, 'yyyyMM', 'en-US') Period,
                                                COUNT(DISTINCT H.SalesOrderID) OrderQty
                                           FROM [Sales].[SalesOrderHeader] H
		                                  WHERE H.SalesPersonID = @BusinessEntityID
                                          GROUP BY H.SalesPersonID,
		                                           FORMAT(H.OrderDate, 'yyyyMM', 'en-US')) Q);
			RETURN @OrderQty;
		END;

GO

-- Using of the function
SELECT E.BusinessEntityID,
       dbo.GetCurrentOrderQty(E.BusinessEntityID) AverageQty -- The function that has been created
  FROM [HumanResources].[Employee] E
 ORDER BY AverageQty DESC; 