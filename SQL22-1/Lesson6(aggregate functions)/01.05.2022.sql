/*
Напишите запрос, который вернет кол-во продуктов в разрезе цвета продукта.
Учитывайте только продукты с указанным цветом ([Color] is not null). 
В результате выведите только цвета с количеством продуктов больше 1.
- Используется таблица [Production].[Product]
	Атрибут - [Color] - цвет продукта
	Атрибут - ProductID - идент. продукта
	Детальное описание таблицы - https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Production_Product_153.html
- Отсортировать рез. набор данных пол количеству продуктов (по убыванию)		
*/

--===============================================================================================================================================================
-- Расчет кол-ва продуктов в разрезе цвета
select t1.Color,                                  -- цвет продукта
       count(distinct t1.ProductID) as [prod_qty] -- идент. продукта/ кол-во продуктов
  from [Production].[Product] as t1
       -- Учитывайте только продукты с указанным цветом
 where t1.Color is not null 
 group by t1.Color
       -- Только цвета с количеством продуктов больше 1.
having count(t1.ProductID) > 1
      -- Отсортировать рез. набор данных пол количеству продуктов (по убыванию)
order by [prod_qty] desc
;
--====================================================ДЗ 5 урок Найда Я.С.=========================================
USE SQL221

select 
p.color ,count(distinct p.productid) as [Colorqty] 
	from [Production].[Product] as p
	where p.color is not null
	group by p.color
	having count(distinct p.productid) > 1
	order by [Colorqty]  desc
GO
--===============================================================================================================================================================
-- Стас
select a.color,
       count(*) as [QTY] 
  from Production.Product as a
 where a.color is not null
 group by a.color
having count(*) > 1
 order by [QTY] desc
;
--===============================================================================================================================================================
-- Дмитрий
select p.Color,
       count(p.ProductID) as [Prod_QTY]
  from [Production].[Product] as p
 where p.Color is not null
 group by p.Color
having count(*) > 1
 order by [Prod_QTY] desc
;
--===============================================================================================================================================================
-- Агрегатные функции

-- COUNT - Счет значений

-- COUNT(*) - кол-во строк в группе
-- COUNT(<attribute>)

-- INT
select Color,
       COUNT(*) as [row_qty],                                       -- кол-во строк
	   COUNT([ProductID]) as [not_null_attribute_values_qty],       -- кол-во значений атрибута без учета null(пустых значений)
	   COUNT(distinct [ProductID]) as [unique_attribute_values_qty] -- кол-во уникальных значений атрибута без учета null(пустых значений)
  from [Production].[Product]
 group by Color;

-- INT
select COUNT(*),
       COUNT(Color),
	   COUNT(distinct color)
  from [Production].[Product];


-- BIGINT
select COUNT_BIG(*),
       COUNT_BIG(Color),
	   COUNT_BIG(distinct color),
	   APPROX_COUNT_DISTINCT(Color)
  from [Production].[Product];
--===============================================================================================================================================================
-- SUM - суммирование значений
select color,
       SUM([StandardCost]) as [values_sum],
       SUM(distinct [StandardCost]) as [unique_values_sum]
  from [Production].[Product]
 group by color;
--===============================================================================================================================================================
-- AVG - среднее значение
select p.Color,
       AVG(p.StandardCost),
	   AVG(distinct p.StandardCost)
  from [Production].[Product] p
 group by p.Color;
--===============================================================================================================================================================
-- MIN
select MIN(p.StandardCost),
       MIN(distinct p.StandardCost)
  from [Production].[Product] p
 where p.StandardCost > 0.00;
--===============================================================================================================================================================
-- MAX
select  p.Color,
       MAX(p.StandardCost),
       MAX(distinct p.StandardCost)
  from [Production].[Product] p
 where p.StandardCost > 0.00
 group by  p.Color;


--===============================================================================================================================================================
 SELECT STRING_AGG (CONVERT(NVARCHAR(max),FirstName), CHAR(13)) AS csv 
   FROM Person.Person;
--===============================================================================================================================================================
/*
Напишите запрос, который в разрезе наименования должности
вернет кол-во работников мужского пола.
- Используется таблица [HumanResources].[Employee]
*/
select *
  from [HumanResources].[Employee] e

-- Ян
select e.JobTitle,
       Count (e.JobTitle) 
from [HumanResources].[Employee] as E
 where gender = 'M'
 group by JobTitle

-- Дмитрий
select  e.Jobtitle,
       count (*)
  from [HumanResources].[Employee] as e
  where e.Gender = 'M'
  group by e.Jobtitle

-- Стас
select a.JobTitle,
       count (a.JobTitle) 
from [HumanResources].[Employee] as a
 where gender = 'm'
 group by a.JobTitle
 ;

-- Юля
select e.[JobTitle],                                  
       count(e.[JobTitle]) 
from [HumanResources].[Employee] as e
  where Gender = 'M'
  group by JobTitle

select e.JobTitle,
       count(distinct [BusinessEntityID]) as [emp_qty]
  from [HumanResources].[Employee] e
 where e.Gender = N'M'
 group by e.JobTitle
 order by [emp_qty] desc;
--===============================================================================================================================================================
/*
Напишите запрос, который для продуктов с не указанным цветом вернет общую стоимость ([StandardCost]).
- Используется таблица [Production].[Product]
*/
select *
  from [Production].[Product];

-- Ян
select sum (StandardCost) as summoney 
  from [Production].[Product]
 where color is null;


select sum(StandardCost) as [total]
  from [Production].[Product] as p
 where p.Color is null;

-- Юля
select sum ([StandardCost]) 
  from [Production].[Product]as p
 where p.Color is NULL;

-- Дмитий 
select sum(StandardCost)
  from [Production].[Product] as p
 where p.Color is null;
--===============================================================================================================================================================
/*
Напишите запрос, который вернет даты рождения самого младшего и самого старшего сотрудников.
Учитывайте только работников на должности Production Supervisor - WC60
- Используется таблица [HumanResources].[Employee]
*/
select *
  from [HumanResources].[Employee];

-- Юля
select MIN(e.BirthDate)     
  from [HumanResources].[Employee] as e
 where e.JobTitle ='Production Supervisor - WC60';

select MAX (e.BirthDate)     
  from [HumanResources].[Employee] as e
 where e.JobTitle ='Production Supervisor - WC60';

 select MAX (e.BirthDate),
        MIN(e.BirthDate)
  from [HumanResources].[Employee] as e
 where e.JobTitle ='Production Supervisor - WC60'

-- Ян
 select 
   min(e.BirthDate) as [Самы младший],
   max(e.birthDate) as [Самый старший]
   from [HumanResources].[Employee] e
   where e.JobTitle = 'Production Supervisor - WC60'
--===============================================================================================================================================================
-- Фильтр TOP

select top 200 
       e.*
  from [HumanResources].[Employee] e
 order by e.BusinessEntityID desc
  ;

select top 20 percent 
       e.*
  from [HumanResources].[Employee] e
 order by e.BusinessEntityID desc
  ;


select top 1
       e.BusinessEntityID
  from [HumanResources].[Employee] e
 order by e.BirthDate desc;

select top 1
       e.BusinessEntityID
  from [HumanResources].[Employee] e
 order by e.BirthDate asc;


select top 1
       with ties
       e.JobTitle,
       COUNT(distinct e.BusinessEntityID) as [empQty]
  from [HumanResources].[Employee] e
 group by e.JobTitle
 order by [empQty] desc;


-- OFFSET
select e.*
  from [HumanResources].[Employee] e
 where e.BusinessEntityID between 220 and 270
 order by e.BusinessEntityID desc
 offset 10 rows fetch next 20 rows only;


--===============================================================================================================================================================
/*
Напишите запрос, который вернет цвет с наибольшим количеством продуктов.
-- Используется таблица [Production].[Product]
-- Задействуйте фильтр top в комбинации с оператором with ties
-- Задействуйте агрегутную функцию count(distinct)
*/

-- Юля 
select top 1
       with ties
       p.Color,
       COUNT(distinct p.ProductID) as [empQty]
  from [Production].[Product] as p
 group by p.Color
 order by [empQty] desc;

-- Ян
select top 1 
       with ties
       p.color, 
       count(distinct p.productid) 
  from [Production].[Product] p 
 where p.color is not null
 group by p.color 
 order by count (distinct productid) desc

-- Стас
select top 1
    with ties
    e.Color,
    Count (distinct e.ProductID) as empQTY
  from [Production].[Product] as e
  group by e.Color
  order by empQTY desc
--===============================================================================================================================================================
/*
Напишите запрос, который вернет дату найма с наибольшим количеством работников.
- Используется таблица [HumanResources].[Employee]
- Задействуйте фильтр top в комбинации с оператором with ties
- Задействуйте агрегутную функцию count(distinct)
*/
select *
  from [HumanResources].[Employee]


-- Дмитрий 
select top 1 
       with ties
       h.HireDate,
       count (distinct h.BusinessEntityID) as empQTY
  from [HumanResources].[Employee] as h
 group by h.HireDate
 order by empQTY desc;

-- Юля
select top 1
       with ties
       e.HireDate,
       count(distinct e.BusinessEntityID) as [empQty]
  from [HumanResources].[Employee] e
 group by e.HireDate
 order by [empQty] desc;

-- Ян
select top 1 
       with ties
       e.HireDate as "Дата",
       count (distinct e.BusinessEntityID) as "Количество людей" 
  from [HumanResources].[Employee] e 
 group by e.HireDate 
 order by count (distinct e.BusinessEntityID) desc;
--===============================================================================================================================================================
/*
Задача №1
Напишите запрос, который вернет наименования должности с наименьшим количеством работников.
Учитывайте вероятность того, что сразу несколько должностей могут иметь одно и тоже количество работников.

Задача №2
Для работников из задачи №1, расчитайте кол-во мужчин и женщин.

Задача №3
Напишите запрос, который вернет список работников из задачи №1 но только мужчин, в случае если их больше и на оборот.

- Используется таблица [HumanResources].[Employee]

*/

-- Запрос 1
select top 1
       with ties
       e.JobTitle,
       count(distinct e.BusinessEntityID) as [empQty]
  from [HumanResources].[Employee] e
 group by e.JobTitle
 order by [empQty] desc;

-- Запрос 2
select e.Gender,
       count(distinct e.BusinessEntityID) as [empQty]
  from [HumanResources].[Employee] e
 where e.JobTitle in (N'Production Technician - WC50', N'Production Technician - WC60', N'Production Technician - WC40')
 group by e.Gender;

-- Запрос 3
select e.*
  from [HumanResources].[Employee] e
 where e.JobTitle in (N'Production Technician - WC50', N'Production Technician - WC60', N'Production Technician - WC40')
   and e.Gender = N'M';


-- Не оптимизированный запрос
select e3.*
  from [HumanResources].[Employee] e3 
 where e3.Gender in (
						select top 1
							   e2.Gender 
						  from [HumanResources].[Employee] e2
						 where e2.JobTitle in (select top 1
													 with ties
													 e3.JobTitle
												from [HumanResources].[Employee] e3
											   group by e3.JobTitle
											   order by count(distinct e3.BusinessEntityID) desc)
						 group by e2.Gender
						 order by count(e2.BusinessEntityID) desc
					) 
   and e3.JobTitle in (select top 1
							  with ties
			                  e3.JobTitle
						from [HumanResources].[Employee] e3
					group by e3.JobTitle
				    order by count(distinct e3.BusinessEntityID) desc);
;
--=============================================================================================================================================================== 

