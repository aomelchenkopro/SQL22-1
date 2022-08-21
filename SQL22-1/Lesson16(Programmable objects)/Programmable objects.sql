use [SQL221];

-- Программируемые объекты

-- Переменные 
-- Операторы управления потоком кода
-- Циклы
---------------------------------------------------------------------------------------------------------
-- Переменные

-- Package 1
declare @MeaningfulName int; -- Значение по умолчанию - null
    set @MeaningfulName = 1970;

declare @FullName nvarchar(150);
    set @FullName = N'Edgar Frank Codd';
go 

-- Package 2

declare @BusinessEntityID as int = 5;

declare @FullName nvarchar(150);
    set @FullName = (select CONCAT_WS(N' ', p.LastName, p.FirstName, p.MiddleName) 
	                   from [Person].[Person] p
					  where p.BusinessEntityID = @BusinessEntityID);

declare @PersonType nchar(2);
    set @PersonType = (select p.PersonType
	                     from [Person].[Person] p
						where p.BusinessEntityID = @BusinessEntityID);

declare @EmailPromotion as int = 0;
    set @EmailPromotion = (select p.EmailPromotion
	                         from [Person].[Person] p
							where p.BusinessEntityID = @BusinessEntityID);

select @FullName as [FULLNAME], 
       [PERSONTYPE] = @PersonType,
	   [EMAILPROMOTION] = @EmailPromotion
go

-- Package 3
declare @BusinessEntityID as int = 5,
        @FullName         as nvarchar(150),
		@PersonType       as nchar(2),
		@EmailPromotion   as int;

select 
       @FullName = CONCAT_WS(N' ', p.LastName, p.FirstName, p.MiddleName),
       @PersonType = p.PersonType,
	   @EmailPromotion = p.EmailPromotion

  from [Person].[Person] p
 where p.BusinessEntityID = @BusinessEntityID;

select resultmessage = N'The values have been just inserted into the variables',
       @FullName as [FULLNAME], 
       [PERSONTYPE] = @PersonType,
	   [EMAILPROMOTION] = @EmailPromotion;
go
---------------------------------------------------------------------------------------------------------
-- Create a new user's type
CREATE TYPE MyFirstOwnTableType AS TABLE
(
	[group] NVARCHAR(50)    NULL,
	metrics  numeric(15,2)  NULL
);


go
declare @DateFrom as datetime = '20110101 00:00:00';
declare @DateTo as datetime = '20111231 23:59:59';
declare @resultset as table ([group] nvarchar(50), metrics numeric(15,2) );
declare @demonstration_of_owntype as MyFirstOwnTableType;

insert into @demonstration_of_owntype([group], metrics)
select s.[Status],
       Qty = count(distinct s.SalesOrderID)
  from [Sales].[SalesOrderHeader] s
 where s.OrderDate between @DateFrom and @DateTo
group by s.[Status];


insert into @demonstration_of_owntype([group], metrics)
select format(s.OrderDate, 'yyyyMM', 'en-US') as [period],
       average = count(distinct s.SalesOrderID)
  from [Sales].[SalesOrderHeader] s
 where s.OrderDate between @DateFrom and @DateTo
group by format(s.OrderDate, 'yyyyMM', 'en-US');

insert into @demonstration_of_owntype([group], metrics)
select s.CreditCardID,
       total = sum(s.SubTotal)
  from [Sales].[SalesOrderHeader] s
 where s.OrderDate between @DateFrom and @DateTo
group by s.CreditCardID;

select * from @demonstration_of_owntype; 
---------------------------------------------------------------------------------------------------------
-- Ян
use SQL221
 declare @CauntUniqueEmployee int
 set @CauntUniqueEmployee =
                           (select count(distinct BusinessEntityID) 
                             from [HumanResources].[Employee])

select @CauntUniqueEmployee
go;

-- Стас
DECLARE @FullEmployee int
set @FullEmployee = 
                   (
       select count(distinct a1.BusinessEntityID)
       from [HumanResources].[Employee] as a1
      
       )

select @FullEmployee;
---------------------------------------------------------------------------------------------------------
-- Операторы управления потоком кода
-- IF, WHILE

-- IF
go -- divide the code into separate batches
declare @if_last_day_of_year_flag as bit = 0; -- 0 - it's not a last day of a year / 1 - it's the last day of a year
declare @date as date;
    set @date = '20221231';

-- Control-of-Flow operators
if year(@date) < year(dateadd(day, 1, @date))
	begin
		set @if_last_day_of_year_flag = 1;
		print('The first year is less than the second one')
	end
else 
	begin
		if year(@date) = year(dateadd(day, 1, @date))
			begin
				set @if_last_day_of_year_flag = 0;
				print('Years are the same');
			end
	end

print(case @if_last_day_of_year_flag when 1 then 'it is the last day of a year' when 0 then 'it is not a last day of a year' end);
---------------------------------------------------------------------------------------------------------
go
declare @FirstDay as nvarchar(3);
declare @Date as date;
set @date = Getdate();

if year(@date) > year(dateadd(day,-1,@date))
    set @FirstDay = 'yes'
  else 
    set @FirstDay = 'no'
select @FirstDay as [Is it the first day?]
---------------------------------------------------------------------------------------------------------
select case when p.BusinessEntityID = 1 and p.PersonType = 'EM' and NameStyle != 1 then 'Everything is correct' end as [case],
       case p.NameStyle when 0 then 'There is 0' /*else*/ end                                                   as [NameStyle]
       
  from [Person].[Person] p;

---------------------------------------------------------------------------------------------------------
-- Cycles
declare @resultset as table ([number] int);

insert into @resultset([number])
values(1),
      (2),
	  (3),
	  (4),
	  ... 
	  (1000);

insert into @resultset([number])
values(1);

insert into @resultset([number])
values(2);

insert into @resultset([number])
values(3);

insert into @resultset([number])
values(4);


...

insert into @resultset([number])
values(1000);

go
declare @resultset as table ([number] int);
declare @counter as int = 0;

while @counter <= 1000
	begin
	    --------------------------------
		insert into @resultset([number])
		values(@counter);
		-- set @counter += 1
		set @counter = @counter + 1;
		--------------------------------
	end


select * 
  from @resultset;

--Ян
go
declare @MyTable as table ([Number] int);
declare @Counter as int = 5000;

while @Counter >= 1
     begin 
     insert into @MyTable([Number])
  values (@Counter);
  set @Counter -= 1 
 end

select * from @MyTable

-- YYYYMM - 202208
go 
declare @MyTable as table ([Number] int);
declare @period as date = getdate();

while @period <= DATEADD(YEAR,5,getdate())
     begin 
     insert into @MyTable([Number])
  values (format(@period, 'yyyyMM', 'en-US'))
  set @period = DATEADD(MONTH,1,@period)
 end

select * from  @MyTable

--====================================================================================================

--====================================================================================================
declare @resultset as table ([grade] int, number int null);
declare @grade as int = 1000000;

while @grade <= 12000000
	begin

	if @grade = 3000000
		begin
		set @grade += 1000000;
			continue;
			end
			--break;

		insert into @resultset([grade]) 
		values(@grade);
		set @grade += 1000000;

	end

update r
   set number = (select count(distinct q.SalesPersonID)
     from (select s.SalesPersonID
             from [Sales].[SalesOrderHeader] s
            group by s.SalesPersonID
		   having sum(s.SubTotal) <= r.[grade]) q)
  from @resultset r

select * from @resultset order by [grade] asc;


while 
break; -- Прерывание цикла 
continue; -- Прерывание итерации
--====================================================================================================