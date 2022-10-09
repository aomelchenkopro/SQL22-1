/* Реализовать триггер для проверки количества единиц товара на складе.
Триггер блокирует операцию внесения (insert) данных в таблицу [Sales].[SalesOrderDetail] и выводит сообщение об ошибке,
в случае не достаточного количества.
- Используются таблицы: [Production].[ProductInventory], [Sales].[SalesOrderDetail]*/

--Copy Table
select * into Yan.[salesOrderdetail] from sales.salesOrderdetail
-- select * from Yan.[salesOrderdetail]

--select sum(Quantity) from [Production].[ProductInventory] where productid = 776

--Create triger 
GO 
CREATE TRIGGER Yan.CheckProductSum ON Yan.[salesOrderdetail]
--DROP TRIGGER Yan.CheckProductSum
INSTEAD OF INSERT AS
		-- The body of a trigger
		BEGIN
			IF @@ROWCOUNT > 0
				BEGIN
					DECLARE @SumProduct INT;
					    SET @SumProduct = (Select sum(Quantity)
						                    FROM [Production].[ProductInventory] as T1
									        WHERE productid = (select ProductID
											                   FROM inserted));
									     
					IF @SumProduct < (Select OrderQty from inserted)
						BEGIN
							PRINT('There is a quota. Only three specialists can be hired as Design Engineers');
							RETURN
						END
					ELSE
					BEGIN
						INSERT INTO Yan.[salesOrderdetail]
						([SalesOrderID]
                         ,[SalesOrderDetailID]
                         ,[CarrierTrackingNumber]
                         ,[OrderQty]
                         ,[ProductID]
                         ,[SpecialOfferID]
                         ,[UnitPrice]
                         ,[UnitPriceDiscount]
                         ,[LineTotal]
                         ,[rowguid]
                         ,[ModifiedDate])
						SELECT [SalesOrderID]
                         ,[SalesOrderDetailID]
                         ,[CarrierTrackingNumber]
                         ,[OrderQty]
                         ,[ProductID]
                         ,[SpecialOfferID]
                         ,[UnitPrice]
                         ,[UnitPriceDiscount]
                         ,[LineTotal]
                         ,[rowguid]
                         ,[ModifiedDate]
						  FROM inserted;
					END

					
				END
		END;

select * from Yan.[salesOrderdetail]
Go
INSERT INTO Yan.[salesOrderdetail]
                ([SalesOrderID],[SalesOrderDetailID],[CarrierTrackingNumber] ,[OrderQty],[ProductID] ,[SpecialOfferID],[UnitPrice] ,[UnitPriceDiscount]
 ,[LineTotal],[rowguid],[ModifiedDate])
Values (99999,500,'260F-4DCF-A1',1,776,1,2024,0,2024.994000,NEWID(),GETDATE());