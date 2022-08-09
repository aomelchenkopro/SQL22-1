-- Виды индексов
-- Кластерный индекс 
-- Не кластерный индекс

-- Кластерный индекс (уникальный/ не уникальный)
/*
- В таблице может быть только один кластерный индекс
- Кластерный индекс физически сортирует строки в таблице
- Может быть составным, т.е. состоять из комбинации значений сразу нескольких атрибутов таблицы
- Кластерный индекс обладает высокой производительностью и работает быстрее чем не кластерный индекс, в связи с физ. сортировкой строк
- По умолчаню primary key индексируется кластерным индексом
*/

-- Не кластерный индекс (уникальный/ не уникальный)
/*
- Таблица может содержать не ограниченное количество индексов
- Не кластерный индекс не сортирует строки физически
- Может быть составным, т.е. состоять из комбинации значений сразу нескольких атрибутов таблицы
- Не кластерный индекс работает медленнее чем кластерный индекс, в связи с тем, что не сортирует строки физически
- Не кластерный индекс не создается по умолчанию. Обычно с помощью такого индекса, индексируются внешение ключи - foreign key 
*/
-- =================================================================================================================================
-- Пример запроса для поиска информации о созданных индексах на таблицу
select * 
  from sys.indexes i
 where i.object_id in(select t.object_id
                        from sys.tables t
                       where t.[name] = 'Employee'
                         and t.schema_id in (select s.schema_id
                                               from sys.schemas s
                                              where s.[name] = 'HumanResources'));
-- =================================================================================================================================
/*
--https://docs.microsoft.com/en-us/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver16

CREATE [ UNIQUE ] [ CLUSTERED | NONCLUSTERED ] INDEX index_name
    ON <object> ( column [ ASC | DESC ] [ ,...n ] )

*/
--create unique clustered index uci_index1 on table_name (column1 desc);
--create unique nonclustered index uci_index1 on table_name (column1 desc);
--create clustered index uci_index1 on table_name (column1 desc);
--create nonclustered index uci_index1 on table_name (column1 desc);
-- =================================================================================================================================
--https://docs.microsoft.com/en-us/sql/t-sql/data-types/data-type-precedence-transact-sql?view=sql-server-ver16
--https://docs.microsoft.com/ru-ru/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver16

if object_id('[SQL221].[dbo].[Employee]') is not null drop table [SQL221].[dbo].[Employee];
select * 
  into [SQL221].[dbo].[Employee]
  from [HumanResources].[Employee];

if object_id('[SQL221].[dbo].[Person]') is not null drop table [SQL221].[dbo].[Person];
select *
  into [SQL221].[dbo].[Person]
  from [Person].[Person];
--create nonclustered index nci_BusinessEntityID on [SQL221].[dbo].[Person]([BusinessEntityID]);
-- ==========================================================================================
-- create nonclustered index nci_nationalidnumber on [SQL221].[dbo].[Employee]([NationalIDNumber]);
-- create nonclustered index nci_BusinessEntityID on [SQL221].[dbo].[Employee]([BusinessEntityID]);
select * 
  from [SQL221].[dbo].[Employee];


select * 
  from [SQL221].[dbo].[Employee] e
 where e.[NationalIDNumber] = 295847284;

select e.[BusinessEntityID]
  from [SQL221].[dbo].[Employee] e
 where e.[NationalIDNumber] = N'295847284';

select e.[LoginID]
  from [SQL221].[dbo].[Employee] e
 where e.[NationalIDNumber] = N'295847284';

select e.[BusinessEntityID],
       p.[FirstName],
	   p.[MiddleName],
	   p.[LastName]
  from [SQL221].[dbo].[Employee] e
  inner join [SQL221].[dbo].[Person] p on p.[BusinessEntityID] = e.[BusinessEntityID];


select p.[BusinessEntityID],
       p.[FirstName],
	   p.[MiddleName],
	   p.[LastName],
	   p.[PersonType]
  from [SQL221].[dbo].[Employee] e
  inner join [SQL221].[dbo].[Person] p on p.[BusinessEntityID] = e.[BusinessEntityID];
-- ==========================================================================================
select e.[NationalIDNumber],
       e.[LoginID]
  from [SQL221].[dbo].[Employee] e
 where e.[NationalIDNumber] = N'295847284';


select *
  from [SQL221].[dbo].[Employee] e
   inner join [SQL221].[dbo].[Person] p on p.[BusinessEntityID] = e.[BusinessEntityID]
 where e.[NationalIDNumber] = N'295847284';

 -- ==========================================================================================
select 
       *
  from [HumanResources].[Employee] e
  inner join [Person].[Person] p on p.[BusinessEntityID] = e.[BusinessEntityID]
  inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
                                         and h.OrderDate between '20110101' and '20111231 23:59:59'
  inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
  inner join [Production].[Product] r on r.ProductID = d.ProductID
                                     and r.Color = 'Multi'
 where e.[JobTitle] = 'Sales Representative'
   and e.BusinessEntityID in (

							  select e.BusinessEntityID
							  from [HumanResources].[Employee] e
							  inner join [Person].[Person] p on p.[BusinessEntityID] = e.[BusinessEntityID]
							  inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
																	 and h.OrderDate between '20110101' and '20111231 23:59:59'
							  inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
                              inner join [Production].[Product] r on r.ProductID = d.ProductID
                                     and r.Color = 'Multi'
							 where e.[JobTitle] = 'Sales Representative'
							 group by e.BusinessEntityID
							 having COUNT(distinct h.SalesOrderID) = (

																		select MAX(q.qty)
																		  from (
																		 select e.BusinessEntityID,
																				COUNT(distinct h.SalesOrderID) as qty
																		  from [HumanResources].[Employee] e
																		  inner join [Person].[Person] p on p.[BusinessEntityID] = e.[BusinessEntityID]
																		  inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
																												 and h.OrderDate between '20110101' and '20111231 23:59:59'
																		  inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
                                                                          inner join [Production].[Product] r on r.ProductID = d.ProductID
                                                                                                             and r.Color = 'Multi'
																		 where e.[JobTitle] = 'Sales Representative'
																		 group by e.BusinessEntityID
																		) q
																		)) 
order by e.BusinessEntityID desc;

 -- =========================================1================================================
 --create nonclustered index nci_jobtitle on [HumanResources].[Employee](JobTitle);

 SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
 with cte as (
				 select 
						p.BusinessEntityID,
						p.LastName,
						p.FirstName,
						p.MiddleName,
						h.[SalesOrderID],
						h.OrderDate,
						r.[Name]
				   from [HumanResources].[Employee]     e /*with (nolock)*/ with (READUNCOMMITTED)
				  inner join [Person].[Person]          p /*with (nolock)*/ on p.[BusinessEntityID] = e.[BusinessEntityID]
				  inner join [Sales].[SalesOrderHeader] h /*with (nolock)*/ on h.SalesPersonID      = e.BusinessEntityID
														               and h.OrderDate between '20110101 00:00:00' and '20111231 23:59:59'
				  inner join [Sales].[SalesOrderDetail] d /*with (nolock)*/ on d.SalesOrderID       = h.SalesOrderID
				  inner join [Production].[Product]     r /*with (nolock)*/ on r.ProductID          = d.ProductID
													                   and r.Color              = N'Multi'
				  where e.[JobTitle] = N'Sales Representative'
) 
select *
  from cte c3
 where c3.BusinessEntityID in (
								select c2.BusinessEntityID
								  from cte c2
								 group by c2.BusinessEntityID
								having count(distinct c2.[SalesOrderID]) = (select top 1
																				   count(distinct c1.[SalesOrderID]) qty
																			  from cte c1
																			 group by c1.BusinessEntityID
																			 order by count(distinct c1.[SalesOrderID])  desc));
 -- ============================================2=============================================
 if object_id('[tempdb].[dbo].#local') is not null drop table #local;
 select 
        p.BusinessEntityID,
		p.LastName,
		p.FirstName,
		p.MiddleName,
		h.[SalesOrderID],
		h.OrderDate,
		r.[Name]
  into #local
  from [HumanResources].[Employee] e
  inner join [Person].[Person] p on p.[BusinessEntityID] = e.[BusinessEntityID]
  inner join [Sales].[SalesOrderHeader] h on h.SalesPersonID = e.BusinessEntityID
                                         and h.OrderDate between '20110101' and '20111231 23:59:59'
  inner join [Sales].[SalesOrderDetail] d on d.SalesOrderID = h.SalesOrderID
  inner join [Production].[Product] r on r.ProductID = d.ProductID
                                     and r.Color = 'Multi'
 where e.[JobTitle] = 'Sales Representative';

select *
  from #local c3
 where c3.BusinessEntityID in (
								select c2.BusinessEntityID
								  from #local c2
								 group by c2.BusinessEntityID
								having count(distinct c2.[SalesOrderID]) = (select top 1
																				   count(distinct c1.[SalesOrderID]) qty
																			  from #local c1
																			 group by c1.BusinessEntityID
																			 order by count(distinct c1.[SalesOrderID])  desc));
 -- ===============================================3==========================================
 -- Транзакция 1 -- select * from #l1;
  if object_id('[tempdb].[dbo].#l1') is not null drop table #l1;
  select e.BusinessEntityID
    into #l1
    from [HumanResources].[Employee] e  with (READUNCOMMITTED)
   where e.[JobTitle] = N'Sales Representative';
create clustered index ci_BusinessEntityID on #l1(BusinessEntityID);

 -- Транзакция 2 -- select * from #l2;
  if object_id('[tempdb].[dbo].#l2') is not null drop table #l2;
  select p.[BusinessEntityID],
         p.LastName,
		 p.FirstName,
		 p.MiddleName
    into #l2
    from #l1 l
   inner join [Person].[Person] p  with (READUNCOMMITTED) on p.[BusinessEntityID] = l.[BusinessEntityID];
create clustered index ci_BusinessEntityID on #l2(BusinessEntityID);

-- Транзакция 3 -- select * from #l3;
  if object_id('[tempdb].[dbo].#l3') is not null drop table #l3;
  select l.*,
         h.SalesOrderID
    into #l3
    from #l2 l
   inner join [Sales].[SalesOrderHeader] h  with (READUNCOMMITTED) on h.SalesPersonID = l.[BusinessEntityID]
                                          and h.OrderDate between '20110101' and '20111231 23:59:59';
create clustered index cli_SalesOrderID on #l3(SalesOrderID);

-- Транзакция 4 -- select * from #l4;
  if object_id('[tempdb].[dbo].#l4') is not null drop table #l4;
  select l.*,
         d.ProductID
	into #l4
    from #l3 l
   inner join [Sales].[SalesOrderDetail] d  with (READUNCOMMITTED) on d.SalesOrderID = l.SalesOrderID;
create clustered index cli_ProductID on #l4(ProductID);

-- Транзакция 5 -- select * from #l5;
  if object_id('[tempdb].[dbo].#l5') is not null drop table #l5;
  select 
         l.*
    into #l5
    from #l4 l
  inner join [Production].[Product] r  with (READUNCOMMITTED) on r.ProductID = l.ProductID
                                     and r.Color = N'Multi';
create clustered index ci_BusinessEntityID on #l5(BusinessEntityID);

select *
  from #l5 c3
 where c3.BusinessEntityID in (
								select c2.BusinessEntityID
								  from #l5 c2
								 group by c2.BusinessEntityID
								having count(distinct c2.[SalesOrderID]) = (select top 1
																				   count(distinct c1.[SalesOrderID]) qty
																			  from #l5 c1
																			 group by c1.BusinessEntityID
																			 order by count(distinct c1.[SalesOrderID])  desc));

--==================================================================================================================================================================================
select * from Purchasing.Vendor;
select * from Purchasing.ProductVendor
select * from Production.Product
/*
Напишите запрос, который для поставщика с наибольшим количеством продуктов цвета Black, вернет список таких продуктов.
Учитывайте только поставщиков с кредитным рейтингом 1.
- Используются таблицы: Purchasing.Vendor, Purchasing.ProductVendor, Production.Product
- Результирующий набора данных содержит: идент. поставщика, наименование поставщика, идент. товара, наименование товара
*/
go
with cte as (
		 	 select n.BusinessEntityID,
					n.[name],
					r.ProductID,
					r.[Name] as productName
				from Purchasing.Vendor n 
				inner join Purchasing.ProductVendor p on p.BusinessEntityID = n.BusinessEntityID
				inner join Production.Product r on r.ProductID = p.ProductID
											and r.Color = N'Black'
				where n.CreditRating = 1
)
-- Рез. набор данных - список продуктов производителя с нибольшим количеством продутков
select distinct
       * 
  from cte c3
 where c3.BusinessEntityID in (-- Все идент. поставщиков с наибольшим количеством продуктов
								select c2.BusinessEntityID
								  from cte c2
								 group by c2.BusinessEntityID
								having count(distinct c2.ProductID) = (-- Наибольшее кол-во продуктов в разрезе поставщика
																		select top 1
																				count(distinct c1.ProductID) as qty
																		   from cte c1
																		  group by c1.BusinessEntityID
																		  order by qty desc 
																	   )
								)
;

-- Ян
if object_id('[tempdb].dbo.#loc1') is not null drop table #loc1;

select t3.BusinessEntityID,
     t3.[Name] as VendorName,
     t2.productid,
     t3.[Name] as productName
     into #loc1
   from Purchasing.ProductVendor as t1
   join Production.Product as t2 on t2.productid = t1.productid
           and t2.color = N'Black'
   join Purchasing.Vendor as t3 on t3.BusinessEntityID = t1.BusinessEntityID 
          and t3.CreditRating = 1

select * 
from #loc1 
where BusinessEntityID = 
(select top 1  BusinessEntityID
from #loc1
Group by BusinessEntityID
order by count (productid) desc)