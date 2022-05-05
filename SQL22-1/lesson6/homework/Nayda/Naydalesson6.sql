---===============================================ДЗ 6============================
/* "Напишите запрос, который в разрезе идентификатора карты (CreditCardID) вернет: 
кол-во заказов,
общую сумму заказов,
максимальную сумму заказа,
минимальную сумму заказа, 
среднюю сумму заказа. 
Сумма заказа - [SubTotal]. Не учитывайте заказы, у которых не указан идент. карты (CreditCardID is not null)
- Используется таблица [Sales].[SalesOrderHeader] 
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- Отсортировать результат по общей сумме заказа (по убыванию)"
*/

Select s.CreditCardID,
       count (Distinct s.SalesOrderID) as [CountOrder], 
       sum(s.SubTotal) as [TotalSumOrder],
       max(s.SubTotal) as [MaxSumOrder],
       min(s.SubTotal) as [MinSumOrder], 
       AVG(s.SubTotal) as [AVGSumOrder]
 from [Sales].[SalesOrderHeader] s 
 where CreditCardID is not null
 Group by CreditCardID 
 order by [TotalSumOrder] desc