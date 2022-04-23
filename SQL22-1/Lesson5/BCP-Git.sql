﻿-- Создание таблицы для хранения данных о должностях (без ограничений целостности данных)
if OBJECT_ID('[BCP].[Title]', 'U') is not null drop table [BCP].[Title];
create table [BCP].[Title](
       TITLE_ID   int,         -- идент. Должности
	   TITLE_NAME nvarchar(50) -- Наименование должности
);

-- bcp SQL221.BCP.Title in C:\Storage\bcp\Title.txt -c -S 159.224.194.250 -U sa -P rLC9s39J7h
--select * from [BCP].[Title];
--truncate table [BCP].[Title];
	
-- Создание таблицы для хранения данных о статусах (без ограничений целостности данных)
if OBJECT_ID('[BCP].[Status]', 'U') is not null drop table [BCP].[Status];
create table [BCP].[Status](
       STATUS_ID   int,         -- идент. Статуса 
	   STATUS_NAME nvarchar(50) -- наименование статуса 
);

-- bcp SQL221.BCP.Status in C:\Storage\bcp\Status.txt -c -S 159.224.194.250 -U sa -P rLC9s39J7h
--select * from [BCP].[Status];
--truncate table [BCP].[Status];

-- Создание таблицы для хранения данных офисов (без ограничений целостности данных)
if OBJECT_ID('[BCP].Office', 'U') is not null drop table [BCP].Office;
create table [BCP].Office(
       REGION_ID       int,          -- идент. Региона в котором работает сотрудник
	   DEP_ID          int,          -- идент. Департамента в котором работает сотрудник
	   DEP_NAME        nvarchar(50), -- Наименование департамента
	   DEP_MANAGER_ID  nvarchar(50)  -- Идент. Руководителя
);

-- bcp SQL221.BCP.Office in C:\Storage\bcp\Office.txt -c -S 159.224.194.250 -U sa -P rLC9s39J7h
-- select * from [BCP].Office;


-- Создание таблицы для хранения данных сотрудников (без ограничений целостности данных)
if OBJECT_ID('[BCP].Employee', 'U') is not null drop table [BCP].Employee;
create table [BCP].Employee(
       EMP_ID      int,          -- Идент. Сотрудника
	   [NAME]      nvarchar(50), -- Имя сотрудника
	   SURNAME     nvarchar(50), -- Фамилия сотрудника
	   MIDDLE_NAME nvarchar(50), -- Отчество сотрудника
	   HIRE_DATE   date,         -- Дата найма сотрудника
	   BIRTH_DATE  date,         -- Дата рождения сотрудника
	   TITLE_ID    int,          -- идент. Должности
	   STATUS_ID   int,          -- идент. Статуса сотрудника
	   MANAGER_ID  int,          -- идент. Руководителя
	   REGION_ID   int,          -- идент. Региона в котором работает сотрудник
	   DEP_ID      int           -- идент. Департамента в котором работает сотрудник
);

-- bcp SQL221.BCP.Employee in C:\Storage\bcp\Employee.txt -c -S 159.224.194.250 -U sa -P rLC9s39J7h
-- select * from [BCP].Employee
-- truncate table [BCP].Employee;

-- Создание таблицы для хранения данных о номерах телефонов (без ограничений целостности данных) 
if OBJECT_ID('[BCP].[Phone]', 'U') is not null drop table [BCP].[Phone];
create table [BCP].[Phone](
       PHONE_ID     int,                       -- Идент. Телефона
	   PHONE        nvarchar(50),              -- Номер телефона
	   PHONE_STATUS int,                       -- Cтатус телефона 
	   CREATE_DATE  datetime default sysdatetime(), -- Дата внесения номера телефона
	   EMP_ID       int                        -- Идент. Почты
);

-- Создание таблицы для хранения данных о адресах электронной почты (без ограничений целостности данных) 
if OBJECT_ID('[BCP].[Email]', 'U') is not null drop table [BCP].[Email];
create table [BCP].[Email](
       EMAIL_ID     int,                       -- Идент. Телефона
	   EMAIL        nvarchar(50),              -- Номер телефона
	   EMAIL_STATUS int,                       -- Cтатус телефона 
	   CREATE_DATE  datetime default sysdatetime(), -- Дата внесения номера телефона
	   EMP_ID       int                        -- Идент. Почты
);
--=======================================================================================LANDING===========================================================================
-- Создание таблицы для хранения данных о должностях (без ограничений целостности данных)
if OBJECT_ID('[LANDING].[Title]', 'U') is not null drop table [LANDING].[Title];
create table [LANDING].[Title](
       TITLE_ID   int,         -- идент. Должности
	   TITLE_NAME nvarchar(50) -- Наименование должности
);

insert into [LANDING].[Title]
select * 
  from [BCP].[Title];

select * from [LANDING].[Title]
	
-- Создание таблицы для хранения данных о статусах (без ограничений целостности данных)
if OBJECT_ID('[LANDING].[Status]', 'U') is not null drop table [LANDING].[Status];
create table [LANDING].[Status](
       STATUS_ID   int,         -- идент. Статуса 
	   STATUS_NAME nvarchar(50) -- наименование статуса 
);

-- Пример инструкции insert into с источником данных - инструкция select
insert into [LANDING].[Status] (STATUS_ID, STATUS_NAME)
select STATUS_ID,
       STATUS_NAME
  from [BCP].[Status];

-- Полноя очистка таблицы (удаление всех строк) в режиме не полного журналирование
truncate table [BCP].[Status];

-- select * from [LANDING].[Status];
-- select * from [BCP].[Status];

-- Создание таблицы для хранения данных офисов (без ограничений целостности данных)
if OBJECT_ID('[LANDING].Office', 'U') is not null drop table [LANDING].Office;
create table [LANDING].Office(
       REGION_ID       int,          -- идент. Региона в котором работает сотрудник
	   DEP_ID          int,          -- идент. Департамента в котором работает сотрудник
	   DEP_NAME        nvarchar(50), -- Наименование департамента
	   DEP_MANAGER_ID  nvarchar(50)  -- Идент. Руководителя
);

insert into [LANDING].Office
select * 
  from BCP.Office;

-- select * from [LANDING].Office;
-- truncate table BCP.Office;
-- select * from BCP.Office;

-- Пример очистки данны в изолированном слое LANDING.
update [LANDING].Office
   set DEP_MANAGER_ID = nullif(DEP_MANAGER_ID, N'None')
;

-- Создание таблицы для хранения данных сотрудников (без ограничений целостности данных)
if OBJECT_ID('[LANDING].Employee', 'U') is not null drop table [LANDING].Employee;
create table [LANDING].Employee(
       EMP_ID      int,          -- Идент. Сотрудника
	   [NAME]      nvarchar(50), -- Имя сотрудника
	   SURNAME     nvarchar(50), -- Фамилия сотрудника
	   MIDDLE_NAME nvarchar(50), -- Отчество сотрудника
	   HIRE_DATE   date,         -- Дата найма сотрудника
	   BIRTH_DATE  date,         -- Дата рождения сотрудника
	   TITLE_ID    int,          -- идент. Должности
	   STATUS_ID   int,          -- идент. Статуса сотрудника
	   MANAGER_ID  int,          -- идент. Руководителя
	   REGION_ID   int,          -- идент. Региона в котором работает сотрудник
	   DEP_ID      int           -- идент. Департамента в котором работает сотрудник
);

insert into [LANDING].Employee
select * 
  from [BCP].Employee;

-- select * from [LANDING].Employee
-- truncate table [BCP].Employee;
-- select * from [BCP].Employee;

-- Создание таблицы для хранения данных о номерах телефонов (без ограничений целостности данных) 
if OBJECT_ID('[LANDING].[Phone]', 'U') is not null drop table [LANDING].[Phone];
create table [LANDING].[Phone](
       PHONE_ID     int,                       -- Идент. Телефона
	   PHONE        nvarchar(50),              -- Номер телефона
	   PHONE_STATUS int,                       -- Cтатус телефона 
	   CREATE_DATE  datetime default sysdatetime(), -- Дата внесения номера телефона
	   EMP_ID       int                        -- Идент. Почты
);

-- Создание таблицы для хранения данных о адресах электронной почты (без ограничений целостности данных) 
if OBJECT_ID('[LANDING].[Email]', 'U') is not null drop table [LANDING].[Email];
create table [LANDING].[Email](
       EMAIL_ID     int,                       -- Идент. Телефона
	   EMAIL        nvarchar(50),              -- Номер телефона
	   EMAIL_STATUS int,                       -- Cтатус телефона 
	   CREATE_DATE  datetime default sysdatetime(), -- Дата внесения номера телефона
	   EMP_ID       int                        -- Идент. Почты
);