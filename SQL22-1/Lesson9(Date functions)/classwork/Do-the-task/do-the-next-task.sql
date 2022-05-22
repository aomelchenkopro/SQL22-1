-- Do the task to study the date functions
select upper(e.Gender) as [gender],
       avg(datediff(year, e.BirthDate, sysdatetime()) - case when 100 * month(sysdatetime()) + day(sysdatetime()) < 100 * month(e.BirthDate) + day(e.BirthDate) then 1 else 0 end) as [averageyear]
  from [HumanResources].[Employee] e
 group by upper(e.Gender);