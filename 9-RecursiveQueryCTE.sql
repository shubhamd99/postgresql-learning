-- A recursive query is a query that refers to a recursive CTE.
-- The recursive queries are useful in many situations such as for querying hierarchical data like organizational structure, bill of materials, etc.

WITH RECURSIVE cte_name(
    CTE_query_definition -- non-recursive term
    UNION [ALL]
    CTE_query definion  -- recursive term
) SELECT * FROM cte_name;

-- A recursive CTE has three elements:
-- Non-recursive term: the non-recursive term is a CTE query definition that forms the base result set of the CTE structure.
-- Recursive term: the recursive term is one or more CTE query definitions joined with the non-recursive term using the UNION or UNION ALL operator. 
    -- The recursive term references to the CTE name itself.
-- Termination check: the recursion stops when no rows are returned from the previous iteration.

CREATE TABLE employees (
   employee_id serial PRIMARY KEY,
   full_name VARCHAR NOT NULL,
   manager_id INT
);

INSERT INTO employees (
   employee_id,
   full_name,
   manager_id
)
VALUES
   (1, 'Michael North', NULL),
   (2, 'Megan Berry', 1),
   (3, 'Sarah Berry', 1),
   (4, 'Zoe Black', 1),
   (5, 'Tim James', 1),
   (6, 'Bella Tucker', 2),
   (7, 'Ryan Metcalfe', 2),
   (8, 'Max Mills', 2),
   (9, 'Benjamin Glover', 2),
   (10, 'Carolyn Henderson', 3),
   (11, 'Nicola Kelly', 3),
   (12, 'Alexandra Climo', 3),
   (13, 'Dominic King', 3),
   (14, 'Leonard Gray', 4),
   (15, 'Eric Rampling', 4),
   (16, 'Piers Paige', 7),
   (17, 'Ryan Henderson', 7),
   (18, 'Frank Tucker', 8),
   (19, 'Nathan Ferguson', 8),
   (20, 'Kevin Rampling', 8);

-- The following query returns all subordinates of the manager with the id 2.
WITH RECURSIVE subordinates AS (
   SELECT
      employee_id,
      manager_id,
      full_name
   FROM
      employees
   WHERE
      employee_id = 2
   UNION
      SELECT
         e.employee_id,
         e.manager_id,
         e.full_name
      FROM
         employees e
      INNER JOIN subordinates s ON s.employee_id = e.manager_id
) SELECT
   *
FROM
   subordinates;

-- The recursive CTE, subordinates, defines one non-recursive term and one recursive term.
-- The non-recursive term returns the base result set R0 that is the employee with the id 2.

-- employee_id | manager_id |  full_name
-------------+------------+-------------
--           2 |          1 | Megan Berry

-- The recursive term returns the direct subordinate(s) of the employee id 2.
-- This is the result of joining between the employees table and the subordinates CTE.
-- The first iteration of the recursive term returns the following result set:

-- employee_id | manager_id |    full_name
-------------+------------+-----------------
--           6 |          2 | Bella Tucker
--          7 |          2 | Ryan Metcalfe
--           8 |          2 | Max Mills
--           9 |          2 | Benjamin Glover

-- PostgreSQL executes the recursive term repeatedly.
-- The second iteration of the recursive member uses the result set above step as the input value, and returns this result set:

-- employee_id | manager_id |    full_name
-------------+------------+-----------------
--          16 |          7 | Piers Paige
--          17 |          7 | Ryan Henderson
--          18 |          8 | Frank Tucker
--          19 |          8 | Nathan Ferguson
--          20 |          8 | Kevin Rampling


-- RESULT
-- employee_id | manager_id |    full_name
-------------+------------+-----------------
--           2 |          1 | Megan Berry
--           6 |          2 | Bella Tucker
--           7 |          2 | Ryan Metcalfe
--           8 |          2 | Max Mills
--           9 |          2 | Benjamin Glover
--          16 |          7 | Piers Paige
--          17 |          7 | Ryan Henderson
--          18 |          8 | Frank Tucker
--          19 |          8 | Nathan Ferguson
--          20 |          8 | Kevin Rampling
