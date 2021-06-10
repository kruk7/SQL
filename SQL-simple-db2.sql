CREATE DATABASE test2;
USE test;
CREATE TABLE employees (
employee_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20),
    departament_id INT,
    PRIMARY KEY(employee_id)
);

CREATE TABLE departaments (
departament_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20),
    PRIMARY KEY (departament_id)
);

INSERT INTO employees (name, departament_id)
values ('kamil', 1),
	   ('adam', 2),
       ('grzesiek', 3),
	   ('alex', 2),
       ('rico', 2),
	   ('zenon', 3),
	   ('rafaello', NULL),
       ('marco', NULL)
;      

INSERT INTO departaments (name)
VALUES ('production'),
	   ('R&D'),
       ('maintenance'),
       ('secret dep.')
;

SELECT * FROM employees;
SELECT * FROM departaments;

-- inner join
-- show employees in departments
SELECT
	e.name AS 'employee_name',
    d.name AS 'departament_name'
FROM employees AS  e
JOIN departaments AS d ON e.departament_id = d.departament_id
ORDER BY d.name
;

-- left join
-- show all employees in departaments
SELECT
	e.name AS 'employee_name', 
	IFNULL(d.name, 'EMPTY') AS 'name_of_departament'
FROM employees AS e
LEFT JOIN departaments AS d AS e.departament_id = d.departament_id
ORDER BY d.name
;

-- right join
-- show all departament with employees
SELECT
	e.name AS 'employee_name',
    d.name AS 'departament_name'
FROM employees AS e
RIGHT JOIN departaments AS d ON e.departament_id = d.departament_id
;

-- full join
-- show all employees and departaments
SELECT
	e.name AS 'employee_name',
	d.name AS 'departament_name'
FROM employees AS e
LEFT JOIN departaments AS d ON e.departament_id = d.departament_id
UNION ALL
 SELECT
	e.name AS 'employee_name',
	d.name AS 'departament_name'
FROM employees AS e
RIGHT JOIN departaments AS d ON e.departament_id = d.departament_id
;
 
-- left join without common part
-- show employees without departament
SELECT e.name AS 'employee_name'
FROM employees AS e
LEFT JOIN departaments AS d ON e.departament_id = d.departament_id
WHERE e.departament_id IS NULL
;

-- right join without common part
-- show departaments without employees
SELECT d.name AS 'departament_name'
FROM employees AS e
RIGHT JOIN departaments AS d ON e.departament_id = d.departament_id
WHERE e.name IS NULL
;

-- full join without common part
-- show employees without departament and departament without employees
SELECT
	e.name AS 'employee_name',
    d.name AS 'departament_name'
FROM employees AS e
LEFT JOIN departaments AS d ON e.departament_id = d.departament_id
WHERE d.name IS NULL
UNION
SELECT
	e.name AS 'employee_name',
    d.name AS 'departament_name'
FROM employees AS e
RIGHT JOIN departaments AS d ON e.departament_id = d.departament_id
WHERE e.name IS NULL
;