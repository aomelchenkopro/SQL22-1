--==============================================homrwork_Nayda_Yan===========================

---==========Task1===========================================================================
/*Задача 1
Напишите запрос, который вернет список уникальных годов из даты проведения заказов (OrderDate).
- Используется таблица [Sales].[SalesOrderHeader].
- Задействуйте функцию year
- Задействуйте оператор distinct
- Результирующи набор данных содержит: год проведения заказа (без дублирующих строк)
- Отсортировать рез. набор данных по году (по возрастанию)*/

select distinct 
       YEAR (OrderDate) as [OrderYear] 
 from [Sales].[SalesOrderHeader]
order by OrderYear asc;


---==========Task2===========================================================================
/*Задача 2
Напишите запрос, который вернет период(yyyyMM) с наибольшей общей суммой заказов (SubTotal).
Учитывайте вероятность того, что сразу несколько периодов могут иметь одну и туже сумму заказов.
Учитывайте только заказы за 2011 и 2012 года.
- Используется таблица [Sales].[SalesOrderHeader]
- Задействуйте предикат принадлежности множеству: in
- Задействуйте функции для работы с датой: year
- Задействуйте строковую функцию format
- Задействуйте агрегатную функцию sum
- Результирующий набор данных содержит: период(yyyyMM) общая сумма заказов (SubTotal)*/


select top 1 with ties 
       format(OrderDate, 'yyyyMM') as [Period],
       sum(SubTotal) as [TotalSum]
 from [Sales].[SalesOrderHeader]
 --where OrderDate between '20110101' and '20130101'
 where YEAR(OrderDate) in (2011,2012)
 group by format(OrderDate, 'yyyyMM')
 Order by [TotalSum] desc;


--Вопрос по синтаксису второго параметра Format.... Было бы круто ещё раз пройтись




---==========Task3===========================================================================
/*Задача 3
Напишите запрос, который вернет список заказов за декабрь 2012 года.
Необходимо рассчитать кол-во прошедших дней, часов, минут, секунд с момента проведения заказа (OrderDate).
Учитывайте только заказы, у которых код подтверждения (CreditCardApprovalCode) заканчивается на 8.
- Используется таблица [Sales].[SalesOrderHeader]
- Задействуйте предикат соответствия шаблону like
- Задействуйте функцию format (для поиска заказов за декабрь 2012 года)
- Задействуйте функции для работы с датой datediff, sysdatetime
- Задействуйте строковую функцию concat_ws
- Рез. набор данных содержит: идент. заказа, кол-во дней + 'days', кол-во часов + 'hours',
кол-во минут + 'minutes', кол-во секунд + 'seconds'.*/


select SalesOrderID as [Order],
        concat_ws (' ',DATEDIFF(day,   OrderDate,sysdatetime()),'Days')    as [DAYS],
		concat_ws (' ',DATEDIFF(HOUR,  OrderDate,sysdatetime()),'Hours')   as [HOURS],
		concat_ws (' ',DATEDIFF(MINUTE,OrderDate,sysdatetime()),'Minutes') as [MINUTES],
		concat_ws (' ',DATEDIFF(SECOND,OrderDate,sysdatetime()),'Seconds') as [SECONDS]
 from [Sales].[SalesOrderHeader]
 Where CreditCardApprovalCode like '%8'
       and format(OrderDate, 'yyyyMM') = '201212';


---==========Task4===========================================================================
/*Задача 4*
Напишите запрос, который вернет кол-во уникальных заказов и среднее кол-во дней прошедших с момента проведения заказа (OrderDate)
до даты доставки клиенту (DueDate) в разрезе периода (OrderDate yyyymm) и типа оплаты (OnlineOrderFlag). 
Учитывайте только заказы с кодом подтверждения (CreditCardApprovalCode), которые начинаются с 1, 
и заканчиваются на 4 либо начинаются с 1, и заканчиваются на 0 либо начинаются с 1, 
и заканчиваются 5 и с пустым кодом обменного курса (CurrencyRateID).
- Используется таблица: Sales.SalesOrderHeader
- Рез. набор данных содержит: период (OrderDate yyyymm ), тип оплаты (OnlineOrderFlag),
кол-во уникальных заказов, среднее кол-во дней (DueDate - OrderDate).
- Отсортируйте рез. набор данных по периоду (по убыванию).*/

select format(OrderDate,'yyyyMM') as [Period],
       OnlineOrderFlag as [PayType],
	   count (distinct SalesOrderID) as [CountOrders],
	   avg(datediff(day,OrderDate,DueDate)) as [AvgDayAfterOrders]
  from Sales.SalesOrderHeader
  Where CurrencyRateID is null
        and (CreditCardApprovalCode like '1%4'
		or CreditCardApprovalCode like '1%0'
		or CreditCardApprovalCode like  '1%5')
  group by format(OrderDate,'yyyyMM'), OnlineOrderFlag
  order by [Period] desc


---==========Task5===========================================================================
/*Дополнительная задача
Определите аналоги функций dateadd, datediff, datename, datepart для СУБД Postgresql и MySQL*/

/*
dateadd  - INTERVAL
datediff - DATE_PART
datename - age с ньюансами 
datepart - EXTRACT