 --=====================================Home_work_7(Nayda)================================
 Use SQL221
 --==========================================#1===========================================
 /*Задача 1
Напишите запрос, который вернет первые 100 наиболее молодых сотрудников мужского пола.
- Используется таблица [HumanResources].[Employee]
- Результирующий набор данных содержит: Идент. сотр, Уникальный государственный идентификационный номер, дату рождения
  Описание таблицы можно видеть по ссылке
https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html */

select top 100 e.BusinessEntityID,
               e.NationalIDNumber,
			   e.BirthDate, 
			   datediff(year,e.BirthDate,GETDATE()) as [Age]
 from [HumanResources].[Employee] e
 where Gender = 'M'
 order by BirthDate desc


  --==========================================#2=============================================
/*Задача 2
Напишите запрос, который вернет список уникальных наименований должностей.
Исключите сотрудников, которые состоят в браке и сотрудников с пустым атрибутом OrganizationNode.
- Используется таблица [HumanResources].[Employee]
- Результирующий набор данных содержит: Наименование должности
- Задействуйте оператор DISTINCT
- Отсортируйте результат по наименованию должности (по возрастанию)
  Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html */

select Distinct (e.JobTitle) 
 from [HumanResources].[Employee] e
 where MaritalStatus = 'S'
   and OrganizationNode is not null
   order by e.JobTitle desc

  --==========================================#3=============================================
/*Задача 3
Напишите запрос, который в разрезе должности и пола вернет кол-во часов отпуска и кол-во часов отпуска по болезни
и разницу между ними. Исключите сотрудников с окладом, без участия в коллективном договоре (SalariedFlag != 0). 
Учитывайте только сотрудников на должностях: North American Sales Manager, European Sales Manager, Sales Representative.
Исключите группы строк, у которых кол-во часов отпуска больше или равна кол-ву часов отпуска по болезни (общая сумма в разрезе должности и пола).
- Используется таблица [HumanResources].[Employee]
- Результирующий набор данных содержит: Наименование должности, пол, кол-во часов отпуска, кол-во часов отпуска по болезни, разницу.
- Задействуйте агрегатную функцию SUM
- Отсортируйте результат по разнице (по убыванию)
  Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html */

select e.JobTitle,
       e.Gender,
	   sum (e.VacationHours) as [VacationHours],
	   sum (e.SickLeaveHours) as [SickLeaveHours] ,
	   sum (e.VacationHours) - sum (e.SickLeaveHours) as [Difference]
 from [HumanResources].[Employee] e
 where SalariedFlag <> 0
   and e.JobTitle in
                    ('North American Sales Manager',
					 'European Sales Manager',
					 'Sales Representative')
 group by e.JobTitle,
          e.Gender
 Having sum (e.VacationHours) < sum (e.SickLeaveHours)
 Order by (sum (e.VacationHours) - sum (e.SickLeaveHours)) desc


--==========================================#4=============================================
/* Задача 4
Напишите запрос, который в разрезе идент. территории ([TerritoryID]) вернет кол-во уникальных заказов.
Учитывайте только заказы за октябрь 2011 (year(t1.OrderDate) = 2011  and month(t1.OrderDate) = 10) . 
Исключите заказы размещенные клиентом через сеть (OnlineOrderFlag != 1). 
Уникальный идентификационный номер заказа на продажу(PurchaseOrderNumber) должен начинаться на PO10 или PO20.
- Используется таблица [Sales].[SalesOrderHeader].
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- Результирующий набора данных содержит: идент. территории, кол-во уникальных заказов 
- Отсортируйте результат по кол-ву заказов (по убыванию) */

select s.TerritoryID, 
       count (distinct s.SalesOrderID) as [CountOrder]
 from [Sales].[SalesOrderHeader] s
 where (year(s.OrderDate) = 2011 and month(s.OrderDate) = 10)
   and s.OnlineOrderFlag <> 1
   and (s.PurchaseOrderNumber like 'PO10%' or s.PurchaseOrderNumber like 'PO20%')
 group by s.TerritoryID
 Order by [countOrder] desc

--==========================================#4.1=============================================
/*Задача 4.1
В запросе из задачи 4, замените фукнкции year и month на предикат between.*/

select s.TerritoryID, 
       count (distinct s.SalesOrderID) as [CountOrder]
 from [Sales].[SalesOrderHeader] s
 where s.OrderDate between '20111001' and '20111101'
   and s.OnlineOrderFlag <> 1
   and (s.PurchaseOrderNumber like 'PO10%' or s.PurchaseOrderNumber like 'PO20%')
 group by s.TerritoryID
 Order by [countOrder] desc