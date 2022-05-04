"�������� ������, ������� � ������� �������������� ����� (CreditCardID) 
������: ���-�� �������, ����� ����� �������, ������������ ����� ������, ����������� ����� ������, ������� ����� ������. ����� ������ - [SubTotal].
�� ���������� ������, � ������� �� ������ �����. ����� (CreditCardID is not null)
- ������������ ������� [Sales].[SalesOrderHeader] 
  https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
- ������������� ��������� �� ����� ����� ������ (�� ��������)"				

select * from [Sales].[SalesOrderHeader]

--===== ���-�� �������
select count(CreditCardID) as [qty]
      from [Sales].[SalesOrderHeader]
	 where CreditCardID is not null
  group by CreditCardID
  order by [qty] desc


--=====  ����� ����� �������
select sum(subtotal) as [qty]
     from [Sales].[SalesOrderHeader]
   	where CreditCardID is not null
 group by CreditCardID
 order by [qty] desc

--===== ������������ ����� ������, ����������� ����� ������
select   max(subtotal) as [MAX], 
         min(subtotal) as [MIN]
     from [Sales].[SalesOrderHeader] 
   	where CreditCardID is not null
 group by CreditCardID
 order by [max], [MIN] desc

  select max(subtotal) as [MAX]
     from [Sales].[SalesOrderHeader] 
   	where CreditCardID is not null
 group by CreditCardID
 order by [max] desc

select  min(subtotal) as [MIN]
     from [Sales].[SalesOrderHeader] 
   	where CreditCardID is not null
 group by CreditCardID
 order by [MIN] desc

--===== ������� ����� ������.
select avg(subtotal) as [AVG]
     from [Sales].[SalesOrderHeader] 
	where CreditCardID is not null
 group by CreditCardID
 order by [AVG] desc

select creditcardid,
       count(SalesOrderID) as [countQTY],
        sum(subtotal) as [sumQTY],
	    max(subtotal) as [maxQTY], 
        min(subtotal) as [minQTY],
	    avg(subtotal) as [avgQTY]
	 from [Sales].[SalesOrderHeader] 
	where CreditCardID is not null
 group by CreditCardID
 order by [sumQTY] desc
 ;