/* For problems from 1 to 11 (inclusively) use "soft_uni" database and for the other – "geography". */

USE soft_uni;

/* 1. Employee Address
Write a query that selects:
•	employee_id
•	job_title
•	address_id
•	address_text
Return the first 5 rows sorted by address_id in ascending order.
Example:
employee_id		job_title					address_id		address_text
142				Production Technician		1				108 Lakeside Court
30				Human Resources Manager		2				1341 Prospect St 	*/

SELECT 
    e.employee_id, e.job_title, a.address_id, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON e.address_id = a.address_id
ORDER BY a.address_id
LIMIT 5;


/* 2. Addresses with Towns
Write a query that selects:
•	first_name
•	last_name
•	town
•	address_text
Sorted by first_name in ascending order then by last_name. 
Select first 5 employees.
Example:
first_name		last_name		town			address_text
A.Scott			Wright			Newport Hills	1400 Gate Drive
Alan			Brewer			Kenmore	8		192 Seagull Court*/

SELECT 
    e.first_name, e.last_name, t.name, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a
        JOIN
    towns AS t ON e.address_id = a.address_id
        AND a.town_id = t.town_id
ORDER BY e.first_name, e.last_name
LIMIT 5;

/* 3. Sales Employee
Write a query that selects:
•	employee_id
•	first_name
•	last_name
•	department_name
Sorted by employee_id in descending order. 
Select only employees from “Sales” department.
Example:
employee_id		first_name	last_name	department_name
290				Lynn		Tsoflias	Sales
289				Rachel		Valdez		Sales */

SELECT 
    e.employee_id, e.first_name, e.last_name, d.name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    d.name = 'Sales'
ORDER BY e.employee_id DESC
LIMIT 5;


/* 4.	Employee Departments
Write a query that selects:
•	employee_id
•	first_name
•	salary
•	department_name
Filter only employees with salary higher than 15000.
Return the first 5 rows sorted by department_id in descending order.
Example:
employee_id		first_name		salary		department_name
109				Ken				125500.00	Executive
140	L			aura			60100.00	Executive */

SELECT 
    e.employee_id, e.first_name, e.salary, d.name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;


/* 5. Employees Without Project
Write a query that selects:
•	employee_id
•	first_name
Filter only employees without a project. Return the first 3 rows sorted by employee_id in descending order.
Example:
employee_id		first_name
293				George
292				Martin */

SELECT 
    e.employee_id, e.first_name
FROM
    employees AS e
        LEFT JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
WHERE
    ISNULL(ep.employee_id)
ORDER BY e.employee_id DESC
LIMIT 3;


/* 6.	Employees Hired After
Write a query that selects:
•	first_name
•	last_name
•	hire_date
•	dept_name
Filter only employees with hired after 1/1/1999 and are from either "Sales" or "Finance" departments. 
Sorted by hire_date (ascending).
Example:
first_name		last_name	hire_date				dept_name
Debora     		Poe			2001-01-19 00:00:00		Finance
Wendy			Kahn		2001-01-26 00:00:00		Finance */

SELECT 
    e.first_name, e.last_name, e.hire_date, d.name as dept_name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
   d.name IN ('Sales' , 'Finance')
        AND DATE(e.hire_date) > '1999/1/1'
ORDER BY e.hire_date;


/* 7. Employees with Project
Write a query that selects:
•	employee_id
•	first_name
•	project_name
Filter only employees with a project which has started after 13.08.2002 and it is still ongoing (no end date). 
Return the first 5 rows sorted by first_name then by project_name both  in ascending order.
Example
employee_id		first_name		project_name
44				A. Scott		Hitch Rack - 4-Bike
170				Alan			LL Touring Handlebars */

SELECT 
    e.employee_id, e.first_name, p.name
FROM
    employees AS e
        JOIN
    projects AS p
        JOIN
    employees_projects ep ON e.employee_id = ep.employee_id
        AND p.project_id = ep.project_id
WHERE
    DATE(p.start_date) > ('2002-08-13')
        AND ISNULL(p.end_date)
ORDER BY e.first_name , p.name
LIMIT 5;


/*8.	Employee 24
Write a query that selects:
•	employee_id
•	first_name
•	project_name
Filter all the projects of employees with id 24. 
If the project has started after 2005 inclusively the return value should be NULL. 
Sort result by project_name alphabetically.
Example
employee_	id	first_name		project_name
24			David				NULL
24			David				NULL */

SELECT 
    e.employee_id,
    e.first_name,
    IF(YEAR(p.start_date) >= 2005,
        NULL,
        p.name)
FROM
    employees AS e
        JOIN
    projects AS p
        JOIN
    employees_projects ep ON e.employee_id = ep.employee_id
        AND p.project_id = ep.project_id
WHERE
    ep.employee_id = 24
ORDER BY p.name;



/* 9.	Employee Manager
Write a query that selects:
•	employee_id
•	first_name
•	manager_id
•	manager_name
Filter all employees with a manager who has id equals to 3 or 7. 
Return the all rows sorted by employee first_name in ascending order.
Example
employee_id		first_name		manager_id		manager_name
122				Bryan			7				JoLynn
158				Dylan			3				Roberto */


SELECT 
    e.employee_id, e.first_name, e.manager_id, m.first_name
FROM
    `employees` AS e
        JOIN
    `employees` AS m ON e.manager_id = m.employee_id
WHERE
    e.manager_id IN (3 , 7)
ORDER BY e.first_name;



/*10.	Employee Summary
Write a query that selects:
•	employee_id
•	employee_name
•	manager_name
•	department_name
Show first 5 employees (only for employees who has a manager) 
with their managers and the departments which they are in 
(show the departments of the employees). Order by employee_id.
Example
employee_id		employee_name		manager_name		department_name
1				Guy Gilbert			Jo Brown			Production
2				Kevin Brown			David Bradley		Marketing*/

SELECT 
    e.employee_id,
    CONCAT_WS(' ', e.first_name, e.last_name) AS employee_name,
    CONCAT_WS(' ', m.first_name, m.last_name) AS manager_name,
    d.name AS department_name
FROM
    employees AS e
        JOIN
    employees AS m ON e.manager_id = m.employee_id
        JOIN
    departments AS d ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;


/* 11.	Min Average Salary
Write a query that return the value of the lowest average salary of all departments.
Example:
min_average_salary
10866.6666 */

SELECT 
    AVG(e.salary) AS min_average_salary
FROM
    employees AS e
GROUP BY e.department_id
ORDER BY min_average_salary
LIMIT 1;

USE geography;

/* 12.	Highest Peaks in Bulgaria
Write a query that selects:
•	country_code	
•	mountain_range
•	peak_name
•	elevation
Filter all peaks in Bulgaria with elevation over 2835. Return the all rows sorted by elevation in descending order.
Example
country_code	mountain_range	peak_name	elevation
BG				Rila			Musala		2925
BG				Pirin			Vihren		2914 */


SELECT 
    c.country_code, m.mountain_range, p.peak_name, p.elevation
FROM
    countries AS c
        JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        JOIN
    mountains AS m ON mc.mountain_id = m.id
        JOIN
    peaks AS p ON p.mountain_id = m.id
WHERE
    c.country_code = 'BG'
        AND p.elevation > 2835
ORDER BY p.elevation DESC;


/* 13.	Count Mountain Ranges
Write a query that selects:
•	country_code
•	mountain_range
Filter the count of the mountain ranges in the United States, 
Russia and Bulgaria. Sort result by mountain_range count  in decreasing order.
Example
country_code	mountain_range
BG				6
RU				1 */


SELECT 
    c.country_code, COUNT(m.mountain_range) AS mountain_range
FROM
    countries AS c
        JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        JOIN
    mountains AS m ON mc.mountain_id = m.id
WHERE
    c.country_code IN ('US' , 'BG', 'RU')
GROUP BY c.country_code
ORDER BY mountain_range DESC;


/* 14.	Countries with Rivers
Write a query that selects:
•	country_name
•	river_name
Find the first 5 countries with or without rivers in Africa. Sort them by country_name in ascending order.
Example
country_name	river_name
Algeria			Niger
Angola			Congo
Benin			Niger
Botswana		NULL
Burkina Faso	Niger */

SELECT 
    country_name, river_name
FROM
    rivers AS r
        RIGHT JOIN
    countries_rivers AS cr ON r.id = cr.river_id
        RIGHT JOIN
    countries AS c ON cr.country_code = c.country_code
WHERE
    continent_code = 'AF'
ORDER BY country_name ASC
LIMIT 5;


/* 15.	*Continents and Currencies
Write a query that selects:
•	continent_code
•	currency_code
•	currency_usage
Find all continents and their most used currency. 
Filter any currency that is used in only one country. 
Sort your results by continent_code and currency_code.
Example
continent_code	currency_code	currency_usage
AF				XOF				8
AS				AUD				2
AS				ILS				2
EU				EUR				26
NA				XCD				8
OC				USD				8 */


SELECT 
    c1.continent_code,
    c1.currency_code,
    MAX(c3.currency_count) AS currency_usage
FROM
    countries AS c1
        JOIN
    (SELECT 
        c2.continent_code, COUNT(c2.currency_code) AS currency_count
    FROM
        countries AS c2
    GROUP BY c2.continent_code , c2.currency_code
    ORDER BY c2.continent_code , c2.currency_code) AS c3 ON c1.continent_code = c3.continent_code
GROUP BY c1.continent_code
HAVING  currency_usage > 1
ORDER BY c1.continent_code , c1.currency_code; 




SELECT MAX(c3.currency_count) from
 
 (SELECT 
        c2.continent_code, COUNT(c2.currency_code) AS currency_count
    FROM
        countries AS c2
    GROUP BY  c2.currency_code
    HAVING currency_count > 1
    ORDER BY c2.continent_code , c2.currency_code ) as c3
    
    
    `c`.`currency_code`,
    COUNT(`c`.`currency_code`) AS `currency_usage` FROM
    `countries` AS `c`
GROUP BY `c`.`continent_code`,`c`.`currency_code`
HAVING `currency_usage` > 1
ORDER BY `c`.`continent_code` , `c`.`currency_code`;
 
SELECT
    `cc`.*
FROM
    `continents_currencies` AS `cc`
        LEFT JOIN
    `continents_currencies` AS `cc2` ON `cc`.`continent_code` = `cc2`.`continent_code`
        AND `cc`.`currency_usage` < `cc2`.`currency_usage`
WHERE
    `cc2`.`currency_usage` IS NULL;
   
DROP TABLE `continents_currencies`;


SELECT d1.continent_code, d1.currency_code, d1.currency_usage FROM
    (SELECT `c`.`continent_code`, `c`.`currency_code`,
    COUNT(`c`.`currency_code`) AS `currency_usage` FROM countries as c
    GROUP BY c.currency_code, c.continent_code HAVING currency_usage > 1) as d1
LEFT JOIN
    (SELECT `c`.`continent_code`,`c`.`currency_code`,
    COUNT(`c`.`currency_code`) AS `currency_usage` FROM countries as c
     GROUP BY c.currency_code, c.continent_code HAVING currency_usage > 1) as d2
ON d1.continent_code = d2.continent_code AND d2.currency_usage > d1.currency_usage
 
WHERE d2.currency_usage IS NULL
ORDER BY d1.continent_code, d1.currency_code;

/* 16.	Countries without any Mountains
Find all the count of all countries which don’t have a mountain.
Example
country_count
231 */

SELECT (COUNT(*) - COUNT(mc.mountain_id)) AS country_count  
FROM countries AS c
LEFT JOIN mountains_countries As mc
ON c.country_code = mc.country_code;


/*17.	Highest Peak and Longest River by Country
For each country, find the elevation of the highest peak and the length of the longest river, 
sorted by the highest peak_elevation (from highest to lowest), 
then by the longest river_length (from longest to smallest), 
then by country_name (alphabetically). 
Display NULL when no data is available in some of the columns. Limit only the first 5 rows.
Example
country_name	highest_peak_elevation	longest_river_length
China				8848							6300
India				8848							3180
Nepal				8848							2948
Pakistan			8611							3180
Argentina		6962							4880 */

SELECT 
	c.country_name, 
	MAX(p.elevation) AS highest_peak_elevation,
	MAX(r.length) AS longest_river_length
FROM countries AS c
LEFT JOIN mountains_countries as mc ON c.country_code = mc.country_code 
LEFT JOIN peaks AS p ON mc.mountain_id = p.mountain_id
LEFT JOIN countries_rivers AS cr ON cr.country_code = c.country_code
LEFT JOIN rivers as r ON r.id = cr.river_id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC, c.country_name
LIMIT 5;

