use ChainStore;

-- Transactions
-- Транзакция - не делимая с точки зрения воздействия на базу данных единица работы.
-- Транзакция переводит базу данных из одного согласованного состояния в другое.

/*
TCL - язык управления транзакциями
BEGIN TRANSACTION    -- начать транзакцию
SAVE TRANSACTION     -- создать особую точку сохранения транзакции
COMMIT TRANSACTION   -- подтвердить транзакцию
ROLLBACK TRANSACTION -- откатить/ отменить транзакцию
*/

-- Example 1

-- Начало транзакции
BEGIN TRANSACTION

    -- I don't really like ACI products;)
	DELETE FROM [dbo].[ORDERS] WHERE MFR = 'ACI';

	-- Let's create a special save point
	SAVE TRANSACTION ACI_DELETED;

	DELETE FROM [dbo].[ORDERS] WHERE MFR = 'IMM';

	SAVE TRANSACTION IMM_DELETED;

	DELETE FROM [dbo].[ORDERS] WHERE MFR = 'FEA';

	SAVE TRANSACTION FEA_DELETED;

-- Откат транзакции
ROLLBACK TRANSACTION;

-- If there are any open transactions here
SELECT XACT_STATE();


-- Example 2
BEGIN TRAN
	
	UPDATE [dbo].[ORDERS]
	   SET ORDER_DATE = DATEADD(DAY, 1, ORDER_DATE)
	 WHERE ORDER_NUM = 112963

-- Let's confirm the transactions
COMMIT TRANSACTION;

-- IMPLICIT - не явный
SET IMPLICIT_TRANSACTIONS ON;  -- включить не явные транзакции

UPDATE [dbo].[ORDERS]
   SET ORDER_DATE = DATEADD(DAY, 1, ORDER_DATE)
 WHERE ORDER_NUM = 112963;
COMMIT TRANSACTION;

COMMIT TRANSACTION;
ROLLBACK TRANSACTION;

SELECT * FROM [dbo].[ORDERS]
SELECT XACT_STATE();
-- ----------------------------------------------------------------------------


-- Let's set up a new transaction
BEGIN TRANSACTION

    -- Unique number of an order
    DECLARE @ORDER_NUM AS INT;
	    SET @ORDER_NUM = (SELECT COUNT(*) + 1 FROM [dbo].[ORDERS]);

	-- Date when the order was created
	DECLARE @ORDER_DATE AS DATETIME;
	    SET @ORDER_DATE = CURRENT_TIMESTAMP;
	
	-- Number of a customer who ordered the order
	DECLARE @CUST AS INT;
	    SET @CUST = 2103;

	-- Number of an employee who provided the order
	DECLARE @REP AS INT;
	    SET @REP = 105;
    
    -- Code of product manufacturer
	DECLARE @MFR AS CHAR(3);
	    SET @MFR = 'ACI';

	-- Code of the product
	DECLARE @PRODUCT AS CHAR(5);
	    SET @PRODUCT = '41003';

	-- The ordered quantity of products
	DECLARE @QTY AS INT;
	    SET @QTY = 10;

	-- The order cost
	DECLARE @AMOUNT MONEY;
	    SET @AMOUNT = 2400;
   
    -- Subtract order amount
    UPDATE [dbo].[CUSTOMERS]
	   SET CREDIT_LIMIT = (CREDIT_LIMIT - @AMOUNT)
	 WHERE CUST_NUM = @CUST;

	 -- Subtract quantity of products
	 UPDATE [dbo].[PRODUCTS]
	    SET [QTY_ON_HAND] = ([QTY_ON_HAND] - @QTY)
	  WHERE MFR_ID = @MFR
	    AND PRODUCT_ID = @PRODUCT;

	 -- Summarize current sales of the employee
	 UPDATE [dbo].[SALESREPS]
	    SET SALES = (SALES + @AMOUNT)
	  WHERE EMPL_NUM = @REP;

	  -- Summarize current sales of the office
	  UPDATE f
	     SET f.SALES = (f.SALES + @AMOUNT) 
	    FROM [dbo].[OFFICES] f
	   INNER JOIN [dbo].[SALESREPS] s ON s.REP_OFFICE = f.OFFICE
	                                 AND s.EMPL_NUM = @REP

      -- Add the new row to reflect new order
	  INSERT INTO [dbo].[ORDERS]
	  (ORDER_NUM, ORDER_DATE, CUST, REP, MFR, PRODUCT, QTY, AMOUNT)
	  VALUES(@ORDER_NUM, @ORDER_DATE, @CUST, @REP, @MFR, @PRODUCT, @QTY, @AMOUNT);

COMMIT TRANSACTION;

-- ------------------------------------------------------------------------------------------------------------
-- Транзакции обеспечивают многопользовательский доступ к таблицам
/*
Разделяемые блокировки 
Монопольные блокировки
*/

SET IMPLICIT_TRANSACTIONS OFF;

-- Пример разделяемой блокировки
BEGIN TRAN 

	SELECT * 
	  FROM [dbo].[ORDERS]
	 WHERE AMOUNT > 10000;

COMMIT TRANSACTION;


-- Пример монопольной блокировки
BEGIN TRAN 

	UPDATE [dbo].[ORDERS]
       SET ORDER_DATE = DATEADD(DAY, 1, ORDER_DATE)
     WHERE ORDER_NUM = 112963;


ROLLBACK TRANSACTION;
SELECT XACT_STATE();
-- ------------------------------------------------------------------------------------------------------------
-- SET TRANSACTION ISOLATION LEVEL
/*
READ UNCOMMITTED    - 1
READ COMMITTED      - 2
REPEATABLE READ     - 3
SERIALIZABLE        - 5
*/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; -- WITH NOLOCK 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;   -- Решает проблему чернового чтения
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;  -- Решает проблему повторного обновления
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;     -- Решает проблему фантомных строк

BEGIN TRAN

-- 208937.00
SELECT SUM(AMOUNT)
  FROM [dbo].[ORDERS];


ROLLBACK TRANSACTION;
-- ------------------------------------------------------------------------------------------------------------
SELECT XACT_STATE();
-- ------------------------------------------------------------------------------------------------------------
-- Dead locks

-- Tran 1
BEGIN TRAN
UPDATE [dbo].[ORDERS]
   SET ORDER_DATE = DATEADD(DAY, 1, ORDER_DATE);

SELECT * 
  FROM PRODUCTS;


SELECT XACT_STATE();
-- ------------------------------------------------------------------------------------------------------------
/*
Напишите запрос, возвращающий для каждого города наиболее продаваемый (по количеству заказов) товар.
Учитывайте вероятность того что, одно и то же количество заказов могут иметь сразу несколько товаров.
- Используются таблицы PRODUCTS, [dbo].[ORDERS], [dbo].[SALESREPS], [dbo].[OFFICES],
- Задействуйте внутреннее объединение таблицы (синтаксис ANSI SQL-92).
- Задействуйте ранжирующую функцию DENSE_RANK.
- Задействуйте агрегатную функцию COUNT в режиме игнорирующем null.
- Результирующий набор данных содержит город, идентификатор производителя товара, идентификатор товара, описание товара, количество заказов, ранг строки.
*/
SELECT * 
  FROM (
		SELECT f.CITY,
			   p.MFR_ID,
			   p.PRODUCT_ID,
			   p.[DESCRIPTION],
			   COUNT(DISTINCT o.ORDER_NUM) qty,
			   DENSE_RANK()OVER(PARTITION BY f.CITY ORDER BY COUNT(DISTINCT o.ORDER_NUM) DESC) drnk
		  FROM [dbo].[OFFICES] f
		 INNER JOIN [dbo].[SALESREPS] s ON s.REP_OFFICE = f.OFFICE
		 INNER JOIN [dbo].[ORDERS] o ON o.REP = s.EMPL_NUM
		 INNER JOIN [dbo].[PRODUCTS] p ON p.MFR_ID = o.MFR
									  AND p.PRODUCT_ID = o.PRODUCT
		 GROUP BY f.CITY,
				  p.MFR_ID,
				  p.PRODUCT_ID,
				  p.[DESCRIPTION]
		 ) q
  WHERE q.drnk = 1;