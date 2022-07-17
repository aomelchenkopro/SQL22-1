-- bcp nauda.raw.products in C:\Storage\projects\SQL22-1\SQL22-1\Diploma\Products.txt -t\t -r\n -w -S 159.224.194.250 -U sa -P rLC9s39J7h

insert into [Nauda].[Landing].[PRODUCTS]
select * 
  from [Nauda].[raw].[PRODUCTS];

truncate table [Nauda].[raw].[PRODUCTS];

insert into [Nauda].[TARGET].[PRODUCTS]
select * 
  from [Nauda].[Landing].[PRODUCTS];

truncate table [Nauda].[Landing].[PRODUCTS];

-- select * from [Nauda].[raw].[PRODUCTS];
-- select * from [Nauda].[Landing].[PRODUCTS];
-- select * from [Nauda].[TARGET].[PRODUCTS];
-- select count(*) from [Nauda].[TARGET].[PRODUCTS] where MFR_ID = 'ACI';
--=============================================================================================================================================
-- Функции ранжирования
/*
ROW_NUMBER
RANK
DENSE_RANK
NTILE
*/
with cte as
(
-- This query returns the list of products that were sold in 2013
select t1.[CustomerID],
       t3.[ProductID],
       t3.[Name],
	   sum(t1.subtotal) as Total
  from [Sales].[SalesOrderHeader] as t1
  inner join [Sales].[SalesOrderDetail] as t2 on t2.[SalesOrderID] = t1.[SalesOrderID]
  inner join [Production].[Product] as t3 on t3.[ProductID] = t2.[ProductID]
 where t1.[OrderDate] between '20130101' and '20131231 23:59:59'
 group by t1.[CustomerID],
          t3.[ProductID],
          t3.[Name] 
) 
/*
select *,
       row_number()over(partition by [CustomerID] order by Total desc, productID asc) as rwn,
	   dense_rank()over(partition by [CustomerID] order by Total desc) as drnk,
	   rank()over(partition by [CustomerID] order by Total desc) rnk
  from cte
 order by [CustomerID];
 */

-- The list of product that were not sold by the most profitable customers
select * 
  from [Production].[Product] as p
 where p.[ProductID] not in (
								select d.[ProductID]
								  from [Sales].[SalesOrderHeader] as h
								  inner join [Sales].[SalesOrderDetail] as d on d.[SalesOrderID] = h.[SalesOrderID]
								 where h.CustomerID in (-- The most profitable customers
														select s.CustomerID
														  from (-- Divide rows into 100 groups
																select CustomerID,
																	   sum(Total) as total,
																	   ntile(100)over(order by sum(Total) desc) as nt
																  from cte
																 group by CustomerID
														) as s
														where s.nt = 1)
							 )
;
--=============================================================================================================================================
/*
Напишите запрос, который вернет список уникальных продуктов (без дублирующих строк) проданных в 2013 году.
Результирующий набор данных содержит: идент. клиента, ФИО клиента, идент. продукта, наменование продукта.
Не используйте оператор distinct/ group by.

select * from [Person].[Person];
[Sales].[Customer] 
[Sales].[SalesOrderDetail]
[Sales].[SalesOrderHeader]
[Production].[Product]

*/
use [SQL221];

select * 
  from (
		select c.[CustomerID],
			   concat_ws(N' ', p.LastName, p.FirstName, p.MiddleName) as [full_name],
			   r.ProductID,
			   r.[Name],
			   row_number()over(partition by c.[CustomerID], r.ProductID order by r.ProductID) as rown
		  from [Sales].[Customer] as c
		 left outer join [Person].[Person] as p on p.[BusinessEntityID] = c.PersonID
		 inner join [Sales].[SalesOrderHeader] as h on h.CustomerID = c.CustomerID
												   and h.OrderDate between '20130101' and '20131231 23:59:59'
		 inner join [Sales].[SalesOrderDetail] as d on d.SalesOrderID = h.SalesOrderID                                 
		 inner join [Production].[Product] as r on r.ProductID = d.ProductID
		) q
	where q.rown = 1
 order by q.[CustomerID] asc
;
