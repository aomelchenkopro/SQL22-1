-- Создание схемы
create schema LEVELUP;

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