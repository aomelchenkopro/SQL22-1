﻿/*
Напишите запрос, который вернет кол-во продуктов в разрезе цвета продукта.
Учитывайте только продукты с указанным цветом ([Color] is not null). 
В результате выведите только цвета с количеством продуктов больше 1.
- Используется таблица [Production].[Product]
	Атрибут - [Color] - цвет продукта
	Атрибут - ProductID - идент. продукта
	Детальное описание таблицы - https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Production_Product_153.html
- Отсортировать рез. набор данных пол количеству продуктов (по убыванию)		
*/

--===============================================================================================================================================================
-- Расчет кол-ва продуктов в разрезе цвета
select t1.Color,                                  -- цвет продукта
       count(distinct t1.ProductID) as [prod_qty] -- идент. продукта/ кол-во продуктов
  from [Production].[Product] as t1
       -- Учитывайте только продукты с указанным цветом
 where t1.Color is not null 
 group by t1.Color
       -- Только цвета с количеством продуктов больше 1.
having count(t1.ProductID) > 1
      -- Отсортировать рез. набор данных пол количеству продуктов (по убыванию)
order by [prod_qty] desc
;