/*
Напишите запрос, который вернет наименование должности с наибольшим количеством символов.
Учитывайте вероятность того, что сразу несколько должностей могут иметь одно и то же кол-во символов.
Вывести список уникальных наименований должностей (без дублирующих строк)
- Используется таблица [HumanResources].[Employee]
- Задействуйте строковые функции: lower, len
- Результирующий набор данных содержит: Наименование должности, кол-во символов
- Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/modules/Human_Resources_9/tables/HumanResources_Employee_130.html
*/

select  "jobTitleWithLen" = concat_ws(N' ', lower(q.JobTitle), len(q.JobTitle), NULL),
        "jobTitleWithLen+" = lower(q.JobTitle) + NULL + cast(len(q.JobTitle) as nvarchar(10))
  from (
		select distinct
			   top 1
			   with ties
			   "jobTitle" = lower(t1.JobTitle),
			   "len" = len(t1.JobTitle) 
		  from [HumanResources].[Employee] as t1
		 order by len(t1.JobTitle) desc
		 ) as q

/*
Напишите запрос, который вернет код продукта (первые лат. Буквы до дефиса атрибута t1.ProductNumber 
Кол-во букв до дефиса может меняться от строки к строке. Необходимо определить позицию дефиса с помощью функции charindex) с наибольшим количеством продуктов.
Учитывайте вероятность того, что сразу несколько кодов продуктов могу иметь одно и тоже кол-во продуктов. Не учитывайте продукты цвета Multi.
- Используется таблица [Production].[Product]
- Задействуйте строковые функции: charindex, substring
- Задействуйте агрегатную функцию count
- Результирующий набор данных содержит: код продукта, кол-во продуктов
- Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/modules/Products_10/tables/Production_Product_153.html
*/

select top 1
       with ties
       substring(t1.ProductNumber, 1, charindex('-', t1.ProductNumber)-1) as [pCode],
       count(t1.ProductID) as [pQTY]
  from [Production].[Product] as t1
 where t1.Color != N'Multi' 
 group by substring(t1.ProductNumber, 1, charindex('-', t1.ProductNumber)-1)
 order by [pQTY] desc;

/*
Напишите запрос возвращающий список карт, номера которых начинаются с комбинаций чисел: 1111,
3333, 4444, 5555, 7777. Результирующий набор данных содержит: идент. кредит карты, наименование типа карты (в верхнем регистре),
номер карты (6 цифр начиная с 5 цифры заменено на * ), срок действия карты в формате YYYYMM (задействуйте функцию format https://docs.microsoft.com/ru-ru/dotnet/standard/base-types/custom-numeric-format-strings)
 - Используется таблица [Sales].[CreditCard]
 - Задействуйте строковые функции: left, upper, stuff, concat, format
 - Задействуйте предикат принадлежности множеству - in 
 - Отсортировать рез. набор данных по сроку действия карты (по убыванию)
 - Ссылки на описание таблицы и документацию функций
	https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/modules/Sales_12/tables/Sales_CreditCard_179.html
    https://docs.microsoft.com/ru-ru/sql/t-sql/functions/string-functions-transact-sql?view=sql-server-ver15
	https://docs.microsoft.com/ru-ru/dotnet/standard/base-types/custom-numeric-format-strings
  */

select t1.CreditCardID,
       upper(t1.CardType) as [CardType],
	   stuff(t1.CardNumber, 5, 6, '******') as [cardNumber],	
	   concat(expYear, format(ExpMonth, '00')) as [expPeriod]
  from [Sales].[CreditCard] as t1
 where left(t1.CardNumber, 4) in (N'1111',N'3333', N'4444', N'5555', N'7777')
 order by t1.expYear desc, t1.ExpMonth desc;

/*
Напишите запрос, котрый вернет адрес электронной почты с наибольшим 
количеством символов до знака @. Учитывайте вероятность того, что сразу несколько 
адресов могут иметь одно и тоже кол-во символов. Не учитывайте адреса, 
которые начинаются с j, s (без учета регистра).
- Результирующий набор данных содержит: адрес электронной почты,
индекс символа @, символы до знака @, кол-во символов до знака @.
*/
select top 1
       with ties
       e.EmailAddress,
       charindex(N'@', e.EmailAddress) as [SymbolIndex],
	   substring(e.EmailAddress, 1, charindex(N'@', e.EmailAddress)-1) as  [EmailName],
	   len(substring(e.EmailAddress, 1, charindex(N'@', e.EmailAddress)-1))
  from [Person].[EmailAddress] e
 where lower(left(e.EmailAddress, 1)) not in (N'j', N's')
 order by len(substring(e.EmailAddress, 1, charindex('@', e.EmailAddress)-1)) desc;
