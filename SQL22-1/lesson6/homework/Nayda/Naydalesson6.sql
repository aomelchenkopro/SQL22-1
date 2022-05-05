---===============================================�� 6============================
/* "�������� ������, ������� � ������� �������������� ����� (CreditCardID) ������: 
���-�� �������,
����� ����� �������,
������������ ����� ������,
����������� ����� ������, 
������� ����� ������. 
����� ������ - [SubTotal]. �� ���������� ������, � ������� �� ������ �����. ����� (CreditCardID is not null)
- ������������ ������� [Sales].[SalesOrderHeader] 
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- ������������� ��������� �� ����� ����� ������ (�� ��������)"
*/

Select s.CreditCardID,
       count (Distinct s.SalesOrderID) as [CountOrder], 
       sum(s.SubTotal) as [TotalSumOrder],
       max(s.SubTotal) as [MaxSumOrder],
       min(s.SubTotal) as [MinSumOrder], 
       AVG(s.SubTotal) as [AVGSumOrder]
 from [Sales].[SalesOrderHeader] s 
 where CreditCardID is not null
 Group by CreditCardID 
 order by [TotalSumOrder] desc