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
select creditcardid,
       count(SalesOrderID) as [countQTY],
        sum(subtotal) as [sumQTY],
	    max(subtotal) as [maxQTY], 
        min(subtotal) as [minQTY],
	    avg(subtotal) as [avgQTY]
	 from [Sales].[SalesOrderHeader] 
	where CreditCardID is not null
 group by CreditCardID
 order by [sumQTY] desc;