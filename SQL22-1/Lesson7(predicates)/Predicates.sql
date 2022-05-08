/*
"Напишите запрос, который в разрезе идентификатора карты (CreditCardID) вернет: кол-во заказов, общую сумму заказов, максимальную сумму
заказа, минимальную сумму заказа, среднюю сумму заказа. Сумма заказа - [SubTotal]. 
Не учитывайте заказы, у которых не указан идент. карты (CreditCardID is not null)
- Используется таблица [Sales].[SalesOrderHeader] 
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- Отсортировать результат по общей сумме заказа (по убыванию)"					

*/
select t1.CreditCardID,
       count(t1.SalesOrderID) as [orderQty], -- кол-во заказов
       sum(t1.SubTotal)       as [totalSum], -- общая сумма заказов
	   max(t1.SubTotal)       as [maxSum],   -- максимальная сумма
	   min(t1.SubTotal)       as [minSum],   -- минимальная сумма
	   avg(t1.SubTotal)       as [avgSum]    -- средняя сумма
  from [Sales].[SalesOrderHeader] as t1
 where t1.CreditCardID is not null
 group by t1.CreditCardID;
--==========================================================================================================================================================
-- Виды предикатов t-sql

-- Предикаты сравнения
select h.*
  from [HumanResources].[Employee] h
 where
       -- предикат равенства
	   h.Gender = N'M'

	   -- предикат больше
   and h.HireDate > '20090114'

       -- предикат меньше
   and h.HireDate < '20200101'

   and h.SickLeaveHours >= 10
   and h.SickLeaveHours <= 200
       -- не равенство
   and h.JobTitle != N'Marketing Specialist' --/ h.JobTitle <> N'Marketing Specialist'

   and h.BusinessEntityID !< 10
   and h.BusinessEntityID !> 100
;

-- https://docs.microsoft.com/en-us/sql/t-sql/language-elements/comparison-operators-transact-sql?view=sql-server-ver15
--==========================================================================================================================================================
-- Предикат соответствия NULL IS NULL / IS NOT NULL
select h.*
  from [HumanResources].[Employee] h
 where -- OrganizationLevel is null;
       OrganizationLevel is NOT null;
--==========================================================================================================================================================
-- Предикат принадлежности диапазону BETWEEN
select h.*
  from [HumanResources].[Employee] h
 where -- h.HireDate between '20090101' and '20091231';
          h.HireDate NOT between '20090101' and '20091231';
--==========================================================================================================================================================
-- Предикат принадлежности множеству IN
select h.*
  from [HumanResources].[Employee] h
 where  (--
        h.JobTitle = N'Production Technician - WC60'
     or h.JobTitle = N'Production Technician - WC30'
	 or h.JobTitle = N'Production Supervisor - WC40'
	    )--
;
 
select h.*
  from [HumanResources].[Employee] h
 where h.JobTitle NOT in (N'Production Technician - WC60', N'Production Technician - WC30', N'Production Supervisor - WC40')
;
 
select h.*
  from [HumanResources].[Employee] h
 where h.BusinessEntityID NOT in (select top 1
                                     with ties
                                     e.BusinessEntityID
                                from [HumanResources].[Employee] e
                               where e.Gender = N'M'
                               order by e.BirthDate asc);
--==========================================================================================================================================================
-- Предикат соответствия шаблону LIKE

-- % - любое кол-во любых символов
select distinct 
       p.LastName
  from [Person].[Person] as p 
 where p.LastName NOT like '%oo%'
 order by p.LastName;

-- _ - любой один символ
select distinct
       p.LastName
  from [Person].[Person] as p 
 where p.LastName like '_arris'
 order by p.LastName;

-- within specified range 
select distinct 
       p.FirstName
  from [Person].[Person] as p 
 where p.FirstName like N'%[А-я]%';

select distinct 
       p.FirstName
  from [Person].[Person] as p 
 where p.FirstName like N'%[абвгдо]%';

-- not within specified range 
select distinct 
       p.FirstName
  from [Person].[Person] as p 
 where p.FirstName like N'%[^А-я]%';

select distinct 
       p.FirstName
  from [Person].[Person] as p 
 where p.FirstName like N'%[^абвгдо]%';

-- Escape character
select * 
  from [Person].[Person]
 where Title like '%#%%' escape '#';
--==========================================================================================================================================================
-- AND - И
-- OR  - ИЛИ
-- NOT - ОТРИЦАНИЕ

select p.* 
  from [Production].[Product] p
 where 
       ((
	   p.ProductNumber like 'FW%'
   and p.Color in (N'Black', N'Silver', N'Blue')
       )

   or p.ProductNumber like 'FH%'
       )

   and StandardCost > 0.00
   and SafetyStockLevel = 500;
--==========================================================================================================================================================
-- OR
select p.* 
  from [Production].[Product] p
 where (p.ProductNumber like 'FR%'
    or p.ProductNumber like 'FH%')
   and p.Color in (N'Black', N'Silver', N'Blue');

--==========================================================================================================================================================
select p.LastName,
      COUNT(distinct p.BusinessEntityID) as "qty"
 from [Person].[Person] p
 where EmailPromotion !> 2
 group by p.LastName
 order by "qty" desc;
 --==========================================================================================================================================================
 /*

 Напишите запрос, который в разрезе идент. территории (TerritoryID - Territory in which the sale was made) 
 вернет кол-во уникальных заказов и их сумму (SubTotal) за 2012 год, 
 проведенные торговым представителем (OnlineOrderFlag - 0 - Order placed by sales person).
 Учитывайте только заказы, у которых (CreditCardApprovalCode - Approval code provided by the credit card company) 
 начинается и заканчивается цифрой 1 и способом доставки 5 ShipMethodID (CARGO TRANSPORT).

 - Используется таблица [Sales].[SalesOrderHeader]

 AVG, MIN, MAX

 5069, 6070
 */

-- Subject matter of the query - суть запроса
select s.TerritoryID,                                 -- идент. территории
       "OrderQty" = COUNT(distinct s.[SalesOrderID]), -- кол-во заказов
       SUM(s.SubTotal) as "Total"                     -- общая сумма
  from [Sales].[SalesOrderHeader] s
 where 
       -- за 2012 год
       s.OrderDate between '20120101 00:00:00.00' and '20121231 23:59:59.00'
	   -- проведенные торговым представителем
   and s.OnlineOrderFlag = 0
       -- начинается и заканчивается цифрой 1
   and s.CreditCardApprovalCode like '1%1'
       -- способом доставки 5 ShipMethodID
   and s.ShipMethodID = 5

 group by s.TerritoryID
 order by s.TerritoryID
;

-- Юля
 select  s.TerritoryID,
    COUNT(s.TerritoryID)  as  Qty,
    SUM (s.SubTotal)    as  Sum_total
  from [Sales].[SalesOrderHeader] as s
      where     
      s.OrderDate between '20120101 00:00:00.00' and '20121231 23:59:59.00'
      and s.OnlineOrderFlag = 0
          and s.CreditCardApprovalCode like '1%1'
          and  s.ShipMethodID = 5   
      group by s.TerritoryID
  order by  SUM (s.SubTotal)   desc;

-- Дмитрий
select s.TerritoryID,
       count(distinct s.SalesOrderID) as [Qty],
       sum (s.SubTotal) as [total]
from [Sales].[SalesOrderHeader] as s
where s.ShipDate between '20120101' and '20121231'
  and s.OnlineOrderFlag = 0
  and s.CreditCardApprovalCode like '1%1'
  and s.ShipMethodId  = 5
 group by s.TerritoryID
 order by TerritoryID;