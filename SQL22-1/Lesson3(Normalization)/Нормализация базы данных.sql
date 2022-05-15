-- Создание схемы
create schema LEVELUP;
go
-- Создание таблицы для хранения данных о клиентах
create table [LEVELUP].[CUSTOMER] (
       [CLIENT_ID]     int                    identity(1, 1) primary key, -- идент. клиента
	   [NAME]          nvarchar(50) not null,                             -- имя 
	   [SURNAME]       nvarchar(50) not null,                             -- фамилия
	   [PATRONYMIC]    nvarchar(50) null,                                 -- отчество
	   [DATE_OF_BIRTH] date         not null                              -- дата рождения
);

-- Создание таблицы для хранения данных о телефонах
create table [LEVELUP].[PHONES] (
       [PHONE_ID]     int identity(1, 1) primary key,           -- идент. телефона
	   [CLIENT_ID]    int          null,                        -- идент. клиента
	   [PHONE_NUMBER] nvarchar(50) not null,                    -- номер телефона        
	   [STATUS]       nchar(1)     not null,                    -- статус
	   [CREATE_DATE]  datetime2    not null default getdate(),  -- дата создания строки 
	   [MODIFY_DATE]  datetime2    not null                     -- дата последнего изменения строки

);

-- Создание таблицы для хранения емейлов
create table [LEVELUP].[EMAILS](
       [EMAIL_ID]     int identity(1, 1) primary key,          -- идент. почты
	   [CLIENT_ID]    int          null,                       -- идент. клиента
	   [EMAIL]        nvarchar(50) not null,                   -- адрес электронной почты      
	   [STATUS]       nchar(1)     not null,                   -- статус
	   [CREATE_DATE]  datetime2    not null default getdate(), -- дата создания строки 
	   [MODIFY_DATE]  datetime2    not null                    -- дата последнего изменения строки     
);

-- Создание таблицы для хранения данных о статусах
create table [LEVELUP].[STATUS](
       [STATUS_ID]   nchar(1) primary key, -- идент. статуса
	   [DESCRIPTION] nvarchar(50) not null -- описание
)

-- Определение внешних ключей
-- Внешний ключ - телефоны --> статусы
alter table [LEVELUP].[PHONES]
	add constraint fk_phone_status foreign key([STATUS]) references [LEVELUP].[STATUS]([STATUS_ID]) -- on delete cascade on update cascade;

-- Внешний ключ - телефоны --> клиенты
alter table [LEVELUP].[PHONES]
	add constraint fk_cust_id foreign key([CLIENT_ID]) references [LEVELUP].[CUSTOMER]([CLIENT_ID]);

-- Внешний ключ - емейлы --> статусы 
alter table [LEVELUP].[EMAILS]
	add constraint fk_emails_status foreign key([STATUS]) references [LEVELUP].[STATUS]([STATUS_ID]);

-- Внешний ключ - емейлы --> клиенты
alter table [LEVELUP].[EMAILS]
	add constraint fk_emails_cust foreign key([CLIENT_ID]) references [LEVELUP].[CUSTOMER]([CLIENT_ID]);
--====================================================================================================================================================================================
-- Нормализация/денормализация базы данных
-- Нормализация - это процесс деления одной универсальной таблицы на множество других с отдельными темами.
-- Денормализация - это процесс совмещения множества отдельных таблиц в одну универсальную таблицу.

---- Формы нормализации:
-- 1nf - Первая форма нормализации 
-- 2nf - Вторая формаци нормализации 
-- 3nf - Третья форма нормализации

-- Процесс нормализации необходим для исключения любых возможных аномалий данных. 
-- Аномалия - процесс изменения данных, который влечет за собой изменение других данных
-- Аномалии данных:
-- Аномалия обновления данных
-- Аномалия удаления данных
-- Аномалия вставки данных
--====================================================================================================================================================================================
-- Переключение контекста БД/ выбор БД
use [SQL 22-1];

-- Создание схемы BCP
go
create schema BCP;
go

-- Создание таблицы для хранения данных офисов
if object_id('[SQL 22-1].[BCP].[Office]', 'U') is not null drop table [BCP].[Office];
create table [BCP].[Office](
       office_id int,           -- идент. Офиса, в котором находится работник
	   city      nvarchar(50),  -- Наименование города, в котором расположен офис
	   region    nvarchar(50)   -- Регион, в котором расположен офис
);

-- Создание таблицы для хранения данных о работниках
if object_id('[SQL 22-1].[BCP].[Employee]', 'U') is not null drop table [BCP].[Employee];
create table [BCP].[Employee](
       emp_id         int,           -- Идент. Сотр.
	   emp_name	      nvarchar(50),  -- Имя работника
	   emp_surname    nvarchar(50),	 -- Фамилия работника
	   emp_patronymic nvarchar(50),  -- Отчество работника
	   job_title	  nvarchar(50),  -- наименование должности
	   office_id      int            --	идент. Офиса, в котором находится работник    
);

-- Создание таблицы для хранения данных о клиентах
if object_id('[SQL 22-1].[BCP].[Customer]', 'U') is not null drop table [BCP].[Customer];
create table [BCP].[Customer](
       cust_id         int,          -- идент. Клиента, который совершил заказ
	   cust_name       nvarchar(50), -- имя клиента
	   cust_surname    nvarchar(50), -- фамилия клиента
	   cust_patronymic nvarchar(50), -- отчество клиента
	   limit           numeric(15,2) -- Сумма доступных средств
);

-- Создание таблицы для хранения данных о продуктах
if object_id('[SQL 22-1].[BCP].[Product]', 'U') is not null drop table [BCP].Product;
create table [BCP].Product(
       mfr_id        char(3),        -- идент. Производителя товара
	   product_id    char(5),        -- идент. Товара
	   [description] nvarchar(50),   -- Детальное описание товара
	   price         numeric(15, 2), -- Цена за ед. товара
	   qty_on_hand   int             -- Кол-во ед. товара на складе
);
		
-- Создание таблицы для хранения данных о производителях
if object_id('[SQL 22-1].[BCP].[Manufacturer]', 'U') is not null drop table [BCP].Manufacturer;
create table [BCP].Manufacturer(
       mfr_id   char(3),     -- идент. Производителя товара
	   mfr_name nvarchar(50) -- Наименование производителя товара
);

-- Создание таблицы для хранения данных о заказах
if object_id('[SQL 22-1].[BCP].[Order]', 'U') is not null drop table [BCP].[Order];
create table [BCP].[Order] (
       order_id   int,             -- Идент. Заказа
	   mfr_id     char(3),         -- идент. Производителя товара
	   product_id char(5),         -- идент. Товара
	   cust_id    int,             -- идент. Клиента, который совершил заказ
	   emp_id     int,             -- идент. работника, который провел заказ
	   qty        int,             -- Кол-во заказанных ед. товара
	   amount     numeric(15, 2)   -- Стоимость заказа
);
--====================================================================================================================================================================================
--====================================================================================================================================================================================						
--====================================================================================================================================================================================
-- Создание схемы BCP
go
create schema LANDING;
go
-- Создание таблицы для хранения данных офисов
if object_id('[SQL 22-1].[LANDING].[Office]', 'U') is not null drop table LANDING.[Office];
create table LANDING.[Office](
       office_id int primary key,              -- идент. Офиса, в котором находится работник
	   city      nvarchar(50) not null unique, -- Наименование города, в котором расположен офис
	   region    nvarchar(50) not null         -- Регион, в котором расположен офис
);

-- Создание таблицы для хранения данных о работниках
if object_id('[SQL 22-1].[LANDING].[Employee]', 'U') is not null drop table LANDING.[Employee];
create table LANDING.[Employee](
       emp_id         int primary key,       -- Идент. Сотр.
	   emp_name	      nvarchar(50) not null, -- Имя работника
	   emp_surname    nvarchar(50) not null, -- Фамилия работника
	   emp_patronymic nvarchar(50) null,     -- Отчество работника
	   job_title	  nvarchar(50) not null, -- наименование должности
	   office_id      int          null      --	идент. Офиса, в котором находится работник  
	   foreign key references LANDING.[Office](office_id)
);

-- Создание таблицы для хранения данных о клиентах
if object_id('[SQL 22-1].[LANDING].[Customer]', 'U') is not null drop table [LANDING].[Customer];
create table [LANDING].[Customer](
       cust_id         int primary key,                 -- идент. Клиента, который совершил заказ
	   cust_name       nvarchar(50) not null,           -- имя клиента
	   cust_surname    nvarchar(50) not null,           -- фамилия клиента
	   cust_patronymic nvarchar(50) null,               -- отчество клиента
	   limit           numeric(15,2) check (limit >= 0) -- Сумма доступных средств
);

-- Создание таблицы для хранения данных о продуктах
if object_id('[SQL 22-1].[LANDING].[Product]', 'U') is not null drop table [LANDING].Product;
create table [LANDING].Product(
       mfr_id        char(3),                                         -- идент. Производителя товара
	   product_id    char(5),                                         -- идент. Товара
	   [description] nvarchar(50)   not null,                         -- Детальное описание товара
	   price         numeric(15, 2) not null check(price >= 0),       -- Цена за ед. товара
	   qty_on_hand   int            not null check(qty_on_hand >= 0), -- Кол-во ед. товара на складе

	   constraint pk_prod primary key(mfr_id, product_id)
);
		
-- Создание таблицы для хранения данных о производителях
if object_id('[SQL 22-1].[LANDING].[Manufacturer]', 'U') is not null drop table [LANDING].Manufacturer;
create table [LANDING].Manufacturer(
       mfr_id   char(3) primary key,     -- идент. Производителя товара
	   mfr_name nvarchar(50) not null,   -- Наименование производителя товара
);

-- Создание таблицы для хранения данных о заказах
if object_id('[SQL 22-1].[LANDING].[Order]', 'U') is not null drop table [LANDING].[Order];
create table [LANDING].[Order] (
       order_id   int primary key,                            -- Идент. Заказа
	   mfr_id     char(3)        not null,                    -- идент. Производителя товара
	   product_id char(5)        not null,                    -- идент. Товара
	   cust_id    int            not null,                    -- идент. Клиента, который совершил заказ
	   emp_id     int            not null,                    -- идент. работника, который провел заказ
	   qty        int            not null check (qty > 0),    -- Кол-во заказанных ед. товара
	   amount     numeric(15, 2) not null check (amount > 0), -- Стоимость заказа

	   constraint fk_order_to_cust foreign key (cust_id) references [LANDING].[Customer](cust_id),
	   constraint fk_order_to_emp foreign key (emp_id) references LANDING.[Employee](emp_id),
	   constraint fk_order_to_prod foreign key(mfr_id, product_id) references [LANDING].Product(mfr_id, product_id)
);
--====================================================================================================================================================================================
--====================================================================================================================================================================================						
--====================================================================================================================================================================================
