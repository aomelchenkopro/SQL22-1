/*
������ 1
�������� ������, ������� ������ ������ 100 �������� ������� ����������� �������� ����.
- ������������ ������� [HumanResources].[Employee]
- �������������� ����� ������ ��������: �����. ����, ���������� ��������������� ����������������� �����, ���� ��������
  �������� ������� ����� ������ �� ������
https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html
*/
select top 100
       t1.BusinessEntityID,
       t1.NationalIDNumber,
       t1.BirthDate
  from [HumanResources].[Employee] as t1 
 where t1.Gender = N'M'
 order by t1.BirthDate desc;

/*
������ 2
�������� ������, ������� ������ ������ ���������� ������������ ����������.
��������� �����������, ������� ������� � �����.
- ������������ ������� [HumanResources].[Employee]
- �������������� ����� ������ ��������: ������������ ���������
- ������������ �������� DISTINCT
- ������������ ��������� �� ������������ ��������� (�� �����������)
  �������� ������� ����� ������ �� ������
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html
*/
select distinct 
       t1.JobTitle
  from [HumanResources].[Employee] as t1 
 where t1.MaritalStatus != N'M'
 order by t1.JobTitle asc;

/*
������ 3
�������� ������, ������� � ������� ��������� � ���� ������ ���-�� ����� ������� � ���-�� ����� ������� �� �������
� ������� ����� ����. ��������� ����������� � �������, ��� ������� � ������������ �������� (SalariedFlag != 0). 
��������� ������ �����, � ������� ���-�� ����� ������� ������ ��� ����� ���-�� ����� ������� �� ������� (����� ����� � ������� ��������� � ����).
- ������������ ������� [HumanResources].[Employee]
- �������������� ����� ������ ��������: ������������ ���������, ���, ���-�� ����� �������, ���-�� ����� ������� �� �������, �������.
- ������������ ���������� ������� SUM
- ������������ ��������� �� ������� (�� ��������)
  �������� ������� ����� ������ �� ������
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/HumanResources_Employee_130.html
*/
select t1.JobTitle,
       t1.Gender,
	   sum(t1.VacationHours)                          as [VHours],
	   sum(t1.SickLeaveHours)                         as [SHors],
	   sum(t1.VacationHours) - sum(t1.SickLeaveHours) as [VSDiffQtyHours]
  from [HumanResources].[Employee] as t1
 where t1.SalariedFlag != 0
 group by t1.JobTitle,
          t1.Gender
having sum(t1.VacationHours) < sum(t1.SickLeaveHours)
order by [VSDiffQtyHours] desc;


/*
������ 4
�������� ������, ������� � ������� �����. ���������� ([TerritoryID]) ������ ���-�� ���������� �������. ���������� ������ ������ �� ������� 2011 (year(t1.OrderDate) = 2011  and month(t1.OrderDate) = 10) . 
��������� ������ ����������� �������� ����� ���� (OnlineOrderFlag != 1). ���������� ����������������� ����� ������ �� �������(SalesOrderNumber) ������ ���������� �� %SO44.
- ������������ ������� [Sales].[SalesOrderHeader].
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- �������������� ������ ������ ��������: �����. ����������, ���-�� ���������� ������� 
- ������������ ��������� �� ���-�� ������� (�� ��������)
*/
select t1.[TerritoryID],
       count(distinct t1.[SalesOrderID]) as [orderQty]
  from [Sales].[SalesOrderHeader] as t1
 where year(t1.OrderDate) = 2011 
   and month(t1.OrderDate) = 10
   and t1.OnlineOrderFlag != 1
   and t1.SalesOrderNumber like 'SO44%'
 group by t1.[TerritoryID]
 order by [orderQty] desc;
