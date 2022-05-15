-- Создание схемы (коллекция объектов)
create schema [omelchenko];
go
-- Создание таблицы для хранения данных о клиентах
create table [omelchenko].[Customers] (
       [ID]           int           -- идент. клиента
	  ,[NAME]         nvarchar(50)  -- имя 
	  ,[LAST_NAME]    nvarchar(50)  -- фамилия 
	  ,[MIDDLE_NAME]  nvarchar(50)  -- отчество
	  ,[GENDER]       char(1)       -- пол f/m
	  ,[BIRTH_DATE]   date          -- дата рождения
	  ,[AGE]          tinyint       -- кол-во лет
	  ,[PHONE_NUMBER] nvarchar(50)  -- номер телефона
	  ,[EMAIL]        nvarchar(50)  -- адрес электронной почтыы
	  ,[ADDRESS]      nvarchar(500) -- адрес проживания
);
