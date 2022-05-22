select r.inventory_id,
       avg(EXTRACT(DAY FROM r.return_date - r.rental_date)) as "AVG"
  from public.rental r
  group by r.inventory_id
  order by "AVG" desc