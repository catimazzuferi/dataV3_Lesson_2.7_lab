USE sakila;
#How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT * FROM category;
SELECT * FROM film;
SELECT * from film_category;

SELECT c.name as genre_name , COUNT(distinct fc.film_id) as number_of_movies
FROM sakila.category c
JOIN sakila.film_category fc
ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY c.name ASC;

#Display the total amount rung up by each staff member in August of 2005.

-- rung up = total amount that each staff member entered into the cash register in aug 2005
SELECT *
FROM sakila.staff;
SELECT *
FROM sakila.payment;
-- staff ID is in both tables
SELECT staff.staff_id, staff.first_name, last_name, SUM(payment.amount)
FROM sakila.staff
JOIN sakila.payment
USING (staff_id)
-- ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE "2005-08%"
-- WHERE YEAR(payment.payment_date) = 2005 AND MONTH(payment.payment_date) = 8
GROUP BY staff.staff_id
ORDER BY payment.staff_id ASC;
#Which actor has appeared in the most films?
select first_name, last_name, count(*) as cnt
from sakila.actor a
join sakila.film_actor f on a.actor_id = f.actor_id
group by a.actor_id, a.first_name, a.last_name
order by count(*) desc ;
#Most active customer (the customer that has rented the most number of films)
select * from rental;
SELECT r.customer_id, count(*) as Numero_de_rentas
FROM rental as r
GROUP BY r.customer_id
ORDER BY Numero_de_rentas DESC LIMIT 1;

SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.customer_id) AS rental_counts
FROM sakila.customer
JOIN sakila.rental
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY rental_counts DESC Limit 1;
#Display the first and last names, as well as the address, of each staff member.
select * from staff;
SELECT staff.first_name, last_name, address.address
FROM sakila.staff
JOIN sakila.address
USING (address_id);
#List each film and the number of actors who are listed for that film.
SELECT film.title, COUNT(distinct film_actor.actor_id) AS number_actors
FROM sakila.film
JOIN sakila.film_actor
USING (film_id)
GROUP BY film.title;

#Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT c.last_name, SUM(p.amount) as total_paid
FROM sakila.customer c
JOIN sakila.payment p
USING (customer_id)
GROUP BY c.last_name
ORDER BY c.last_name ASC;

#List the titles of films per category.
SELECT film.title, film_category.category_id as category
FROM sakila.film
JOIN sakila.film_category
USING (film_id);