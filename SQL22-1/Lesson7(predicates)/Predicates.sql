/*
"Напишите запрос, который в разрезе идентификатора карты (CreditCardID) вернет: кол-во заказов, общую сумму заказов, максимальную сумму
заказа, минимальную сумму заказа, среднюю сумму заказа. Сумма заказа - [SubTotal]. 
Не учитывайте заказы, у которых не указан идент. карты (CreditCardID is not null)
- Используется таблица [Sales].[SalesOrderHeader] 
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- Отсортировать результат по общей сумме заказа (по убыванию)"					

*/
select t1.CreditCardID,
       count(t1.SalesOrderID) as [orderQty], -- кол-во заказов
       sum(t1.SubTotal)       as [totalSum], -- общая сумма заказов
	   max(t1.SubTotal)       as [maxSum],   -- максимальная сумма
	   min(t1.SubTotal)       as [minSum],   -- минимальная сумма
	   avg(t1.SubTotal)       as [avgSum]    -- средняя сумма
  from [Sales].[SalesOrderHeader] as t1
 where t1.CreditCardID is not null
 group by t1.CreditCardID;
--==========================================================================================================================================================