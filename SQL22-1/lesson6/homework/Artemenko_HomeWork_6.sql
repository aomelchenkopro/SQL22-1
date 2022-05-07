
--Home work 6 (1/05/2022)
/*  ���������� �������
 	COUNT - ���� ��������
		COUNT(*) - ���-�� ����� � ������
		COUNT(<attribute>)
	SUM - ������������ ��������
		select color,
			 SUM([StandardCost]) as [values_sum],
			SUM(distinct [StandardCost]) as [unique_values_sum]
		from [Production].[Product]
		group by color;
	AVG - ������� ��������
		select p.Color,
			AVG(p.StandardCost),
			AVG(distinct p.StandardCost)
		from [Production].[Product] p
		group by p.Color;
	MIN
		select MIN(p.StandardCost),
			MIN(distinct p.StandardCost)
		from [Production].[Product] p
		where p.StandardCost > 0.00;
	MAX
		select  p.Color,
			MAX(p.StandardCost),
			MAX(distinct p.StandardCost)
		from [Production].[Product] p
		where p.StandardCost > 0.00
		group by  p.Color;

asc  -- ���������� �������� �� �����������
desc -- ���������� �������� �� ��������

--======================================================================================================
�������� ������, ������� � ������� �������������� ����� (CreditCardID) ������: ���-�� �������, 
����� ����� �������, ������������ ����� ������, ����������� ����� ������, ������� ����� ������. 
����� ������ - [SubTotal]. 
�� ���������� ������, � ������� �� ������ �����. ����� (CreditCardID is not null)
- ������������ ������� [Sales].[SalesOrderHeader] 
--  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- ������������� ��������� �� ����� ����� ������ (�� ��������)
*/

use [SQL221];
go

	select s.*
	from [Sales].[SalesOrderHeader] as s
go


	select  s.CreditCardID,
		COUNT(s.SalesOrderID) as Qty,
		SUM (s.SubTotal)      as Sum_total,
		MAX (s.SubTotal)      as Sum_max,
		MIN (s.SubTotal)      as Sum_min,
		AVG (s.SubTotal)      as Sum_avg
	from [Sales].[SalesOrderHeader] as s
	where s.CreditCardID is not null
	group by s.CreditCardID
	order by  SUM (s.SubTotal) 
	desc;		