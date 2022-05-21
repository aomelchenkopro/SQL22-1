use [SQL221];
go

/* #1 */

select e.*
from [HumanResources].[Employee] as e
go

select distinct
       top 1
       with ties
       e.JobTitle,
	   len(e.JobTitle)
  from [HumanResources].[Employee] as e
 order by len(e.JobTitle) desc;
go

/* #2 */

select p.*
from [Production].[Product] as p
go

select top 1
       with ties
       "Cod_pr"=substring(p.ProductNumber, 1, charindex('-', p.ProductNumber)-1),
       "Qty_pr"=count(p.ProductID)
	from [Production].[Product] as p
 where p.Color != N'Multi' 
 group by substring(p.ProductNumber, 1, charindex('-', p.ProductNumber)-1)
 order by "Qty_pr" desc;

/* #3 */
  
select s.*
from [Sales].[CreditCard] as s
go

select s.CreditCardID,
       upper(s.CardType) ,
	   stuff(s.CardNumber, 5, 6, '******') ,	
	   concat(expYear, format(ExpMonth, '00')) 
  from [Sales].[CreditCard] as s
 where right(s.CardNumber, 4) in ('1111','3333', '4444', '5555', '7777')
 order by s.expYear desc, s.ExpMonth desc;
go

/* #4 */

select p.*
from [Person].[EmailAddress] as p
go

select top 1
       with ties
       e.EmailAddress,
       charindex(N'@', e.EmailAddress),
	   substring(e.EmailAddress, 1, charindex(N'@', e.EmailAddress)-1) ,
	   len(substring(e.EmailAddress, 1, charindex(N'@', e.EmailAddress)-1))
  from [Person].[EmailAddress] e
 order by len(substring(e.EmailAddress, 1, charindex('@', e.EmailAddress)-1)) desc;