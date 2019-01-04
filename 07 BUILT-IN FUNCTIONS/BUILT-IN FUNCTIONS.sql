USE book_library;

-- 1. Find Book Titles
-- Write a SQL query to find books which titles start with “The”.
-- Order the result by id. Submit your query statements as Prepare DB & run queries. 

-- 1.1 
SELECT 
    book.title
FROM
    books AS book
WHERE
    SUBSTRING(book.title, 1, 3) = 'The'
ORDER BY book.id;

-- 1.2

SELECT 
    book.title
FROM
    books AS book
WHERE
    book.title LIKE ('The%')
ORDER BY book.id;

-- 2. Replace Titles
-- Write a SQL query to find books which titles start with “The” and replace the substring with 3 asterisks.
-- Retrieve data about the updated titles. Order the result by id.
-- Submit your query statements as Prepare DB & run queries.

-- 2.1 Concat + Substring solution
SELECT 
    CONCAT('***', SUBSTRING(book.title, 4)) AS 'title'
FROM
    books AS book
WHERE
    SUBSTRING(book.title, 1, 3) = 'The'
ORDER BY book.id;

-- 2.2 Replace solution
SELECT 
    REPLACE(book.title, 'The', '***') AS 'title'
FROM
    books AS book
WHERE
    book.title LIKE ('The%')
ORDER BY book.id;

-- 2.3
UPDATE books AS book
SET 
    book.title  = REPLACE(book.title, 'The', '***')
WHERE
    book.title LIKE ('The%');

SELECT 
    book.title
FROM
    books AS book
WHERE
    book.title LIKE ('***%')
ORDER BY book.id;


-- 3. Sum Cost of All Books
-- Write a SQL query to sum prices of all books.
-- Format the output to 2 digits after decimal point.
-- Submit your query statements as Prepare DB & run queries. 

-- 3.1
SELECT 
    FORMAT(SUM(books.cost), 2)
FROM
    books;

-- 3.2
SELECT 
    ROUND(SUM(`cost`), 2) AS 'cost'
FROM
    `books`;


-- 04. Days Lived
-- Write a SQL query to calculate the days that the authors have lived. 
-- NULL values mean that the author is still alive.

SELECT 
    CONCAT_WS(' ', first_name, last_name) AS 'Full Name',
    TIMESTAMPDIFF(DAY, born, died) AS 'Days Lived'
FROM
    authors;


-- 05. Harry Potter Books
-- Write a SQL query to retrieve titles of all the Harry Potter books. 
-- Order the information by id.

SELECT 
    title
FROM
    books
WHERE
    title LIKE ('%Harry Potter%')
ORDER BY id;


-- Practice exercises

SELECT SUBSTRING('Hello, Peshp', 3) AS 'string';

SELECT SUBSTRING('Hello, Peshp' FROM 1 FOR 4);

SELECT SUBSTRING("SQL Tutorial", -4,5) AS ExtractString;

SELECT INSERT('Petar', 4, 0, '|');

SELECT LOCATE('s',"SQL Tutorial", 1);

SELECT LOCATE('231',"SQL Tutorial", 1);
 
SELECT LOCATE('op', 'foobarbaraaop');

SELECT 3 + 2 AS 'sum', 3 DIV 2 AS 'DIV', 3 / 2 AS 'div', -(-3);

DESCRIBE books;

SELECT DATABASE();

