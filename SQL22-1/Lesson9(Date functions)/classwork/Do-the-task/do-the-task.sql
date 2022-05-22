-- Do the task to study the date functions
select "ucaseJobTitle" = upper(e.JobTitle),
       "year" = year(e.HireDate),
	   "month" = month(e.HireDate),
	   COUNT(distinct e.BusinessEntityID)
  from [HumanResources].[Employee] e
 group by upper(e.JobTitle),
          year(e.HireDate),
	      month(e.HireDate)
 order by upper(e.JobTitle),
          year(e.HireDate) desc,
		  month(e.HireDate) desc;