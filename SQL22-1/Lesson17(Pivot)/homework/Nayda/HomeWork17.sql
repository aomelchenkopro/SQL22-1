/*Задача 1
Напишите запрос для разворачивания данных.
Отразите идентификатор продукта вертикально, а даты проведения заказа горизонтально.
На пересечени расчитайте кол-во уникальных заказов. Учитывайте только заказы за июнь 2011 года.
- Ипользуется таблица [Sales].[SalesOrderHeader]
- Задействуйте оператор pivot.

Задача 2
Отмените разворачивание данных из задачи 1 (без деагрегации данных).
- Задействуйте оператор unpivot

Задача 3
Напишите запрос для разворачивания данных.
Отразите идентификатор продукта вертикально, а даты проведения заказа горизонтально.
На пересечени расчитайте кол-во уникальных заказов. Учитывайте только заказы за июнь 2011 года.
- Ипользуется таблица [Sales].[SalesOrderHeader]
- Задействуйте встроенные средства - оператор case.

Задача 4
Отмените разворачивание данных из задачи 1 (без деагрегации данных).
- Задействуйте встроенные средства - cross join*/

---------Задача 1--------------------------
with cte as 
(
  select t2.ProductID, 
         convert(date,t1.OrderDate) as orderdate,
	     Count (distinct t1.SalesOrderID) as countorder
          from [Sales].[SalesOrderHeader] as t1
	      join [Sales].[SalesOrderDetail] as t2 on t2.SalesOrderID = t1.SalesOrderID
   where t1.OrderDate between '20110701' and '20110731 23:59:59'
   group by t2.ProductID,orderdate 
)

select *
  from cte
  pivot(sum(countorder) for orderdate in  ([2011-07-01],[2011-07-02],[2011-07-03],[2011-07-04],[2011-07-05],
                                                [2011-07-06],[2011-07-07],[2011-07-08],[2011-07-09],[2011-07-10],
												[2011-07-11],[2011-07-12],[2011-07-13],[2011-07-14],[2011-07-15],
												[2011-07-16],[2011-07-17],[2011-07-18],[2011-07-19],[2011-07-20],
												[2011-07-21],[2011-07-22],[2011-07-23],[2011-07-24],[2011-07-25],
												[2011-07-26],[2011-07-27],[2011-07-28],[2011-07-29],[2011-07-30],
												[2011-07-31])) as t3 order by ProductID asc

-------Задача 2----------------------------------------

with cte as (
select *
  from (select t2.ProductID, 
         convert(date,t1.OrderDate) as orderdate,
	     Count (distinct t1.SalesOrderID) as countorder
          from [Sales].[SalesOrderHeader] as t1
	      join [Sales].[SalesOrderDetail] as t2 on t2.SalesOrderID = t1.SalesOrderID
   where t1.OrderDate between '20110701' and '20110731 23:59:59'
   group by t2.ProductID,orderdate ) as q
  pivot(sum(countorder) for orderdate in  ([2011-07-01],[2011-07-02],[2011-07-03],[2011-07-04],[2011-07-05],
                                                [2011-07-06],[2011-07-07],[2011-07-08],[2011-07-09],[2011-07-10],
												[2011-07-11],[2011-07-12],[2011-07-13],[2011-07-14],[2011-07-15],
												[2011-07-16],[2011-07-17],[2011-07-18],[2011-07-19],[2011-07-20],
												[2011-07-21],[2011-07-22],[2011-07-23],[2011-07-24],[2011-07-25],
												[2011-07-26],[2011-07-27],[2011-07-28],[2011-07-29],[2011-07-30],
												[2011-07-31])) as t3 )
										
select *
  from cte 
   unpivot (countorder for orderdate in  ([2011-07-01],[2011-07-02],[2011-07-03],[2011-07-04],[2011-07-05],
                                                [2011-07-06],[2011-07-07],[2011-07-08],[2011-07-09],[2011-07-10],
												[2011-07-11],[2011-07-12],[2011-07-13],[2011-07-14],[2011-07-15],
												[2011-07-16],[2011-07-17],[2011-07-18],[2011-07-19],[2011-07-20],
												[2011-07-21],[2011-07-22],[2011-07-23],[2011-07-24],[2011-07-25],
												[2011-07-26],[2011-07-27],[2011-07-28],[2011-07-29],[2011-07-30],
												[2011-07-31])) as q											



-------Задача 3----------------------------------------

with cte as 
(
  select t2.ProductID, 
         convert(date,t1.OrderDate) as orderdate,
	     Count (distinct t1.SalesOrderID) as countorder
          from [Sales].[SalesOrderHeader] as t1
	      join [Sales].[SalesOrderDetail] as t2 on t2.SalesOrderID = t1.SalesOrderID
   where t1.OrderDate between '20110701' and '20110731 23:59:59'
   group by t2.ProductID,orderdate 
)
 --select * from cte
 select ProductID,
 sum(case orderdate when '2011-07-01' then countorder end) as [2011-07-01],
 sum(case orderdate when '2011-07-02' then countorder end) as [2011-07-02],
 sum(case orderdate when '2011-07-03' then countorder end) as [2011-07-03],
 sum(case orderdate when '2011-07-04' then countorder end) as [2011-07-04],
 sum(case orderdate when '2011-07-05' then countorder end) as [2011-07-05],
 sum(case orderdate when '2011-07-06' then countorder end) as [2011-07-06],
 sum(case orderdate when '2011-07-07' then countorder end) as [2011-07-07],
 sum(case orderdate when '2011-07-08' then countorder end) as [2011-07-08],
 sum(case orderdate when '2011-07-09' then countorder end) as [2011-07-09],
 sum(case orderdate when '2011-07-10' then countorder end) as [2011-07-10],
 sum(case orderdate when '2011-07-11' then countorder end) as [2011-07-11],
 sum(case orderdate when '2011-07-12' then countorder end) as [2011-07-12],
 sum(case orderdate when '2011-07-13' then countorder end) as [2011-07-13],
 sum(case orderdate when '2011-07-14' then countorder end) as [2011-07-14],
 sum(case orderdate when '2011-07-15' then countorder end) as [2011-07-15],
 sum(case orderdate when '2011-07-16' then countorder end) as [2011-07-16],
 sum(case orderdate when '2011-07-17' then countorder end) as [2011-07-17],
 sum(case orderdate when '2011-07-18' then countorder end) as [2011-07-18],
 sum(case orderdate when '2011-07-19' then countorder end) as [2011-07-19],
 sum(case orderdate when '2011-07-20' then countorder end) as [2011-07-20],
 sum(case orderdate when '2011-07-21' then countorder end) as [2011-07-21],
 sum(case orderdate when '2011-07-22' then countorder end) as [2011-07-22],
 sum(case orderdate when '2011-07-23' then countorder end) as [2011-07-23],
 sum(case orderdate when '2011-07-24' then countorder end) as [2011-07-24],
 sum(case orderdate when '2011-07-25' then countorder end) as [2011-07-25],
 sum(case orderdate when '2011-07-26' then countorder end) as [2011-07-26],
 sum(case orderdate when '2011-07-27' then countorder end) as [2011-07-27],
 sum(case orderdate when '2011-07-28' then countorder end) as [2011-07-28],
 sum(case orderdate when '2011-07-29' then countorder end) as [2011-07-29],
 sum(case orderdate when '2011-07-30' then countorder end) as [2011-07-30],
 sum(case orderdate when '2011-07-31' then countorder end) as [2011-07-31]
 from cte
 group by ProductID 
 order by ProductID asc;

 --------------Задача 4

with cte as (
select *
  from (select t2.ProductID, 
         convert(date,t1.OrderDate) as orderdate,
	     Count (distinct t1.SalesOrderID) as countorder
          from [Sales].[SalesOrderHeader] as t1
	      join [Sales].[SalesOrderDetail] as t2 on t2.SalesOrderID = t1.SalesOrderID
   where t1.OrderDate between '20110701' and '20110731 23:59:59'
   group by t2.ProductID,orderdate ) as q
  pivot(sum(countorder) for orderdate in  ([2011-07-01],[2011-07-02],[2011-07-03],[2011-07-04],[2011-07-05],
                                                [2011-07-06],[2011-07-07],[2011-07-08],[2011-07-09],[2011-07-10],
												[2011-07-11],[2011-07-12],[2011-07-13],[2011-07-14],[2011-07-15],
												[2011-07-16],[2011-07-17],[2011-07-18],[2011-07-19],[2011-07-20],
												[2011-07-21],[2011-07-22],[2011-07-23],[2011-07-24],[2011-07-25],
												[2011-07-26],[2011-07-27],[2011-07-28],[2011-07-29],[2011-07-30],
												[2011-07-31])) as t3 )
										 
select * 
  from (
       select  c.ProductID,
               d.orderdate,
    case       d.orderdate  when '2011-07-01' then [2011-07-01] 
                         when '2011-07-02' then [2011-07-02] 
                         when '2011-07-03' then [2011-07-03] 
                         when '2011-07-04' then [2011-07-04] 
                         when '2011-07-05' then [2011-07-05] 
                         when '2011-07-06' then [2011-07-06] 
						 when '2011-07-07' then [2011-07-07] 
						 when '2011-07-08' then [2011-07-08] 
						 when '2011-07-09' then [2011-07-09] 
						 when '2011-07-10' then [2011-07-10] 
					     when '2011-07-11' then [2011-07-11] 
						 when '2011-07-12' then [2011-07-12] 
			             when '2011-07-13' then [2011-07-13] 
						 when '2011-07-14' then [2011-07-14] 
						 when '2011-07-15' then [2011-07-15] 
						 when '2011-07-16' then [2011-07-16] 
						 when '2011-07-17' then [2011-07-17] 
						 when '2011-07-18' then [2011-07-18] 
						 when '2011-07-19' then [2011-07-19] 
						 when '2011-07-20' then [2011-07-20]
						 when '2011-07-21' then [2011-07-21] 
						 when '2011-07-22' then [2011-07-22] 
						 when '2011-07-23' then [2011-07-23] 
						 when '2011-07-24' then [2011-07-24] 
						 when '2011-07-25' then [2011-07-25] 
						 when '2011-07-26' then [2011-07-26] 
						 when '2011-07-27' then [2011-07-27] 
						 when '2011-07-28' then [2011-07-28] 
						 when '2011-07-29' then [2011-07-29] 
						 when '2011-07-30' then [2011-07-30] 
                         when '2011-07-31' then [2011-07-31] end as [countorder]
  from cte c
  cross join (values ('2011-07-01'), ('2011-07-02'), ('2011-07-03'), ('2011-07-04'), ('2011-07-05'),
                     ('2011-07-06'), ('2011-07-07'), ('2011-07-08'), ('2011-07-09'), ('2011-07-10'),
                     ('2011-07-11'), ('2011-07-12'), ('2011-07-13'), ('2011-07-14'), ('2011-07-15'),
                     ('2011-07-16'), ('2011-07-17'), ('2011-07-18'), ('2011-07-19'), ('2011-07-20'),
                     ('2011-07-21'), ('2011-07-22'), ('2011-07-23'), ('2011-07-24'), ('2011-07-25'),
                     ('2011-07-26'), ('2011-07-27'), ('2011-07-28'), ('2011-07-29'), ('2011-07-30'),('2011-07-31')) as d (orderdate)
  ) q 
  where q.countorder is not null;
	
