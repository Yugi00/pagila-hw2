/*
 * This problem is the same as 05.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 *
 */
select last_name, first_name
from actor
left join customer using(last_name, first_name)
where customer.customer_id is null
order by last_name, first_name;
