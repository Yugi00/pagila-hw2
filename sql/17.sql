/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */
SELECT 
rank,
title,
revenue,
SUM(revenue) OVER (ORDER BY rank) AS "total revenue"
FROM (
    SELECT title,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS rank
    FROM (
        SELECT film.title,
        COALESCE(SUM(payment.amount), 0.00) AS revenue
        FROM film
        LEFT JOIN inventory ON film.film_id = inventory.film_id
        LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
        LEFT JOIN payment ON rental.rental_id = payment.rental_id
        GROUP BY film.title
    ) AS subquery
) AS outer_query
ORDER BY revenue desc, title;

