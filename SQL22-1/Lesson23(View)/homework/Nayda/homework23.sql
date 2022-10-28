

CREATE VIEW V_OrdersProductsCustomers AS
with cte as (
select ORDER_NUМ,
       PRODUCT,
	   FORMAT(ORDER_DATE,'yyyyMM', 'en-US') as [date],
	   qty,
       DENSE_RANK()OVER(ORDER BY FORMAT(ORDER_DATE,'yyyyMM', 'en-US') DESC) as [rank]
from [TARGET].[ORDERS])

select PRODUCT,
sum(case [date] when '200802' then [qty] end) as [200802],
sum(case [date] when '200803' then [qty] end) as [200803],
sum(case [date] when '202210' then [qty] end) as [202210]
 from cte 
where [rank] < 4
group by PRODUCT

select * from V_OrdersProductsCustomers
