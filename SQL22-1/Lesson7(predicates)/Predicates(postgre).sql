select f.status,
       count(distinct f.flight_id) as "qty"
  from bookings.flights f
 where f.flight_id < 1000.00
 group by f.status
 order by "qty" desc
 --limit 2
 OFFSET 0 row fetch next 1 row with ties
 
 
 select count(*)
   from bookings.flights
