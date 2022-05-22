
  select  [Gender],
          AVG (datediff(year,BirthDate,GETDATE())) as [Age]
    from [HumanResources].[Employee]
    where [JobTitle] like N'%- WC%'
    Group by gender

  select [Gender],
          AVG (datediff(year, BirthDate, sysdatetime()) - case when 100 * month(sysdatetime()) + day(sysdatetime()) < 100 * month(BirthDate) + day(BirthDate) then 1 else 0 end)
   from [HumanResources].[Employee]
   where [JobTitle] like '%- WC%'
   Group by gender
