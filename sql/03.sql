/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1, you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */

-- subquery
-- select f.film_id, sum(p.amount) as profit
-- from film as f
-- join inventory as i on i.film_id = f.film_id
-- join rental as r on r.inventory_id = i.inventory_id
-- join payment as p on p.rental_id = r.rental_id
-- group by f.film_id
-- order by sum(p.amount) desc
-- limit 5;
--
select distinct customer_id
from customer
join rental using(customer_id)
join inventory using(inventory_id)
join film using(film_id)
where film_id in (
    select film_id
    from (
        select film_id, sum(amount) as profit
        from film
        join inventory using(film_id)
        join rental using(inventory_id)
        join payment using(rental_id)
        group by film_id
        order by sum(amount) desc
        limit 5)
    as most_profit)
order by customer_id;
