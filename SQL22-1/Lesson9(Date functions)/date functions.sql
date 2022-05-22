-- Языковое окружение
select * from sys.syslanguages;

-- Установка языкового окружения
set language English;

-- Установка последовательности компонентов даты
set dateformat mdy;

select '01-12-2022',
       "month" = month('01-12-2022'),
	   "day" = day('01-12-2022'),
	   "year" = year('01-12-2022'),
	   "datename" = datename(month, '01-12-2022'),
	   "weekday" = datename(weekday, '01-12-2022'),
---------------------ANSI/ISO-------------------------
       "ANSI_MONTH" = month('20221201'),
	   --month(convert(date, '01-12-2022', 104))

	   -- ANSI/ ISO 
	   'YYYYMMDD',
	   '20221201',
	   format(getdate(), 'yyyyMM', 'en-US')

--===================================================================================================================
-- EOMONTH 
select e.HireDate,
       eomonth(e.HireDate)

  from [HumanResources].[Employee] e;

select e.HireDate,
       "theLastDayOfAMonth" = dateadd(day, -1, concat(format(dateadd(month, 1, e.HireDate),  'yyyyMM', 'en-US'), '01'))
  from [HumanResources].[Employee] e
 where month(e.HireDate) = 2;

-- DATEADD  ( datepart , number , date )       добавляет к дате указанное значение дней, месяцев, часов и т.д.
select e.HireDate,
       dateadd(day, -1, e.HireDate),
       e.*
  from [HumanResources].[Employee] e;

-- DATEDIFF ( datepart , startdate , enddate ) возвращает разницу между указанными частями двух дат.
select 
       --datediff(day, e.HireDate, sysdatetime()),
	   "DATEDIFF" = datediff(year, e.HireDate, sysdatetime()),

	   "CASE" = case when 100 * month(sysdatetime()) + day(sysdatetime()) < 100 * month(e.BirthDate) + day(e.BirthDate) then 1 else 0 end,

	   "AGE" = datediff(year, e.BirthDate, sysdatetime()) - case when 100 * month(sysdatetime()) + day(sysdatetime()) < 100 * month(e.BirthDate) + day(e.BirthDate) then 1 else 0 end
	   
  from [HumanResources].[Employee] e;

-- DATENAME ( datepart , date )                выделяет из даты указанную часть и возвращает ее в символьном формате.
select datename(dw, e.HireDate),
       datename(month, e.HireDate),
       e.*
  from [HumanResources].[Employee] e
 where datename(dw, HireDate) = N'Monday'
  -- and datename(month, e.HireDate) = N'March';

-- DATEPART ( datepart , date )                выделяет из даты указанную часть и возвращает ее в числовом формате.
select datepart(day, e.HireDate) as [DAY],
       "month" =  datepart(month, e.HireDate),
	   datepart(year, e.HireDate) as [YEAR],
	   datepart(quarter, e.HireDate) as [quarter],
	   datepart(dayofyear, e.HireDate) as [dayofyear]
  from [HumanResources].[Employee] e;
  
-- DAY      ( date )                           возвращает число из указанной даты.
select e.HireDate,
       "day" = day(e.hiredate),
	   e.*
  from [HumanResources].[Employee] e
 where year(e.hiredate) = 2009
   and month(e.hiredate) = 1
   and day(e.hiredate) between 10 and 20;

-- GETDATE  ()                                 возвращает текущее системное время.
select getdate();

-- SYSDATETIME  -- дата и время на сервере
select SYSDATETIME();

select CURRENT_TIMESTAMP;

-- ISDATE   ( expression )                     проверяет правильность выражения на соответствие одному из возможных форматов ввода даты.
select isdate('20221212'), -- 1 - значение является датой
       isdate('20221312')  -- 0 - значение не является датой

-- MONTH    ( date )                           возвращает значение месяца из указанной даты.
select e.HireDate,
       "month" = month(e.hiredate),
	   e.*
  from [HumanResources].[Employee] e
 where year(e.hiredate) = 2009
   and month(e.hiredate) = 1;

-- YEAR     ( date )                           возвращает значение года из указанной даты.
select e.HireDate,
       "year" = year(e.hiredate),
	   e.*
  from [HumanResources].[Employee] e
 where year(e.hiredate) = 2009;

--===================================================================================================================
select case grouping(h.TerritoryID) when 1 then N'TOTAL' else convert(nvarchar(10),h.TerritoryID) end,
       "year" = case grouping(year(h.OrderDate)) when 1 then  N'TOTAL' else convert(nvarchar(10) ,year(h.OrderDate)) end,
	   "month" = case grouping(month(h.OrderDate)) when 1 then  N'TOTAL' else convert(nvarchar(10), month(h.OrderDate)) end ,
	   "total" = sum(h.SubTotal)
  from [Sales].[SalesOrderHeader] h

 where h.SubTotal between 10000 and 40000
   and h.OnlineOrderFlag = 0
   and h.CustomerID in (select c.CustomerID from [Sales].[Customer] c where c.AccountNumber like 'AW%')
 group by h.TerritoryID,
          year(h.OrderDate),
	      month(h.OrderDate) with rollup
 order by 
          grouping_id(h.TerritoryID) asc,
	      grouping_id(year(h.OrderDate)) asc,
		  grouping_id(month(h.OrderDate)) asc;
		  


		  