

-- Функции ранжирования 
-- RANK
-- ROW_NUMBER
-- DENSE_RANK
-- NTILE

USE [SQL221];

WITH R AS
(
	SELECT ROW_NUMBER()over(partition by E.JobTitle/*,..*/ order by E.HireDate desc /*asc*/, E.BusinessEntityID asc /*desc*/) as [Row],
		   E.JobTitle,
		   E.HireDate,
		   RANK()over(partition by E.JobTitle order by E.HireDate) as [Rank],
		   DENSE_RANK()over(partition by E.JobTitle order by E.HireDate) as [Drank],
		   NTILE(4)over(/*partition by */ order by E.HireDate desc) as [N]
	  FROM [HumanResources].[Employee] E
)
SELECT * 
  FROM R
 -- WHERE JobTitle = N'Production Technician - WC10'
 ORDER BY [N] ASC;


-- Функции смещения
-- LAG -- возвращает предыдущую строку относительно текущей строки
-- LEAD -- возвращает следующую строку относительно текущей строки
-- FIRST_VALUE -- возвращает первую строку в группе
-- LAST_VALUE -- возвращает последнюю строку в группе


-- Lag
-- Currency exchange rates.
SELECT CurrencyRateDate,
       FromCurrencyCode,
	   ToCurrencyCode,
       EndOfDayRate,          -- Final exchange rate for the day.
	   LAG(EndOfDayRate, 1, NULL)over(order by CurrencyRateDate asc) as CurrencyRateDatePrev,
	   EndOfDayRate - LAG(EndOfDayRate, 1, NULL)over(order by CurrencyRateDate asc) CurrencyRateDatePrevDiff
  FROM [Sales].[CurrencyRate]
 WHERE ToCurrencyCode = N'EUR'
 ORDER BY CurrencyRateDate ASC;

-- Lead
SELECT CurrencyRateDate,
       FromCurrencyCode,
	   ToCurrencyCode,
       EndOfDayRate,          -- Final exchange rate for the day.
	   LEAD(EndOfDayRate, 1, 0.00)over(order by CurrencyRateDate asc) as CurrencyRateDatePrev,
	   EndOfDayRate - LEAD(EndOfDayRate, 1, 0.00)over(order by CurrencyRateDate asc) CurrencyRateDatePrevDiff
  FROM [Sales].[CurrencyRate]
 WHERE ToCurrencyCode = N'FRF'
 ORDER BY CurrencyRateDate ASC;


 select distinct ToCurrencyCode from [Sales].[CurrencyRate]


 -- FIRST_VALUE AND LAST VALUE
SELECT CurrencyRateDate,
       FromCurrencyCode,
       ToCurrencyCode,
       EndOfDayRate,
       FIRST_VALUE(EndOfDayRate)OVER(PARTITION BY ToCurrencyCode ORDER BY CurrencyRateDate ASC
	   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS FV,
	   LAST_VALUE(EndOfDayRate)OVER(PARTITION BY ToCurrencyCode ORDER BY CurrencyRateDate ASC 
	   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LV
  FROM [Sales].[CurrencyRate]
 ORDER BY ToCurrencyCode, CurrencyRateDate;

 -- 3.5501


WITH LV AS
(
 SELECT CurrencyRateDate,
       FromCurrencyCode,
       ToCurrencyCode,
       EndOfDayRate,

	   LAST_VALUE(EndOfDayRate)OVER(PARTITION BY ToCurrencyCode ORDER BY CurrencyRateDate ASC 
	   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LV,

	   EndOfDayRate-
	   LAST_VALUE(EndOfDayRate)OVER(PARTITION BY ToCurrencyCode ORDER BY CurrencyRateDate ASC 
	   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LFDIF
  FROM [Sales].[CurrencyRate]
),
D AS 
(
SELECT *,
       DENSE_RANK()OVER(PARTITION BY ToCurrencyCode ORDER BY LFDIF DESC) db,
	   DENSE_RANK()OVER(PARTITION BY ToCurrencyCode ORDER BY LFDIF ASC)  dl
  FROM LV

)
SELECT CurrencyRateDate,
       FromCurrencyCode,
	   ToCurrencyCode,
	   EndOfDayRate,
	   LV,
	   LFDIF,
	   case db when 1 then 'Biggest' End,
	   case dl when 1 then 'Smallest' end
  FROM D
 WHERE (db = 1 OR dl = 1)
   AND ToCurrencyCode != N'USD'
 ORDER BY ToCurrencyCode, CurrencyRateDate;
 
--======================================================================================
-- COUNT
-- AVG
-- SUM
-- MAX
-- MIN

WITH O AS
(
SELECT
       H.SalesOrderID,
	   D.ProductID,
	   H.OrderDate,
	   D.OrderQty
  FROM [Sales].[SalesOrderHeader] H
 INNER JOIN [Sales].[SalesOrderDetail] D ON D.SalesOrderID = H.SalesOrderID
) 
SELECT * 
  FROM O AS O2
 WHERE O2.ProductID IN (SELECT TOP 1
                               WITH TIES
                               O1.ProductID
                          FROM O AS O1
                         GROUP BY O1.ProductID
                         ORDER BY SUM(O1.OrderQty) DESC);


SELECT TOP 1
       WITH TIES
       H.SalesOrderID,
	   D.ProductID,
	   H.OrderDate,
	   D.OrderQty
  FROM [Sales].[SalesOrderHeader] H
 INNER JOIN [Sales].[SalesOrderDetail] D ON D.SalesOrderID = H.SalesOrderID
 ORDER BY SUM(D.OrderQty)OVER(PARTITION BY D.ProductID) DESC;


SELECT YEAR(OrderDate),
       SubTotal,
	   SUM(SubTotal)OVER(/*PARTITION BY YEAR(OrderDate)*/ ORDER BY YEAR(OrderDate) ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
  FROM [Sales].[SalesOrderHeader]
 ORDER BY YEAR(OrderDate);



 110010405.9179

 12621106.5923
 SELECT 

	   SUM(SubTotal)
  FROM [Sales].[SalesOrderHeader]

  SELECT 184590.1346+185884.3875
  
 SELECT 
       YEAR(OrderDate),
	   SUM(SubTotal)
  FROM [Sales].[SalesOrderHeader]
 GROUP BY YEAR(OrderDate)


 select top 1 with ties
       salesorderid,
    orderdate,
       year(orderdate),
       count(SalesOrderID)Over(partition by year(orderdate))
from [Sales].[SalesOrderHeader] 
order by count(SalesOrderID)Over(partition by year(orderdate)) desc