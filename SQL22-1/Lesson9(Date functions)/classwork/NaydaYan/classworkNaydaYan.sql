select upper ([JobTitle]),
       YEAR([HireDate]) as [YearHire],
       MONTH([HireDate])as [MountHere],
       Count ([BusinessEntityID]) as cont
  from [HumanResources].[Employee]
 group by upper ([JobTitle]),  YEAR([HireDate]),MONTH([HireDate])