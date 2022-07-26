select * from sys.foreign_keys where parent_object_id = 1557580587;


select *
  from sys.tables t
 where t.[schema_id] in (select s.[schema_id] 
                           from sys.schemas s
                           where s.[name] = 'TARGET');

-- Deactivate a foreign key 
ALTER TABLE [TARGET].[OFFICES]
NOCHECK CONSTRAINT mgr_fk;

-- Activate a foreign key
ALTER TABLE [TARGET].[OFFICES]
CHECK CONSTRAINT mgr_fk;

insert into [TARGET].[OFFICES]
select * from [Landing].[OFFICES]
select * from [TARGET].[OFFICES];

--truncate table [TARGET].[OFFICES];
delete from [TARGET].[OFFICES];
--==================================================================================================
-- Set opetators
-- Union 
-- Union all
-- Intersect
-- EXCEPT


-- Union/ Union all
-- This query returns the list of products that were sold by women who worked as North American Sales Manager or European Sales Manager, in 2012
select --distinct
       p.ProductID,
	   null
  from [HumanResources].[Employee] e
 inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
                                        and h.OrderDate between '20120101' and '20121231 23:59:59'
										and h.Status = 5
										and h.TerritoryID = 5
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
 inner join [Production].[Product] p on p.ProductID = d.ProductID
 where e.JobTitle in (N'North American Sales Manager', N'European Sales Manager')
   and e.Gender = N'M'
union  -- union all doesn't eliminate duplicates unlike union. 
-- This query returns the list of products that were sold by man who had been worked as Sales Representative, in 2011
select 
       p.ProductID,
	   null
  from [HumanResources].[Employee] e
 inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
                                        and h.OrderDate between '20110101' and '20111231 23:59:59'
										and h.OnlineOrderFlag = 0	
										and h.TerritoryID !=5
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
 inner join [Production].[Product] p on p.ProductID = d.ProductID
 where e.JobTitle = 'Sales Representative'
   and e.Gender = N'F'
order by ProductID;

-- Intersect
-- This query returns the list of products that were sold by women who worked as North American Sales Manager or European Sales Manager, in 2012
select p.ProductID,
       null
  from [HumanResources].[Employee] e
 inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
                                        and h.OrderDate between '20110101' and '20111231 23:59:59'
										and h.OnlineOrderFlag = 0	
										and h.TerritoryID !=5
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
 inner join [Production].[Product] p on p.ProductID = d.ProductID
 where e.JobTitle = 'Sales Representative'
   and e.Gender = N'F'
intersect
-- This query returns the list of products that were sold by man who had been working as Sales Representative, in 2011
select p.ProductID,
       null
  from [HumanResources].[Employee] e
 inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
                                        and h.OrderDate between '20120101' and '20121231 23:59:59'
										and h.Status = 5
										and h.TerritoryID = 5
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
 inner join [Production].[Product] p on p.ProductID = d.ProductID
 where e.JobTitle in (N'North American Sales Manager', N'European Sales Manager')
   and e.Gender = N'M';

-- EXCEPT
-- This query returns the list of products that were sold by women who worked as North American Sales Manager or European Sales Manager, in 2012
select p.ProductID,
       null
  from [HumanResources].[Employee] e
 inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
                                        and h.OrderDate between '20110101' and '20111231 23:59:59'
										and h.OnlineOrderFlag = 0	
										and h.TerritoryID !=5
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
 inner join [Production].[Product] p on p.ProductID = d.ProductID
 where e.JobTitle = 'Sales Representative'
   and e.Gender = N'F'
except
-- This query returns the list of products that were sold by man who had been working as Sales Representative, in 2011
select p.ProductID,
       null
  from [HumanResources].[Employee] e
 inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
                                        and h.OrderDate between '20120101' and '20121231 23:59:59'
										and h.Status = 5
										and h.TerritoryID = 5
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
 inner join [Production].[Product] p on p.ProductID = d.ProductID
 where e.JobTitle in (N'North American Sales Manager', N'European Sales Manager')
   and e.Gender = N'M';

/*
-- Intersect
select q.c1,
       q.c2
  from (values (null, null), (null, null), (null, null)) as q (c1, c2)
intersect
select q.c1,
       q.c2
  from (values (null, null), (null, null), (null, null)) as q (c1, c2)

select q.c1,
       q.c2
  from (values (null, null), (null, null), (null, null)) as q (c1, c2)
except
select q.c1,
       q.c2
  from (values (null, null), (null, null), (null, null)) as q (c1, c2)
*/

--==================================================================================================
/*
Напишите запрос, который вернет список пар значений идент. клиента и идент. сотрудника.
Учитывайте только сотрудников, которые работали в январе, а не в феврал 2012.
- Задействуйтвуйте оператор except
*/
-- Ян
select SalesPersonID, 
       CustomerID 
  from [Sales].[SalesOrderHeader] 
  where OrderDate between '20100101' and '20120131 23:59:59'
  --and SalesPersonID is not null
except
  select SalesPersonID, 
       CustomerID 
  from [Sales].[SalesOrderHeader] 
  where OrderDate between '20130101' and '20150131 23:59:59'
 --and SalesPersonID is not null

 --==================================================================================================
 -- Temporary tables
 -- # - local temporary table
 -- ## - global temporary table

-- This query returns the list of products that were sold by man who had been working as Sales Representative, in 2011
select 
       p.ProductID,
	   null
  from [HumanResources].[Employee] e
 inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
                                        and h.OrderDate between '20120101' and '20121231 23:59:59'
										and h.Status = 5
										and h.TerritoryID = 5
 inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
 inner join [Production].[Product] p on p.ProductID = d.ProductID
 where e.JobTitle in (N'North American Sales Manager', N'European Sales Manager')
   and e.Gender = N'M';
--===============================================1=========================================================
if object_id('[tempdb].dbo.#loc1') is not null drop table #loc1;
select distinct
       h.SalesOrderID
  into #loc1
  from [HumanResources].[Employee] e with (nolock)
 inner join [Sales].[SalesOrderHeader] h with (readuncommitted) on h.SalesPersonID = e.BusinessEntityID
                                        and h.OrderDate between '20120101' and '20121231 23:59:59'
										and h.Status = 5
										and h.TerritoryID = 5
 where e.JobTitle in (N'North American Sales Manager', N'European Sales Manager')
   and e.Gender = N'M';

create clustered index CISalesOrderID on #loc1(SalesOrderID);
-- select * from #loc1;
--===============================================2=========================================================
if object_id('[tempdb].dbo.#loc2') is not null drop table #loc2;
select distinct
       d.ProductID
  into #loc2
  from #loc1 l 
 inner join [Sales].[SalesOrderDetail] d with (readuncommitted) on d.SalesOrderID = l.SalesOrderID
;

create clustered index CISalesOrderID on #loc2(ProductID);
-- select * from #loc2;
--===============================================3=========================================================
if object_id('[tempdb].dbo.#loc3') is not null drop table #loc3;
select distinct
       p.ProductID,
	   p.[Name]
  into #loc3
  from #loc2 l
 inner join [Production].[Product] p with (readuncommitted) on p.ProductID = l.ProductID
;
--===============================================4=========================================================
select * 
  from #loc3;


  --========================#1======================================
if object_id('[tempdb].dbo.#loc1') is not null drop table #loc1;
select t1.BusinessEntityID
 into #loc1
  from [HumanResources].[Employee] as t1
  where t1.JobTitle in ('Sales Manager', 'North American Sales Manager','Pacific Sales Manager', 'Sales Representative')

select * from #loc1


--================================#2==============================
if object_id('[tempdb].dbo.#loc2') is not null drop table #loc2;
select ProductID 
 into #loc2
 from [Production].[Product]
  where ProductNumber in ('FW-M423', 'FW-M762', 'FW-M928', 'FW-R762', 'FW-R820')

select * from #loc2

--==================================#3==========================
if object_id('[tempdb].dbo.#loc3') is not null drop table #loc3;
select t5.SalesPersonID 
into #loc3
  from [Sales].[SalesOrderHeader] as t5
  join [Sales].[SalesOrderDetail] as t6 on t6.SalesOrderID = t5.SalesOrderID
  join #loc2 as t3 on t6.ProductID = t3.ProductID

select * from #loc3

--=================================#4============================
if object_id('[tempdb].dbo.#loc4') is not null drop table #loc4;
select BusinessEntityID
into #loc4
  from #loc1
except
select * 
from #loc3 

select * from #loc4

--==============================#5================================
if object_id('[tempdb].dbo.#loc5') is not null drop table #loc5;
select t2.BusinessEntityID,
    t1.SalesOrderID,
    t1.OrderDate, 
    t1.SubTotal 
into #loc5
from [Sales].[SalesOrderHeader] as t1
join #loc4 as t2 on t2.BusinessEntityID = t1.SalesPersonID

select * from #loc5

--========================#6==================================
if object_id('[tempdb].dbo.#loc6') is not null drop table #loc6;
select t2.BusinessEntityID,
       convert(nvarchar(50), null) as [jobTitle],
    t2.SalesOrderID,
    t2.OrderDate, 
    t2.SubTotal,
       t1.SalesOrderDetailID,
	t1.productid,
	convert(nvarchar(25), null) as ProductNumber,
	convert(nvarchar(50), null) as [Name],
    dense_rank()over(partition by t2.BusinessEntityID order by t2.SalesOrderID desc,t2.orderdate desc) as [Rank]
    into #loc6 
from [Sales].[SalesOrderDetail] as t1
join #loc5 as t2 on t2.SalesOrderID = t1.SalesOrderID;

create clustered index CIBusinessEntityID on #loc6(BusinessEntityID);
create nonclustered index CIProductID on #loc6(ProductID);

-- Update local table to get job title name
update l
   set l.jobTitle = upper(ltrim(e.JobTitle))
  from #loc6 l
  inner join [HumanResources].[Employee] e on e.BusinessEntityID = l.BusinessEntityID;

-- Update local table to get product information
update l
   set l.ProductNumber = p.ProductNumber,
       l.[Name] = p.[Name]
  from #loc6 l
 inner join [Production].[Product] p on p.ProductID = l.ProductID;

 --======================#7=================================
 select * 
 from #loc6 
 where [rank] < 4