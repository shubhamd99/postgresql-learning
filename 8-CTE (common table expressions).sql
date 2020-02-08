-- A common table expression is a temporary result set which you can reference within another SQL statement
-- including SELECT, INSERT, UPDATE or DELETE.

WITH cte_name (column_list) AS (
    CTE_query_definition 
)
statement;

-- Example
WITH cte_film AS (
    SELECT 
        film_id, 
        title,
        (CASE 
            WHEN length < 30 THEN 'Short'
            WHEN length >= 30 AND length < 90 THEN 'Medium'
            WHEN length > 90 THEN 'Long'
        END) length    
    FROM
        film
)
SELECT
    film_id,
    title,
    length
FROM 
    cte_film
WHERE
    length = 'Long'
ORDER BY 
    title; 


-- The following statement illustrates how to use the CTE with the RANK() window function:
WITH cte_film AS  (
    SELECT film_id,
        title,
        rating,
        length,
        RANK() OVER (
            PARTITION BY rating
            ORDER BY length DESC) 
        length_rank
    FROM 
        film
)
SELECT *
FROM cte_film
WHERE length_rank = 1;