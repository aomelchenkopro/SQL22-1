/*Напишите запрос, который для работников на должностях
European Sales Manager, North American Sales Manager, Pacific Sales Manager, Sales Representative,
вернет по 3 последних заказа (за все время). Последний заказа определяется по дате заказа (OrderDate) и
по индет. заказа (SalesOrderID). Чем больше дата и идентификатор заказа, тем позднее закал был проведен.
Например, 2014-05-01 00:00:00.000 и 113164 больше чем 2014-05-01 00:00:00.000 и 112471.
Работники на указанных должностях, которые не проводили ни одного заказа остаются самом конце рез. набора данных.
Исключить из выборки сотрудников, которые проводили заказы (за все время) на товары с номерами (ProductNumber) 
FW-M423, FW-M762, FW-M928, FW-R762, FW-R820 .
- Используются таблицы: [HumanResources].[Employee], [Sales].[SalesOrderHeader], [Sales].[SalesOrderDetail], [Production].[Product]
- Задействуйте ранжирующую функцию dense_rank
- Результирующий набор данных содержит: Идент. работника, наименование должности (в верхнем регистре без пробелов в начале),
идент.заказа, дата проведения заказа, идент. детали заказа, сума заказа, сумма детали заказа,
номер продукта(в верхнем регистре без пробелов в начале), ранг строки.
- Отсортируйте рез. набор данных по идент. сотрудника, по дате заказа (по убыванию), по идент заказа (по убыванию)*/



with cte as (
select t1.BusinessEntityID,
       upper(ltrim(t1.JobTitle)) as [JobTitle],
	   t2.SalesOrderID,
	   t2.OrderDate,
	   t3.SalesOrderDetailID,
	   t2.SubTotal,
	   t3.LineTotal,
	   upper(ltrim(t4.ProductNumber)) as [ProductNumber], 
	   dense_rank()over(partition by t1.BusinessEntityID order by t2.SalesOrderID desc,t2.orderdate desc) as [Rank]
  from [HumanResources].[Employee] as t1
  left join [Sales].[SalesOrderHeader] as t2 on t2.SalesPersonID = t1.BusinessEntityID
  join [Sales].[SalesOrderDetail] as t3 on t3.SalesOrderID = t2.SalesOrderID
  join [Production].[Product] as t4 on t4.ProductID = t3.ProductID
    where t1.JobTitle in ('Sales Manager', 'North American Sales Manager','Pacific Sales Manager', 'Sales Representative')
     and t1.BusinessEntityID not in ( select t5.SalesPersonID 
                                       from [Sales].[SalesOrderHeader] as t5
                                       join [Sales].[SalesOrderDetail] as t6 on t6.SalesOrderID = t5.SalesOrderID
	                                  where t6.ProductID in (select ProductID 
	                                                          from [Production].[Product]
							                                 where ProductNumber in ('FW-M423', 'FW-M762', 'FW-M928', 'FW-R762', 'FW-R820'))))
Select * from cte
where [Rank] < 4

