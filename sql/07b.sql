/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
/*
select distinct title
from film
left join inventory using(film_id)
left join rental using(inventory_id)
left join customer using(customer_id)
left join address using(address_id)
left join city using(city_id)
left join country using(country_id)
where country.country != 'United States'
order by title;


SELECT distinct film.title
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN customer ON rental.customer_id = customer.customer_id
LEFT JOIN address ON customer.address_id = address.address_id
LEFT JOIN city ON address.city_id = city.city_id
LEFT JOIN country ON city.country_id = country.country_id
WHERE country.country != 'United States'
order by film.title;
*/

SELECT DISTINCT film.title
FROM film
JOIN inventory USING(film_id)
LEFT JOIN (
    SELECT DISTINCT country, film_id
    FROM film
    JOIN inventory USING(film_id)
    JOIN rental USING(inventory_id)
    JOIN customer USING(customer_id)
    JOIN address USING(address_id)
    JOIN city USING(city_id)
    JOIN country USING(country_id)
    WHERE country LIKE 'United States'
) c USING(film_id)
WHERE country is NULL;
