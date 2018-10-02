-- Download and get familiar with the restaurant database. You will use it in the assignments bellow.

USE restaurant;

SELECT 
    e.department_id, COUNT(e.id) as 'Number of employees'
FROM
    employees AS e
GROUP BY e.department_id
ORDER BY e.department_id, COUNT(e.department_id);


-- 2. Average Salary
-- Write a query to calculate the average salary in each department. 
-- Order the information by department_id. Round the salary result 
-- to two digits after the decimal point.

SELECT 
    e.department_id, ROUND(AVG(e.salary), 2) AS 'Average Salary'
FROM
    employees AS e
GROUP BY e.department_id
ORDER BY e.department_id;

-- 3. Minimum Salary
-- Write a query to retrieve information about the departments
-- grouped by department_id with minumum salary higher than 800. 
-- Round the salary result to two digits after the decimal point.


SELECT 
    e.department_id, TRUNCATE(MIN(e.salary), 2) AS 'Min Salary'
FROM
    employees AS e
GROUP BY e.department_id
HAVING MIN(e.salary) > 800;

-- 4. Appetizers Count
-- Write a query to retrieve the count of all appetizers (category id = 2)
-- with price higher than 8.

SELECT 
    COUNT(p.id) AS 'Appetizers count'
FROM
    products AS p
WHERE
    p.category_id = 2 AND p.price > 8
GROUP BY p.category_id;

-- 5. Menu Prices
-- Write a query to retrieve information about the prices of each category.
-- The output should consist of:
-- * category_id
-- * Average Price 
-- * Cheapest Product
-- * Most Expensive Product
-- See the examples for more information. 
-- Round the results to 2 digits after the decimal point.

SELECT 
    category_id,
    ROUND(AVG(p.price), 2) AS 'Average Price',
    ROUND(MIN(p.price), 2) AS 'Cheapest Product',
    ROUND(MAX(p.price), 2) AS 'Most Expensive Product'
FROM
    products AS p
GROUP BY p.category_id
ORDER BY p.category_id;