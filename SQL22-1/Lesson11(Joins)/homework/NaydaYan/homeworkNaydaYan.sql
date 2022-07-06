/* Напишите запрос, который возвращает кол-во уникальных заказов и кол-во уникальных проданных продуктов в
разрезе номера карты. Учитывайте только карты клиентов с кодом территории 2,4,6,8.
- Используются таблицы: [Sales].[SalesOrderHeader], [Sales].[Customer],
[Sales].[SalesOrderDetail], [Sales].[CreditCard]
- Результирующий набора данных содержит: номер карты, кол-во уникальных заказов, кол-во уникальных проданных продуктов
- Отсортируйте результат по количеству заказов (по убыванию), по количеству продуктов (по убыванию) */

select 
      t1.CardNumber,
	  count (distinct t2.SalesOrderID) as CountOrder,
	  count (distinct t3.ProductID) as CountProduct
 from [Sales].[CreditCard] as t1 
	  join [Sales].[SalesOrderHeader] as t2 on t2.CreditCardID = t1.CreditCardID
	  join [Sales].[SalesOrderDetail] as t3 on t3.SalesOrderID = t2.SalesOrderID
	  left join [Sales].[Customer] as t4 on t4.CustomerID = t2.CustomerID
where t4.TerritoryID in (2,4,6,8)
	  Group by t1.CardNumber
	  order by CountOrder desc,CountProduct desc


