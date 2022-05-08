SELECT c.last_name,
	   count(distinct c.customer_id) as "qty"
  FROM sakila.customer c
-- where c.address_id !> 10
 group by c.last_name
 order by "qty" desc
 limit 1, 1
 
 
select  f.film_id,
    COUNT(f.rating) as `QTY`
    from sakila.film as f
      where     
      f.length between 50 and 100
      group by f.film_id
    order by  f.film_id   desc;
 

