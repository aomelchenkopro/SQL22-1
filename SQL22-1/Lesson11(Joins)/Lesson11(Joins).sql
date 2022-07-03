-- Products sold or used in the manfacturing of sold products.
select top 1000 * from [Production].[Product];

-- General sales order information.
select top 1000 * from [Sales].[SalesOrderHeader] where SalesOrderID = 43659;

-- Individual products associated with a specific sales order. See SalesOrderHeader.
select top 1000 * from [Sales].[SalesOrderDetail] -- where SalesOrderID = 43659;

-- Employee information such as salary, department, and title.
select top 1000 * from [HumanResources].[Employee];

-- Inner join ANSI - 89
select distinct 
       d.ProductID
  from [Sales].[SalesOrderHeader] as h,
       [Sales].[SalesOrderDetail] as d
 where h.OrderDate between '20120101' and '20121231 23:59:59'
   -- and h.SalesOrderID = d.SalesOrderID
;

-- inner join ANSI - 92
select distinct 
       d.ProductID
  from [Sales].[SalesOrderHeader] as h 
 inner join [Sales].[SalesOrderDetail] as d on d.SalesOrderID = h.SalesOrderID 
                                           and d.UnitPriceDiscount = 0.00
 inner join [Production].[Product] as p on p.ProductID = d.ProductID
                                       and p.Color != N'Black'
 where h.OrderDate between '20120101' and '20121231 23:59:59'
;

-- Cross join ANSI - 89 - декартово произведение строк
if object_id('[tempdb].[dbo].#template') is not null drop table #template;
select *
  into #template
  from (--List of unique products
        select distinct 
               p.ProductID,
               p.[Name]
          from [Production].[Product] as p) as d,
  (values('201101', null), ('201102', null), ('201103', null),
	     ('201104', null), ('201105', null), ('201106', null),
	     ('201107', null), ('201108', null), ('201109', null),
	     ('201110', null), ('201111', null), ('201112', null)) as c ([period], [qty])
 ;

select * from #template;

-- Update template to count quantity of orders
update t
   set [qty] = (-- An example of a correlating sub-query
                select count(distinct h.SalesOrderID) 
                  from [Sales].[SalesOrderHeader] as h
				 inner join [Sales].[SalesOrderDetail] as d on d.SalesOrderID = h.SalesOrderID
				 where format(h.OrderDate, 'yyyyMM', 'en-US') = t.period
				   and d.ProductID = t.ProductID)
 from #template as t
;

select * from #template;


-- Cross join ANSI - 92 - декартово произведение строк
if object_id('[tempdb].[dbo].#template') is not null drop table #template;
select *
  into #template
  from (--List of unique products
        select distinct 
               p.ProductID,
               p.[Name]
          from [Production].[Product] as p) as d
		  cross join
  (values('201101', null), ('201102', null), ('201103', null),
	     ('201104', null), ('201105', null), ('201106', null),
	     ('201107', null), ('201108', null), ('201109', null),
	     ('201110', null), ('201111', null), ('201112', null)) as c ([period], [qty])
 ;

-- A query to warn about null that may affect aggregate expressions
select ProductID,
       count(distinct SalesOrderID),
       count(*)
  from (select p.ProductID,
               d.SalesOrderID,
	           c.period
          from [Production].[Product] p 
          left outer join [Sales].[SalesOrderDetail] as d on d.ProductID = p.ProductID 
		  cross join (values('201101', null), ('201102', null), ('201103', null),
	                        ('201104', null), ('201105', null), ('201106', null),
	                        ('201107', null), ('201108', null), ('201109', null),
	                        ('201110', null), ('201111', null), ('201112', null)) as c ([period], [qty])
) q
group by ProductID


select p.ProductID,
       d.SalesOrderID
  from [Production].[Product] p 
  left outer join [Sales].[SalesOrderDetail] as d on d.ProductID = p.ProductID 

;
--=======================================================================================================================================================================================

select * from [HumanResources].[Employee];
select * from [Person].[EmailAddress];
select * from [Person].[PersonPhone];

select distinct 
       t1.BusinessEntityID
  from [HumanResources].[Employee] as t1
  join [Person].[EmailAddress] as t2 on t2.BusinessEntityID = t1.BusinessEntityID
  join [Person].[PersonPhone] as t3 on t3.BusinessEntityID = t1.BusinessEntityID;

select distinct 
       t1.BusinessEntityID
  from [HumanResources].[Employee] as t1
  left join [Person].[EmailAddress] as t2 on t2.BusinessEntityID = t1.BusinessEntityID 
  left join [Person].[PersonPhone] as t3 on t3.BusinessEntityID = t1.BusinessEntityID
 where (t2.BusinessEntityID is not null or t3.BusinessEntityID is not null);

/*
Напишите запрос возвращающий список уникальных идент. сотр. у которых есть адрес электронной почты но нет номера телефона.
*/
select distinct 
       t1.BusinessEntityID 
  from [HumanResources].[Employee] as t1
  join [Person].[EmailAddress] as t2 on t2.BusinessEntityID = t1.BusinessEntityID 
  left join [Person].[PersonPhone] as t3 on t3.BusinessEntityID = t1.BusinessEntityID
 where t3.BusinessEntityID is null

--delete from [Person].[PersonPhone] where BusinessEntityID = 78;
-- Research and Development Manager
/*
select * from [HumanResources].[Employee]
select * from [Person].[Person]
select * from [Person].[EmailAddress]
select * from [Person].[PersonPhone]
*/
select t1.BusinessEntityID,
       CONCAT(UPPER(left(t1.FirstName,1)),UPPER(left(t1.MiddleName,1)),UPPER(left(t1.LastName,1))) as FIO,
       datediff(year, t2.BirthDate, sysdatetime()) - case when 100 * month(sysdatetime()) 
	   + day(sysdatetime()) < 100 * month(t2.BirthDate) + day(t2.BirthDate) then 1 else 0 end as AGE
  from [Person].[Person] as t1
  join [HumanResources].[Employee] as t2 on t2.BusinessEntityID = t1.BusinessEntityID 
                                        and t2.JobTitle = N'Research and Development Manager'
  left join [Person].[EmailAddress] as t3 on t3.BusinessEntityID = t1.BusinessEntityID 
  left join [Person].[PersonPhone] as t4 on t4.BusinessEntityID = t1.BusinessEntityID;

