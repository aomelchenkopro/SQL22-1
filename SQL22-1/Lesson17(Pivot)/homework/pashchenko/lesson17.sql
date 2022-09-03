/*
Задача 1
Напишите запрос для разворачивания данных.
Отразите идентификатор продукта вертикально, а даты проведения заказа горизонтально.
На пересечени расчитайте кол-во уникальных заказов. Учитывайте только заказы за июнь 2011 года.
- Ипользуется таблица [Sales].[SalesOrderHeader]
- Задействуйте оператор pivot.
select * from  [Sales].[SalesOrderHeader]

*/

with cte as 
(
select     count(distinct a.SalesOrderID) as [OrderID],
           format(a.OrderDate, 'yyyy-MM-dd', 'en-US') as [OrderDate],
	       d.ProductID as [ProductID]
from       [Sales].[SalesOrderHeader] as a
inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = a.SalesOrderID
where      a.OrderDate between '20110601' and '20110630'
group by   format(a.OrderDate, 'yyyy-MM-dd', 'en-US'),
           d.ProductID
)

select *
from cte
pivot (sum([OrderID]) for [OrderDate] in ([2011-06-01], [2011-06-02], [2011-06-03],
[2011-06-04], [2011-06-05], [2011-06-06], [2011-06-07], [2011-06-08], [2011-06-09],
[2011-06-10], [2011-06-11], [2011-06-12], [2011-06-13], [2011-06-14], [2011-06-15],
[2011-06-16], [2011-06-17], [2011-06-18], [2011-06-19], [2011-06-20], [2011-06-21], 
[2011-06-22], [2011-06-23], [2011-06-24], [2011-06-25], [2011-06-26], [2011-06-27],
[2011-06-28], [2011-06-295], [2011-06-30])) as q
--===================================================================================
/*
Задача 2
Отмените разворачивание данных из задачи 1 (без деагрегации данных).
- Задействуйте оператор unpivot
*/
with cte as 
(
   select  count(distinct a.SalesOrderID) as [OrderID],
           format(a.OrderDate, 'yyyy-MM-dd', 'en-US') as [OrderDate],
	       d.ProductID as [ProductID]
    from   [Sales].[SalesOrderHeader] as a
inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = a.SalesOrderID
   where   a.OrderDate between '20110601' and '20110630'
group by   format(a.OrderDate, 'yyyy-MM-dd', 'en-US'),
           d.ProductID
)

select  *
  into  #loc1
  from  cte
pivot (sum([OrderID]) for [OrderDate] in ([2011-06-01], [2011-06-02], [2011-06-03],
[2011-06-04], [2011-06-05], [2011-06-06], [2011-06-07], [2011-06-08], [2011-06-09],
[2011-06-10], [2011-06-11], [2011-06-12], [2011-06-13], [2011-06-14], [2011-06-15],
[2011-06-16], [2011-06-17], [2011-06-18], [2011-06-19], [2011-06-20], [2011-06-21], 
[2011-06-22], [2011-06-23], [2011-06-24], [2011-06-25], [2011-06-26], [2011-06-27],
[2011-06-28], [2011-06-295], [2011-06-30])) as q


 select *
   from #loc1
unpivot([OrderID] for [OrderDate] in ([2011-06-01], [2011-06-02], [2011-06-03],
       [2011-06-04], [2011-06-05], [2011-06-06], [2011-06-07], [2011-06-08], [2011-06-09],
       [2011-06-10], [2011-06-11], [2011-06-12], [2011-06-13], [2011-06-14], [2011-06-15],
       [2011-06-16], [2011-06-17], [2011-06-18], [2011-06-19], [2011-06-20], [2011-06-21], 
       [2011-06-22], [2011-06-23], [2011-06-24], [2011-06-25], [2011-06-26], [2011-06-27],
       [2011-06-28], [2011-06-295], [2011-06-30])) as q
--==2
with cte as 
(
   select  count(distinct a.SalesOrderID) as [OrderID],
           format(a.OrderDate, 'yyyy-MM-dd', 'en-US') as [OrderDate],
	       d.ProductID as [ProductID]
    from   [Sales].[SalesOrderHeader] as a
inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = a.SalesOrderID
   where   a.OrderDate between '20110601' and '20110630'
group by   format(a.OrderDate, 'yyyy-MM-dd', 'en-US'),
           d.ProductID
),
[unpivot] as 
(
select  *
  from  cte
pivot (sum([OrderID]) for [OrderDate] in ([2011-06-01], [2011-06-02], [2011-06-03],
[2011-06-04], [2011-06-05], [2011-06-06], [2011-06-07], [2011-06-08], [2011-06-09],
[2011-06-10], [2011-06-11], [2011-06-12], [2011-06-13], [2011-06-14], [2011-06-15],
[2011-06-16], [2011-06-17], [2011-06-18], [2011-06-19], [2011-06-20], [2011-06-21], 
[2011-06-22], [2011-06-23], [2011-06-24], [2011-06-25], [2011-06-26], [2011-06-27],
[2011-06-28], [2011-06-295], [2011-06-30])) as q
)

 select *
   from [unpivot]
unpivot([OrderID] for [OrderDate] in ([2011-06-01], [2011-06-02], [2011-06-03],
       [2011-06-04], [2011-06-05], [2011-06-06], [2011-06-07], [2011-06-08], [2011-06-09],
       [2011-06-10], [2011-06-11], [2011-06-12], [2011-06-13], [2011-06-14], [2011-06-15],
       [2011-06-16], [2011-06-17], [2011-06-18], [2011-06-19], [2011-06-20], [2011-06-21], 
       [2011-06-22], [2011-06-23], [2011-06-24], [2011-06-25], [2011-06-26], [2011-06-27],
       [2011-06-28], [2011-06-295], [2011-06-30])) as q
--===================================================================================
/*
Задача 3
Напишите запрос для разворачивания данных.
Отразите идентификатор продукта вертикально, а даты проведения заказа горизонтально.
На пересечени расчитайте кол-во уникальных заказов. Учитывайте только заказы за июнь 2011 года.
- Ипользуется таблица [Sales].[SalesOrderHeader]
- Задействуйте встроенные средства - оператор case.
*/
with cte as 
(
   select  count(distinct a.SalesOrderID) as [OrderID],
           format(a.OrderDate, 'yyyy-MM-dd', 'en-US') as [OrderDate],
	       d.ProductID as [ProductID]
    from   [Sales].[SalesOrderHeader] as a
inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = a.SalesOrderID
   where   a.OrderDate between '20110601' and '20110630'
group by   format(a.OrderDate, 'yyyy-MM-dd', 'en-US'),
           d.ProductID
)
select [ProductID],
         sum(case OrderDate when '2011-06-01' then [OrderID] end) as [2011-06-01],
		 sum(case OrderDate when '2011-06-02' then [OrderID] end) as [2011-06-02],
		 sum(case OrderDate when '2011-06-03' then [OrderID] end) as [2011-06-03],
		 sum(case OrderDate when '2011-06-04' then [OrderID] end) as [2011-06-04],
		 sum(case OrderDate when '2011-06-05' then [OrderID] end) as [2011-06-05],
		 sum(case OrderDate when '2011-06-06' then [OrderID] end) as [2011-06-06],
		 sum(case OrderDate when '2011-06-07' then [OrderID] end) as [2011-06-07],
		 sum(case OrderDate when '2011-06-08' then [OrderID] end) as [2011-06-08],
		 sum(case OrderDate when '2011-06-09' then [OrderID] end) as [2011-06-09],
		 sum(case OrderDate when '2011-06-10' then [OrderID] end) as [2011-06-10],
		 sum(case OrderDate when '2011-06-11' then [OrderID] end) as [2011-06-11],
		 sum(case OrderDate when '2011-06-12' then [OrderID] end) as [2011-06-12],
		 sum(case OrderDate when '2011-06-13' then [OrderID] end) as [2011-06-13],
		 sum(case OrderDate when '2011-06-14' then [OrderID] end) as [2011-06-14],
		 sum(case OrderDate when '2011-06-15' then [OrderID] end) as [2011-06-15],
		 sum(case OrderDate when '2011-06-16' then [OrderID] end) as [2011-06-16],
		 sum(case OrderDate when '2011-06-17' then [OrderID] end) as [2011-06-17],
		 sum(case OrderDate when '2011-06-18' then [OrderID] end) as [2011-06-18],
		 sum(case OrderDate when '2011-06-19' then [OrderID] end) as [2011-06-19],
		 sum(case OrderDate when '2011-06-20' then [OrderID] end) as [2011-06-20],
		 sum(case OrderDate when '2011-06-21' then [OrderID] end) as [2011-06-21],
		 sum(case OrderDate when '2011-06-22' then [OrderID] end) as [2011-06-22],
		 sum(case OrderDate when '2011-06-23' then [OrderID] end) as [2011-06-23],
		 sum(case OrderDate when '2011-06-24' then [OrderID] end) as [2011-06-24],
		 sum(case OrderDate when '2011-06-25' then [OrderID] end) as [2011-06-25],
		 sum(case OrderDate when '2011-06-26' then [OrderID] end) as [2011-06-26],
		 sum(case OrderDate when '2011-06-27' then [OrderID] end) as [2011-06-27],
		 sum(case OrderDate when '2011-06-28' then [OrderID] end) as [2011-06-28],
		 sum(case OrderDate when '2011-06-29' then [OrderID] end) as [2011-06-29],
		 sum(case OrderDate when '2011-06-30' then [OrderID] end) as [2011-06-30]
		  from cte
group by [ProductID]
--===================================================================================
/*
Отмените разворачивание данных из задачи 1 (без деагрегации данных).
- Задействуйте встроенные средства - cross join
*/
with cte as (
select *
  from (select  count(distinct a.SalesOrderID) as [OrderID],
           format(a.OrderDate, 'yyyy-MM-dd', 'en-US') as [OrderDate],
	       d.ProductID as [ProductID]
    from   [Sales].[SalesOrderHeader] as a
inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = a.SalesOrderID
   where   a.OrderDate between '20110601' and '20110630'
group by   format(a.OrderDate, 'yyyy-MM-dd', 'en-US'),
           d.ProductID ) as q
  pivot(sum([OrderID]) for orderdate in        ([2011-06-01],[2011-06-02],[2011-06-03],[2011-06-04],[2011-06-05],
                                                [2011-06-06],[2011-06-07],[2011-06-08],[2011-06-09],[2011-06-10],
												[2011-06-11],[2011-06-12],[2011-06-13],[2011-06-14],[2011-06-15],
												[2011-06-16],[2011-06-17],[2011-06-18],[2011-06-19],[2011-06-20],
												[2011-06-21],[2011-06-22],[2011-06-23],[2011-06-24],[2011-06-25],
												[2011-06-26],[2011-06-27],[2011-06-28],[2011-06-29],[2011-06-30]
												)) as q )
										 
select * 
  from (
       select  c.ProductID,
               d.orderdate,
    case    d.orderdate  when '2011-06-01' then [2011-06-01] 
                         when '2011-06-02' then [2011-06-02] 
                         when '2011-06-03' then [2011-06-03] 
                         when '2011-06-04' then [2011-06-04] 
                         when '2011-06-05' then [2011-06-05] 
                         when '2011-06-06' then [2011-06-06] 
						 when '2011-06-07' then [2011-06-07] 
						 when '2011-06-08' then [2011-06-08] 
						 when '2011-06-09' then [2011-06-09] 
						 when '2011-06-10' then [2011-06-10] 
					     when '2011-06-11' then [2011-06-11] 
						 when '2011-06-12' then [2011-06-12] 
			             when '2011-06-13' then [2011-06-13] 
						 when '2011-06-14' then [2011-06-14] 
						 when '2011-06-15' then [2011-06-15] 
						 when '2011-06-16' then [2011-06-16] 
						 when '2011-06-17' then [2011-06-17] 
						 when '2011-06-18' then [2011-06-18] 
						 when '2011-06-19' then [2011-06-19] 
						 when '2011-06-20' then [2011-06-20]
						 when '2011-06-21' then [2011-06-21] 
						 when '2011-06-22' then [2011-06-22] 
						 when '2011-06-23' then [2011-06-23] 
						 when '2011-06-24' then [2011-06-24] 
						 when '2011-06-25' then [2011-06-25] 
						 when '2011-06-26' then [2011-06-26] 
						 when '2011-06-27' then [2011-06-27] 
						 when '2011-06-28' then [2011-06-28] 
						 when '2011-06-29' then [2011-06-29] 
						 when '2011-06-30' then [2011-06-30]  end as [OrderID]
  from cte c
  cross join (values ('2011-06-01'), ('2011-06-02'), ('2011-06-03'), ('2011-06-04'), ('2011-06-05'),
                     ('2011-06-06'), ('2011-06-07'), ('2011-06-08'), ('2011-06-09'), ('2011-06-10'),
                     ('2011-06-11'), ('2011-06-12'), ('2011-06-13'), ('2011-06-14'), ('2011-06-15'),
                     ('2011-06-16'), ('2011-06-17'), ('2011-06-18'), ('2011-06-19'), ('2011-06-20'),
                     ('2011-06-21'), ('2011-06-22'), ('2011-06-23'), ('2011-06-24'), ('2011-06-25'),
                     ('2011-06-26'), ('2011-06-27'), ('2011-06-28'), ('2011-06-29'), ('2011-06-30')) as d (orderdate)
  ) q 
  where q.[OrderID] is not null;