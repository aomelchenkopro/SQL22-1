/*
Задача 1
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
- Задействуйте встроенные средства - cross join
*/

-- Задача 1
with products as
(
select convert(date, s.OrderDate) OrderDate,
       d.ProductID,
	   count(distinct d.SalesOrderID) OrderQty
  from [Sales].[SalesOrderHeader] s
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = s.SalesOrderID
 where s.OrderDate between '20110701' and '20110731'
 group by convert(date, s.OrderDate),
          d.ProductID
)  

select p.* 
  from products r
  pivot (sum(r.OrderQty) for r.OrderDate in ([2011-07-01], [2011-07-02], [2011-07-03],
[2011-07-04], [2011-07-05], [2011-07-06], [2011-07-07], [2011-07-08], [2011-07-09],
[2011-07-10], [2011-07-11], [2011-07-12], [2011-07-13], [2011-07-14], [2011-07-15],
[2011-07-17], [2011-07-18], [2011-07-19], [2011-07-20], [2011-07-21], [2011-07-22],
[2011-07-23], [2011-07-24], [2011-07-25], [2011-07-26], [2011-07-27], [2011-07-28],
[2011-07-29], [2011-07-30], [2011-07-31])) p;

---------------------------------------------------------------------------------------------------
-- Задача 2
with products as
(
select convert(date, s.OrderDate) OrderDate,
       d.ProductID,
	   count(distinct d.SalesOrderID) OrderQty
  from [Sales].[SalesOrderHeader] s
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = s.SalesOrderID
 where s.OrderDate between '20110701' and '20110731'
 group by convert(date, s.OrderDate),
          d.ProductID
),
set_for_unpivot as 
(
select p.* 
  from products r
  pivot (sum(r.OrderQty) for r.OrderDate in ([2011-07-01], [2011-07-02], [2011-07-03],
[2011-07-04], [2011-07-05], [2011-07-06], [2011-07-07], [2011-07-08], [2011-07-09],
[2011-07-10], [2011-07-11], [2011-07-12], [2011-07-13], [2011-07-14], [2011-07-15],
[2011-07-17], [2011-07-18], [2011-07-19], [2011-07-20], [2011-07-21], [2011-07-22],
[2011-07-23], [2011-07-24], [2011-07-25], [2011-07-26], [2011-07-27], [2011-07-28],
[2011-07-29], [2011-07-30], [2011-07-31])) p
)
select up.* 
  from set_for_unpivot
  unpivot(OrderQty for OrderDate in ([2011-07-01], [2011-07-02], [2011-07-03],
[2011-07-04], [2011-07-05], [2011-07-06], [2011-07-07], [2011-07-08], [2011-07-09],
[2011-07-10], [2011-07-11], [2011-07-12], [2011-07-13], [2011-07-14], [2011-07-15],
[2011-07-17], [2011-07-18], [2011-07-19], [2011-07-20], [2011-07-21], [2011-07-22],
[2011-07-23], [2011-07-24], [2011-07-25], [2011-07-26], [2011-07-27], [2011-07-28],
[2011-07-29], [2011-07-30], [2011-07-31])) up;
---------------------------------------------------------------------------------------------------
-- Задача 3
with products as
(
select convert(date, s.OrderDate) OrderDate,
       d.ProductID,
	   count(distinct d.SalesOrderID) OrderQty
  from [Sales].[SalesOrderHeader] s
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = s.SalesOrderID
 where s.OrderDate between '20110701' and '20110731'
 group by convert(date, s.OrderDate),
          d.ProductID
)  
select p.ProductID,
       sum(case p.OrderDate when '2011-07-01' then p.OrderQty end) [2011-07-01],
	   sum(case p.OrderDate when '2011-07-02' then p.OrderQty end) [2011-07-02],
	   sum(case p.OrderDate when '2011-07-03' then p.OrderQty end) [2011-07-03],
	   sum(case p.OrderDate when '2011-07-04' then p.OrderQty end) [2011-07-04],
	   sum(case p.OrderDate when '2011-07-05' then p.OrderQty end) [2011-07-05],
	   sum(case p.OrderDate when '2011-07-06' then p.OrderQty end) [2011-07-06],
	   sum(case p.OrderDate when '2011-07-07' then p.OrderQty end) [2011-07-07],
	   sum(case p.OrderDate when '2011-07-08' then p.OrderQty end) [2011-07-08],
	   sum(case p.OrderDate when '2011-07-09' then p.OrderQty end) [2011-07-09],
	   sum(case p.OrderDate when '2011-07-10' then p.OrderQty end) [2011-07-10],
	   sum(case p.OrderDate when '2011-07-11' then p.OrderQty end) [2011-07-11],
	   sum(case p.OrderDate when '2011-07-12' then p.OrderQty end) [2011-07-12],
	   sum(case p.OrderDate when '2011-07-13' then p.OrderQty end) [2011-07-13],
	   sum(case p.OrderDate when '2011-07-14' then p.OrderQty end) [2011-07-14],
	   sum(case p.OrderDate when '2011-07-15' then p.OrderQty end) [2011-07-15],
	   sum(case p.OrderDate when '2011-07-17' then p.OrderQty end) [2011-07-17],
	   sum(case p.OrderDate when '2011-07-18' then p.OrderQty end) [2011-07-18],
	   sum(case p.OrderDate when '2011-07-19' then p.OrderQty end) [2011-07-19],
	   sum(case p.OrderDate when '2011-07-20' then p.OrderQty end) [2011-07-20],
	   sum(case p.OrderDate when '2011-07-21' then p.OrderQty end) [2011-07-21],
	   sum(case p.OrderDate when '2011-07-22' then p.OrderQty end) [2011-07-22],
	   sum(case p.OrderDate when '2011-07-23' then p.OrderQty end) [2011-07-23],
	   sum(case p.OrderDate when '2011-07-24' then p.OrderQty end) [2011-07-24],
	   sum(case p.OrderDate when '2011-07-25' then p.OrderQty end) [2011-07-25],
	   sum(case p.OrderDate when '2011-07-26' then p.OrderQty end) [2011-07-26],
	   sum(case p.OrderDate when '2011-07-27' then p.OrderQty end) [2011-07-27],
	   sum(case p.OrderDate when '2011-07-28' then p.OrderQty end) [2011-07-28],
	   sum(case p.OrderDate when '2011-07-29' then p.OrderQty end) [2011-07-29],
	   sum(case p.OrderDate when '2011-07-30' then p.OrderQty end) [2011-07-30],
	   sum(case p.OrderDate when '2011-07-31' then p.OrderQty end) [2011-07-31]
  from products p
 group by p.ProductID;
---------------------------------------------------------------------------------------------------
-- Задача 4
with products as
(
select convert(date, s.OrderDate) OrderDate,
       d.ProductID,
	   count(distinct d.SalesOrderID) OrderQty
  from [Sales].[SalesOrderHeader] s
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = s.SalesOrderID
 where s.OrderDate between '20110701' and '20110731'
 group by convert(date, s.OrderDate),
          d.ProductID
),
set_for_unpivot as
(
select p.ProductID,
       sum(case p.OrderDate when '2011-07-01' then p.OrderQty end) [2011-07-01],
	   sum(case p.OrderDate when '2011-07-02' then p.OrderQty end) [2011-07-02],
	   sum(case p.OrderDate when '2011-07-03' then p.OrderQty end) [2011-07-03],
	   sum(case p.OrderDate when '2011-07-04' then p.OrderQty end) [2011-07-04],
	   sum(case p.OrderDate when '2011-07-05' then p.OrderQty end) [2011-07-05],
	   sum(case p.OrderDate when '2011-07-06' then p.OrderQty end) [2011-07-06],
	   sum(case p.OrderDate when '2011-07-07' then p.OrderQty end) [2011-07-07],
	   sum(case p.OrderDate when '2011-07-08' then p.OrderQty end) [2011-07-08],
	   sum(case p.OrderDate when '2011-07-09' then p.OrderQty end) [2011-07-09],
	   sum(case p.OrderDate when '2011-07-10' then p.OrderQty end) [2011-07-10],
	   sum(case p.OrderDate when '2011-07-11' then p.OrderQty end) [2011-07-11],
	   sum(case p.OrderDate when '2011-07-12' then p.OrderQty end) [2011-07-12],
	   sum(case p.OrderDate when '2011-07-13' then p.OrderQty end) [2011-07-13],
	   sum(case p.OrderDate when '2011-07-14' then p.OrderQty end) [2011-07-14],
	   sum(case p.OrderDate when '2011-07-15' then p.OrderQty end) [2011-07-15],
	   sum(case p.OrderDate when '2011-07-17' then p.OrderQty end) [2011-07-17],
	   sum(case p.OrderDate when '2011-07-18' then p.OrderQty end) [2011-07-18],
	   sum(case p.OrderDate when '2011-07-19' then p.OrderQty end) [2011-07-19],
	   sum(case p.OrderDate when '2011-07-20' then p.OrderQty end) [2011-07-20],
	   sum(case p.OrderDate when '2011-07-21' then p.OrderQty end) [2011-07-21],
	   sum(case p.OrderDate when '2011-07-22' then p.OrderQty end) [2011-07-22],
	   sum(case p.OrderDate when '2011-07-23' then p.OrderQty end) [2011-07-23],
	   sum(case p.OrderDate when '2011-07-24' then p.OrderQty end) [2011-07-24],
	   sum(case p.OrderDate when '2011-07-25' then p.OrderQty end) [2011-07-25],
	   sum(case p.OrderDate when '2011-07-26' then p.OrderQty end) [2011-07-26],
	   sum(case p.OrderDate when '2011-07-27' then p.OrderQty end) [2011-07-27],
	   sum(case p.OrderDate when '2011-07-28' then p.OrderQty end) [2011-07-28],
	   sum(case p.OrderDate when '2011-07-29' then p.OrderQty end) [2011-07-29],
	   sum(case p.OrderDate when '2011-07-30' then p.OrderQty end) [2011-07-30],
	   sum(case p.OrderDate when '2011-07-31' then p.OrderQty end) [2011-07-31]
  from products p
 group by p.ProductID
)
select * 
  from (
select up.ProductID,
       d.dates,
	   case when d.dates = '2011-07-01' then up.[2011-07-01]
	        when d.dates = '2011-07-02' then up.[2011-07-02] 
	        when d.dates = '2011-07-03' then up.[2011-07-03] 
	        when d.dates = '2011-07-04' then up.[2011-07-04] 
	        when d.dates = '2011-07-05' then up.[2011-07-05] 
	        when d.dates = '2011-07-06' then up.[2011-07-06] 
	        when d.dates = '2011-07-07' then up.[2011-07-07] 
	        when d.dates = '2011-07-08' then up.[2011-07-08] 
	        when d.dates = '2011-07-09' then up.[2011-07-09] 
	        when d.dates = '2011-07-10' then up.[2011-07-10] 
	        when d.dates = '2011-07-11' then up.[2011-07-11] 
	        when d.dates = '2011-07-12' then up.[2011-07-12] 
	        when d.dates = '2011-07-13' then up.[2011-07-13] 
	        when d.dates = '2011-07-14' then up.[2011-07-14] 
	        when d.dates = '2011-07-15' then up.[2011-07-15] 
	        when d.dates = '2011-07-17' then up.[2011-07-17] 
	        when d.dates = '2011-07-18' then up.[2011-07-18] 
	        when d.dates = '2011-07-19' then up.[2011-07-19] 
	        when d.dates = '2011-07-20' then up.[2011-07-20] 
	        when d.dates = '2011-07-21' then up.[2011-07-21] 
	        when d.dates = '2011-07-22' then up.[2011-07-22] 
	        when d.dates = '2011-07-23' then up.[2011-07-23] 
	        when d.dates = '2011-07-24' then up.[2011-07-24] 
	        when d.dates = '2011-07-25' then up.[2011-07-25] 
	        when d.dates = '2011-07-26' then up.[2011-07-26] 
	        when d.dates = '2011-07-27' then up.[2011-07-27] 
	        when d.dates = '2011-07-28' then up.[2011-07-28] 
	        when d.dates = '2011-07-29' then up.[2011-07-29] 
	        when d.dates = '2011-07-30' then up.[2011-07-30] 
	        when d.dates = '2011-07-31' then up.[2011-07-31] end OrderDate
  from set_for_unpivot up
  cross join (values('2011-07-01'), ('2011-07-02'), ('2011-07-03'),
  ('2011-07-04'), ('2011-07-05'), ('2011-07-06'), ('2011-07-07'), ('2011-07-08'),
  ('2011-07-09'), ('2011-07-10'), ('2011-07-11'), ('2011-07-12'), ('2011-07-13'),
  ('2011-07-14'), ('2011-07-15'), ('2011-07-17'), ('2011-07-18'), ('2011-07-19'),
  ('2011-07-20'), ('2011-07-21'), ('2011-07-22'), ('2011-07-23'), ('2011-07-24'),
  ('2011-07-25'), ('2011-07-26'), ('2011-07-27'), ('2011-07-28'), ('2011-07-29'),
  ('2011-07-30'), ('2011-07-31')) d (dates)
 ) q
 where q.OrderDate is not null;