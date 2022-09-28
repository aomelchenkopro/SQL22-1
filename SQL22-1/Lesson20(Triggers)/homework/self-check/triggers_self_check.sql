/*
Реализовать триггер для проверки количества единиц товара на складе.
Триггер блокирует операцию внесения (insert) данных в таблицу [Sales].[SalesOrderDetail] и выводит сообщение об ошибке,
в случае не достаточного количества.
- Используются таблицы: [Production].[ProductInventory], [Sales].[SalesOrderDetail]
*/

GO
IF OBJECT_ID('Sales.PQTY', 'TR') IS NOT NULL DROP TRIGGER Sales.PQTY;
GO
CREATE TRIGGER Sales.PQTY ON [Sales].[SalesOrderDetail] 
	INSTEAD OF INSERT AS
	BEGIN

		DECLARE @Result INT;
		
		-- The list of unique product id 
		WITH ID AS
		(   
			SELECT DISTINCT 
				   ProductID
			  FROM inserted
		),
		-- The quantity of product units on the stock per productid 
	     Inventory AS
		(
			SELECT P.ProductID,
				   SUM(P.Quantity) AS TotalQTY
			  FROM ID U
		     INNER JOIN [Production].[ProductInventory] P ON P.ProductID = U.ProductID
		     GROUP BY P.ProductID
		),
		-- The quantity of product units that were ordered per productid 
		Orders AS
		(
			SELECT I.ProductID,
			       SUM(I.OrderQty) AS OrderQty
		      FROM inserted I 
			 GROUP BY I.ProductID 
		),
		-- Compare quantity
		Comparation AS
		(
			SELECT COUNT(*) AS R
			  FROM Inventory I
			 INNER JOIN Orders P ON P.ProductID = I.ProductID
			                             AND P.OrderQty > I.TotalQTY
		)
       SELECT @Result = R 
	     FROM Comparation;

	   IF @Result = 0
		BEGIN
			INSERT INTO [Sales].[SalesOrderDetail]
			([SalesOrderID] ,[CarrierTrackingNumber]
            ,[OrderQty],[ProductID],[SpecialOfferID],[UnitPrice],[UnitPriceDiscount]
            ,[rowguid], [ModifiedDate])
			SELECT [SalesOrderID]
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

--=====================================================================================================================

INSERT INTO [Sales].[SalesOrderDetail]
           ([SalesOrderID]
           ,[CarrierTrackingNumber]
           ,[OrderQty]
           ,[ProductID]
           ,[SpecialOfferID]
           ,[UnitPrice]
           ,[UnitPriceDiscount]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           (43659
           ,'4911-403C-98'
           ,200
           ,776
           ,1
           ,2024.994
           ,0.00
           ,NEWID()
           ,SYSDATETIME())
GO
