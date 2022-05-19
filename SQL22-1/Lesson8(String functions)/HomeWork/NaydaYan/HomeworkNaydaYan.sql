--=============================================================HomeWork_8_Nayda_Yan======================================================================================


--Task_1=================

/*Задача 1
Напишите запрос, который вернет наименование должности с наибольшим количеством символов.
Учитывайте вероятность того, что сразу несколько должностей могут иметь одно и то же кол-во символов.
Вывести список уникальных наименований должностей (без дублирующих строк)
- Используется таблица [HumanResources].[Employee]
- Задействуйте строковые функции: len
- Результирующий набор данных содержит: Наименование должности, кол-во символов
- Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/modules/Human_Resources_9/tables/HumanResources_Employee_130.html */

 select  distinct top 1 
                  with ties
       (e.JobTitle) as [JobTitle],
       LEN (e.jobTitle) as [CountLetter]
 from  [HumanResources].[Employee] e
 order by [CountLetter] desc
       

--Task_2=================


/*Задача 2
Напишите запрос, который вернет код продукта (первые лат. Буквы до дефиса атрибута t1.ProductNumber 
Кол-во букв до дефиса может меняться от строки к строке. Необходимо определить позицию дефиса с помощью функции charindex) с наибольшим количеством продуктов.
Учитывайте вероятность того, что сразу несколько кодов продуктов могу иметь одно и тоже кол-во продуктов. Не учитывайте продукты цвета Multi.
- Используется таблица [Production].[Product]
- Задействуйте строковые функции: charindex, substring
- Задействуйте агрегатную функцию count
- Результирующий набор данных содержит: код продукта, кол-во продуктов
- Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/modules/Products_10/tables/Production_Product_153.html */


   select distinct top 1 
                   with ties 
		  SUBSTRING(ProductNumber,1,CHARINDEX('-' ,ProductNumber,0)-1) as [StartWord], 
          COUNT (productid) as [CountProduct]
   from [Production].[Product]
   where Color != 'multi'
   group by SUBSTRING(ProductNumber,1,CHARINDEX('-' ,ProductNumber,0)-1)
   order by [CountProduct] desc
  

--Task_3=================

/*Задача 3
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
	https://docs.microsoft.com/ru-ru/dotnet/standard/base-types/custom-numeric-format-strings */

Select c.CreditCardID,
       upper (c.CardType) as [TypeCard],
	   stuff (c.CardNumber,5,6,'******') as [NumberCard], 
	   CONCAT(c.ExpYear,format(c.ExpMonth,'00','en-US')) as [YYYYMM]
 from [Sales].[CreditCard] c
 where left(c.CardNumber,4) in (1111,3333, 4444, 5555, 7777)
 order by convert(date,Concat(CONCAT(c.ExpYear,format(c.ExpMonth,'00','en-US')),'01')) desc


--Task_4=================

/*Задача 4*
Напишите запрос, который вернет адрес электронной почты с наибольшим
количеством символов до знака @. Учитывайте вероятность того, что сразу несколько
адресов могут иметь одно и тоже кол-во символов. Не учитывайте адреса,
которые начинаются с j, s (без учета регистра).
- Используется таблица [Person].[EmailAddress]
- Результирующий набор данных содержит: адрес электронной почты,
индекс символа @, символы до знака @, кол-во символов до знака @.*/


select * from [Person].[EmailAddress]

select top 1 
       with ties
       e.EmailAddress as [Email],
       CHARINDEX ('@',e.EmailAddress) as [NumberSymbolinLine],
       left (e.EmailAddress,(CHARINDEX ('@',e.EmailAddress)-1)) as [LetterBefore],
       (CHARINDEX ('@',e.EmailAddress)-1) as [CountSimbols]
from [Person].[EmailAddress] e
Where left(e.EmailAddress,1) not in ('j','s')
Order by [CountSimbols] desc