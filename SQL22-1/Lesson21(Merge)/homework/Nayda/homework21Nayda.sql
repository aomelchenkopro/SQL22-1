/*Напишите запрос для слияния данных двух таблиц [YourSchema].[stgCustomer] и [YourSchema].[Customer].
Удалите строки из target таблицы, которы нет в таблице source.
- Задействуйте инструкцию merge*/
GO

IF OBJECT_ID('Ynayda.stgCustomer') IS NOT NULL DROP TABLE Ynayda.stgCustomer;
CREATE TABLE [Ynayda].[stgCustomer](
	   CustomerID  INT,
       PersonID    INT,
	   StoreID     INT,
	   TerritoryID INT
);
--select * from [Ynayda].[stgCustomer]

INSERT INTO [Ynayda].[stgCustomer](CustomerID, PersonID, StoreID, TerritoryID)
	VALUES(29484, 291, 292, 5),
	      (29485, 293, 294, 4),
		  (29486, 295, 296, 3),
		  (29487, 297, 298, 2),
		  (29488, 299, 300, 9),
		  (29489, 301, 302, 4),
		  (29490, 303, 304, 1),
		  (29491, 305, 306, 5),
		  (29492, 307, 308, 3),
		  (29493, 309, 310, 5);

--select * from [Ynayda].[stgCustomer]


IF OBJECT_ID('Ynayda.Customer') IS NOT NULL DROP TABLE Ynayda.Customer;
CREATE TABLE [Ynayda].[Customer](
	   CustomerID  INT,
       PersonID    INT,
	   StoreID     INT,
	   TerritoryID INT,
	   ModifiedDate DATETIME DEFAULT SYSDATETIME()
);

INSERT INTO [Ynayda].[Customer](CustomerID, PersonID, StoreID, TerritoryID)
	VALUES(29494, 311, 312, 6),
	      (29495, 313, 314, 8);

--select * from [Ynayda].[Customer]

IF OBJECT_ID('Ynayda.AuditLog', 'U') IS NOT NULL DROP TABLE Ynayda.AuditLog;
CREATE TABLE Ynayda.AuditLog(
       logID           BIGINT IDENTITY(1, 1),
	   [Action]        CHAR(6),
	   oldCustomerID   INT,
	   newCustomerID   INT,
       oldPersonID     INT,
	   newPersonID     INT,
	   oldStoreID      INT,
	   newStoreID      INT,
	   oldTerritoryID  INT,
	   newTerritoryID  INT,
	   oldModifiedDate DATETIME,
	   newModifiedDate DATETIME
);
--select * from Ynayda.AuditLog

INSERT INTO Ynayda.AuditLog([Action], oldCustomerID, newCustomerID, oldPersonID, newPersonID, oldStoreID, newStoreID,
oldTerritoryID, newTerritoryID, oldModifiedDate, newModifiedDate)
SELECT M.*
  FROM (
MERGE [Ynayda].[Customer] as tgt
USING [Ynayda].[stgCustomer] as src		
   ON tgt.CustomerID = src.CustomerID
 WHEN MATCHED THEN
 UPDATE 
    SET tgt.CustomerID = src.CustomerID,
	    tgt.PersonID = src.PersonID,
	    tgt.StoreID = src.StoreID,
   	    tgt.TerritoryID = src.TerritoryID,
	    tgt.ModifiedDate = SYSDATETIME()
   WHEN NOT MATCHED THEN
  INSERT(CustomerID, PersonID, StoreID, TerritoryID)
  VALUES(src.CustomerID, src.PersonID, src.StoreID, src.TerritoryID)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE
	OUTPUT $action as [action],
	       deleted.CustomerID as oldCustomerID,
	       inserted.CustomerID as newCustomerID,
           deleted.PersonID as oldPersonID,
	       inserted.PersonID as newPersonID,
	       deleted.StoreID as oldStoreID,
	       inserted.StoreID as newStoreID,
	       deleted.TerritoryID as oldTerritoryID,
	       inserted.TerritoryID as newTerritoryID,
		   deleted.ModifiedDate as oldModifiedDate,
		   inserted.ModifiedDate as newModifiedDate
) as M;

SELECT * FROM Ynayda.stgCustomer;
SELECT * FROM Ynayda.Customer;
SELECT * FROM Ynayda.AuditLog;