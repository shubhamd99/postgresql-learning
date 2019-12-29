-- Group By
-- GROUP BY clause divides the rows returned from the SELECT statement into groups. 
-- For each group, you can apply an aggregate function e.g., ..
-- SUM() to calculate the sum of items or COUNT() to get the number of items in the groups.

SELECT
   customer_id,
   SUM (amount)
FROM
   payment
GROUP BY
   customer_id
ORDER BY
   SUM (amount) DESC;


-- Count
SELECT
   staff_id,
   COUNT (payment_id)
FROM
   payment
GROUP BY
   staff_id;


-- GROUP BY with multiple columns
SELECT 
   customer_id, 
   staff_id, 
   SUM(amount) 
FROM 
   payment
GROUP BY 
   staff_id, 
   customer_id
ORDER BY 
    customer_id;

-- Grouping by dates
SELECT 
   DATE(payment_date) paid_date, 
   SUM(amount) sum
FROM 
   payment
GROUP BY
   DATE(payment_date);



-- HAVING
--  use the HAVINGclause in conjunction with the GROUP BY clause to filter group rows that do not satisfy a specified condition
SELECT
   customer_id,
   SUM (amount)
FROM
   payment
GROUP BY
   customer_id
HAVING
   SUM (amount) > 200;