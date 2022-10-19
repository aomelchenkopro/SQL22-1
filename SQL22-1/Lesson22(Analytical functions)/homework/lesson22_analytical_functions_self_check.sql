/*
Напишите запрос для расчета доли каждой отдельной детали заказа от общей стоимости заказа (LineTotal).
Учитывайте только заказы за три последние даты (без времени), которые есть в таблице [Sales].[SalesOrderHeader].
- Используется таблицы: [Sales].[SalesOrderDetail], [Production].[Product], [Sales].[SalesOrderHeader]
- Задействуйте функцию ранжирования DENSE_RANK
- Задействуйте оконно-агрегатные функцию SUM
- Рез. набор данных содержит: Идент. заказа, идент. детали заказа, идент. продукта,
наименование продукта, стоимость детали заказа, доля.
*/

SELECT O.SalesOrderID,
       O.SalesOrderDetailID,
	   O.ProductID,
	   P.[Name],
	   O.LineTotal,
	   O.LineTotal/ SUM(O.LineTotal)OVER(PARTITION BY O.SalesOrderID) * 100.00 part
  FROM [Sales].[SalesOrderDetail] AS O
 INNER JOIN [Production].[Product] AS P ON P.ProductID = O.ProductID
 WHERE O.SalesOrderID in (SELECT d.SalesOrderID
                            FROM (SELECT H.SalesOrderID,
                                         DENSE_RANK()OVER(ORDER BY CONVERT(DATE, OrderDate) DESC) AS R
                                    FROM [Sales].[SalesOrderHeader] H) d
                                   WHERE d.R <= 3);