-- Get familiar with the camp database. You will use it in the following exercises bellow.

USE camp;

/* 1. Mountains and Peaks
Write a query to create two tables – mountains and peaks and link their fields properly. Tables should have:
-	Mountains:
•	id 
•	name
-	Peaks: 
•	id
•	name
•	mountain_id
Check your solutions using the “Run Queries and Check DB” strategy.*/

CREATE TABLE mountains (
    id INT UNSIGNED NOT NULL  AUTO_INCREMENT ,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_mountains PRIMARY KEY(id)
);

CREATE TABLE peaks (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    mountain_id INT UNSIGNED,
    CONSTRAINT pk_peaks PRIMARY KEY(id),
    CONSTRAINT fk_peaks_mountains FOREIGN KEY (mountain_id)
        REFERENCES mountains (id)
);


/*2. Posts and Authors
Write a query to create a one-to-many relationship between a table, 
holding information about books and other -about authors, so that when 
an author gets removed from the database all his books are deleted too. 
The tables should have:
-	Books
•	id
•	name  
•	author_id
•	Authors
•	id
•	name
Submit your queries using the “MySQL run queries & check DB” strategy.*/

CREATE TABLE authors (
	id int UNSIGNED not null AUTO_INCREMENT,
    name VARCHAR(30) not null,
    CONSTRAINT pk_authors PRIMARY KEY (id)
);

CREATE TABLE books (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    author_id INT UNSIGNED,
    CONSTRAINT pk_books PRIMARY KEY (id),
    CONSTRAINT fk_authors_books FOREIGN KEY (author_id)
        REFERENCES authors (id)
        ON DELETE CASCADE
);


/* 3. Trip Organization
Write a query to retrieve information about the SoftUni camp’s 
transportation organization. Get information about the people who 
drive(name and age) and their vehicle type. Submit your queries using 
the “MySQL prepare DB and Run Queries” strategy. */

SELECT 
    v.driver_id,
    v.vehicle_type,
    CONCAT_WS(' ', c.first_name, c.last_name) AS driver_name
FROM
    campers AS c
        JOIN
    vehicles AS v ON c.id = v.driver_id;
    

/* SoftUni Hiking
Get information about the hiking routes and their leaders – name and id. 
Submit your queries using the “MySQL prepare DB and Run Queries” strategy.*/


SELECT 
    r.starting_point,
    r.end_point,
    r.leader_id,
    CONCAT_WS(' ', c.first_name, c.last_name) AS leader_name
FROM
    campers AS c
        JOIN
    routes AS r ON c.id = r.leader_id;


/* 5. Project Management DB*
Write a query to create a project management db according to the following E/R Diagram: */

CREATE DATABASE company;
USE company;

CREATE TABLE employees (
    id INT UNIQUE NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    project_id INT UNIQUE,
    CONSTRAINT pk_employees PRIMARY KEY (id)
);

CREATE TABLE clients (
    id INT UNIQUE NOT NULL AUTO_INCREMENT,
    client_name VARCHAR(100) NOT NULL,
    project_id INT UNIQUE,
    CONSTRAINT pk_clients PRIMARY KEY (id)
);

CREATE TABLE projects (
    id INT UNIQUE NOT NULL AUTO_INCREMENT,
    client_id INT UNIQUE,
    project_lead_id INT UNIQUE,
    CONSTRAINT pk_projects PRIMARY KEY (id)
);

ALTER TABLE employees 
	ADD CONSTRAINT fk_projects_employees FOREIGN KEY (project_id) REFERENCES projects(id);
    
ALTER TABLE clients 
	ADD CONSTRAINT fk_projects_clients FOREIGN KEY (project_id) REFERENCES projects(id);
    
ALTER TABLE projects 
	ADD CONSTRAINT fk_clients_projects FOREIGN KEY (client_id) REFERENCES clients(id),
    ADD CONSTRAINT fk_emoloyees_projects FOREIGN KEY (project_lead_id) REFERENCES employees(id);















