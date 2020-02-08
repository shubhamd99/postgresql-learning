CREATE TABLE product_groups (
   group_id serial PRIMARY KEY,
   group_name VARCHAR (255) NOT NULL
);
 
CREATE TABLE products (
   product_id serial PRIMARY KEY,
   product_name VARCHAR (255) NOT NULL,
   price DECIMAL (11, 2),
   group_id INT NOT NULL,
   FOREIGN KEY (group_id) REFERENCES product_groups (group_id)
);

INSERT INTO product_groups (group_name)
VALUES
   ('Smartphone'),
   ('Laptop'),
   ('Tablet');
 
INSERT INTO products (product_name, group_id,price)
VALUES
   ('Microsoft Lumia', 1, 200),
   ('HTC One', 1, 400),
   ('Nexus', 1, 500),
   ('iPhone', 1, 900),
   ('HP Elite', 2, 1200),
   ('Lenovo Thinkpad', 2, 700),
   ('Sony VAIO', 2, 700),
   ('Dell Vostro', 2, 800),
   ('iPad', 3, 700),
   ('Kindle Fire', 3, 150),
   ('Samsung Galaxy Tab', 3, 200);

--  Aggregate function to calculate the average price of all products in the products table
SELECT
   AVG (price)
FROM
   products;


-- To apply the aggregate function to subsets of rows, you use the GROUP BY clause
SELECT
   group_name,
   AVG (price)
FROM
   products
INNER JOIN product_groups USING (group_id)
GROUP BY
   group_name;



-- Similar to an aggregate function, a window function operates on a set of rows.
-- However, it does not reduce the number of rows returned by the query.

-- The term window describes the set of rows on which the window function operates.
-- A window function returns values from the rows in a window.

-- In this query, the AVG() function works as a window function that operates on a set of rows specified by the OVER clause.

-- In this syntax, the PARTITION BY distributes the rows of the result set into groups and
-- the AVG() function is applied to each group to return the average price for each.

SELECT
   product_name,
   price,
   group_name,
   AVG (price) OVER (
      PARTITION BY group_name
   )
FROM
   products
INNER JOIN 
    product_groups USING (group_id);

-- HP Elite	1200.00	Laptop	850.0000000000000000
-- Lenovo Thinkpad	700.00	Laptop	850.0000000000000000
-- Sony VAIO	700.00	Laptop	850.0000000000000000
-- Dell Vostro	800.00	Laptop	850.0000000000000000
-- Microsoft Lumia	200.00	Smartphone	500.0000000000000000
-- HTC One	400.00	Smartphone	500.0000000000000000
-- Nexus	500.00	Smartphone	500.0000000000000000
-- iPhone	900.00	Smartphone	500.0000000000000000
-- iPad	700.00	Tablet	350.0000000000000000
-- Kindle Fire	150.00	Tablet	350.0000000000000000
-- Samsung Galaxy Tab	200.00	Tablet	350.0000000000000000

-- PostgreSQL Window Function Syntax
window_function(arg1, arg2,..) OVER (
   [PARTITION BY partition_expression]
   [ORDER BY sort_expression [ASC | DESC] [NULLS {FIRST | LAST }]
   [frame_clause] )

-- The PARTITION BY clause divides rows into multiple groups or partitions to which the window function is applied
-- The ORDER BY clause specifies the order of rows in each partition to which the window function is applied.
-- The ORDER BY clause uses the NULLS FIRST or NULLS LAST option to specify whether nullable values should be first or last in the result set. The default is NULLS LAST option.
-- The frame_clause defines a subset of rows in the current partition to which the window function is applied


-- you can use the WINDOW clause to shorten the query as shown in the following query:
SELECT 
   wf1() OVER w,
   wf2() OVER w,
FROM table_name
WINDOW w AS (PARTITION BY c1 ORDER BY c2);

-- It is also possible to use the WINDOW clause even though you call one window function in a query
SELECT wf1() OVER w
FROM table_name 
WINDOW w AS (PARTITION BY c1 ORDER BY c2);


-- The ROW_NUMBER() function assigns a sequential number to each row in each partition. See the following query:
SELECT
   product_name,
   group_name,
   price,
   ROW_NUMBER () OVER (
      PARTITION BY group_name -- Laptop, Laptop, Laptop, Smartphone, SmartPhone
      ORDER BY price          -- 200, 300, 1200, 500, 700
   )
FROM
   products
INNER JOIN product_groups USING (group_id);


-- The RANK() function assigns ranking within an ordered partition.
-- If rows have the same values, the  RANK() function assigns the same rank, with the next ranking(s) skipped.

SELECT
   product_name,
   group_name,
  price,
   RANK () OVER (
      PARTITION BY group_name
      ORDER BY
         price
   )
FROM
   products
INNER JOIN product_groups USING (group_id);


-- The FIRST_VALUE() function returns a value evaluated against the first row within its partition,
-- whereas the LAST_VALUE() function returns a value evaluated against the last row in its partition.

SELECT
   product_name,
   group_name,
   price,
   FIRST_VALUE (price) OVER (
      PARTITION BY group_name       -- (group 1 [Laptop, Laptop], group 2 [SmartPhone, SmartPhone], group 3 [Tablet] )
      ORDER BY price                -- (group 1 [700, 900], group 2 [500, 300], group 3 [400] )
   ) AS lowest_price_per_group      -- per group lowest value (group 1 - 700, group 2 - 300, group 3 - 400)
FROM
   products
INNER JOIN product_groups USING (group_id);


-- Last Value
-- we added the frame clause RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING,
-- because by default the frame clause is RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW.
SELECT
   product_name,
   group_name,
   price,
   LAST_VALUE (price) OVER (
      PARTITION BY group_name
      ORDER BY
         price RANGE BETWEEN UNBOUNDED PRECEDING
      AND UNBOUNDED FOLLOWING
   ) AS highest_price_per_group
FROM
   products
INNER JOIN product_groups USING (group_id);


-- The LAG() function has the ability to access data from the previous row
-- while the LEAD() function can access data from the next row

LAG  (expression [,offset] [,default]) over_clause;
LEAD (expression [,offset] [,default]) over_clause;

-- expression – a column or expression to compute the returned value.
-- offset – the number of rows preceding ( LAG)/ following ( LEAD) the current row. It defaults to 1
-- default – the default returned value if the offset goes beyond the scope of the window. The default is NULL if you skip it.

SELECT
   product_name,
   group_name,
   price,
   LAG (price, 1) OVER (
      PARTITION BY group_name
      ORDER BY
         price
   ) AS prev_price,
   price - LAG (price, 1) OVER (
      PARTITION BY group_name
      ORDER BY
         price
   ) AS cur_prev_diff
FROM
   products
INNER JOIN product_groups USING (group_id);


-- The following statement uses the LEAD() function to return the prices from the next row
-- and calculates the difference between the price of the current row and the next row.
SELECT
   product_name,
   group_name,
   price,
   LEAD (price, 1) OVER (
      PARTITION BY group_name
      ORDER BY
         price
   ) AS next_price,
   price - LEAD (price, 1) OVER (
      PARTITION BY group_name
      ORDER BY
         price
   ) AS cur_next_diff
FROM
   products
INNER JOIN product_groups USING (group_id);
