/*Реализуйте пользовательскую scalar функцию, которая по идент. работника возвращает среднее кол-во уникальных заказов в месяц.
Функция принимает один входящий параметр - @BusinessEntityID - идент. работника. Функция возвращает NUMERIC(15,2) - среднее 
кол-во заказов в месяц. Месяц - период - yyyyMM.
- Используется таблица -[Sales].[SalesOrderHeader]
- Задействуйте строковую функцию FORMAT
- Задействуйте функцию преобразования данных CONVERT
- Задействуйте агрегатную функцию AVG*/
use [SQL221];
go
CREATE FUNCTION dbo.ReturnAVGOrder (@BusinessEntityID int)
-- drop FUNCTION dbo.ReturnAVGOrder
	RETURNS numeric(15,2) AS
	 BEGIN
		DECLARE @OrderAVG numeric(15,2);
			SET @OrderAVG = (Select AVG(convert(numeric(15,2), countorder) 
                               from (
                                     select SalesPersonID,
                                            FORMAT(OrderDate,'yyyyMM', 'en-US') as mounth,
	                                        Count(distinct SalesOrderID) as countorder 
                                     from [Sales].[SalesOrderHeader]
                                     where SalesPersonID = @BusinessEntityID
                                     group by SalesPersonID,FORMAT(OrderDate,'yyyyMM', 'en-US')) as R)	   
		RETURN @OrderAVG;
	END;
GO
 --Check 
 SELECT dbo.ReturnAVGOrder (279)



 select e.BusinessEntityID,
         dbo.ReturnAVGOrder(e.BusinessEntityID)
   from [HumanResources].[Employee] e
 where dbo.ReturnAVGOrder(e.BusinessEntityID) is not null
 order by dbo.ReturnAVGOrder(e.BusinessEntityID) desc