-- Вложенные запросы
/*
1.Скалярные -> автономные/ коррелирующие -> гарантируемые/ не гарантируемые

2.Табличные -> автономные/ коррелирующие
*/

select t1.*
  from [HumanResources].[Employee] as t1
 where t1.BirthDate = (--Гарантируемый скалярный автономный вложенный запрос
                       select min(t2.BirthDate)
                         from [HumanResources].[Employee] as t2);

select t1.*
  from [Sales].[SalesOrderHeader] as t1
 where t1.OrderDate = (select max(t2.OrderDate)
                         from [Sales].[SalesOrderHeader] as t2);

select t1.*
  from [Sales].[SalesOrderHeader] as t1
 where t1.CustomerID NOT IN (-- Табличный автономный
                             select isnull(t2.CustomerID, -1)
                               from [Sales].[Customer] as t2 
						      where t2.TerritoryID = 4
						        and t2.CustomerID is not null);

select t1.*
  from [Sales].[SalesOrderHeader] as t1
 where t1.CustomerID not IN (
                             select CustomerID
                               from [Sales].[Customer]
						      where TerritoryID = 4);

select t1.*
  from [Sales].[SalesOrderHeader] as t1
 where not exists (-- Табличный не автономный коррелирующий запрос
                   select t2.*
                     from [Sales].[Customer] as t2
			        where t2.TerritoryID = 4
					   -- корреляция 
				      and t2.CustomerID = t1.CustomerID );

select p.*
  from [Person].[Person] as p
 where p.BusinessEntityID in (-- Не гарантируемый скалярный автономный запрос
                             select t1.BusinessEntityID
                               from [HumanResources].[Employee] as t1
                               where t1.JobTitle = N'Master Scheduler');

select *
  from (-- Табличный автономный
        select t1.BusinessEntityID,
               concat_ws(N' ', t2.LastName, t2.FirstName, t2.MiddleName) as FullName,
               t1.Gender,
	           datediff(year, t1.BirthDate, sysdatetime()) - case when 100 * month(sysdatetime()) + day(sysdatetime()) < 100 * month(t1.BirthDate) + day(t1.BirthDate) then 1 else 0 end as Age,
               t1.HireDate
         from [HumanResources].[Employee] as t1 
        inner join [Person].[Person] as t2 on t2.BusinessEntityID = t1.BusinessEntityID
       where t1.JobTitle in (N'Production Technician - WC60', N'Production Supervisor - WC10')
	     ) as subquery
	where subquery.Age between 30 and 35
	  and subquery.FullName = N'Masters Steve F'
;

select subquery.*
  from (
        select t1.JobTitle,
               count(distinct t1.BusinessEntityID) as EmpQty
          from [HumanResources].[Employee] as t1
         group by t1.JobTitle
	    ) as subquery
 where subquery.EmpQty between 10 and 15;

 -- CTE - Common table expression - Обобщенное табличное выражение
 with cte as
 (
 select e.BusinessEntityID,
       h.SalesOrderID,
	   h.OrderDate,
	   h.SubTotal
  from [HumanResources].[Employee] as e
 inner join [Sales].[SalesOrderHeader] as h on h.SalesPersonID = e.BusinessEntityID
                                           and h.OrderDate between '20120101' and '20121231 23:59:59'
 where e.JobTitle = N'Sales Representative' 
 )
select t3.*
  from cte as t3
 where t3.BusinessEntityID in (

								select t2.BusinessEntityID
								   from cte as t2
								  group by t2.BusinessEntityID
								 having count(distinct t2.SalesOrderID) = (
																			 select top 1
																					count(distinct t1.SalesOrderID) as Q
																			   from cte as t1
																			  group by t1.BusinessEntityID
																			  order by Q desc
																		   )
							   )
;

--=========================================================================================================
select t4.*
  from [Sales].[SalesOrderHeader] as t4
 where exists (
               select *
			     from (
						select t3.SalesPersonID,
							   max(t3.OrderDate) as [mod]
						  from [Sales].[SalesOrderHeader] as t3 
						 where t3.SalesPersonID in (select t2.BusinessEntityID
													  from [HumanResources].[Employee] as t2 
													 where t2.BirthDate = (select min(t1.BirthDate)
																			 from [HumanResources].[Employee] t1))
						group by t3.SalesPersonID
				       ) as subq
				   where t4.OrderDate = subq.[mod]
			         and t4.SalesPersonID = subq.SalesPersonID
			 
			   )

--========================================================================================================
with cte as 
(
select t3.*
  from [Sales].[SalesOrderHeader] as t3 
 where t3.SalesPersonID in (select t2.BusinessEntityID
				              from [HumanResources].[Employee] as t2 
					         where t2.BirthDate = (select min(t1.BirthDate)
												     from [HumanResources].[Employee] t1))
)
select t2.*
  from [Sales].[SalesOrderHeader] as t2
 where exists (
               select * 
			     from (select t1.SalesPersonID,
                              max(t1.OrderDate) as [mod]
                         from cte as t1
                        group by t1.SalesPersonID) subq
				where subq.[mod] = t2.OrderDate
				  and subq.SalesPersonID = t2.SalesPersonID
			   ) 

