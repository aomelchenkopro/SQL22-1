select s.CreditCardID,
        count (distinct s.SalesOrderID) as [count], --- кол. заказов
	    sum(s.SubTotal) as [sum],  --- суммарное значение 
	    max(s.SubTotal) as [max],  --- максимально значение 
	    min(s.SubTotal) as [min],  --- минимальное значение 
	    avg(s.SubTotal) as [avg]   --- среднее значение 
  from  [Sales].[SalesOrderHeader] as s
  where s.CreditCardID is not null 
 
  group by s.CreditCardID
  order by sum(s.SubTotal) desc;