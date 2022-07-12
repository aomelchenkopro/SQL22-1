/*Напишите запрос, который вернет список товаров (без дубликатов) проведенные самым старшим работником мужского пола, за 2011 год.
Учитывайте вероятность того, что сразу несколько работников могут иметь одну и ту же дату рождения.
Решите задачу двумя способами, с применением CTE (with) и без. Не используйте оператор with ties.
- Используются таблицы: [HumanResources].[Employee], [Sales].[SalesOrderHeader], [Sales].[SalesOrderDetail], [Production].[Product]
- Рез. набор данных содержит идент. товара, наименование товара, цвет товара
- Отсортировать рез. набор данных по цвету товара (по возрастанию), в разрезе цвета по идент. товара (по возрастанию)*/

-- Только вложенный запрос
select ProductID,
       [Name],
	   Color 
    from [Production].[Product]
   where ProductID in (
                        Select distinct ProductID 
						 from [Sales].[SalesOrderDetail]
						 where SalesOrderID in (
						                               Select SalesOrderID
													   from [Sales].[SalesOrderHeader]
													   Where (OrderDate between '20110101' and '20111231 23:59:59')
													   and SalesPersonID = (
													                     select top 1 BusinessEntityID 
																		 from [HumanResources].[Employee]
																		 where Gender = N'M'
																		 order by BirthDate , LoginID)))
	order by color, ProductID

	--- используя времянку(Ну типо вримянки)

	with cte as
	(Select distinct t1.ProductID,
	                 t4.[Name],
					 t4.Color
	 from [Sales].[SalesOrderDetail] as t1
	 join [Sales].[SalesOrderHeader] as t2 on t2.SalesOrderID = t1.SalesOrderID
	                                       and t2.OrderDate between '20110101' and '20111231 23:59:59'
	 join [HumanResources].[Employee] as t3 on t3.BusinessEntityID = t2.SalesPersonID
	                                        and t3.Gender = N'M'
	 join [Production].[Product] as t4 on t4.ProductID = t1.ProductID
	 where t3.BusinessEntityID = (select top 1 BusinessEntityID 
								   from [HumanResources].[Employee]
								  where Gender = N'M'
								   order by BirthDate , LoginID))

     select * from cte
	 order by color, ProductID
