-- SELECT QUERY
SELECT * FROM shubham.CUSTOMERS;

SELECT ID, NAME, SALARY 
FROM shubham.CUSTOMERS
WHERE NAME = 'Shubham';

SELECT ID, NAME, SALARY 
FROM CUSTOMERS
WHERE SALARY > 2000 AND age < 25;

-- combine first and last name in one column
SELECT 
   first_name || ' ' || last_name AS full_name,
   email
FROM 
   customer;

-- Order BY
SELECT
   first_name,
   last_name
FROM
   customer
ORDER BY
   first_name ASC,
   last_name DESC;

-- It will show length and first name and order by desc
SELECT 
   first_name,
   LENGTH(first_name) len
FROM
   customer
ORDER BY 
   LENGTH(first_name) DESC;



-- The DISTINCT clause is used in the SELECT statement to remove duplicate rows from a result set
SELECT
   DISTINCT ON (column_1) column_alias,
   column_2
FROM
   table_name
ORDER BY
   column_1,
   column_2;