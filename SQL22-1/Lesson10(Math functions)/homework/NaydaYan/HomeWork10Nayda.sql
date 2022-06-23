/*"Задача №1
Напишите запрос, который возвращает наименование должности (в верхнем регистре и без пробелов в начале строки) 
с наибольшим количеством работников не проводивших продажи на товары цвета Black в 2013 году
- Используются таблицы: [HumanResources].[Employee], [Sales].[SalesOrderHeader], [Sales].[SalesOrderDetail], [Production].[Product]
- Рез. набор данных содержит: наименование должности (в верхнем регистре и без пробелов в начале строки), кол-во работников" */


select top 1
       with ties upper(ltrim(JobTitle)) , COUNT(BusinessEntityID) as qtyemp 
 from HumanResources.Employee
 where BusinessEntityID not in (
                                select BusinessEntityID from HumanResources.Employee
 where BusinessEntityID in (
	                            select distinct soh.SalesPersonID 
       from [Sales].[SalesOrderHeader] as soh
	  left join [Sales].[SalesOrderDetail] as sod on soh.SalesOrderID = sod.SalesOrderID
	  left join [Production].[Product] as p on sod.ProductID = p.ProductID
  where  p.Color = N'Black'
   and soh.OrderDate between '20130101' and '20140101'
   ))    group by JobTitle
   order by qtyemp desc;


 --Разобрать что не так с запросом 

  /* select BusinessEntityID from HumanResources.Employee
 where BusinessEntityID not in (
	select distinct soh.SalesPersonID 
       from [Sales].[SalesOrderHeader] as soh
	   left join [Sales].[SalesOrderDetail] as sod on soh.SalesOrderID = sod.SalesOrderID
	   left join [Production].[Product] as p on sod.ProductID = p.ProductID
  where  p.Color = N'Black'
   and soh.OrderDate between '20130101' and '20140101')*/
   
