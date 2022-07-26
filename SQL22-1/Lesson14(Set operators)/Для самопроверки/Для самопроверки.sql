/*
Напишите запрос, который вернет список товаров (без дубликатов) проведенные самым старшим работником мужского пола, за 2011 год.
Учитывайте вероятность того, что сразу несколько работников могут иметь одну и ту же дату рождения.
Не используйте оператор with ties.
- Оптимизируйте запрос с помощью временных локальных таблиц
- Используются таблицы: [HumanResources].[Employee], [Sales].[SalesOrderHeader], [Sales].[SalesOrderDetail], [Production].[Product]
- Рез. набор данных содержит идент. товара, наименование товара, цвет товара
- Отсортировать рез. набор данных по цвету товара (по возрастанию), в разрезе цвета по идент. товара (по возрастанию)
*/
if object_id('[tempdb].[dbo].#loc1') is not null drop table #loc1;
select distinct 
        t2.SalesOrderID
  into #loc1
  from [HumanResources].[Employee] as t1
 inner join [Sales].[SalesOrderHeader] as t2 on t2.SalesPersonID = t1.BusinessEntityID
                                            and t2.OrderDate between '20110101' and '20111231 23:59:59'
 where t1.Gender = N'M'
   and t1.BirthDate = (select min(t3.BirthDate)
                         from [HumanResources].[Employee] as t3
                        where t3.Gender = N'M');

create clustered index CLSalesOrderID on #loc1(SalesOrderID);

if object_id('[tempdb].[dbo].#loc2') is not null drop table #loc2;
select distinct
       t2.ProductID
  into #loc2
  from #loc1 as t1 
 inner join [Sales].[SalesOrderDetail] as t2 on t2.SalesOrderID = t1.SalesOrderID;

create clustered index CLProductID on #loc2(ProductID);

if object_id('[tempdb].[dbo].#loc3') is not null drop table #loc3;
select t2.ProductID,
	   t2.[Name],
	   t2.Color 
  into #loc3
  from #loc2 as t1
 inner join [Production].[Product] as t2 on t2.ProductID = t1.ProductID;

select * 
  from #loc3
 order by Color asc,
          ProductID asc;