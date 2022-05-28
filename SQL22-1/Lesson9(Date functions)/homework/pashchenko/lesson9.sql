Задача 1
Напишите запрос, который вернет список уникальных годов из даты проведения заказов (OrderDate).
- Используется таблица [Sales].[SalesOrderHeader].
- Задействуйте функцию year
- Задействуйте оператор distinct
- Результирующи набор данных содержит: год проведения заказа (без дублирующих строк)
- Отсортировать рез. набор данных по году (по возрастанию)

select * from [Sales].[SalesOrderHeader]

select distinct
       year(a.OrderDate) as [year]
from [Sales].[SalesOrderHeader] as a
order by [year] asc
--============================================
Задача 2
Напишите запрос, который вернет период(yyyyMM) с наибольшей общей суммой заказов (SubTotal).
Учитывайте вероятность того, что сразу несколько периодов могут иметь одну и туже сумму заказов.
Учитывайте только заказы за 2011 и 2012 года.
- Используется таблица [Sales].[SalesOrderHeader]
- Задействуйте предикат принадлежности множеству: in
- Задействуйте функции для работы с датой: year
- Задействуйте строковую функцию format
- Задействуйте агрегатную функцию sum
- Результирующий набор данных содержит: период(yyyyMM) общая сумма заказов (SubTotal)

select * from [Sales].[SalesOrderHeader]

select top 1
       with ties
	   format(a.OrderDate, 'yyyyMM', 'en-US'),
	   sum(SubTotal) as [total]
from [Sales].[SalesOrderHeader] as a
where year(a.OrderDate) in ('2011', '2012')
group by format(a.OrderDate, 'yyyyMM', 'en-US')
order by sum(SubTotal) desc
--========================================
Задача 3
Напишите запрос, который вернет список заказов за декабрь 2012 года.
Необходимо рассчитать кол-во прошедших дней, часов, минут, секунд с момента проведения заказа (OrderDate).
Учитывайте только заказы, у которых код подтверждения (CreditCardApprovalCode) заканчивается на 8.
- Используется таблица [Sales].[SalesOrderHeader]
- Задействуйте предикат соответствия шаблону like
- Задействуйте функцию format (для поиска заказов за декабрь 2012 года)
- Задействуйте функции для работы с датой datediff, sysdatetime
- Задействуйте строковую функцию concat_ws
- Рез. набор данных содержит: идент. заказа, кол-во дней + 'days', кол-во часов + 'hours',
кол-во минут + 'minutes', кол-во секунд + 'seconds'.

select * from [Sales].[SalesOrderHeader]

select a.SalesOrderID,
       concat_ws(N' ', datediff(day, a.OrderDate, SYSDATETIME()), N' ') as [DAY],
	   concat_ws(N' ', datediff(hour, a.OrderDate, SYSDATETIME()), N' ') as [hours],
	   concat_ws(N' ', datediff(minute, a.OrderDate, SYSDATETIME()), N' ') as [minutes],
	   concat_ws(N' ', datediff(second, a.OrderDate, SYSDATETIME()), N' ') as [seconds]
from [Sales].[SalesOrderHeader] as a
where a.CreditCardApprovalCode like '%8'
      and  format(a.OrderDate, 'yyyyMM', 'en-US') = '201212'
	  order by a.OrderDate desc;
--==========================================
Задача 4*
Напишите запрос, который вернет кол-во уникальных заказов и среднее кол-во дней прошедших с момента проведения заказа (OrderDate)
до даты доставки клиенту (DueDate) в разрезе периода (OrderDate yyyymm) и типа оплаты (OnlineOrderFlag).
Учитывайте только заказы с кодом подтверждения (CreditCardApprovalCode),
которые начинаются с 1, и заканчиваются на 4 либо начинаются с 1, и заканчиваются на 0 либо начинаются с 1, и заканчиваются 5 
и с пустым кодом обменного курса (CurrencyRateID).
- Используется таблица: Sales.SalesOrderHeader
- Рез. набор данных содержит: период (OrderDate yyyymm ), тип оплаты (OnlineOrderFlag),
кол-во уникальных заказов, среднее кол-во дней (DueDate - OrderDate).
- Отсортируйте рез. набор данных по периоду (по убыванию).

select * from [Sales].[SalesOrderHeader]

select count(distinct a.SalesOrderID) as [count],
	   avg(datediff(day,a.OrderDate, a.DueDate)) as [days],
       format(a.OrderDate,  'yyyyMM', 'en-US') as [period],
       a.OnlineOrderFlag
  from [Sales].[SalesOrderHeader] a
 where a.OrderDate between '20110101' and '20111231 23:59:59.00'
   and ((a.CreditCardApprovalCode like '1%4' or a.CreditCardApprovalCode like '1%0') or (a.CreditCardApprovalCode like '1%5' and a.CurrencyRateID is null))
 group by format(a.OrderDate,  'yyyyMM', 'en-US'),
          a.OnlineOrderFlag
 order by [period] desc;
