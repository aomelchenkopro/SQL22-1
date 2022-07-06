/*
Напишите запрос, который возвращает кол-во уникальных заказов и кол-во уникальных проданных продуктов в
разрезе номера карты. Учитывайте только карты клиентов с кодом территории 2,4,6,8.
- Используются таблицы: [Sales].[SalesOrderHeader], [Sales].[Customer],
[Sales].[SalesOrderDetail], [Sales].[CreditCard]
- Результирующий набора данных содержит: номер карты, кол-во уникальных заказов, кол-во уникальных проданных продуктов
- Отсортируйте результат по количеству заказов (по убыванию), по количеству продуктов (по убыванию)
*/

select r.CardNumber,
       count(distinct h.SalesOrderID) as [order_qty],
	   count(distinct d.ProductID) as [prod_qty]
  from [Sales].[SalesOrderHeader] as h 
  inner join [Sales].[Customer] as c on c.CustomerID = h.CustomerID
                                    and c.TerritoryID in (2,4,6,8)
  left outer join [Sales].[SalesOrderDetail] as d on d.SalesOrderID = h.SalesOrderID
  right outer join [Sales].[CreditCard] as r on r.CreditCardID = h.CreditCardID
 group by r.CardNumber
 order by [order_qty] desc,
          [prod_qty] desc;
