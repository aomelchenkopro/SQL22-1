USE [AdventureWorks2012];

/*
Задача 1
Напишите SQL script, который рассчитает общую стоимость проданных товаров и кол-во проданных единиц товара.
Учитывайте только заказы, которые были проведены активными работниками (CurrentFlag) на должностях
Production Technician - WC10, Production Technician - WC20, Production Technician - WC30, Production Technician - WC40
Production Technician - WC45, Production Technician - WC50, Production Technician - WC60.
Не учитывайте сотрудников, которые на данным момент работаю в департаменте 14
Учитывайте только заказы за последний год в таблице [Sales].[SalesOrderHeader].
Постарайтесь исключить вероятные дубликаты строк, чтобы не допустить задваивания показателей.
- Используются таблицы: [HumanResources].[Employee], [HumanResources].[EmployeeDepartmentHistory],
[Sales].[SalesOrderHeader], [Sales].[SalesOrderDetail], [Production].[Product], 
- Результирующий набор данных содержит: Наименование продукта, сумма проданного товара, кол-во проданных ед. товара




*/
WITH ActiveEmployee AS
(SELECT e.BusinessEntityID
   FROM [HumanResources].[Employee] e
  WHERE e.JobTitle IN (N'Sales Representative',N'North American Sales Manager')
     -- Active
    AND e.CurrentFlag = 1
    AND e.BusinessEntityID NOT IN (-- List of active employee from 14 department
                                  SELECT dh.BusinessEntityID
                                    FROM [HumanResources].[EmployeeDepartmentHistory] dh
                                   WHERE dh.DepartmentID = 14
                                     AND dh.EndDate IS NULL)
),
LastYearOrders AS
(
SELECT TOP 1
       WITH TIES
	   oh.SalesOrderID,
	   oh.SalesPersonID,
	   oh.OrderDate
  FROM [Sales].[SalesOrderHeader] oh
 ORDER BY year(oh.OrderDate) DESC
),
LastYear AS
(
SELECT MAX(YEAR(OrderDate)) LYear
  FROM LastYearOrders
),
LastYearPeriods AS
(
SELECT CONCAT((SELECT LYear FROM LastYear), '01') [PERIOD]
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '02') 
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '03') 
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '04') 
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '05') 
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '06') 
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '07') 
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '08') 
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '09') 
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '10') 
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '11') 
UNION ALL
SELECT CONCAT((SELECT LYear FROM LastYear), '12') 

),
ResultOrders AS
(
SELECT p.[Name],
       FORMAT(lyo.OrderDate,'yyyyMM', 'en-US') [PERIOD],
       sod.LineTotal,
	   sod.OrderQty 
  FROM ActiveEmployee ae
 INNER JOIN LastYearOrders lyo ON lyo.SalesPersonID = ae.BusinessEntityID
 INNER JOIN [Sales].[SalesOrderDetail] sod ON sod.SalesOrderID = lyo.SalesOrderID
 INNER JOIN [Production].[Product] p ON p.ProductID = sod.ProductID
)

SELECT qb.[Name],
       qb.[PERIOD],
	   SUM(qb.LineTotal) TOTAL,
	   SUM(qb.OrderQty) QTY
  FROM (
		SELECT rto.[Name],
			   rto.[PERIOD],
			   rto.LineTotal,
			   rto.OrderQty
		  FROM ResultOrders rto
		UNION ALL
		SELECT q.[Name],
			   lyp.[PERIOD],
			   NULL,
			   NULL
		  FROM (SELECT DISTINCT
					   ro.[Name]
				  FROM ResultOrders ro) q
		  CROSS JOIN LastYearPeriods lyp) qb
 GROUP BY qb.[Name],
       qb.[PERIOD]
;









-- Ян
Select t3.[Name],
       sum(t1.OrderQty) as CountProduct,
	   sum(t1.LineTotal) as SumProduct
from [Sales].[SalesOrderDetail] as t1
join [Sales].[SalesOrderHeader] as t2 on t2.SalesOrderID = t1.SalesOrderID
                                      and t2.OrderDate between (select dateadd (year, -1, max(OrderDate))from [Sales].[SalesOrderHeader]) and (select max(OrderDate) from [Sales].[SalesOrderHeader])
join [Production].[Product] as t3 on t3.ProductID = t1.ProductID
Join [HumanResources].[Employee] as t4 on t4.BusinessEntityID = t2.SalesPersonID
                                       and t4.JobTitle in (N'Sales Representative',N'North American Sales Manager')
									   and t4.CurrentFlag = 1
									   and t4.BusinessEntityID in (Select t5.BusinessEntityID
									                                from [HumanResources].[EmployeeDepartmentHistory] as t5
																	where t5.DepartmentID <> 14 
																	      and t5.EndDate is null)
group by t3.[Name]
