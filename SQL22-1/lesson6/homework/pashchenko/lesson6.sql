"Напишите запрос, который в разрезе идентификатора карты (CreditCardID) 
вернет: кол-во заказов, общую сумму заказов, максимальную сумму заказа, минимальную сумму заказа, среднюю сумму заказа. Сумма заказа - [SubTotal].
Не учитывайте заказы, у которых не указан идент. карты (CreditCardID is not null)
- Используется таблица [Sales].[SalesOrderHeader] 
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- Отсортировать результат по общей сумме заказа (по убыванию)"				

select * from [Sales].[SalesOrderHeader]

--===== кол-во заказов
select count(CreditCardID) as [qty]
      from [Sales].[SalesOrderHeader]
	 where CreditCardID is not null
  group by CreditCardID
  order by [qty] desc


--=====  общую сумму заказов
select sum(subtotal) as [qty]
     from [Sales].[SalesOrderHeader]
   	where CreditCardID is not null
 group by CreditCardID
 order by [qty] desc

--===== максимальную сумму заказа, минимальную сумму заказа
select   max(subtotal) as [MAX], 
         min(subtotal) as [MIN]
     from [Sales].[SalesOrderHeader] 
   	where CreditCardID is not null
 group by CreditCardID
 order by [max], [MIN] desc

  select max(subtotal) as [MAX]
     from [Sales].[SalesOrderHeader] 
   	where CreditCardID is not null
 group by CreditCardID
 order by [max] desc

select  min(subtotal) as [MIN]
     from [Sales].[SalesOrderHeader] 
   	where CreditCardID is not null
 group by CreditCardID
 order by [MIN] desc

--===== среднюю сумму заказа.
select avg(subtotal) as [AVG]
     from [Sales].[SalesOrderHeader] 
	where CreditCardID is not null
 group by CreditCardID
 order by [AVG] desc

select creditcardid,
       count(SalesOrderID) as [countQTY],
        sum(subtotal) as [sumQTY],
	    max(subtotal) as [maxQTY], 
        min(subtotal) as [minQTY],
	    avg(subtotal) as [avgQTY]
	 from [Sales].[SalesOrderHeader] 
	where CreditCardID is not null
 group by CreditCardID
 order by [sumQTY] desc
 ;