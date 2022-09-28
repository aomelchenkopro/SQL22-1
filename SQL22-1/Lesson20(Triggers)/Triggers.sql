SELECT *
  FROM sys.triggers
 WHERE parent_id = 1893581784;

SELECT *
  FROM sys.tables
 WHERE object_id = 1922105888;

SELECT * 
  FROM sys.schemas
 WHERE SCHEMA_ID = 9;
--=========================================================================================

DELETE FROM [HumanResources].[Employee] WHERE BusinessEntityID = 1;
DELETE FROM [Purchasing].[Vendor] WHERE BusinessEntityID = 1492;


SELECT E.JobTitle,
       COUNT(DISTINCT E.BusinessEntityID)
  FROM [HumanResources].[Employee] E
 GROUP BY E.JobTitle 
ORDER BY 2 DESC;


--=========================================================================================
GO
IF OBJECT_ID('HumanResources.EQuota', 'TR') IS NOT NULL DROP TRIGGER HumanResources.EQuota;
GO
-- The head of a trigger
CREATE TRIGGER HumanResources.EQuota ON [HumanResources].[Employee]
	INSTEAD OF INSERT AS
		-- The body of a trigger
		BEGIN
			IF @@ROWCOUNT > 0
				BEGIN
					DECLARE @COUNT INT;
					    SET @COUNT = (SELECT COUNT(DISTINCT E.BusinessEntityID)
						                FROM [HumanResources].[Employee] E
									   WHERE E.JobTitle = N'Design Engineer'
									     AND E.CurrentFlag = 1);
					IF @COUNT >= 3
						BEGIN
							PRINT('There is a quota. Only three specialists can be hired as Design Engineers');
							RETURN
						END
					ELSE
					BEGIN
						INSERT INTO [HumanResources].[Employee]
						([BusinessEntityID] ,[NationalIDNumber] ,[LoginID] ,[OrganizationNode]
						,[JobTitle] ,[BirthDate] ,[MaritalStatus] ,[Gender] ,[HireDate] ,[SalariedFlag] ,[VacationHours]
					    ,[SickLeaveHours] ,[CurrentFlag] ,[rowguid] ,[ModifiedDate])
						SELECT [BusinessEntityID]
						      ,[NationalIDNumber]
							  ,[LoginID]
							  ,[OrganizationNode]
							  ,[JobTitle]
							  ,[BirthDate]
							  ,[MaritalStatus]
							  ,[Gender]
							  ,[HireDate]
							  ,[SalariedFlag]
							  ,[VacationHours]
							  ,[SickLeaveHours]
							  ,[CurrentFlag]
							  ,[rowguid]
							  ,[ModifiedDate]
						  FROM inserted;
					END

					
				END
		END;
--=========================================================================================
INSERT INTO [HumanResources].[Employee]
(
BusinessEntityID, NationalIDNumber, LoginID, OrganizationNode, JobTitle,
BirthDate, MaritalStatus, Gender, HireDate, SalariedFlag, VacationHours, SickLeaveHours, CurrentFlag, rowguid, 
ModifiedDate
)
VALUES (100006, '578953500', 'adventure-works\jo00', NULL, 'Design Engineer', '19860928', 'S', 'M', '20100227', 0, 92, 55, 1, 'D4CF23D9-21B6-45E4-827C-22890DF037AA', SYSDATETIME())



SELECT *
  FROM [HumanResources].[Employee] E
 WHERE E.JobTitle = N'Design Engineer';


UPDATE [HumanResources].[Employee]
   SET CurrentFlag = 0
 WHERE BusinessEntityID = 5
--=========================================================================================

SELECT SYSTEM_USER, SYSDATETIME();


DECLARE @Action CHAR(1);
SELECT @Action = CASE 
            WHEN EXISTS(SELECT 1 FROM INSERTED) 
             AND EXISTS(SELECT 1 FROM DELETED) THEN 'U'
            WHEN EXISTS(SELECT 1 FROM INSERTED) THEN 'I'
            ELSE 'D' END;

-- [HumanResources].[JobCandidate] - Ян
-- [HumanResources].[Shift] - Стас

-- Update, insert, delete

stas.audit
yan.audit

SELECT USER_NAME(), SYSDATETIME();
--=========================================================================================
select * into Yan.[Customer] from [Sales].[Customer];
Yan.[Customer] add column [CurrentFlag] bit default 1;

Yan.[Customer]
/*
Реализовать триггер, котрый блокирует удаление данных из таблицы Customer.
В случае операции удаления, триггеру выводит сообщение об ошибке - Customers cannot be deleted. They can only be marked as not current.'

*/
--=========================================================================================
select * from [Sales].[SalesOrderDetail]

select SUM(Quantity) from [Production].[ProductInventory] where ProductID = 776

--=========================================================================================
GO
IF OBJECT_ID('Sales.PQTY', 'TR') IS NOT NULL DROP TRIGGER Sales.PQTY;
GO
CREATE TRIGGER Sales.PQTY ON [Sales].[SalesOrderDetail] 
	INSTEAD OF INSERT AS
	BEGIN

		DECLARE @ResComp INT;
		
		WITH UProductID AS
		(
			SELECT DISTINCT 
				   ProductID
			  FROM inserted
		),

	     InvQtyPerProd AS
		(
			SELECT P.ProductID,
				   SUM(P.Quantity) AS TotalQTY
			  FROM uProductID U
		     INNER JOIN [Production].[ProductInventory] P ON P.ProductID = U.ProductID
		     GROUP BY P.ProductID
		),

		OrdQtyPerProd AS
		(
			SELECT I.ProductID,
			       SUM(I.OrderQty) AS OrderQty
		      FROM inserted I 
			 GROUP BY I.ProductID 
		),

		ResComp AS
		(
			SELECT COUNT(*) AS R
			  FROM InvQtyPerProd I
			 INNER JOIN OrdQtyPerProd P ON P.ProductID = I.ProductID
			                             AND P.OrderQty > I.TotalQTY
		)
       SELECT @ResComp = R 
	     FROM ResComp;

	   IF @ResComp = 0
		BEGIN
			INSERT INTO [Sales].[SalesOrderDetail]
			([SalesOrderID], [SalesOrderDetailID], [CarrierTrackingNumber]
			,[OrderQty]  ,[ProductID],[SpecialOfferID],[UnitPrice]
			,[UnitPriceDiscount],[rowguid],[ModifiedDate])
			SELECT [SalesOrderID]
                  ,[SalesOrderDetailID]
                  ,[CarrierTrackingNumber]
                  ,[OrderQty]
                  ,[ProductID]
                  ,[SpecialOfferID]
                  ,[UnitPrice]
                  ,[UnitPriceDiscount]
                  ,[rowguid]
                  ,[ModifiedDate]
			  FROM inserted;

		END
		ELSE 
		PRINT('There is not enough goods');


	END;

INSERT INTO [Sales].[SalesOrderDetail]([SalesOrderID], [rowguid])
VALUES(2323, NEWID( )  )

SalesOrderID	43659
SalesOrderDetailID	
CarrierTrackingNumber	OrderQty	ProductID	SpecialOfferID	UnitPrice	UnitPriceDiscount	LineTotal	rowguid	ModifiedDate
	1	4911-403C-98	1	776	1	2024.994	0.00	2024.994000	B207C96D-D9E6-402B-8470-2CC176C42283	2011-05-31 00:00:00.000
   
    SELECT NEWID ( )  
      
      
      
      
      
      