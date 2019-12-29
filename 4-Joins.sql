-- JOINS


-- Inner join
SELECT
    a.id id_a,
    a.fruit fruit_a,
    b.id id_b,
    b.fruit fruit_b
FROM
    basket_a a
INNER JOIN basket_b b ON a.fruit = b.fruit;


-- Left Join
-- The left join returns a complete set of rows from the left table with the matching rows if available from the right table.
-- If there is no match, the right side will have null values.
SELECT
    a.id id_a,
    a.fruit fruit_a,
    b.id id_b,
    b.fruit fruit_b
FROM
    basket_a a
LEFT JOIN basket_b b ON a.fruit = b.fruit;


-- Left Outer Join
SELECT
    a.id id_a,
    a.fruit fruit_a,
    b.id id_b,
    b.fruit fruit_b
FROM
    basket_a a
LEFT JOIN basket_b b ON a.fruit = b.fruit
WHERE b.id IS NULL;



-- Right Join
-- If there is no match, the left side will contain null values.
SELECT
    a.id id_a,
    a.fruit fruit_a,
    b.id id_b,
    b.fruit fruit_b
FROM
    basket_a a
RIGHT JOIN basket_b b ON a.fruit = b.fruit;


-- Full outer join
-- The full outer join or full join produces a result set that contains all rows from both the left and right tables,
-- with the matching rows from both sides where available. If there is no match, the missing side contains null values.
SELECT
    a.id id_a,
    a.fruit fruit_a,
    b.id id_b,
    b.fruit fruit_b
FROM
    basket_a a
FULL OUTER JOIN basket_b b ON a.fruit = b.fruit;


SELECT
    a.id id_a,
    a.fruit fruit_a,
    b.id id_b,
    b.fruit fruit_b
FROM
    basket_a a
FULL JOIN basket_b b ON a.fruit = b.fruit
   WHERE a.id IS NULL OR b.id IS NULL;


-- Current Date
SELECT
	tt.source_data, tt.recorded_at as date
FROM
	shubham.tracker_data tt
INNER JOIN
	shubham.trucks t2 ON tt.trcuk_id = t2.id
WHERE
	tt.recorded_at = current_date - 4;


-- INNER JOIN to join 3 tables example
SELECT
   customer.customer_id,
   customer.first_name customer_first_name,
   customer.last_name customer_last_name,
   customer.email,
   staff.first_name staff_first_name,
   staff.last_name staff_last_name,
   amount,
   payment_date
FROM
   customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
INNER JOIN staff ON payment.staff_id = staff.staff_id;


-- Query finds all pair of films that have the same length and where f1 id's not equal to f2 id's
SELECT
    f1.title,
    f2.title,
    f1. length
FROM
    film f1
INNER JOIN film f2 ON f1.film_id <> f2.film_id
AND f1. length = f2. length;




-- CROSS JOIN clause
-- CROSS JOIN to produce the cartesian product of rows in the joined tables.
SELECT
   *
FROM
   T1
CROSS JOIN T2;

-- label | score
-------+-------
-- A     |     1
-- B     |     1
-- A     |     2
-- B     |     2
-- A     |     3
-- B     |     3
-- (6 rows)


-- Natural Join
-- natural join is a join that creates an implicit join based on the same column names in the joined tables
SELECT
   *
FROM
   products
NATURAL JOIN categories;

-- Same with Inner Join
SELECT
   *
FROM
   products
INNER JOIN categories USING (category_id);

