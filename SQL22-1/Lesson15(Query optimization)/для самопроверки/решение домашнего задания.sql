/*
Напишите запрос, который вернет список заказов на период (YYYYMM) с наибольшим количеством заказов.
Учитывайте только заказы, которые были осуществлены клиентами 4 территории на продукты желтого цвета в 2014 году.
- Решите задачу двумя способами, с помощью cte и временных локальных таблиц
- Используются таблицы: [Sales].[SalesOrderHeader], [Sales].[Customer], [Sales].[SalesOrderDetail], [Production].[Product]
- Результирующий набор данных содержит: Период (YYYYMM), идент. заказа, общая сумма заказа, идент. клиента, идент. продукта
*/
--==================================================================================================================================================
-- CTE
with cte as (
select format(h.OrderDate, 'yyyyMM', 'en-US') as [period],
       h.SalesOrderID,
	   c.CustomerID,
	   p.ProductID,
	   h.SubTotal
  from [Sales].[SalesOrderHeader] h 
  inner join [Sales].[Customer] c on c.CustomerID = h.CustomerID
                                 and c.TerritoryID = 4
  inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
  inner join [Production].[Product] p on p.ProductID = d.ProductID
                                     and p.Color = N'Yellow'
 where h.OrderDate between '20140101 00:00:00' and '20141231 23:59:59'
) 

select c3.*
  from cte c3
 where c3.[period] in (select c2.[period]
                         from cte c2 
                        group by c2.[period]
                       having count(distinct c2.SalesOrderID) = (select top 1
                                                                        count(distinct c1.SalesOrderID) as ordQty
                                                                   from cte c1
                                                                  group by c1.[period]
                                                                  order by count(distinct c1.SalesOrderID) desc));
--==================================================================================================================================================
go
-- Local temporary tables
if object_id('[tempdb].[dbo].#l1') is not null drop table #l1;
select convert(char(6),format(h.OrderDate, 'yyyyMM', 'en-US')) as [period],
       h.SalesOrderID,
	   h.SubTotal,
	   h.CustomerID
  into #l1
  from [Sales].[SalesOrderHeader] h;

create clustered index ci_CustomerID on #l1(CustomerID); 
---------------------------------------------------------------------
if object_id('[tempdb].[dbo].#l2') is not null drop table #l2;
select l.*
  into #l2
  from #l1 l
 inner join [Sales].[Customer] c on c.CustomerID = l.CustomerID
                                and c.TerritoryID = 4;

create clustered index ci_SalesOrderID on #l2(SalesOrderID);
---------------------------------------------------------------------
if object_id('[tempdb].[dbo].#l3') is not null drop table #l3;
select l.*,
       d.ProductID
  into #l3
  from #l2 l
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = l.SalesOrderID;

create clustered index ci_SalesOrderID on #l3(ProductID);
---------------------------------------------------------------------
if object_id('[tempdb].[dbo].#l4') is not null drop table #l4;
select l.*
  into #l4
  from #l3 l 
 inner join [Production].[Product] p on p.ProductID = l.ProductID
                                     and p.Color = N'Yellow';

create clustered index ci_period on #l4([period]);
---------------------------------------------------------------------
select c3.*
  from #l4 c3
 where c3.[period] in (select c2.[period]
                         from #l4 c2 
                        group by c2.[period]
                       having count(distinct c2.SalesOrderID) = (select top 1
                                                                        count(distinct c1.SalesOrderID) as ordQty
                                                                   from #l4 c1
                                                                  group by c1.[period]
                                                                  order by count(distinct c1.SalesOrderID) desc));


