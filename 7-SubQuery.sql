SELECT
   film_id,
   title,
   rental_rate
FROM
   film
WHERE
   rental_rate > (
      SELECT
         AVG (rental_rate)
      FROM
         film
   );


-- IN operator
SELECT
   film_id,
   title
FROM
   film
WHERE
   film_id IN (
      SELECT
         inventory.film_id
      FROM
         rental
      INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
      WHERE
         return_date BETWEEN '2005-05-29'
      AND '2005-05-30'
   );

--  EXISTS operator
-- If the subquery returns any row, the EXISTS operator returns true. If the subquery returns no row, the result of EXISTS operator is false.
-- Will only returns true values
SELECT
   first_name,
   last_name
FROM
   customer
WHERE
   EXISTS (
      SELECT
         1
      FROM
         payment
      WHERE
         payment.customer_id = customer.customer_id
   );