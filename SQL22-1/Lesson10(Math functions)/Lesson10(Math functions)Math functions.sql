/*
if OBJECT_ID('[tempdb].[dbo].#local') is not null drop table #local;
create table [tempdb].[dbo].#local(
       id int,
	   rep_date date
);

insert into [tempdb].[dbo].#local(id, rep_date)
values(1, '20200101'),
      (1, '20200201'),
	  (2, '20200201')
;

insert into [tempdb].[dbo].#local(id, rep_date)
values
	  (2, '20200401')
;

select *
  from(
		select l.id, datediff(day, l.rep_date, lead(rep_date)over(partition by l.id order by rep_date)) as diff
		  from #local as l 

	  ) q
where diff is not null

-- lead, last_value, first_value, lag 
 */
--================================================================================================================================

-- Math functions
--================================================================================================================================
/*
ABS  ( numeric_expression ) вычисляет абсолютное значение числа.
ACOS ( float_expression   ) вычисляет арккосинус.
ASIN ( float_expression   ) вычисляет арксинус.
ATAN ( float_expression   ) вычисляет арктангенс.

ATN2 ( float_expression , float_expression ) 
вычисляет арктангенс с учетом квадратов.

CEILING ( numeric_expression )   выполняет округление вверх.
COS     ( float_expression   )   вычисляет косинус угла.
COT     ( float_expression   )   возвращает котангенс угла.
DEGREES ( numeric_expression )   преобразует значение угла из радиан в градусы.
EXP     ( float_expression   )   возвращает экспоненту.
FLOOR   ( numeric_expression )   выполняет округление вниз.
LOG     ( float_expression   )   вычисляет натуральный логарифм.
LOG10   ( float_expression   )   вычисляет десятичный логарифм.
PI      ()                       возвращает значение "пи".
POWER   ( float_expression , y ) возводит число в степень.
RADIANS ( numeric_expression   ) преобразует значение угла из градуса в радианы.
RAND    ( [ seed ] )             возвращает случайное число

ROUND   ( numeric_expression , length [ ,function ] ) 
выполняет округление с заданной точностью.

SIGN   ( numeric_expression ) определяет знак числа.
SIN    ( float_expression   ) вычисляет синус угла.
SQUARE ( float_expression   ) выполняет возведение числа в квадрат.
SQRT   ( float_expression   ) извлекает квадратный корень.
TAN    ( float_expression   ) возвращает тангенс угла.
*/
--================================================================================================================================
-- ABS  ( numeric_expression ) вычисляет абсолютное значение числа.
select -1445.00, ABS(-1445.00), 18453.00, ABS(18453.00);

-- CEILING ( numeric_expression )   выполняет округление вверх.
select 453.66, ceiling(453.001);

-- FLOOR   ( numeric_expression )   выполняет округление вниз.
select 453.66, floor(453.95);

-- ROUND   ( numeric_expression , length [ ,function ] ) 
select 453.66, round(453.66, 1);

-- POWER   ( float_expression , y ) возводит число в степень.
select POWER(2, 3);

-- RAND    ( [ seed ] )             возвращает случайное число
select rand(100), rand(), rand();   

-- SQUARE ( float_expression   ) выполняет возведение числа в квадрат.
select square(3), power(3,2);

-- SIGN   ( numeric_expression ) определяет знак числа
select sign(-223), sign(223), sign(0);

-- PI      ()                       возвращает значение "пи".
select PI();
--================================================================================================================================
/*
+ (Add)	Addition
- (Subtract)	Subtraction
* (Multiply)	Multiplication
/ (Divide)	Division
% (Modulo)	Returns the integer remainder of a division. For example, 12 % 5 = 2 because the remainder of 12 divided by 5 is 2.
*/

select s.SalesOrderID,
       s.SubTotal,
	   s.TaxAmt,
	   s.Freight,
	   (s.SubTotal + s.TaxAmt + s.Freight) as total,
	   s.TaxAmt - 0.10 * 2,
	   (s.TaxAmt - 0.10) * 2
  from [Sales].[SalesOrderHeader] s;

select s.SalesOrderID,
       s.SalesOrderID % 2
  from [Sales].[SalesOrderHeader] s
 where s.SalesOrderID % 2 != 0;
 --================================================================================================================================
select e.BusinessEntityID,
       e.MaritalStatus,
	   -- позиционный case
	   "status_descr" = case e.MaritalStatus when N'M' then N'Married' 
	                                         when N'S' then N'Single' else N'N/A' end,
	    e.[Gender],
	   "gender_descr" = case e.[Gender] when N'M' then N'Male' 
	                                    when N'F' then N'Female' else N'N/A' end,
--------------------------------------------------------------------------------------------
	    -- поисковый case
		"status_descr" = case when e.MaritalStatus = N'M' then N'Married' 
	                          when e.MaritalStatus = N'S' then N'Single' 
							  else N'N/A' end,
	    e.[Gender],
	    "gender_descr" = case when e.[Gender] = N'M' then N'Male' 
	                          when e.[Gender] = N'F' then N'Female' 
							  else N'N/A' end
  from [HumanResources].[Employee] e;
--================================================================================================================================
select * from [HumanResources].[Employee];
select * from [Person].[Person];

-- ANSI-92
select p.BusinessEntityID,
       upper(concat_ws(p.LastName, p.FirstName, p.MiddleName)) as FullName
  from [humanresources].[employee] as e
  /*inner*/ join [person].[person] as p on p.businessentityid = e.businessentityid
 where e.JobTitle = N'Tool Designer'
 order by p.BusinessEntityID desc;

-- ANSI-89
select p.BusinessEntityID,
       upper(concat_ws(p.LastName, p.FirstName, p.MiddleName)) as FullName
  from [humanresources].[employee] as e,
  [person].[person] as p 
 where p.businessentityid = e.businessentityid
   and e.JobTitle = N'Tool Designer'
 order by p.BusinessEntityID desc;
--================================================================================================================================
--ANSI-89 Перекрестное соединение (cross join) - первая фаза табличного оператора join
select *
  from [HumanResources].[Employee] e,
  [Person].[Person]
where e.JobTitle = N'Tool Designer';

--ANSI-92 Перекрестное соединение (cross join) - первая фаза табличного оператора join
select *
  from [HumanResources].[Employee] e
  cross join [Person].[Person]
where e.JobTitle = N'Tool Designer';

--ANSI-89 Внутреннее соединение (inner join)  - вторая фаза табличного оператора join
select *
  from [HumanResources].[Employee] e,
  [Person].[Person] p
where e.BusinessEntityID = p.BusinessEntityID
  and e.JobTitle = N'Tool Designer';

--ANSI-92 Внутреннее соединение (inner join)  - вторая фаза табличного оператора join
select p.BusinessEntityID,
       "fullname" = upper(concat_ws(p.LastName, p.FirstName, p.MiddleName)),
	   "age" = datediff(year, e.BirthDate, sysdatetime()) 
		- case when 100 * month(sysdatetime()) + day(sysdatetime()) < 100 * month(e.BirthDate) + day(e.BirthDate) then 1 else 0 end
  from [HumanResources].[Employee] e
  /*inner*/ join [Person].[Person] p on e.BusinessEntityID = p.BusinessEntityID
  where e.JobTitle = N'Tool Designer'
  order by "age" asc;

--ANSI-92 Внешние соединения (left outer join, right outer join, full outer join)
select *
  from [HumanResources].[Employee] e 
  left /*outer*/ join [Person].[Person] p on e.BusinessEntityID = p.BusinessEntityID
 where e.JobTitle = N'Tool Designer'
  -- and p.BusinessEntityID is null
;

select *
  from [Person].[Person] p 
  right /*outer*/ join [HumanResources].[Employee] e on e.BusinessEntityID = p.BusinessEntityID
 where e.JobTitle = N'Tool Designer'
;
-- https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Person_Person_144.html
--================================================================================================================================
select * from [HumanResources].[Employee];
select * from [Sales].[SalesOrderHeader];
select * from [Sales].[SalesPerson];

select e.JobTitle,
       COUNT(distinct h.SalesOrderID) as orderQty
  from [Sales].[SalesOrderHeader] h 
  inner join [Sales].[SalesPerson] sp on sp.BusinessEntityID  = h.SalesPersonID
  inner join [HumanResources].[Employee] e on e.BusinessEntityID = sp.BusinessEntityID
 group by e.JobTitle
 order by orderQty desc

select e.JobTitle,
       COUNT(distinct h.SalesOrderID) as orderQty
  from [HumanResources].[Employee] e
  inner join [Sales].[SalesPerson] sp on sp.BusinessEntityID = e.BusinessEntityID
  inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = sp.BusinessEntityID
  group by e.JobTitle
  order by orderQty desc;

select e.JobTitle,
       COUNT(distinct h.SalesOrderID) as orderQty
  from [HumanResources].[Employee] e
  left outer join [Sales].[SalesPerson] sp on sp.BusinessEntityID = e.BusinessEntityID
  left outer join [Sales].[SalesOrderHeader] h on h.SalesPersonID = sp.BusinessEntityID
  group by e.JobTitle
  order by orderQty desc;
--================================================================================================================================
-- Запрос возвращающий список заказов, которые были проведены сотрудниками на должности Pacific Sales Manager
select t2.*
  from [HumanResources].[Employee]      as t1
  inner join [Sales].[SalesOrderHeader] as t2 on t2.SalesPersonID = t1.BusinessEntityID
 where t1.JobTitle = N'Pacific Sales Manager'
;

select t2.*
  from [HumanResources].[Employee]          as t1
 left outer join [Sales].[SalesOrderHeader] as t2 on t2.SalesPersonID = t1.BusinessEntityID
 where t1.JobTitle = N'Pacific Sales Manager'
;
--================================================================================================================================
-- [HumanResources].[Employee] 
-- [Person].[EmailAddress]

/*
Напишите запрос, который вернет список emails для сотр. на должности North American Sales Manager.
- Используется таблицы:[HumanResources].[Employee], [Person].[EmailAddress] 
*/

-- Ян
select e.EmailAddress
  from [HumanResources].[Employee] as h
 inner join [Person].[EmailAddress]as e on h.BusinessEntityID = e.BusinessEntityID 
 where h.JobTitle = N'North American Sales Manager'
;