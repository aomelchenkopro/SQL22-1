/*Напишите запрос для расчета доли каждой отдельной детали заказа от общей стоимости заказа (LineTotal).
Учитывайте только заказы за три последние даты (без времени), которые есть в таблице [Sales].[SalesOrderHeader].
- Используется таблицы: [Sales].[SalesOrderDetail], [Production].[Product], [Sales].[SalesOrderHeader]
- Задействуйте функцию ранжирования DENSE_RANK
- Задействуйте оконно-агрегатные функцию SUM
- Рез. набор данных содержит: Идент. заказа, идент. детали заказа, идент. продукта,
наименование продукта, стоимость детали заказа, доля.*/

with cte as ( 
	          SELECT SalesOrderID,
                     DENSE_RANK()OVER(ORDER BY CONVERT(DATE, OrderDate) DESC) as [rank]
              FROM [Sales].[SalesOrderHeader])

SELECT t1.SalesOrderID,
       t1.SalesOrderDetailID,
	   t1.ProductID,
	   t2.[Name],
	   t1.LineTotal,
	   t1.LineTotal/ SUM(t1.LineTotal)OVER(PARTITION BY t1.SalesOrderID) * 100.00 as part
  FROM [Sales].[SalesOrderDetail] AS t1
 join [Production].[Product] AS t2 ON t2.ProductID = t1.ProductID
 join cte as t3 on t3.SalesOrderID = t1.SalesOrderID
                and t3.[rank] <= 3
order by SalesOrderID
 
