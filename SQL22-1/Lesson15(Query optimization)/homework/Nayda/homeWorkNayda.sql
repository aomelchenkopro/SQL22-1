/*Напишите запрос, который вернет список заказов на период (YYYYMM) с наибольшим количеством заказов.
Учитывайте только заказы, которые были осуществлены клиентами 4 территории на продукты желтого цвета в 2014 году.
- Решите задачу двумя способами, с помощью cte и временных локальных таблиц
- Используются таблицы: [Sales].[SalesOrderHeader], [Sales].[Customer], [Sales].[SalesOrderDetail], [Production].[Product]
- Результирующий набор данных содержит: Период (YYYYMM), идент. заказа, общая сумма заказа, идент. клиента, идент. продукта*/

--=====================CTE=======================================
with cte as(
select format (t1.OrderDate, 'yyyyMM') as [Period],
       t1.SalesOrderID as OrderID,
	   t1.SubTotal,
	   t1.CustomerID,
	   t4.ProductID
 from [Sales].[SalesOrderHeader] as t1
 join [Sales].[Customer] as t2 on t2.CustomerID = t1.CustomerID
                               and t2.TerritoryID = 4
 join [Sales].[SalesOrderDetail] as t3 on t3.SalesOrderID = t1.SalesOrderID
 join [Production].[Product] as t4 on t4.ProductID = t3.ProductID
                                   and t4.Color = N'Yellow'
where t1.OrderDate between '20140101' and '20141231 23:59:59')

select 
* from cte 
where [Period] in (select top 1 with ties [Period]    
	                      from cte
	                Group by [Period]  
                    order by count (distinct orderid) desc)

---===============================LocalTables===============================
---------------===================#1========================================
if object_id('[tempdb].[dbo].#loc1') is not null drop table #loc1;
select format (OrderDate, 'yyyyMM') as [Period],
       SalesOrderID as OrderID,
	   SubTotal,
	   CustomerID
 into #loc1
 from [Sales].[SalesOrderHeader]
 where OrderDate between '20140101' and '20141231 23:59:59'

 select * from #loc1

 ---------------===================#2========================================
if object_id('[tempdb].[dbo].#loc2') is not null drop table #loc2;
select t1.* 
into #loc2
 from #loc1 as t1
 join [Sales].[Customer] as t2 on t2.CustomerID = t1.CustomerID
                                  and t2.TerritoryID = 4

 select * from #loc2

  ---------------===================#3========================================
if object_id('[tempdb].[dbo].#loc3') is not null drop table #loc3;

select t1.*,
       t2.ProductID
into #loc3
from #loc2 as t1
join [Sales].[SalesOrderDetail] as t2 on t2.SalesOrderID = t1.OrderID
                 
 select * from #loc3

   ---------------===================#4========================================
if object_id('[tempdb].[dbo].#loc4') is not null drop table #loc4;

select t1.*
into #loc4
 from #loc3 as t1
 join [Production].[Product] as t2 on t2.ProductID = t1.ProductID
                                   and t2. Color = N'Yellow'

 select * from #loc4

   ---------------===================#5========================================
if object_id('[tempdb].[dbo].#loc5') is not null drop table #loc5;

select top 1 with ties [Period]
into #loc5
  from #loc4
  Group by [Period]  
  order by count (distinct orderid) desc

 select * from #loc5

---------------===================#End========================================

select t1.*
 from #loc4 as t1
 join #loc5 as t2 on t2.[Period] = t1.[Period] 

