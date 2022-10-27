/*Задача №1.
Напишите запрос, возвращающий список имён служащих (без дубликатов), которые совершали заказы в период с 01.01.2008 по 31.03.2008 на продукты компании QSA.
- Используются таблицы SALESREPS, [dbo].[ORDERS].
- Задействуйте внутреннее объединение таблицы (синтаксис ANSI SQL-92).
- Задействуйте предикат between.
- Результирующий набор содержит имя служащего.*/

use Nauda
go 

select distinct t1.NАМЕ 
from [TARGET].[SALESREPS] as t1
join [TARGET].[ORDERS] as t2 on t2.REP = t1.EMPL_NUМ
                             and t2.ORDER_DATE between '20080101' and '20080331 23:59:59'
							 and t2.MFR = N'QSA'

/*Задача №2.
Напишите запрос, возвращающий для клиентов с кредитным лимитом выше 35000 общую сумму заказов на продукты компании 'ACI'.
- Используются таблицы [dbo].[CUSTOMERS], [dbo].[ORDERS].
- Задействуйте внутреннее объединение таблицы (синтаксис ANSI SQL-92).
- Задействуйте агрегатную функцию sum.
- Результирующий набор данных содержит идентификатор клиента, наименование клиента, сумму заказов.*/

use Nauda
go 

select t1.CUST_NUМ,
       t1.COMPANY,
	   sum(t2.AМOUNT) as AmountSum 
 from [TARGET].[CUSTOMERS] as t1
 join [TARGET].[ORDERS] as t2 on t2.CUST = t1.CUST_NUМ
                              and t2.MFR = N'ACI'
where t1.CREDITLIMIT > 35000
group by t1.CUST_NUМ,t1.COMPANY

/*Задача №3.1
Напишите запрос, возвращающий данные самого старшего служащего из восточного региона.
Учитывайте вероятность того что, один и тот же возраст (AGE) может быть сразу у нескольких служащих.
- Используются таблицы [dbo].[SALESREPS], [dbo].[OFFICES].
- Задействуйте внутреннее объединение таблицы (синтаксис ANSI SQL-89).
- Задействуйте скалярный, автономный, вложенный запрос.
- Задействуйте агрегатную функцию MAX.
- Результирующий набор данных содержит идентификатор служащего, должность, имя служащего, цель продаж, текущие продажи.*/

select distinct t1.EMPL_NUМ,
                t1.TITLE,
				t1.NАМЕ,
				sum(t2.[TARGET]) as [TARGET],
				sum(t2.SALES) as SALES
 from [TARGET].[SALESREPS] as t1,
      [TARGET].[OFFICES] as t2
 where t2.REGION = N'Western'
       and t1.AGE = (select Max(age)
	                  from [TARGET].[SALESREPS]
					  where REPOFFICE in (select OFFICE
					                       from [TARGET].[OFFICES]
										   where REGION = N'Western'))
group by t1.EMPL_NUМ,
         t1.TITLE,
		 t1.NАМЕ


/*Задача №3.2
Напишите запрос, возвращающий список заказов за 2008 г, которые обработал (совершил продажу) самый старший служащий из восточного региона.
Учитывайте вероятность того что, один и тот же возраст (AGE) может быть сразу у нескольких служащих.
- Используются таблицы [dbo].[ORDERS], [dbo].[SALESREPS], [dbo].[OFFICES].
- Задействуйте внутреннее объединение таблицы (синтаксис ANSI SQL-92).
- Задействуйте скалярный и табличный автономные, вложенные запросы.
- Результирующий набор данных содержит идентификатор заказа, дату заказа, идентификатор служащего, идентификатор производителя товара, идентификатор товара, сумма заказа.*/



Select t1.ORDER_NUМ,
       t1.ORDER_DATE,
	   t1.REP,
	   t1.MFR,
	   t1.PRODUCT,
	   t1.AМOUNT
from [TARGET].[ORDERS] as t1
join [TARGET].[SALESREPS] as t2 on t2.EMPL_NUМ = t1.REP
                                and t2.EMPL_NUМ in (select distinct EMPL_NUМ
													 from [TARGET].[SALESREPS]
													 where AGE = (select Max(age)
																		  from [TARGET].[SALESREPS]
																		  where REPOFFICE in (select OFFICE
																							   from [TARGET].[OFFICES]
																							   where REGION = N'Western')))
where t1.ORDER_DATE between '20080101' and '20081231 23:59:59';

/*Задача №3.3
Напишите запрос, возвращающий общую сумму заказов по каждому проданному товару за 2008 год, которые обработал (совершил продажу) самый старший служащий из восточного региона.
Учитывайте вероятность того что, один и тот же возраст (AGE) может быть сразу у нескольких служащих.
- Используются таблицы [dbo].[PRODUCTS], [dbo].[ORDERS], [dbo].[SALESREPS], [dbo].[OFFICES].
- Задействуйте внутреннее объединение таблицы (синтаксис ANSI SQL-92).
- Задействуйте скалярный и табличный автономные, вложенные запросы.
- Задействуйте агрегатную функцию SUM.
- Результирующий набор данных содержит идентификатор служащего, идентификатор производителя товара, идентификатор товара, описание товара, общая сумму продаж за 2008 г.*/

Select t1.REP,
       t1.MFR,
       t1.PRODUCT,
	   t2.[DESCRIPTION],
       sum(t1.AМOUNT) as ProductSum
from [TARGET].[ORDERS] as t1
join [TARGET].[PRODUCTS] as t2 on t2.PRODUCT_ID = t1.PRODUCT
                               and t2.MFR_ID = t1.MFR
join [TARGET].[SALESREPS] as t3 on t3.EMPL_NUМ = t1.REP
                                and t3.EMPL_NUМ in (select distinct EMPL_NUМ
													 from [TARGET].[SALESREPS]
													 where AGE = (select Max(age)
																		  from [TARGET].[SALESREPS]
																		  where REPOFFICE in (select OFFICE
																							   from [TARGET].[OFFICES]
																							   where REGION = N'Western')))
where t1.ORDER_DATE between '20080101' and '20081231 23:59:59'
group by t1.REP,
       t1.MFR,
       t1.PRODUCT,
	   t2.[DESCRIPTION]

/*Задача №4.
Напишите запрос, возвращающий для каждого наиболее продаваемый (по количеству заказов) товар.
Учитывайте вероятность того что, одно и то же количество заказов могут иметь сразу несколько товаров.
- Используются таблицы PRODUCTS, [dbo].[ORDERS], [dbo].[SALESREPS], [dbo].[OFFICES],
- Задействуйте внутреннее объединение таблицы (синтаксис ANSI SQL-92).
- Задействуйте ранжирующую функцию DENSE_RANK.
- Задействуйте агрегатную функцию COUNT в режиме игнорирующем null.
- Результирующий набор данных содержит город, идентификатор производителя товара, идентификатор товара, описание товара, количество заказов, ранг строки.*/

select t3.CITY,
       t4.MFR_ID,
	   t4.PRODUCT_ID,
	   t4.[DESCRIPTION],
	   count(t1.ORDER_NUМ),
	   dense_rank()over(partition by t4.PRODUCT_ID order by t3.CITY) as [Rank]
from [TARGET].[ORDERS] as t1
join [TARGET].[SALESREPS] as t2 on t2.EMPL_NUМ = t1.REP
join [TARGET].[OFFICES] as t3 on t3.MGR = t1.REP
join [TARGET].[PRODUCTS] as t4 on t4.PRODUCT_ID = t1.PRODUCT
group by t3.CITY, t4.MFR_ID,t4.PRODUCT_ID,t4.[DESCRIPTION]


/*Задача № 5.
Напишите запрос, возвращающий список товаров, которые не продавались в Chicago.
- Используются таблицы [dbo].[OFFICES], [dbo].[SALESREPS], [dbo].[ORDERS], [dbo].[PRODUCTS].
- Задействуйте внутреннее и внешние обеднения таблицы (синтаксис ANSI SQL-92).
- Результирующий набор данных содержит идентификатор производителя, идентификатор товара, описание товара, цену за единицу, количество на складе.*/

select * 
from [TARGET].[PRODUCTS]
where PRODUCT_ID not in (
							select t1.PRODUCT  
							from [TARGET].[ORDERS] as t1
							join [TARGET].[SALESREPS] as t2 on t2.EMPL_NUМ = t1.REP
							join [TARGET].[OFFICES] as t3 on t3.OFFICE = t2.REPOFFICE
														 and t3.CITY = N'Chicago')


/*Задача № 6.
Создайте хранимую процедуру.
Процедура принимает параметры:
- идентификатор клиента. - 2101
- идентификатор служащего. - 101
- идентификатор производителя. 'ACI'
- идентификатор товара.     -'41001'
- количество единиц. - 10

На первом этапе, процедура проверяет наличие указанного количества единиц товара на складе
далее на втором этапе, проводится расчёт суммы заказа. На третьем этапе, если сумма кредитного лимита компании 
больше или равна сумме заказа - уменьшается количество единиц товара на складе, сумма заказа вычитается из кредитного лимита компании и 
заказ вносится в таблицу заказов.
На четвёртом этапе сумма текущих продаж служащего увеличивается на сумму заказа. На пятом этапе сумма текущих продаж офиса 
данного служащего, увеличивается на сумму заказа. На заключительном этапе процедура выводит сообщение о статусе операции.*/

--Проверка товара и тд


IF OBJECT_ID('[Nauda].[dbo].[Diploma_Procedure]') IS NOT NULL DROP PROCEDURE Diploma_Procedure;
GO
CREATE PROCEDURE Diploma_Procedure
(
    @Cust_num int,
	@EMPL_NUM int,
	@MFR_ID char(3),
	@PRODUCT_ID Char(5),
	@CountProduct int
)
AS BEGIN -- проверяем товар на складе 
	IF @CountProduct <= (SELECT QTY_ON_HAND
							FROM [TARGET].[PRODUCTS]
							where PRODUCT_ID = @PRODUCT_ID
							and MFR_ID = @MFR_ID)
		BEGIN -- расчитываем сумму заказа
		    declare @Price numeric(9,2) 
			set @Price = (Select price 
			              from [TARGET].[PRODUCTS] 
						  where PRODUCT_ID = @PRODUCT_ID
							and MFR_ID = @MFR_ID)
		
		   declare @SumOrder numeric(9,2) 
		   set @SumOrder = @Price * @CountProduct
		   Print @SumOrder
		   

							   IF @SumOrder < (Select CREDITLIMIT
							                   from [TARGET].[CUSTOMERS]
											   where CUST_NUМ = @Cust_num)
							   BEgin
							   update [TARGET].[PRODUCTS] set QTY_ON_HAND = (QTY_ON_HAND - @CountProduct)
							           Where PRODUCT_ID = @PRODUCT_ID
							           and MFR_ID = @MFR_ID -- Уменьшаем остаток товара на складе

							   update [TARGET].[CUSTOMERS] set CREDITLIMIT = (CREDITLIMIT - @SumOrder)
							           Where CUST_NUМ = @Cust_num -- Уменьшаем кредитный лемит компании 

							   --Вносим заказ в таблицу заказов
							   Insert into [TARGET].[ORDERS] ([ORDER_NUМ],[ORDER_DATE],[CUST],[REP],[MFR],[PRODUCT],[QTY],[AМOUNT])
							        values ((select max(ORDER_NUМ)+1 from [TARGET].[ORDERS]),SYSDATETIME(),@Cust_num,@EMPL_NUM,@MFR_ID,@PRODUCT_ID,@CountProduct,@SumOrder); 
							  
							   --Увеличиваем продажи служащего
							    update [TARGET].[SALESREPS] set SALES = (SALES + @SumOrder)
							           Where EMPL_NUМ = @EMPL_NUM 
									   
									   -- Увеличиваем продажи офиса
							             If (Select REPOFFICE from [TARGET].[SALESREPS] where EMPL_NUМ = @EMPL_NUM) is not null
										 begin 
										 Update [TARGET].[OFFICES] set SALES = (SALES + @SumOrder)
										 where OFFICE = (Select REPOFFICE from [TARGET].[SALESREPS] where EMPL_NUМ = @EMPL_NUM)
										 End
							   Print N'Операция успешна'
							   End 
							   Else 
							   Print (N'Недостаточный кредитный лимит у компании')
							   End
		ELSE
			PRINT(N'Недостаточно товаров на складе');
END;
--=============================================================================
execute Diploma_Procedure 2101,101,'ACI','41001',1

