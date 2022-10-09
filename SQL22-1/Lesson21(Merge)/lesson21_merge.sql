-- DML - MERGE 
-- Runs insert, update, or delete operations on a target table from the results of a join with a source table

-- Change the database context
USE [SQL221];

-- Create a new schema to demonstrate merge manipulations
GO
CREATE SCHEMA aomelchenko;
GO

-- Create a table to store STAGING data of employee contact information
IF OBJECT_ID('aomelchenko.StgContact', 'U') IS NOT NULL DROP TABLE aomelchenko.StgContact;
CREATE TABLE aomelchenko.StgContact(
       [BusinessEntityID] INT,          -- Business entity identification number
	   [EmailAddress]     NVARCHAR(50), -- E-mail address for the person
	   [PhoneNumber]      NVARCHAR(25), -- Telephone number identification number
       [AddressLine1]     NVARCHAR(60), -- First street address line
       [AddressLine2]     NVARCHAR(60)  -- Second street address line
);

-- Insert a few rows into StgContact 
INSERT INTO aomelchenko.StgContact([BusinessEntityID], [EmailAddress], [PhoneNumber], [AddressLine1], [AddressLine2])
VALUES(80, N'sandeep0@adventure-works.com', N'166-555-0156', N'Central Avenue', NULL),
      (81, N'mihail0@adventure-works.com', N'733-555-0128', N'8209 Green View Court', NULL),
	  (82, N'jack1@adventure-works.com', N'521-555-0113', N'8463 Vista Avenue', NULL),
	  (83, N'patrick1@adventure-works.com', N'425-555-0117', N'5379 Treasure Island Way', N'# 14'),
	  (84, N'frank3@adventure-works.com', N'203-555-0196', N'3421 Bouncing Road', NULL);

-- Create a table to store data of employee contact information
IF OBJECT_ID('aomelchenko.Contact', 'U') IS NOT NULL DROP TABLE aomelchenko.Contact;
CREATE TABLE aomelchenko.Contact(
       [BusinessEntityID] INT,                           -- Business entity identification number
	   [EmailAddress]     NVARCHAR(50),                  -- E-mail address for the person
	   [PhoneNumber]      NVARCHAR(25),                  -- Telephone number identification number
       [AddressLine1]     NVARCHAR(60),                  -- First street address line
       [AddressLine2]     NVARCHAR(60),                  -- Second street address line
	   [ModifiedDate]     DATETIME DEFAULT SYSDATETIME() -- Date and time the record was last updated

);

-- Insert  a few rows into Contact
INSERT INTO aomelchenko.Contact([BusinessEntityID], [EmailAddress], [PhoneNumber], [AddressLine1], [AddressLine2])
VALUES(80, N'sandeep0@adventure-works.com', N'166-555-0156', N'Central Avenue', NULL),
      (81, N'mihail0@adventure-works.com', N'733-555-0128', N'8209 Green View Court', NULL),
	  (82, N'jack1@adventure-works.com', N'521-555-0113', N'8463 Vista Avenue', NULL),
	  (85, N'brian2@adventure-works.com', N'730-555-0117', N'991 Vista Verde', NULL);


-- Create a table to store audit logs
IF OBJECT_ID('aomelchenko.AuditLog', 'U') IS NOT NULL DROP TABLE aomelchenko.AuditLog;
CREATE TABLE aomelchenko.AuditLog(
       logID           BIGINT IDENTITY(1, 1),
	   [Action]        CHAR(6),
	   oldEmailAddress NVARCHAR(50),
	   newEmailAddress NVARCHAR(50),
	   oldPhoneNumber  NVARCHAR(25),
	   newPhoneNumber  NVARCHAR(25),
	   oldAddressLine1 NVARCHAR(60),
	   newAddressLine1 NVARCHAR(60),
	   oldAddressLine2 NVARCHAR(60),
	   newAddressLine2 NVARCHAR(60),
	   oldModifiedDate DATETIME,
	   newModifiedDate DATETIME
);

SELECT * FROM aomelchenko.StgContact;
SELECT * FROM aomelchenko.Contact;
--====================================================================================================
GO
INSERT INTO aomelchenko.AuditLog([Action], oldEmailAddress, newEmailAddress, oldPhoneNumber, 
newPhoneNumber, oldAddressLine1, newAddressLine1, oldAddressLine2, newAddressLine2, oldModifiedDate, newModifiedDate)
SELECT M.*
  FROM (
		MERGE aomelchenko.Contact as tgt
		USING aomelchenko.StgContact as src		
		   ON tgt.BusinessEntityID = src.[BusinessEntityID]
		 WHEN MATCHED THEN
		UPDATE 
		   SET tgt.[EmailAddress] = src.[EmailAddress],
			   tgt.[PhoneNumber] = src.[PhoneNumber],
			   tgt.[AddressLine1] = src.[AddressLine1],
			   tgt.[AddressLine2] = src.[AddressLine2],
			   tgt.[ModifiedDate] = SYSDATETIME()
		WHEN NOT MATCHED THEN
		INSERT([BusinessEntityID], [EmailAddress], [PhoneNumber], [AddressLine1], [AddressLine2])
		VALUES(src.[BusinessEntityID], src.[EmailAddress], src.[PhoneNumber], src.[AddressLine1], src.[AddressLine2])
		WHEN NOT MATCHED BY SOURCE THEN
		DELETE
		OUTPUT $action                 as [action], 
			   deleted.[EmailAddress]  as oldEmailAddress,
			   inserted.[EmailAddress] as newEmailAddress,
			   deleted.[PhoneNumber]   as oldPhoneNumber,
			   inserted.[PhoneNumber]  as newPhoneNumber,
			   deleted.[AddressLine1]  as oldAddressLine1,
			   inserted.[AddressLine1] as newAddressLine1,
			   deleted.[AddressLine2]  as oldAddressLine2,
			   inserted.[AddressLine2] as newAddressLine2,
			   deleted.[ModifiedDate]  as oldModifiedDate,
			   inserted.[ModifiedDate] as newModifiedDate
) AS M;


SELECT * FROM aomelchenko.StgContact;
SELECT * FROM aomelchenko.Contact;
SELECT * FROM aomelchenko.AuditLog;
/*
Реализовать процесс актуализации информации о сотрудниках.
Таблица <YOUR_SCHEMA>.stgEmployee([BusinessEntityID], [NationalIDNumber],
[MaritalStatus], [Gender], [HireDate], [CurrentFlag], [SickLeaveHours], [VacationHours])
Хранит промежуточную информацию о сотрудниках. 
Таблица <YOUR_SCHEMA>.Employee ([BusinessEntityID], [NationalIDNumber],
[MaritalStatus], [Gender], [HireDate], [CurrentFlag], [SickLeaveHours], [VacationHours], [ModifiedDate])
Хранит данные о сотрудниках на сейчас. С помощью dml оператора MERGE, реализовать процесс слияния данных.
Продемонстрировать ключевые возможности MERGE с помощью синтезированных данных.

Задача 2
Внести строки OUTPUT В таблицу AuditLog
*/

--=============================================================================================================================================
-- CROSS APPLY
-- OUTER APPLY

-- General sales order information.
SELECT * FROM [Sales].[SalesOrderHeader];
-- Current customer information
SELECT * FROM [Sales].[Customer];



WITH wCustomerID AS 
(	
	SELECT c.CustomerID
	  FROM (VALUES(29825), (29672), (29734), 
	              (29994), (29565), (29898), 
				  (29580), (30052), (29974),
				  (-1)) 
				  as c (CustomerID)
)
/*
SELECT * 
  FROM (
		SELECT c.*,
			   h.SalesOrderID,
			   h.OrderDate,
			   h.OnlineOrderFlag,
			   h.SubTotal,
			   ROW_NUMBER()OVER(PARTITION BY c.CustomerID ORDER BY h.OrderDate DESC)  rwn
		  FROM wCustomerID AS c
		 INNER JOIN [Sales].[SalesOrderHeader]  h ON h.CustomerID = c.CustomerID
) AS r
WHERE r.rwn <= 3;
*/
SELECT c.*,
       ca.*
  FROM wCustomerID c
  CROSS APPLY (SELECT TOP 3 
                      o.SalesOrderID,
					  o.OrderDate,
					  o.OnlineOrderFlag,
					  o.SubTotal
                 FROM [Sales].[SalesOrderHeader] o
				WHERE o.CustomerID = c.CustomerID
				ORDER BY o.OrderDate DESC) AS ca
;



WITH wCustomerID AS 
(	
	SELECT c.CustomerID
	  FROM (VALUES(29825), (29672), (29734), 
	              (29994), (29565), (29898), 
				  (29580), (30052), (29974),
				  (-1)) 
				  as c (CustomerID)
)
SELECT c.*,
       ca.*
  FROM wCustomerID c
  OUTER APPLY (SELECT TOP 3 
                      o.SalesOrderID,
					  o.OrderDate,
					  o.OnlineOrderFlag,
					  o.SubTotal
                 FROM [Sales].[SalesOrderHeader] o
				WHERE o.CustomerID = c.CustomerID
				ORDER BY o.OrderDate DESC) AS ca
;
--==================================================================================================================
/*

*/