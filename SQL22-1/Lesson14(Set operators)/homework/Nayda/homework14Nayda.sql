/*Напишите запрос, который вернет список товаров (без дубликатов) проведенные самым старшим работником мужского пола, за 2011 год.
Учитывайте вероятность того, что сразу несколько работников могут иметь одну и ту же дату рождения.
Не используйте оператор with ties.
- Оптимизируйте запрос с помощью временных локальных таблиц
- Используются таблицы: [HumanResources].[Employee], [Sales].[SalesOrderHeader], [Sales].[SalesOrderDetail], [Production].[Product]
- Рез. набор данных содержит идент. товара, наименование товара, цвет товара
- Отсортировать рез. набор данных по цвету товара (по возрастанию), в разрезе цвета по идент. товара (по возрастанию)*/

--===============================================1=========================================================
if object_id('[tempdb].[dbo].#loc1') is not null drop table #loc1;
select BusinessEntityID
into #loc1
from [HumanResources].[Employee] 
where Gender = 'm'
and BirthDate = (select min(BirthDate)
				from [HumanResources].[Employee]
			    where Gender = 'm')

Select * from #loc1

--===============================================2=========================================================
if object_id('[tempdb].[dbo].#loc2') is not null drop table #loc2;

select SalesOrderID
into #loc2 
from [Sales].[SalesOrderHeader] as t1
join #loc1 as t2 on t2.BusinessEntityID = t1.SalesPersonID
where t1.OrderDate between '20110101' and '20111231 23:59:59'

select * from #loc2 

--===============================================3=========================================================
if object_id('[tempdb].[dbo].#loc3') is not null drop table #loc3;

select distinct t1.productId
into #loc3
 from [Sales].[SalesOrderDetail] as t1
 join #loc2 as t2 on t2.SalesOrderID = t1.SalesOrderID

 select * from #loc3 

select t1.ProductID,
       t1.[Name],
	   t1.Color
from [Production].[Product] as t1
join #loc3 as t2 on t2.ProductID = t1.ProductID
order by Color , ProductID