-----------===========================ClassWork===================
select top 1 
        with ties
	     left([ProductNumber],2) as [Name],
         count (ProductNumber) as [Count] 
		 from [Production].[Product]
group by left([ProductNumber],2)
Order by [Count] desc
