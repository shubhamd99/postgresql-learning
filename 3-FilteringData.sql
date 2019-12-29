-- PostgreSQL WHERE

-- AND
SELECT
   last_name,
   first_name
FROM
   customer
WHERE
   first_name = 'Jamie'
AND last_name = 'Rice';

--OR
SELECT
   first_name,
   last_name
FROM
   customer
WHERE
   last_name = 'Rodriguez' OR 
   first_name = 'Adam';

-- IN
SELECT
   first_name,
   last_name
FROM
   customer
WHERE 
   first_name IN ('Ann','Anne','Annie');

-- LIKE
SELECT
   name,
   age
FROM
   shubham.CUSTOMERS
WHERE 
   name LIKE 'Ra%'


-- WHERE clause with the BETWEEN operator example
SELECT
   first_name,
   LENGTH(first_name) name_length
FROM
   customer
WHERE 
   first_name LIKE 'A%' AND
   LENGTH(first_name) BETWEEN 3 AND 5
ORDER BY
   name_length;


-- WHERE First name starts with Shu and last name is not Motley:
SELECT 
   first_name, 
   last_name
FROM 
   customer 
WHERE 
   first_name LIKE 'Shu%' AND 
   last_name <> 'Motley';


-- LIMIT CLAUSE
SELECT
   film_id,
   title,
   rental_rate
FROM
   film
ORDER BY
   rental_rate DESC
LIMIT 10;


-- FETCH clause to retrieve a portion of rows returned by a query.
-- OFFSET clause must come before the FETCH
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title 
OFFSET 5 ROWS 
FETCH FIRST 5 ROW ONLY; 


-- PostgreSQL IN operator example
SELECT
 customer_id,
   rental_id,
   return_date
FROM
   rental
WHERE
   customer_id IN (1, 2)
ORDER BY
   return_date DESC;

-- NOT IN operator
SELECT
   customer_id,
   rental_id,
   return_date
FROM
   rental
WHERE
   customer_id NOT IN (1, 2);


-- IN with a subquery
-- Following query returns a list of customer id of customers that has rental’s return date on 2005-05-27
-- CAST operator to convert a value of one type to another.
SELECT
   customer_id
FROM
   rental
WHERE
   CAST (return_date AS DATE) = '2005-05-27';

-- SAME (SUB QUERY)
SELECT
   first_name,
   last_name
FROM
   customer
WHERE
   customer_id IN (
      SELECT
         customer_id
      FROM
         rental
      WHERE
         CAST (return_date AS DATE) = '2005-05-27'
   );


-- Interval
SELECT
	name_first || ' ' || name_last AS full_name
FROM
	rigbot.users
WHERE
	id IN (
	SELECT
		user_id
	FROM
		rigbot.drivers
	WHERE
		created_at > now( ) - INTERVAL '1 MONTHS'
	
	);



-- CAST
SELECT
   CAST ('100' AS INTEGER);
SELECT
   CAST ('10.2' AS DOUBLE PRECISION);
SELECT 
   CAST('true' AS BOOLEAN),
   CAST('false' as BOOLEAN),
   CAST('T' as BOOLEAN),
   CAST('F' as BOOLEAN);



-- BETWEEN
SELECT
   customer_id,
   payment_id,
   amount,
   payment_date
FROM
   payment
WHERE
   payment_date 
BETWEEN '2007-02-07' AND '2007-02-15';


-- ILIKE operator that acts like the LIKE operator. In addition, the ILIKE operator matches value case-insensitively.
SELECT
   first_name,
   last_name
FROM
   customer
WHERE
   first_name ILIKE 'BAR%';

-- NOT LIKE
SELECT
   first_name,
   last_name
FROM
   customer
WHERE
   first_name NOT LIKE 'Jen%';




-- NULL and IS NULL operator
SELECT
    id,
    first_name,
    last_name,
    email,
    phone
FROM
    contacts
WHERE
    phone IS NULL;

SELECT
    id,
    first_name,
    last_name,
    email,
    phone
FROM
    contacts
WHERE
    phone IS NOT NULL;




-- Column alias
SELECT
    first_name || ' ' || last_name AS full_name
FROM
    customer
ORDER BY 
    full_name;



-- Table alias
SELECT t.column_name
FROM a_very_long_table_name t;