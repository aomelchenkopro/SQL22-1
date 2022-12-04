use [ChainStore];

SELECT * FROM SYS.TABLES;

SELECT * FROM dbo.PRODUCTS;
SELECT * FROM dbo.SALESREPS;
SELECT * FROM dbo.ORDERS;
SELECT * FROM dbo.OFFICES;
SELECT * FROM dbo.CUSTOMERS;

/*
Напишите скрипт для отмены заказа. 
Отмена заказа предусматривает: Возврат заказанных ед. товара на склад (dbo.PRODUCTS),
возврат суммы стоимости заказа клиенту ([dbo].[CUSTOMERS]), перерасчет суммы текущих продаж 
работника (dbo.SALESREPS) и офиса (dbo.OFFICES), удаление заказа из таблицы заказов (dbo.ORDERS).
Реализовать в виде хранимой процедуры. Входящий параметр - идент. заказа. Сообщить об ошибке в случае
если передан не существующий идент. заказа. Добавить логирование операций.
*/

/*
Напишите скрипт для изменения идент. продукта (MFR, PRODUCT).
Изменение продукта предусматривает:
Step 1
Возврат заказанных ед. товара на склад (dbo.PRODUCTS),
возврат суммы стоимости заказа клиенту ([dbo].[CUSTOMERS]), перерасчет суммы текущих продаж 
работника (dbo.SALESREPS) и офиса (dbo.OFFICES).
Step 2
Перерасчет новой стоимости заказа. Расчёт новой суммы текущих продаж работника и офиса.
Вычитание новой суммы заказа из кредитного лимита клиента.
*/

--===========================================================
SELECT * FROM [dbo].[ORDERS] WHERE ORDER_NUM = 112963;

DECLARE @AMOUNT AS INT;
DECLARE @QTY AS INT;
DECLARE @ORDERNUM AS INT = 112963;


SELECT @AMOUNT = o.AMOUNT,
       @QTY = o.QTY + @AMOUNT
  FROM [dbo].[ORDERS]  o
 WHERE o.ORDER_NUM = @ORDERNUM;

 SELECT @AMOUNT, @QTY;
--===========================================================
/*
Напишите скрипт для изменения идент. продукта (MFR, PRODUCT).
Изменение продукта предусматривает:
Step 1
Возврат заказанных ед. товара на склад (dbo.PRODUCTS),
возврат суммы стоимости заказа клиенту ([dbo].[CUSTOMERS]), перерасчет суммы текущих продаж 
работника (dbo.SALESREPS) и офиса (dbo.OFFICES).
Step 2
Перерасчет новой стоимости заказа. Расчёт новой суммы текущих продаж работника и офиса.
Вычитание новой суммы заказа из кредитного лимита клиента.
*/

/*
Напишите запрос, который вернет идент. наиболее продаваемого производителя (MFR).
Учитывайте только заказы, которые проведены сотрудником с наибольшим количеством заказов и работающим в офисе 
с наибольшим количеством работников.
*/
SELECT * 
  FROM [dbo].[ORDERS]



SELECT TOP 1
       WITH TIES
	   s.REP_OFFICE
  FROM [dbo].[SALESREPS] s
 WHERE s.REP_OFFICE IS NOT NULL
 GROUP BY s.REP_OFFICE
 ORDER BY COUNT(s.EMPL_NUM) DESC


WITH EMPLOYEES AS
(
SELECT s.EMPL_NUM, 
       COUNT(s.EMPL_NUM)OVER(PARTITION BY s.REP_OFFICE) QTY
  FROM [dbo].[SALESREPS] s
),
ORDERS AS
(
SELECT TOP 1 
       WITH TIES
       o.*,
	   COUNT(o.ORDER_NUM)OVER(PARTITION BY o.REP) REP_QTY
  FROM EMPLOYEES s
 INNER JOIN [dbo].[ORDERS] o ON o.REP = s.EMPL_NUM
 ORDER BY s.QTY DESC
 )
 SELECT TOP 1
        WITH TIES
        *
   FROM ORDERS eo
  ORDER BY eo.REP_QTY DESC;
