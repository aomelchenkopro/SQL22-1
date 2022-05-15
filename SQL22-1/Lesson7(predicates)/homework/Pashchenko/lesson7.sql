Задача 1
Напишите запрос, который вернет первые 100 наиболее молодых сотрудников мужского пола.
- Используется таблица [HumanResources].[Employee]
- Результирующий набор данных содержит: Идент. сотр, Уникальный государственный идентификационный номер, дату рождения
  Описание таблицы можно видеть по ссылке
https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html

select * from [HumanResources].[Employee]

select top 100
           a.BirthDate,
           a.BusinessEntityID,
           a.NationalIDNumber
      from [HumanResources].[Employee] as a
     where a.Gender = 'M' 
  order by a.BirthDate desc
--===============================
Задача 2
Напишите запрос, который вернет список уникальных наименований должностей.
Исключите сотрудников, которые состоят в браке и сотрудников с пустым атрибутом OrganizationNode.
- Используется таблица [HumanResources].[Employee]
- Результирующий набор данных содержит: Наименование должности
- Задействуйте оператор DISTINCT
- Отсортируйте результат по наименованию должности (по возрастанию)
  Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html

  select * from [HumanResources].[Employee]

    select distinct a.jobtitle
     from           [HumanResources].[Employee] as a
     where          a.MaritalStatus != 'M'
	  and           a.OrganizationNode is not null
  order by          a.jobtitle asc
--=================================
Задача 3
Напишите запрос, который в разрезе должности и пола вернет кол-во часов отпуска и кол-во часов отпуска по болезни
и разницу между ними. Исключите сотрудников с окладом, без участия в коллективном договоре (SalariedFlag != 0). 
Учитывайте только сотрудников на должностях: North American Sales Manager, European Sales Manager, Sales Representative.
Исключите группы строк, у которых кол-во часов отпуска больше или равна кол-ву часов отпуска по болезни (общая сумма в разрезе должности и пола).
- Используется таблица [HumanResources].[Employee]
- Результирующий набор данных содержит: Наименование должности, пол, кол-во часов отпуска, кол-во часов отпуска по болезни, разницу.
- Задействуйте агрегатную функцию SUM
- Отсортируйте результат по разнице (по убыванию)
  Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html

    select * from [HumanResources].[Employee]

   select  a.jobtitle,
           a.gender,
	       sum(a.VacationHours) as [Hours],
	       sum(a.SickLeaveHours) as [Leave],
	       sum(a.VacationHours) - sum(a.SickLeaveHours) as [QTY]
    from   [HumanResources].[Employee] as a
   where   a.SalariedFlag != 0
           and a.JobTitle in (N'North American Sales Manager', N'European Sales Manager', N'Sales Representative')
group by   a.JobTitle,
           a.Gender
  having   sum(a.VacationHours) <= sum(a.SickLeaveHours)
order by   [QTY] desc
--==============================
Задача 4
Напишите запрос, который в разрезе идент. территории ([TerritoryID]) вернет кол-во уникальных заказов. Учитывайте только заказы за октябрь 2011 
(year(t1.OrderDate) = 2011  and month(t1.OrderDate) = 10) . 
Исключите заказы размещенные клиентом через сеть (OnlineOrderFlag != 1).
Уникальный идентификационный номер заказа на продажу(PurchaseOrderNumber) должен начинаться на PO10 или PO20.
- Используется таблица [Sales].[SalesOrderHeader].
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- Результирующий набора данных содержит: идент. территории, кол-во уникальных заказов 
- Отсортируйте результат по кол-ву заказов (по убыванию)

    select * from [Sales].[SalesOrderHeader]

   select distinct [TerritoryID],
   count(distinct a.[SalesOrderID]) as [QTY]
    from  [Sales].[SalesOrderHeader] as a
   where  a.OrderDate between '20111001 00:00:00.00' and '20111031 23:59:59.00'
          and a.OnlineOrderFlag != 1
	      and a.SalesOrderNumber like 'SO44%'
    	  and (a.PurchaseOrderNumber like 'PO10%' or a.PurchaseOrderNumber like 'PO20%')
group by a.[TerritoryID]
order by [Qty] desc;


  select a.[TerritoryID],
count(distinct a.[SalesOrderID]) as [QTY]
    from [Sales].[SalesOrderHeader] as a
   where (year(a.OrderDate) = 2011 
     and month(a.OrderDate) = 10)
	 and a.OnlineOrderFlag != 1
	 and a.SalesOrderNumber like 'SO44%'
	 and (a.PurchaseOrderNumber like 'PO10%' or a.PurchaseOrderNumber like 'PO20%')
group by a.[TerritoryID]
order by [Qty] desc;