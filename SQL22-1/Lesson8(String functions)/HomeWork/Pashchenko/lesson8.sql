Напишите запрос возвращающий список карт, номера которых начинаются с комбинаций чисел: 1111,
3333, 4444, 5555, 7777. Результирующий набор данных содержит: идент. кредит карты, наименование типа карты (в верхнем регистре),
номер карты (6 цифр начиная с 5 цифры заменено на * ), срок действия карты в формате YYYYMM (задействуйте функцию format https://docs.microsoft.com/ru-ru/dotnet/standard/base-types/custom-numeric-format-strings)
 - Используется таблица [Sales].[CreditCard]
 - Задействуйте строковые функции: right, upper, stuff, concat, format
 - Задействуйте предикат принадлежности множеству - in 
 - Отсортировать рез. набор данных по сроку действия карты (по убыванию)
 - Ссылки на описание таблицы и документацию функций
	https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/modules/Sales_12/tables/Sales_CreditCard_179.html
    https://docs.microsoft.com/ru-ru/sql/t-sql/functions/string-functions-transact-sql?view=sql-server-ver15
	https://docs.microsoft.com/ru-ru/dotnet/standard/base-types/custom-numeric-format-strings

  select * from [Sales].[CreditCard]

  select a.CreditCardID,
           concat(a.expYear, format(ExpMonth, '00')) as [exp],
		   stuff(a.CardNumber, 5, 6, '******') as [CardNumber],
		   upper(a.CardType) as [CardType]
      from [Sales].[CreditCard] as a
     where left(a.CardNumber, 4) in ('1111','3333', '4444', '5555', '7777')
  order by a.expYear desc, a.ExpMonth desc
---========================================

Напишите запрос, который вернет код продукта (первые лат. Буквы до дефиса атрибута t1.ProductNumber 
Кол-во букв до дефиса может меняться от строки к строке. Необходимо определить позицию дефиса с помощью функции charindex) с наибольшим количеством продуктов.
Учитывайте вероятность того, что сразу несколько кодов продуктов могу иметь одно и тоже кол-во продуктов. Не учитывайте продукты цвета Multi.
- Используется таблица [Production].[Product]
- Задействуйте строковые функции: charindex, substring
- Задействуйте агрегатную функцию count
- Результирующий набор данных содержит: код продукта, кол-во продуктов
- Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/modules/Products_10/tables/Production_Product_153.html

  select * from [Production].[Product]

  select top 1
          with ties
          substring(a.ProductNumber, 1, charindex('-', a.ProductNumber)-1) as [Series],
          count(a.ProductID) as [Count]
     from [Production].[Product] as a
    where a.Color != N'Multi' 
 group by substring(a.ProductNumber, 1, charindex('-', a.ProductNumber)-1)
 order by [Count] desc;

 --==========================================
Напишите запрос, котрый вернет адрес электронной почты с наибольшим 
количеством символов до знака @. Учитывайте вероятность того, что сразу несколько 
адресов могут иметь одно и тоже кол-во символов. Не учитывайте адреса, 
которые начинаются с j, s (без учета регистра).
- Результирующий набор данных содержит: адрес электронной почты,
индекс символа @, символы до знака @, кол-во символов до знака @.

select * from [Person].[EmailAddress]

   select top 1
          with ties
          a.EmailAddress,
	      substring(a.EmailAddress, 1, charindex(N'@', a.EmailAddress)-1) as  [Email],
	      len(substring(a.EmailAddress, 1, charindex(N'@', a.EmailAddress)-1)) as [symbol],
	      charindex(N'@', a.EmailAddress) as [Index]	   
     from [Person].[EmailAddress] a
    where lower(left(a.EmailAddress, 1)) not in (N'j', N's')
 order by len(substring(a.EmailAddress, 1, charindex('@', a.EmailAddress)-1)) desc
--==========================================
Напишите запрос, который вернет наименование должности с наибольшим количеством символов.
Учитывайте вероятность того, что сразу несколько должностей могут иметь одно и то же кол-во символов.
Вывести список уникальных наименований должностей (без дублирующих строк)
- Используется таблица [HumanResources].[Employee]
- Задействуйте строковые функции: lower, len
- Результирующий набор данных содержит: Наименование должности, кол-во символов
- Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/modules/Human_Resources_9/tables/HumanResources_Employee_130.html
*/
   select distinct
          top 1
          with ties
          lower(a.JobTitle),
	      len(a.JobTitle) as [total]
     from [HumanResources].[Employee] as a
 order by len(a.JobTitle) desc;