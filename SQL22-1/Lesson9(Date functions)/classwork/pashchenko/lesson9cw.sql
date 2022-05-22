среднее количество лет в разрезе пола

select * from [HumanResources].[Employee]

select  a.Gender,
        a.JobTitle,
		a.BirthDate,
		"DATEDIFF" = datediff(year, a.HireDate, sysdatetime()),

	   "CASE" = case when 100 * month(sysdatetime()) + day(sysdatetime()) < 100 * month(a.HireDate) + day(a.HireDate) then 1 else 0 end
from [HumanResources].[Employee] as a
where a.JobTitle like N'%- wc%'