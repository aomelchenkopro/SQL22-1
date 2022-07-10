Напишите запрос, который возвращает кол-во уникальных заказов и кол-во уникальных проданных продуктов в
разрезе номера карты. Учитывайте только карты клиентов с кодом территории 2,4,6,8.
- Используются таблицы: [Sales].[SalesOrderHeader], [Sales].[Customer],
[Sales].[SalesOrderDetail], [Sales].[CreditCard]
- Результирующий набора данных содержит: номер карты, кол-во уникальных заказов, кол-во уникальных проданных продуктов
- Отсортируйте результат по количеству заказов (по убыванию), по количеству продуктов (по убыванию)

select * from [Sales].[SalesOrderHeader]
select * from [Sales].[SalesOrderDetail]
select * from [Sales].[Customer]
select * from [Sales].[CreditCard]

select count (distinct a1.SalesOrderID) as [OrderID],
       count (distinct a2.ProductID)    as [Product],
	                   a4.CardNumber    as [Card]
 from            [Sales].[SalesOrderHeader] as a1
left outer join  [Sales].[SalesOrderDetail] as a2 on a2.SalesOrderID = a1.SalesOrderID
inner join       [Sales].[Customer]         as a3 on a3.CustomerID   = a1.CustomerID
                                            and a3.TerritoryID in (2,4,6,8)
right outer join [Sales].[CreditCard]       as a4 on a4.CreditCardID = a1.CreditCardID
group by a4.CardNumber
order by [OrderID] desc,
         [Product] desc
    

