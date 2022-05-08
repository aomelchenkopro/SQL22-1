select s.CreditCardID,
        count (distinct s.SalesOrderID) as [count], --- ���. �������
	    sum(s.SubTotal) as [sum],  --- ��������� �������� 
	    max(s.SubTotal) as [max],  --- ����������� �������� 
	    min(s.SubTotal) as [min],  --- ����������� �������� 
	    avg(s.SubTotal) as [avg]   --- ������� �������� 
  from  [Sales].[SalesOrderHeader] as s
  where s.CreditCardID is not null 
 
  group by s.CreditCardID
  order by sum(s.SubTotal) desc;