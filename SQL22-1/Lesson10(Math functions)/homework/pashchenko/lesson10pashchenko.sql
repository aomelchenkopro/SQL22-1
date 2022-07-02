"Задача №1
Напишите запрос, который возвращает наименование должности (в верхнем регистре и без пробелов в начале строки) 
с наибольшим количеством работников не проводивших продажи на товары цвета Black в 2013 году
- Используются таблицы: [HumanResources].[Employee], [Sales].[SalesOrderHeader], [Sales].[SalesOrderDetail], [Production].[Product]
- Рез. набор данных содержит: наименование должности (в верхнем регистре и без пробелов в начале строки), кол-во работников"									

select * from [HumanResources].[Employee]
select * from[Sales].[SalesOrderHeader]
select * from[Sales].[SalesOrderDetail]
select * from[Production].[Product]

select     top 1
           with ties
           upper(ltrim(a4.JobTitle)),
           count(distinct a4.BusinessEntityID) as [count]
from       [Production].[Product] as a1
inner join [Sales].[SalesOrderDetail]  as a2 on a2.ProductID = a1.ProductID
                                       and a1.color != 'black'
inner join [Sales].[SalesOrderHeader]  as a3 on a3.SalesOrderID = a2.SalesOrderID
                                       and a3.SalesOrderID between '20130101' and '20140101'
right join [HumanResources].[Employee] as a4 on a4.BusinessEntityID = a3.SalesPersonID
where      a3.SalesOrderID is null
group by   upper(ltrim(a4.JobTitle))
order by   [count] desc
