USE [SQL221];

-- Рекурсивное CTE

WITH <NAME> [(<LIST_OF_COLUMNS>)] AS 
(
	-- Закрепленный элемент
	UNION ALL 
	-- Рекурсивный элемент
)
 -- Внешний запрос к CTE
SELECT *
  FROM <NAME>
;
--=============================================================================================================================
DECLARE @EMPL_NUM AS INT;
    SET @EMPL_NUM = 102;

WITH HierarchicalСhain AS
(
	-- Закрепленный элемент
	SELECT t1.[EMPL_NUМ],
	       t1.[МANAGER],
		   t1.[NАМЕ]
	  FROM [aomelchenko].[SALESREPS] t1
     WHERE t1.[EMPL_NUМ] = @EMPL_NUM
	UNION ALL
	-- Рекурсивный элемент
	SELECT t3.[EMPL_NUМ],
	       t3.[МANAGER],
		   t3.[NАМЕ]
		   -- Повторное обращение к CTE
	  FROM HierarchicalСhain t2
	 INNER JOIN [aomelchenko].[SALESREPS] AS t3 ON t3.EMPL_NUМ = t2.МANAGER

)
SELECT * 
  FROM HierarchicalСhain;


--=============================================================================================================================
IF OBJECT_ID('AOMELCHENKO.vWesternEmp', 'V') IS NOT NULL DROP VIEW AOMELCHENKO.vWesternEmp;
GO
CREATE VIEW AOMELCHENKO.vWesternEmp 
AS
-- TOP
SELECT S.* 
  FROM AOMELCHENKO.OFFICES O
 INNER JOIN [aomelchenko].[SALESREPS] S ON S.REPOFFICE = O.OFFICE
 WHERE O.[REGION]  = N'Western'
-- ORDER BY Нет возможности применить без TOP и OFFSET FETCH
-- OFFSET FETCH
;
GO

SELECT * 
  FROM AOMELCHENKO.vWesternEmp
  
ALTER TABLE [aomelchenko].[SALESREPS] 
ADD [LOGIN2] NVARCHAR(50);

UPDATE [aomelchenko].[SALESREPS]
   SET [LOGIN] = 'L000000';

SELECT * FROM [aomelchenko].[SALESREPS] 

EXECUTE sp_refreshview 'AOMELCHENKO.vWesternEmp';

GRANT SELECT ON AOMELCHENKO.vWesternEmp TO USE1;
REVOKE SELECT ON AOMELCHENKO.vWesternEmp TO USE1;

SELECT * 
  FROM AOMELCHENKO.vWesternEmp
 ORDER BY EMPL_NUМ ASC;

--=============================================================================================================================
USE [Nauda];

IF OBJECT_ID('DBO.vwPurchases', 'V') IS NOT NULL DROP VIEW DBO.vwPurchases;
GO
CREATE VIEW DBO.vwPurchases AS
WITH cOrders AS
(
-- Prepare source data
SELECT C.CUST_NUМ,
       C.CREDITLIMIT,
	   O.ORDER_NUМ,
	   P.[DESCRIPTION]
  FROM [TARGET].[CUSTOMERS] C
  LEFT OUTER JOIN [TARGET].[ORDERS] O ON O.[CUST] = C.CUST_NUМ
  FULL OUTER JOIN [TARGET].[PRODUCTS] P ON P.MFR_ID = O.MFR
                                       AND P.PRODUCT_ID = O.PRODUCT
),
cPivot AS
(
SELECT *
  FROM (-- Prepare columns for pivot manipulations
        SELECT co.CUST_NUМ,
               co.CREDITLIMIT,
	           co.ORDER_NUМ,
	           co.[DESCRIPTION]
          FROM cOrders co) Q
  PIVOT(COUNT(Q.ORDER_NUМ) FOR [DESCRIPTION] IN (
[300 - lb Brace],
[500 - lb Brace],
[900- lb Brace],
[Brace Holder],
[Brace Pin],
[Brace Retainer],
[Handle],
[Hinge Pin],
[Housing],
[Left Hinge],
[Motor Mount],
[Plate],
[Ratchet Link],
[Reducer],
[Retainer],
[Right Hinge],
[Size 1 Widget],
[Size 2 Widget],
[Size 3 Widget],
[Size 4 Widget],
[Widget Adjuster],
[Widget Installer],
[Widget Remover]
))P
)
SELECT CREDITLIMIT,
       COUNT(DISTINCT CUST_NUМ) AS [CustQty],
	    SUM([300 - lb Brace])+
		SUM([500 - lb Brace])+
		SUM([900- lb Brace])+
		SUM([Brace Holder])+
		SUM([Brace Pin])+
		SUM([Brace Retainer])+
		SUM([Handle])+
		SUM([Hinge Pin])+
		SUM([Housing])+
		SUM([Left Hinge])+
		SUM([Motor Mount])+
		SUM([Plate])+
		SUM([Ratchet Link])+
		SUM([Reducer])+
		SUM([Retainer])+
		SUM([Right Hinge])+
		SUM([Size 1 Widget])+
		SUM([Size 2 Widget])+
		SUM([Size 3 Widget])+
		SUM([Size 4 Widget])+
		SUM([Widget Adjuster])+
		SUM([Widget Installer])+
		SUM([Widget Remover]) AS TOTAL,
------------------------------------------------------------------------------------
	    SUM([300 - lb Brace]) AS [300 - lb Brace],
		SUM([500 - lb Brace]) AS [500 - lb Brace],
		SUM([900- lb Brace]) AS [900- lb Brace],
		SUM([Brace Holder]) AS [Brace Holder],
		SUM([Brace Pin]) AS [Brace Pin],
		SUM([Brace Retainer]) AS [Brace Retainer],
		SUM([Handle]) AS [Handle],
		SUM([Hinge Pin]) AS [Hinge Pin],
		SUM([Housing]) AS [Housing],
		SUM([Left Hinge]) AS [Left Hinge],
		SUM([Motor Mount]) AS [Motor Mount],
		SUM([Plate]) AS [Plate],
		SUM([Ratchet Link]) AS [Ratchet Link],
		SUM([Reducer]) AS [Reducer],
		SUM([Retainer]) AS [Retainer] ,
		SUM([Right Hinge]) AS [Right Hinge],
		SUM([Size 1 Widget]) AS [Size 1 Widget],
		SUM([Size 2 Widget]) AS [Size 2 Widget],
		SUM([Size 3 Widget]) AS [Size 3 Widget],
		SUM([Size 4 Widget]) AS [Size 4 Widget],
		SUM([Widget Adjuster]) AS [Widget Adjuster],
		SUM([Widget Installer]) AS [Widget Installer],
		SUM([Widget Remover]) AS [Widget Remover]
  FROM cPivot cpi
 WHERE cpi.CUST_NUМ IS NOT NULL
 GROUP BY cpi.CREDITLIMIT
 ;
 GO

GRANT SELECT ON DBO.vwPurchases TO USER1;

SELECT * 
  FROM DBO.vwPurchases 
  ORDER BY TOTAL ASC;


 -- ENCRYPTION - зашифровать исходный код объекта
 -- SCHEMABINDING - контроль доступности задействованных объектов
 -- CHECK OPTION - контроль редактирования данных
GO
IF OBJECT_ID('DBO.vwOffices', 'V') IS NOT NULL DROP VIEW DBO.vwOffices;
GO
CREATE VIEW DBO.vwOffices AS
SELECT F.OFFICE,
       F.CITY,
	   F.REGION,
	   F.MGR,
	   F.SALES,
	   F.TARGET
  FROM DBO.[OFFICES] F 
 WHERE REGION = N'Eastern'
WITH CHECK OPTION
;
GO

SELECT * FROM DBO.vwOffices
EXECUTE sp_refreshview 'DBO.vwOffices';

ALTER TABLE [TARGET].[OFFICES] ADD [LOGIN] NCHAR(50)
ALTER TABLE 

SELECT * FROM [TARGET].[OFFICES]

DELETE FROM DBO.vwOffices WHERE OFFICE  = 11


UPDATE DBO.vwOffices
   SET [REGION] = 'Western'
   where [OFFICE]  = 12;

--=======================================================================================================================
/*
Реализовать просмотр(VIEW), которое возвращает информацию продуктах.
Результирующий набор данных содержит: [MFR_ID], [PRODUCT_ID], [DESCRIPTION], [PRICE], [QTY_ON_HAND],
[LastMonth1], [LastMonth2], [LastMonth3]
*/