use [SQL221];
go

select e.*
from [HumanResources].[Employee] as e
go

/* Задача 1
Напишите запрос, который вернет первые 100 наиболее молодых сотрудников мужского пола.
- Используется таблица [HumanResources].[Employee]
- Результирующий набор данных содержит: Идент. сотр, Уникальный государственный идентификационный номер, дату рождения
  Описание таблицы можно видеть по ссылке
https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html
*/

select	top 100
		with ties
		e.BusinessEntityID,			--идентификатор сотрудника
		e.NationalIDNumber,			--уникальный государственный идентификационный номер сотрудника
		e.BirthDate					--дата рождения сотрудника
from [HumanResources].[Employee] as e 
	where e.Gender = N'M'			--сотрудникимужского пола
	order by e.BirthDate desc;		--результат отсортирован по датам рождения по возрастанию
 go

/* Задача 2
Напишите запрос, который вернет список уникальных наименований должностей.
Исключите сотрудников, которые состоят в браке и сотрудников с пустым атрибутом OrganizationNode.
- Используется таблица [HumanResources].[Employee]
- Результирующий набор данных содержит: Наименование должности
- Задействуйте оператор DISTINCT
- Отсортируйте результат по наименованию должности (по возрастанию)
  Описание таблицы можно видеть по ссылке
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html
*/

select distinct 
       e.JobTitle
from [HumanResources].[Employee] as e
	where	e.MaritalStatus = N'S'		--исключить сотрудников которые состоят в браке 
	and e.OrganizationNode is not null	--исключить сотрудников сотрудников с пустым атрибутом OrganizationNode
	order by e.JobTitle asc;			--отсортировать результат по наименованию должности (по возрастанию)
	go
	   	 

/* Задача 3
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
*/

  select	e.JobTitle,
			e.Gender,
			"vacation_h"=	SUM(e.VacationHours),	--кол-во часов отпуска
			"sick_h"=		SUM(e.SickLeaveHours),	--кол-во часов отпуска по болезни
			"difference_h"=	SUM(e.VacationHours)-SUM(e.SickLeaveHours)	-- разность часов
  from [HumanResources].[Employee] as e
	where	e.SalariedFlag != 0				--Исключите сотрудников с окладом, без участия в коллективном договоре
		and e.JobTitle in (N'North American Sales Manager', N'European Sales Manager', N'Sales Representative')
	group by	e.JobTitle,
				e.Gender
	having sum(e.VacationHours) < sum(e.SickLeaveHours)	--исключить группы строк, у которых кол-во часов отпуска больше или равна кол-ву часов отпуска по болезни 
	order by "difference_h" desc;
go


select s.*
from [Sales].[SalesOrderHeader] as s
go

/* Задача 4
Напишите запрос, который в разрезе идент. территории ([TerritoryID]) вернет кол-во уникальных заказов. Учитывайте только заказы за октябрь 2011 
(year(t1.OrderDate) = 2011  and month(t1.OrderDate) = 10) . 
Исключите заказы размещенные клиентом через сеть (OnlineOrderFlag != 1). 
Уникальный идентификационный номер заказа на продажу(PurchaseOrderNumber) должен начинаться на PO10 или PO20.
- Используется таблица [Sales].[SalesOrderHeader].
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- Результирующий набора данных содержит: идент. территории, кол-во уникальных заказов 
- Отсортируйте результат по кол-ву заказов (по убыванию)
 */

select	s.TerritoryID,
		"orderQty"=COUNT(distinct s.SalesOrderID)	--кол-во уникальных заказов
  from [Sales].[SalesOrderHeader] as s
	 where	year(s.OrderDate) = 2011	--заказы за 2011 год
		and month(s.OrderDate) = 10		--заказы за октябрь
		and s.OnlineOrderFlag != 1		--исключить заказы размещенные клиентом через сеть
		and (s.PurchaseOrderNumber like 'PO10%' or s.PurchaseOrderNumber like 'PO20%')
		--Уникальный идентификационный номер заказа на продажу(PurchaseOrderNumber) должен начинаться на PO10 или PO20
 group by s.TerritoryID
 order by orderQty desc;
 go


/* Задача 4.1
В запросе из задачи 4, замените фукнкции year и month на предикат between.
 */

select	s.TerritoryID,
		"orderQty"=COUNT(distinct s.SalesOrderID)	--кол-во уникальных заказов
  from [Sales].[SalesOrderHeader] as s
	 where	s.OrderDate between '20111001' and '20111101'
	 	and s.OnlineOrderFlag != 1		--исключить заказы размещенные клиентом через сеть
		and (s.PurchaseOrderNumber like 'PO10%' or s.PurchaseOrderNumber like 'PO20%')
		--Уникальный идентификационный номер заказа на продажу(PurchaseOrderNumber) должен начинаться на PO10 или PO20
 group by s.TerritoryID
 order by orderQty desc;
 go

