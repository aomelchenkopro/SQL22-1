-- Создать таблицу (в вашей схеме - your_surname ) 
-- Customers (уникальный идент, имя, фамилия, отчество, пол, дата рождения, возраст, номер телефона, электронный адре, адрес проживания)

-- Ян
--============================================================================================================== 
USE [SQL 22-1];
GO

-- Создание схемы - коллекция объектов 
CREATE SCHEMA YAN_NAUDA_22_1;
GO

/*
select *
  from sys.schemas
*/

-- Создание таблицы для хранения данных о клиентах
CREATE TABLE [SQL 22-1].YAN_NAUDA_22_1.CUSTOMERS(
	[ID]           int           NOT NULL, -- уникальный идент
	[NAME]         nvarchar(50)  NULL,     -- имя
	[LAST_NAME]    nvarchar(50)  NULL,     -- фамилия
	[MIDDLE_NAME]  nvarchar(50)  NULL,     -- отчество
	[GENDER]       char(1)       NULL,     -- пол
	[BIRTH_DATE]   date          NULL,     -- дата рождения
	[AGE]          tinyint       NULL,     -- возраст
	[PHONE_NUMBER] nvarchar(50)  NULL,     -- номер телефона
	[EMAIL]        nvarchar(50)  NULL,     -- электронный адрес
	[ADDRESS]      nvarchar(500) NULL      -- адрес проживания

);

select * 
  from YAN_NAUDA_22_1.CUSTOMERS

--==============================================================================================================
-- Стас
GO
CREATE SCHEMA PASHCHENKO;
GO

create table [SQL 22-1].PASHCHENKO.CUSTOMERS (
ID               int,
[NAME]           nvarchar(50),
FAMALY           nvarchar(50),
PATRONYMIC       nvarchar(50),
gender           char(1),     -- F/M
BIRTH            date,
AGE              tinyint,
[PFONE NUMBER]   nvarchar(50),
MAIL             nvarchar(50),
ADRES            nvarchar(50)
);

-- T-SQL
USE [SQL 22-1];

-- Изменение типа данных столбца/ атрибута/ поля
alter table PASHCHENKO.CUSTOMERS
alter column gender int;
--==============================================================================================================
/*
1. Создать схему BCP_<YOUR_SURNAME> - BCP_OMELCHENKO - > BCP_OMELCHENKO.EMPLOYEE
2. Создать таблицу EMPLOYEE в схеме BCP_<YOUR_SURNAME>. Таблица EMPLOYEE хранит данные сотрудников
и состоит из следующих атрибутов: ID - уник. идент. сотрудника, GENDER (M = Male, F = Female) - пол,
MARITALSTATUS - семейное положение (M = Married, S = Single),JOBTITLE - наименование занимаемой должности,
HIREDATE - дата найма, BIRTHDATE - дата рождения.

3. Создать схему HR_<YOUR_SURNAME> - HR_OMELCHENKO -> HR_OMELCHENKO.EMPLOYEE
4. Создать таблицу EMPLOYEE в схеме HR_<YOUR_SURNAME>. Таблица EMPLOYEE хранит данные сотрудников
и состоит из следующих атрибутов: ID - уник. идент. сотрудника, GENDER (M = Male, F = Female) - пол,
MARITALSTATUS - семейное положение (M = Married, S = Single),JOBTITLE - наименование занимаемой должности,
HIREDATE - дата найма, BIRTHDATE - дата рождения.
--==============================================================================================================   
*/
go
-- Создание схемы BCP_
create schema BCP_OMELCHENKO;
go
-- Создание таблицы EMPLOYEE в схеме BCP_OMELCHENKO
create table BCP_OMELCHENKO.EMPLOYEE(
       ID            int,          -- уник. идент. сотрудника
	   GENDER        char(1),      -- пол (M = Male, F = Female)
	   MARITALSTATUS char(1),      -- семейное положение (M = Married, S = Single)
	   JOBTITLE      nvarchar(70), -- наименование занимаемой должности
	   HIREDATE      date,         -- дата найма
	   BIRTHDATE     date          -- дата рождения
);

go
-- Создание схемы HR_
create schema HR_OMELCHENKO;
go
-- Создание таблицы для хранения данных сотрудников в схеме HR_OMELCHENKO
create table HR_OMELCHENKO.EMPLOYEE(
       ID            int,          -- уник. идент. сотрудника
	   GENDER        char(1),      -- пол (M = Male, F = Female)
	   MARITALSTATUS char(1),      -- семейное положение (M = Married, S = Single)
	   JOBTITLE      nvarchar(70), -- наименование занимаемой должности
	   HIREDATE      date,         -- дата найма
	   BIRTHDATE     date          -- дата рождения
);
--==============================================================================================================  
-- Добавление нового столбца в таблицу в таблицу BCP_OMELCHENKO.EMPLOYEE
alter table BCP_OMELCHENKO.EMPLOYEE
add SALARY numeric(9, 2);

-- Добавление нового столбца в таблицу в таблицу HR_OMELCHENKO.EMPLOYEE
alter table HR_OMELCHENKO.EMPLOYEE
add SALARY numeric(9, 2);
--==============================================================================================================
-- Изменение типа данных столбца SALARY в таблице BCP_OMELCHENKO.EMPLOYEE
alter table BCP_OMELCHENKO.EMPLOYEE
alter column SALARY money;

-- Изменение типа данных столбца SALARY в таблице HR_OMELCHENKO.EMPLOYEE
alter table HR_OMELCHENKO.EMPLOYEE
alter column SALARY money;
--==============================================================================================================
-- Удаление столбца SALARY из таблицы BCP_OMELCHENKO.EMPLOYEE
alter table BCP_OMELCHENKO.EMPLOYEE
drop column SALARY;

-- Удаление столбца SALARY из таблицы HR_OMELCHENKO.EMPLOYEE
alter table HR_OMELCHENKO.EMPLOYEE
drop column SALARY;
--==============================================================================================================
-- Удаление таблицы BCP_OMELCHENKO.EMPLOYEE
drop table BCP_OMELCHENKO.EMPLOYEE;

-- Удаление таблицы HR_OMELCHENKO.EMPLOYEE
drop table HR_OMELCHENKO.EMPLOYEE;

-- T-SQL
-- DDL - Data definition language - Язык определения данных
-- CREATE, ALTER, DROP 
/*
ALTER             - Изменения объекта
Collations        - Определяет параметры сортировки текстовых значений
CREATE            - Создание объекта
DROP              - Удаление объекта
DISABLE TRIGGER   - Отключить триггер
ENABLE TRIGGER    - Включить триггер
execute sp_rename N'BCP_OMELCHENKO.EMPLOYEE', N'EMPLOYEE2'  - Переименование объекта
UPDATE STATISTICS - Обновление информации для корректной работы индексов - индекс механимз позволяющий быстро считывать данные из таблицы
TRUNCATE TABLE    - Полное удаление всех данных из таблицы (в режиме не полного журналирования)
*/ 
go
--==============================================================================================================
-- Ограничения целостности данных
-- NOT NULL 
-- NULL значение - пусто 

/*
-- Внесние данных в таблицу [BCP_OMELCHENKO].[EMPLOYEE]
insert into [BCP_OMELCHENKO].[EMPLOYEE] ([ID], [GENDER], [MARITALSTATUS], [JOBTITLE], [HIREDATE], [BIRTHDATE])
values (1, N'F', N'S', N'Designer', '20220327', '19700101');

insert into [BCP_OMELCHENKO].[EMPLOYEE] ([ID])
values (2);

insert into [BCP_OMELCHENKO].[EMPLOYEE] ([ID], [BIRTHDATE])
values (3, '19710203');

insert into [BCP_OMELCHENKO].[EMPLOYEE] ([HIREDATE])
values ('20220326');

select *
  from [BCP_OMELCHENKO].[EMPLOYEE];
*/
--==============================================================================================================

-- drop table BCP_OMELCHENKO.EMPLOYEE;
-- drop table HR_OMELCHENKO.EMPLOYEE;

create table BCP_OMELCHENKO.EMPLOYEE(
       ID            int          not null,         
	   GENDER        char(1)      null,    
	   MARITALSTATUS char(1)      null,      
	   JOBTITLE      nvarchar(70) null, 
	   HIREDATE      date         not null,        
	   BIRTHDATE     date         not null
); 


create table HR_OMELCHENKO.EMPLOYEE(
       ID            int          not null,         
	   GENDER        char(1)      null,    
	   MARITALSTATUS char(1)      null,      
	   JOBTITLE      nvarchar(70) null, 
	   HIREDATE      date         not null,        
	   BIRTHDATE     date         not null       
);
go
--==============================================================================================================
--CHECK
-- drop table BCP_OMELCHENKO.EMPLOYEE;
-- drop table HR_OMELCHENKO.EMPLOYEE;

create table BCP_OMELCHENKO.EMPLOYEE(
       ID            int            not null,         
	   GENDER        char(1)        not null  check(GENDER in ('F', 'M')),        -- F  - Female/ M - Male
	   MARITALSTATUS char(1)        not null  check(MARITALSTATUS in ('S', 'M')), -- M = Married, S = Single 
	   JOBTITLE      nvarchar(70)   null      check(JOBTITLE != ''),
	   HIREDATE      date           not null,        
	   BIRTHDATE     date           not null,
	   SALARY        numeric(15, 2) not null check(SALARY > 0)
); 

-- Внесние данных в таблицу [BCP_OMELCHENKO].[EMPLOYEE]
insert into [BCP_OMELCHENKO].[EMPLOYEE] ([ID], [GENDER], [MARITALSTATUS], [JOBTITLE], [HIREDATE], [BIRTHDATE], SALARY)
values (3, N'F', N'S', N'Designer', '20220327', '19700101', 1500.00);

-- CK__EMPLOYEE__GENDER__247D636F
-- CK__EMPLOYEE__SALARY__2759D01A
-- CK__EMPLOYEE__MARITA__257187A8

--==============================================================================================================
-- Primary key - Обеспечивает логическую целостность сущностей за счет уникальности их значений. Primary key - первичный ключ таблицы
create table BCP_OMELCHENKO.EMPLOYEE(
       ID            int          PRIMARY KEY  identity(1,1),         

	   GENDER        char(1)        not null  check(GENDER in ('F', 'M')),        -- F  - Female/ M - Male
	   MARITALSTATUS char(1)        not null  check(MARITALSTATUS in ('S', 'M')), -- M = Married, S = Single 
	   JOBTITLE      nvarchar(70)   null      check(JOBTITLE != ''),
	   HIREDATE      date           not null,        
	   BIRTHDATE     date           not null,
	   SALARY        numeric(15, 2) not null check(SALARY > 0)
); 
--==============================================================================================================
-- Primary key - Обеспечивает логическую целостность сущностей за счет уникальности их значений
create table BCP_OMELCHENKO.EMPLOYEE(
       ID            int identity(1,1)          not null,         

	   GENDER        char(1)        not null  check(GENDER in ('F', 'M')),        -- F  - Female/ M - Male
	   MARITALSTATUS char(1)        not null  check(MARITALSTATUS in ('S', 'M')), -- M = Married, S = Single 
	   JOBTITLE      nvarchar(70)   null      check(JOBTITLE != ''),
	   HIREDATE      date           not null,        
	   BIRTHDATE     date           not null,
	   SALARY        numeric(15, 2) not null check(SALARY > 0),

	   -- Определение первичного ключа таблицы
	   constraint pkemployee primary key (ID)
); 


-- Внесние данных в таблицу [BCP_OMELCHENKO].[EMPLOYEE]
insert into [BCP_OMELCHENKO].[EMPLOYEE] ([GENDER], [MARITALSTATUS], [JOBTITLE], [HIREDATE], [BIRTHDATE], SALARY)
values ( N'F', N'S', N'Designer', '20220327', '19700101', 1500.00);

select * from [BCP_OMELCHENKO].[EMPLOYEE]

-- PK__EMPLOYEE__3214EC279F5BB9ED
--==============================================================================================================
-- Foreign key - Обеспечивает ссылочную целостность сущностей.

create table BCP_OMELCHENKO.[STATUS](
       STATUS_ID     int  not null primary key identity(1, 1), -- идент. статуса
	   [STATUS]      nchar(1)     not null,
	   [DESCRIPTION] nvarchar(70) not null                     -- описание статуса
);

insert into BCP_OMELCHENKO.[STATUS] ([STATUS], [DESCRIPTION])
values(N'A', N'Active'),
      (N'S', N'Sick '),
	  (N'V', N'Vacation'),
	  (N'F', N'Fired ')--,...
;

insert into BCP_OMELCHENKO.[STATUS] ([STATUS], [DESCRIPTION])
values (N'D', N'Decree')
;

create table BCP_OMELCHENKO.EMPLOYEE(
       ID            int            primary key  identity(1,1),   
	   [NAME]        nvarchar(50)   not null,   
	   GENDER        char(1)        not null  check(GENDER in ('F', 'M')),        -- F  - Female/ M - Male
	   MARITALSTATUS char(1)        not null  check(MARITALSTATUS in ('S', 'M')), -- M = Married, S = Single 
	   JOBTITLE      nvarchar(70)   null      check(JOBTITLE != ''),
	   HIREDATE      date           not null,        
	   BIRTHDATE     date           not null,
	   SALARY        numeric(15, 2) not null check(SALARY > 0),
	   STATUS_ID     int            not null foreign key references BCP_OMELCHENKO.[STATUS] default 1--(STATUS_ID)
	   
	   
	   -- Состояние работника. A - активен, S - Болеет, V - Работник в отпуске, D - Уволен, ...
	                                         -- check([STATUS] in ('A', 'S', 'V', 'F'))
); 

insert into [BCP_OMELCHENKO].[EMPLOYEE] ([NAME], [GENDER], [MARITALSTATUS], [JOBTITLE], [HIREDATE], [BIRTHDATE], SALARY, STATUS_ID)
values (N'Janice', N'F', N'S', N'Tool Designer', '20101223', '19890528', 2400, 4);

-- FK__EMPLOYEE__STATUS__3E3D3572

select * from BCP_OMELCHENKO.[STATUS]

select * from BCP_OMELCHENKO.EMPLOYEE
--==============================================================================================================
-- Unique -альтернативный/ резервный ключ. Обеспечивает уникальность значений, допускает NULL значение но только один раз.
-- В таблице может быть не ограниченное кол-во Unique

drop table BCP_OMELCHENKO.EMPLOYEE;
create table BCP_OMELCHENKO.EMPLOYEE(
       ID            int            primary key  identity(1,1),   
	   [NAME]        nvarchar(50)   not null,   
	   GENDER        char(1)        not null  check(GENDER in ('F', 'M')),        -- F  - Female/ M - Male
	   MARITALSTATUS char(1)        not null  check(MARITALSTATUS in ('S', 'M')), -- M = Married, S = Single 
	   JOBTITLE      nvarchar(70)   null      check(JOBTITLE != ''),
	   HIREDATE      date           not null,        
	   BIRTHDATE     date           not null,
	   SALARY        numeric(15, 2) not null check(SALARY > 0),
	   STATUS_ID     int            not null foreign key references BCP_OMELCHENKO.[STATUS] on delete cascade default 1,--(STATUS_ID)
	   EMAIL         nvarchar(70)    null check((EMAIL like '%@%' and EMAIL NOT like '%.ru')) unique,
	   PHONE         char(13)        null check(PHONE like '+3%'),

	   constraint uqphone unique (PHONE, STATUS_ID)
	   
	   
	   -- Состояние работника. A - активен, S - Болеет, V - Работник в отпуске, F - Уволен, ...
	                                         -- check([STATUS] in ('A', 'S', 'V', 'F'))
); 

select * from BCP_OMELCHENKO.[STATUS];
select * from BCP_OMELCHENKO.EMPLOYEE

DELETE FROM BCP_OMELCHENKO.[STATUS]
 WHERE STATUS_ID = 4
--==============================================================================================================
-- NOT NULL/ NULL
-- PRIMARY KEY
-- FOREIGN KEY -- on delete cascade, on update cascade, on update set null, on update set default
-- UNIQUE
-- CHECK